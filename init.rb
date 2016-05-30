require 'redmine'

require_dependency 'redmine_admin_access_application_controller_patch'

Redmine::Plugin.register :redmine_admin_access do
  name 'Redmine Admin Access plugin'
  author 'Yura Zaplavnov'
  description 'Redmine plugin to grant access to redmine administration features for specific users.'
  version '3.0'
  url 'https://github.com/xeagle2/redmine_admin_access'
  author_url 'https://github.com/xeagle2'
end

require 'dispatcher' unless Rails::VERSION::MAJOR >= 3

if Rails::VERSION::MAJOR >= 3
  ActionDispatch::Callbacks.to_prepare do
    ApplicationController.send(:include, RedmineAdminAccess::ApplicationControllerPatch)
  end
else
  Dispatcher.to_prepare do
    ApplicationController.send(:include, RedmineAdminAccess::ApplicationControllerPatch)
  end
end