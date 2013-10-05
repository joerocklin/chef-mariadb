#
# Cookbook Name:: mariadb
# Attributes:: server
#
# Copyright 2008-2009, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

default['mariadb']['bind_address']              = node.attribute?('cloud') ? node.cloud['local_ipv4'] : node['ipaddress']
default['mariadb']['port']                      = 3306
default['mariadb']['nice']                      = 0

case node["platform_family"]
when "debian"
  default['mariadb']['server']['packages']      = %w{mariadb-server}
  default['mariadb']['service_name']            = "mariadb"
  default['mariadb']['basedir']                 = "/usr"
  default['mariadb']['data_dir']                = "/var/lib/mysql"
  default['mariadb']['root_group']              = "root"
  default['mariadb']['mariadbadmin_bin']        = "/usr/bin/mysqladmin"
  default['mariadb']['mariadb_bin']             = "/usr/bin/mysql"

  default['mariadb']['conf_dir']                = '/etc/mysql'
  default['mariadb']['confd_dir']               = '/etc/mysql/conf.d'
  default['mariadb']['socket']                  = "/var/run/mysqld/mysqld.sock"
  default['mariadb']['pid_file']                = "/var/run/mysqld/mysqld.pid"
  default['mariadb']['old_passwords']           = 0
  default['mariadb']['grants_path']             = "/etc/mysql/grants.sql"

when "rhel", "fedora"
  default['mariadb']['service_name']            = "mysql"
  default['mariadb']['pid_file']                = "/var/run/mysql/mysql.pid"
  default['mariadb']['server']['packages']      = %w{MariaDB-server}
  default['mariadb']['basedir']                 = "/usr"
  default['mariadb']['data_dir']                = "/var/lib/mysql"
  default['mariadb']['root_group']              = "root"
  default['mariadb']['mariadbadmin_bin']        = "/usr/bin/mysqladmin"
  default['mariadb']['mariadb_bin']             = "/usr/bin/mysql"
  default['mariadb']['version']                 = '5.5'
  default['mariadb']['conf_dir']                = '/etc'
  default['mariadb']['confd_dir']               = '/etc/mysql/conf.d'
  default['mariadb']['socket']                  = "/var/lib/mysql/mysql.sock"
  default['mariadb']['old_passwords']           = 1
  default['mariadb']['grants_path']             = "/etc/mysql_grants.sql"

when "suse"
  default['mariadb']['service_name']            = "mariadb"
  default['mariadb']['server']['packages']      = %w{mariadb-community-server}
  default['mariadb']['basedir']                 = "/usr"
  default['mariadb']['data_dir']                = "/var/lib/mysql"
  default['mariadb']['root_group']              = "root"
  default['mariadb']['mariadbadmin_bin']        = "/usr/bin/mysqladmin"
  default['mariadb']['mariadb_bin']             = "/usr/bin/mysql"
  default['mariadb']['conf_dir']                = '/etc'
  default['mariadb']['confd_dir']               = '/etc/mysql/conf.d'
  default['mariadb']['socket']                  = "/var/run/mysql/mysql.sock"
  default['mariadb']['pid_file']                = "/var/run/mysql/mysqld.pid"
  default['mariadb']['old_passwords']           = 1
  default['mariadb']['grants_path']             = "/etc/mysql_grants.sql"

when "freebsd"
  default['mariadb']['server']['packages']      = %w{mariadb55-server}
  default['mariadb']['service_name']            = "mariadb-server"
  default['mariadb']['basedir']                 = "/usr/local"
  default['mariadb']['data_dir']                = "/var/db/mariadb"
  default['mariadb']['root_group']              = "wheel"
  default['mariadb']['mariadbadmin_bin']        = "/usr/local/bin/mysqladmin"
  default['mariadb']['mariadb_bin']             = "/usr/local/bin/mysql"

  default['mariadb']['conf_dir']                = '/usr/local/etc'
  default['mariadb']['confd_dir']               = '/usr/local/etc/mysql/conf.d'
  default['mariadb']['socket']                  = "/tmp/mysqld.sock"
  default['mariadb']['pid_file']                = "/var/run/mysqld/mysqld.pid"
  default['mariadb']['old_passwords']           = 0
  default['mariadb']['grants_path']             = "/var/db/mysql/grants.sql"

when "windows"
  default['mariadb']['server']['packages']      = ["MariaDB Server 5.5"]
  default['mariadb']['version']                 = '5.5.21'
  default['mariadb']['arch']                    = 'win32'
  default['mariadb']['package_file']            = "mariadb-#{mariadb['version']}-#{mariadb['arch']}.msi"
  default['mariadb']['url']                     = "http://www.mariadb.com/get/Downloads/MariaDB-5.5/#{mariadb['package_file']}/from/http://mariadb.mirrors.pair.com/"

  default['mariadb']['service_name']            = "mariadb"
  default['mariadb']['basedir']                 = "#{ENV['SYSTEMDRIVE']}\\Program Files (x86)\\MariaDB\\#{mariadb['server']['packages'].first}"
  default['mariadb']['data_dir']                = "#{node['mariadb']['basedir']}\\Data"
  default['mariadb']['bin_dir']                 = "#{node['mariadb']['basedir']}\\bin"
  default['mariadb']['mariadbadmin_bin']        = "#{node['mariadb']['bin_dir']}\\mysqladmin"
  default['mariadb']['mariadb_bin']             = "#{node['mariadb']['bin_dir']}\\mysql"

  default['mariadb']['conf_dir']                = node['mariadb']['basedir']
  default['mariadb']['old_passwords']           = 0
  default['mariadb']['grants_path']             = "#{node['mariadb']['conf_dir']}\\grants.sql"

when "mac_os_x"
  default['mariadb']['server']['packages']      = %w{mariadb}
  default['mariadb']['basedir']                 = "/usr/local/Cellar"
  default['mariadb']['data_dir']                = "/usr/local/var/mariadb"
  default['mariadb']['root_group']              = "admin"
  default['mariadb']['mariadbadmin_bin']        = "/usr/local/bin/mysqladmin"
  default['mariadb']['mariadb_bin']             = "/usr/local/bin/mysql"

else
  default['mariadb']['server']['packages']      = %w{mariadb-server}
  default['mariadb']['service_name']            = "mariadb"
  default['mariadb']['basedir']                 = "/usr"
  default['mariadb']['data_dir']                = "/var/lib/mysql"
  default['mariadb']['root_group']              = "root"
  default['mariadb']['mariadbadmin_bin']        = "/usr/bin/mysqladmin"
  default['mariadb']['mariadb_bin']             = "/usr/bin/mysql"

  default['mariadb']['conf_dir']                = '/etc/mysql'
  default['mariadb']['confd_dir']               = '/etc/mysql/conf.d'
  default['mariadb']['socket']                  = "/var/run/mysqld/mysqld.sock"
  default['mariadb']['pid_file']                = "/var/run/mysqld/mysqld.pid"
  default['mariadb']['old_passwords']           = 0
  default['mariadb']['grants_path']             = "/etc/mysql/grants.sql"
end

if attribute?('ec2')
  default['mariadb']['ec2_path']    = "/mnt/mariadb"
  default['mariadb']['ebs_vol_dev'] = "/dev/sdi"
  default['mariadb']['ebs_vol_size'] = 50
end

default['mariadb']['reload_action'] = "restart" # or "reload" or "none"

default['mariadb']['use_upstart'] = node['platform'] == "ubuntu" && node['platform_version'].to_f >= 10.04

default['mariadb']['auto-increment-increment']        = 1
default['mariadb']['auto-increment-offset']           = 1

default['mariadb']['allow_remote_root']               = false
default['mariadb']['remove_anonymous_users']          = false
default['mariadb']['remove_test_database']            = false
default['mariadb']['root_network_acl']                = nil
default['mariadb']['tunable']['character-set-server'] = "utf8"
default['mariadb']['tunable']['collation-server']     = "utf8_general_ci"
default['mariadb']['tunable']['lower_case_table_names']  = nil
default['mariadb']['tunable']['back_log']             = "128"
default['mariadb']['tunable']['key_buffer_size']           = "256M"
default['mariadb']['tunable']['myisam_sort_buffer_size']   = "8M"
default['mariadb']['tunable']['myisam_max_sort_file_size'] = "2147483648"
default['mariadb']['tunable']['myisam_repair_threads']     = "1"
default['mariadb']['tunable']['myisam-recover']            = "BACKUP"
default['mariadb']['tunable']['max_allowed_packet']   = "16M"
default['mariadb']['tunable']['max_connections']      = "800"
default['mariadb']['tunable']['max_connect_errors']   = "10"
default['mariadb']['tunable']['concurrent_insert']    = "2"
default['mariadb']['tunable']['connect_timeout']      = "10"
default['mariadb']['tunable']['tmp_table_size']       = "32M"
default['mariadb']['tunable']['max_heap_table_size']  = node['mariadb']['tunable']['tmp_table_size']
default['mariadb']['tunable']['bulk_insert_buffer_size'] = node['mariadb']['tunable']['tmp_table_size']
default['mariadb']['tunable']['net_read_timeout']     = "30"
default['mariadb']['tunable']['net_write_timeout']    = "30"
default['mariadb']['tunable']['table_cache']          = "128"

default['mariadb']['tunable']['thread_cache_size']    = 8
default['mariadb']['tunable']['thread_concurrency']   = 10
default['mariadb']['tunable']['thread_stack']         = "256K"
default['mariadb']['tunable']['sort_buffer_size']     = "2M"
default['mariadb']['tunable']['read_buffer_size']     = "128k"
default['mariadb']['tunable']['read_rnd_buffer_size'] = "256k"
default['mariadb']['tunable']['join_buffer_size']     = "128k"
default['mariadb']['tunable']['wait_timeout']         = "180"
default['mariadb']['tunable']['open-files-limit']     = "1024"

default['mariadb']['tunable']['sql_mode'] = nil

default['mariadb']['tunable']['skip-character-set-client-handshake'] = false
default['mariadb']['tunable']['skip-name-resolve']                   = false

default['mariadb']['tunable']['slave_compressed_protocol']       = 0

default['mariadb']['tunable']['server_id']                       = nil
default['mariadb']['tunable']['log_bin']                         = nil
default['mariadb']['tunable']['log_bin_trust_function_creators'] = false

default['mariadb']['tunable']['relay_log']                       = nil
default['mariadb']['tunable']['relay_log_index']                 = nil
default['mariadb']['tunable']['log_slave_updates']               = false

default['mariadb']['tunable']['sync_binlog']                     = 0
default['mariadb']['tunable']['skip_slave_start']                = false
default['mariadb']['tunable']['read_only']                       = false

default['mariadb']['tunable']['log_error']                       = nil
default['mariadb']['tunable']['log_warnings']                    = false
default['mariadb']['tunable']['log_queries_not_using_index']     = true
default['mariadb']['tunable']['log_bin_trust_function_creators'] = false

default['mariadb']['tunable']['innodb_log_file_size']            = "5M"
default['mariadb']['tunable']['innodb_buffer_pool_size']         = "128M"
default['mariadb']['tunable']['innodb_buffer_pool_instances']    = "4"
default['mariadb']['tunable']['innodb_additional_mem_pool_size'] = "8M"
default['mariadb']['tunable']['innodb_data_file_path']           = "ibdata1:10M:autoextend"
default['mariadb']['tunable']['innodb_flush_method']             = false
default['mariadb']['tunable']['innodb_log_buffer_size']          = "8M"
default['mariadb']['tunable']['innodb_write_io_threads']         = "4"
default['mariadb']['tunable']['innodb_io_capacity']              = "200"
default['mariadb']['tunable']['innodb_file_per_table']           = true
default['mariadb']['tunable']['innodb_lock_wait_timeout']        = "60"
if node['cpu'].nil? or node['cpu']['total'].nil?
  default['mariadb']['tunable']['innodb_thread_concurrency']       = "8"
  default['mariadb']['tunable']['innodb_commit_concurrency']       = "8"
  default['mariadb']['tunable']['innodb_read_io_threads']          = "8"
else
  default['mariadb']['tunable']['innodb_thread_concurrency']       = "#{(Integer(node['cpu']['total'])) * 2}"
  default['mariadb']['tunable']['innodb_commit_concurrency']       = "#{(Integer(node['cpu']['total'])) * 2}"
  default['mariadb']['tunable']['innodb_read_io_threads']          = "#{(Integer(node['cpu']['total'])) * 2}"
end
default['mariadb']['tunable']['innodb_flush_log_at_trx_commit']  = "1"
default['mariadb']['tunable']['innodb_support_xa']               = true
default['mariadb']['tunable']['innodb_table_locks']              = true
default['mariadb']['tunable']['skip-innodb-doublewrite']         = false

default['mariadb']['tunable']['transaction-isolation'] = nil

default['mariadb']['tunable']['query_cache_limit']    = "1M"
default['mariadb']['tunable']['query_cache_size']     = "16M"

default['mariadb']['tunable']['log_slow_queries']     = "/var/log/mysql/slow.log"
default['mariadb']['tunable']['slow_query_log']       = node['mariadb']['tunable']['log_slow_queries'] # log_slow_queries is deprecated
                                                                                                       # in favor of slow_query_log
default['mariadb']['tunable']['long_query_time']      = 2

default['mariadb']['tunable']['expire_logs_days']     = 10
default['mariadb']['tunable']['max_binlog_size']      = "100M"
default['mariadb']['tunable']['binlog_cache_size']    = "32K"

default['mariadb']['tmpdir'] = ["/tmp"]

default['mariadb']['log_dir'] = node['mariadb']['data_dir']
default['mariadb']['log_files_in_group'] = false
default['mariadb']['innodb_status_file'] = false

unless node['platform_family'] == "rhel" && node['platform_version'].to_i < 6
  # older RHEL platforms don't support these options
  default['mariadb']['tunable']['event_scheduler']  = 0
  default['mariadb']['tunable']['table_open_cache'] = "128"
  default['mariadb']['tunable']['binlog_format']    = "statement" if node['mariadb']['tunable']['log_bin']
end

default['mariadb']['replication']['master'] = nil
default['mariadb']['replication']['slave'] = nil
default['mariadb']['replication']['user'] = nil
default['mariadb']['replication']['secret'] = nil
