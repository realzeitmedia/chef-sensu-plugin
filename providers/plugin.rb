require "json"

def install(base_dir, sensu_owner, sensu_group)
  directory base_dir do
    owner sensu_owner
    group sensu_group
    mode 0755
    action :create
  end

  new_resource.remote_files.each do |file|
    remote_file "#{base_dir}/#{file[:name]}" do
      source file[:source]
      owner sensu_owner
      group sensu_group
      mode 0755
    end
  end

  new_resource.local_files.each do |file|
    cookbook_file "#{base_dir}/#{file[:name]}" do
      source file[:source]
      owner sensu_owner
      group sensu_group
      mode 0775
    end
  end

  new_resource.gems.each do |gem|
    sensu_gem gem[:name] do
      version gem[:version]
    end
  end
end

def activate(base_dir, sensu_owner, sensu_group)
  file "#{node[:sensu][:directory]}/conf.d/#{new_resource.name}.json" do
    owner sensu_owner
    group sensu_group
    mode 0640
    content JSON.pretty_generate new_resource.get_sensu_config
  end
end

action :create do
  base_dir = "#{node[:sensu][:directory]}/#{new_resource.category}s".sub("checks", "plugins")
  owner = node[:sensu][:admin_user] || "sensu"
  group = node[:sensu][:group] || "sensu"

  install(base_dir, owner, group)
end

action :enable do
  base_dir = "#{node[:sensu][:directory]}/#{new_resource.category}s".sub("checks", "plugins")
  owner = node[:sensu][:admin_user] || "sensu"
  group = node[:sensu][:group] || "sensu"

  install(base_dir, owner, group)
  activate(base_dir, owner, group)
end
