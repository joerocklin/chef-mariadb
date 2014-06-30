class Chef
  class Provider
    class MariadbChefGem < Chef::Provider::LWRPBase
      use_inline_resources if defined?(use_inline_resources)

      def whyrun_supported?
        true
      end

      def action_install
        converge_by 'install mysql chef_gem and dependencies' do

          recipe_eval do
            run_context.include_recipe 'build-essential::default'
            run_context.include_recipe 'mariadb::client'
          end

          recipe_eval do
            node['mariadb']['client']['packages'].each do |p|
              package p do
                action :install
              end
            end
          end

          chef_gem 'mysql2' do
            action :install
          end

          chef_gem 'mysql' do
            action :install
          end

        end
      end

      def action_remove

        recipe_eval do
          %w(mariadb-client libmariadbclient-dev).each do |p|
            package p do
              action :remove
            end
          end
        end

        chef_gem 'mysql' do
          action :remove
        end

      end
    end
  end
end
