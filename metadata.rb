name              "MariaDB"
maintainer        ""
maintainer_email  "joe.rocklin@gmail.com"
license           "Apache 2.0"
description       "Installs and configures mariadb for client or server"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "1.0.2"
recipe            "mariadb", "Includes the client recipe to configure a client"
recipe            "mariadb::client", "Installs packages required for mariadb clients using run_action magic"
recipe            "mariadb::server", "Installs packages required for mariadb servers w/o manual intervention"

%w{ debian ubuntu centos suse fedora redhat scientific amazon freebsd windows mac_os_x }.each do |os|
  supports os
end

depends "openssl"
depends "build-essential", "> 1.1.0"
suggests "homebrew"
suggests "windows"
depends "apt"
depends  "yum"

attribute "mariadb/server_root_password",
  :display_name => "MariaDB Server Root Password",
  :description => "Randomly generated password for the mariadbd root user",
  :default => "randomly generated"

attribute "mariadb/bind_address",
  :display_name => "MariaDB Bind Address",
  :description => "Address that mariadbd should listen on",
  :default => "ipaddress"

attribute "mariadb/data_dir",
  :display_name => "MariaDB Data Directory",
  :description => "Location of mariadb databases",
  :default => "/var/lib/mariadb"

attribute "mariadb/conf_dir",
  :display_name => "MariaDB Conf Directory",
  :description => "Location of mariadb conf files",
  :default => "/etc/mariadb"

attribute "mariadb/ec2_path",
  :display_name => "MariaDB EC2 Path",
  :description => "Location of mariadb directory on EC2 instance EBS volumes",
  :default => "/mnt/mariadb"

attribute "mariadb/reload_action",
  :display_name => "MariaDB conf file reload action",
  :description => "Action to take when mariadb conf files are modified",
  :default => "reload"

attribute "mariadb/tunable",
  :display_name => "MariaDB Tunables",
  :description => "Hash of MariaDB tunable attributes",
  :type => "hash"

attribute "mariadb/tunable/key_buffer",
  :display_name => "MariaDB Tuntable Key Buffer",
  :default => "250M"

attribute "mariadb/tunable/max_connections",
  :display_name => "MariaDB Tunable Max Connections",
  :default => "800"

attribute "mariadb/tunable/wait_timeout",
  :display_name => "MariaDB Tunable Wait Timeout",
  :default => "180"

attribute "mariadb/tunable/net_read_timeout",
  :display_name => "MariaDB Tunable Net Read Timeout",
  :default => "30"

attribute "mariadb/tunable/net_write_timeout",
  :display_name => "MariaDB Tunable Net Write Timeout",
  :default => "30"

attribute "mariadb/tunable/back_log",
  :display_name => "MariaDB Tunable Back Log",
  :default => "128"

attribute "mariadb/tunable/table_cache",
  :display_name => "MariaDB Tunable Table Cache for MariaDB < 5.1.3",
  :default => "128"

attribute "mariadb/tunable/table_open_cache",
  :display_name => "MariaDB Tunable Table Cache for MariaDB >= 5.1.3",
  :default => "128"

attribute "mariadb/tunable/max_heap_table_size",
  :display_name => "MariaDB Tunable Max Heap Table Size",
  :default => "32M"

attribute "mariadb/tunable/expire_logs_days",
  :display_name => "MariaDB Exipre Log Days",
  :default => "10"

attribute "mariadb/tunable/max_binlog_size",
  :display_name => "MariaDB Max Binlog Size",
  :default => "100M"

attribute "mariadb/client",
  :display_name => "MariaDB Connector/C Client",
  :description => "Hash of MariaDB client attributes",
  :type => "hash"

attribute "mariadb/client/version",
  :display_name => "MariaDB Connector/C Version",
  :default => "6.0.2"

attribute "mariadb/client/arch",
  :display_name => "MariaDB Connector/C Architecture",
  :default => "win32"

attribute "mariadb/client/package_file",
  :display_name => "MariaDB Connector/C Package File Name",
  :default => "mariadb-connector-c-6.0.2-win32.msi"

attribute "mariadb/client/url",
  :display_name => "MariaDB Connector/C Download URL",
  :default => "http://www.mariadb.com/get/Downloads/Connector-C/mariadb-connector-c-6.0.2-win32.msi/from/http://mariadb.mirrors.pair.com/"

attribute "mariadb/client/package_name",
  :display_name => "MariaDB Connector/C Registry DisplayName",
  :default => "MariaDB Connector C 6.0.2"

attribute "mariadb/client/basedir",
  :display_name => "MariaDB Connector/C Base Install Directory",
  :default => "C:\\Program Files (x86)\\MariaDB\\Connector C 6.0.2"

attribute "mariadb/client/lib_dir",
  :display_name => "MariaDB Connector/C Library Directory (containing libmariadb.dll)",
  :default => "C:\\Program Files (x86)\\MariaDB\\Connector C 6.0.2\\lib\\opt"

attribute "mariadb/client/bin_dir",
  :display_name => "MariaDB Connector/C Executable Directory",
  :default => "C:\\Program Files (x86)\\MariaDB\\Connector C 6.0.2\\bin"

attribute "mariadb/client/ruby_dir",
  :display_name => "Ruby Executable Directory which should gain MariaDB support",
  :default => "system ruby"
