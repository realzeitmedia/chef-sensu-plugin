require "json"

action :create do

  base_dir = "#{node[:sensu][:directory]}/#{new_resource.category}s".sub("checks", "plugins")
  sensu_owner = node[:sensu][:admin_user] || "sensu"
  sensu_group = node[:sensu][:group] || "sensu"

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

  file "#{node[:sensu][:directory]}/conf.d/#{new_resource.name}.json" do
    owner sensu_owner
    group sensu_group
    mode 0640
    content JSON.pretty_generate new_resource.get_sensu_config
  end

end
