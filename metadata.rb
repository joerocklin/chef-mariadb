name              'mariadb'
maintainer        'Joe Rocklin'
maintainer_email  'joe.rocklin@gmail.com'
license           'Apache 2.0'
description       'Installs and configures mariadb for client or server'
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           '2.0.0'
recipe            'mariadb', 'Includes the client recipe to configure a client'
recipe            'mariadb::client', 'Installs packages required for mariadb clients using run_action magic'
recipe            'mariadb::server', 'Installs packages required for mariadb servers w/o manual intervention'
recipe            'mariadb::server_ec2', 'Performs EC2-specific mountpoint manipulation'

# actually tested on
supports 'centos'
supports 'debian'
supports 'ubuntu'

# # code bits around, untested. remove?
supports 'redhat'
supports 'amazon'
supports 'freebsd'
supports 'mac_os_x'
supports 'scientific'
supports 'suse'
supports 'windows'

depends 'yum',              '~> 3.0'
depends 'yum-epel'

depends 'apt',              '~> 2.0'

depends 'openssl',          '~> 1.1'
depends 'build-essential',  '> 1.4'
