#
# Cookbook Name:: mariadb
# Attributes:: server
#
# Copyright 2008-2013, Opscode, Inc.
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

# Probably driven from wrapper cookbooks, environments, or roles.
# # Keep in this namespace for backwards compat
default['mariadb']['bind_address']              = node.attribute?('cloud') ? node['cloud']['local_ipv4'] : node['ipaddress']
default['mariadb']['port']                      = 3306
default['mariadb']['nice']                      = 0

# service/daemon user/group
default['mariadb']['service']['user']                  = 'mysql'
default['mariadb']['service']['group']                 = 'mysql'

# eventually remove?  where is this used?
if attribute?('ec2')
  default['mariadb']['ec2_path']    = '/mnt/mysql'
  default['mariadb']['ebs_vol_dev'] = '/dev/sdi'
  default['mariadb']['ebs_vol_size'] = 50
end

# actual config starts here
default['mariadb']['auto-increment-increment']        = 1
default['mariadb']['auto-increment-offset']           = 1

default['mariadb']['allow_remote_root']               = false
default['mariadb']['remove_anonymous_users']          = false
default['mariadb']['remove_test_database']            = false
default['mariadb']['root_network_acl']                = nil
default['mariadb']['tunable']['character-set-server'] = 'utf8'
default['mariadb']['tunable']['collation-server']     = 'utf8_general_ci'
default['mariadb']['tunable']['lower_case_table_names']  = nil
default['mariadb']['tunable']['back_log']             = '128'
default['mariadb']['tunable']['key_buffer_size']           = '256M'
default['mariadb']['tunable']['myisam_sort_buffer_size']   = '8M'
default['mariadb']['tunable']['myisam_max_sort_file_size'] = '2147483648'
default['mariadb']['tunable']['myisam_repair_threads']     = '1'
default['mariadb']['tunable']['myisam-recover']            = 'BACKUP'
default['mariadb']['tunable']['max_allowed_packet']   = '16M'
default['mariadb']['tunable']['max_connections']      = '800'
default['mariadb']['tunable']['max_connect_errors']   = '10'
default['mariadb']['tunable']['concurrent_insert']    = '2'
default['mariadb']['tunable']['connect_timeout']      = '10'
default['mariadb']['tunable']['tmp_table_size']       = '32M'
default['mariadb']['tunable']['max_heap_table_size']  = node['mariadb']['tunable']['tmp_table_size']
default['mariadb']['tunable']['bulk_insert_buffer_size'] = node['mariadb']['tunable']['tmp_table_size']
default['mariadb']['tunable']['net_read_timeout']     = '30'
default['mariadb']['tunable']['net_write_timeout']    = '30'
default['mariadb']['tunable']['table_cache']          = '128'
default['mariadb']['tunable']['table_open_cache']     = node['mariadb']['tunable']['table_cache'] # table_cache is deprecated
                                                                                                  # in favor of table_open_cache

default['mariadb']['tunable']['thread_cache_size']    = 8
default['mariadb']['tunable']['thread_concurrency']   = 10
default['mariadb']['tunable']['thread_stack']         = '256K'
default['mariadb']['tunable']['sort_buffer_size']     = '2M'
default['mariadb']['tunable']['read_buffer_size']     = '128k'
default['mariadb']['tunable']['read_rnd_buffer_size'] = '256k'
default['mariadb']['tunable']['join_buffer_size']     = '128k'
default['mariadb']['tunable']['wait_timeout']         = '180'
default['mariadb']['tunable']['open-files-limit']     = '1024'

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

default['mariadb']['tunable']['replicate_do_db']             = nil
default['mariadb']['tunable']['replicate_do_table']          = nil
default['mariadb']['tunable']['replicate_ignore_db']         = nil
default['mariadb']['tunable']['replicate_ignore_table']      = nil
default['mariadb']['tunable']['replicate_wild_do_table']     = nil
default['mariadb']['tunable']['replicate_wild_ignore_table'] = nil

default['mariadb']['tunable']['sync_binlog']                     = 0
default['mariadb']['tunable']['skip_slave_start']                = false
default['mariadb']['tunable']['read_only']                       = false

default['mariadb']['tunable']['log_error']                       = nil
default['mariadb']['tunable']['log_warnings']                    = false
default['mariadb']['tunable']['log_queries_not_using_index']     = true
default['mariadb']['tunable']['log_bin_trust_function_creators'] = false

default['mariadb']['tunable']['innodb_log_file_size']            = '5M'
default['mariadb']['tunable']['innodb_buffer_pool_size']         = '128M'
default['mariadb']['tunable']['innodb_buffer_pool_instances']    = '4'
default['mariadb']['tunable']['innodb_additional_mem_pool_size'] = '8M'
default['mariadb']['tunable']['innodb_data_file_path']           = 'ibdata1:10M:autoextend'
default['mariadb']['tunable']['innodb_flush_method']             = false
default['mariadb']['tunable']['innodb_log_buffer_size']          = '8M'
default['mariadb']['tunable']['innodb_write_io_threads']         = '4'
default['mariadb']['tunable']['innodb_io_capacity']              = '200'
default['mariadb']['tunable']['innodb_file_per_table']           = true
default['mariadb']['tunable']['innodb_lock_wait_timeout']        = '60'
if node['cpu'].nil? || node['cpu']['total'].nil?
  default['mariadb']['tunable']['innodb_thread_concurrency']       = '8'
  default['mariadb']['tunable']['innodb_commit_concurrency']       = '8'
  default['mariadb']['tunable']['innodb_read_io_threads']          = '8'
else
  default['mariadb']['tunable']['innodb_thread_concurrency']       = Integer(node['cpu']['total']) * 2
  default['mariadb']['tunable']['innodb_commit_concurrency']       = Integer(node['cpu']['total']) * 2
  default['mariadb']['tunable']['innodb_read_io_threads']          = Integer(node['cpu']['total']) * 2
end
default['mariadb']['tunable']['innodb_flush_log_at_trx_commit']  = '1'
default['mariadb']['tunable']['innodb_support_xa']               = true
default['mariadb']['tunable']['innodb_table_locks']              = true
default['mariadb']['tunable']['skip-innodb-doublewrite']         = false

default['mariadb']['tunable']['transaction-isolation'] = nil

default['mariadb']['tunable']['query_cache_limit']    = '1M'
default['mariadb']['tunable']['query_cache_size']     = '16M'

default['mariadb']['tunable']['long_query_time']      = 2
default['mariadb']['tunable']['expire_logs_days']     = 10
default['mariadb']['tunable']['max_binlog_size']      = '100M'
default['mariadb']['tunable']['binlog_cache_size']    = '32K'

default['mariadb']['tmpdir'] = ['/tmp']

# default['mariadb']['log_dir'] = node['mariadb']['data_dir']
default['mariadb']['log_files_in_group'] = false
default['mariadb']['innodb_status_file'] = false

default['mariadb']['tunable']['log_slow_queries']     = '/var/log/mysql/slow.log'
default['mariadb']['tunable']['slow_query_log']       = node['mariadb']['tunable']['log_slow_queries'] # log_slow_queries is deprecated

unless node['platform_family'] == 'rhel' && node['platform_version'].to_i < 6
  # older RHEL platforms don't support these options
  default['mariadb']['tunable']['event_scheduler']  = 0
  default['mariadb']['tunable']['table_open_cache'] = '128'
  default['mariadb']['tunable']['binlog_format']    = 'statement' if node['mariadb']['tunable']['log_bin']
end

default['mariadb']['replication']['master'] = nil
default['mariadb']['replication']['slave'] = nil
default['mariadb']['replication']['user'] = nil
default['mariadb']['replication']['secret'] = nil

# security options
# @see http://www.symantec.com/connect/articles/securing-mysql-step-step
# @see http://dev.mysql.com/doc/refman/5.7/en/server-options.html#option_mysqld_chroot
default['mariadb']['security']['chroot']                  = nil
# @see http://dev.mysql.com/doc/refman/5.7/en/server-options.html#option_mysqld_safe-user-create
default['mariadb']['security']['safe_user_create']        = nil
# @see http://dev.mysql.com/doc/refman/5.7/en/server-options.html#option_mysqld_secure-auth
default['mariadb']['security']['secure_auth']             = nil
# @see http://dev.mysql.com/doc/refman/5.7/en/server-options.html#option_mysqld_symbolic-links
default['mariadb']['security']['skip_symbolic_links']     = nil
# @see http://dev.mysql.com/doc/refman/5.7/en/server-options.html#option_mysqld_secure-file-priv
default['mariadb']['security']['secure_file_priv']        = nil
# @see http://dev.mysql.com/doc/refman/5.7/en/server-options.html#option_mysqld_skip-show-database
default['mariadb']['security']['skip_show_database']      = nil
# @see http://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_local_infile
default['mariadb']['security']['local_infile']            = nil
