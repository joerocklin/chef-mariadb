require 'chef/resource/lwrp_base'

class Chef
  class Resource
    class MariadbChefGem < Chef::Resource::LWRPBase
      self.resource_name = :mariadb_chef_gem
      actions  :install, :remove
      default_action :install
    end
  end
end
