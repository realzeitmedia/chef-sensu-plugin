# sensu-plugin cookbook

## Requirements

* `sensu`

## Recipes

none

## Resources

### Define a handler using the mailer from the sensu-community plugins

```ruby
sensu_plugin_handler_mailer "something" do
  mail_from "you@yoursystem.com"
  mail_to "alert@yoursystem.com"
  smtp_domain "mail.yoursystem.com"
  smtp_port 123
end
```

### Define a check using the check-http.rb plugin

Each check now supports the two actions *create* (which is the default) and *enable*. You can simply use the *create* action to install the check-script on the client 

```ruby
sensu_plugin_check_http "http_check"
```

In order to install the check definition on the server you need to use the *enable* action:

```ruby
sensu_plugin_check_http "http_check_website" do
  handlers ["mailer"]
  url "https://yoursystem.com"
  timeout 15
  interval 180
  occurrences 4
  refresh 600
  ssl true
  insecure true
  subscribers ["webservers"]
  action :enable
end
```

### Define a check using the check-diskusage.rb plugin

```ruby
sensu_plugin_check_disk "disk-usage" do
  fstype "ext3,ext4"
  warn 85
  crit 90
  subscribers ["all"]
  action :enable
end
```

### Define a metric using the vmstat-metrics.rb plugin

```ruby
sensu_plugin_metric_vmstat "vmstat" do
  handlers ["graphite"]
  action :enable
end
```

## Author and License

Author:: Christian Graf

```text
Copyright 2014, realzeit GmbH (http://realzeitmedia.com)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
