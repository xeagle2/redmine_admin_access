require_dependency 'application_controller'
require_dependency 'redmine_admin_access_menu_helper'

module RedmineAdminAccess
  module ApplicationControllerPatch
    def self.included(base)
      base.send(:extend, ClassMethods)
      base.send(:include, InstanceMethods)

      base.class_eval do
        unloadable # Send unloadable so it will not be unloaded in development

        helper RedmineAdminAccess::MenuHelper

        alias_method_chain :require_admin, :extension
        alias_method_chain :require_admin_or_api_request, :extension

      end
    end

    module ClassMethods
    end

    module InstanceMethods
      def require_admin_with_extension
        return unless require_login

        if !User.current.admin?
          render_403
          return false
        end

        return true if 1 == User.current.id || '/admin' == request.env['PATH_INFO']

        admin_access_value = get_user_admin_access_custom_field_value
        unless admin_access_value.nil? || admin_access_value.value.index(get_requested_admin_section).nil?
          true
        else
          render_403
          return false
        end

        true
      end

      def require_admin_or_api_request_with_extension
        return true if api_request?

        if User.current.admin?
          return true if 1 == User.current.id || '/admin' == request.env['PATH_INFO']

          admin_access_value = get_user_admin_access_custom_field_value
          unless admin_access_value.nil? || admin_access_value.value.index(get_requested_admin_section).nil?
            true
          else
            deny_access
          end
        elsif User.current.logged?
          render_error(:status => 406)
        else
          deny_access
        end
      end

      def get_user_admin_access_custom_field_value
        admin_access_value = nil

        User.current.custom_field_values.each do |value|
          admin_access_value = value if 'admin_access' == value.custom_field.name
        end

        admin_access_value
      end

      def get_requested_admin_section
        p = request.env['PATH_INFO'].gsub(/\/([^\/]+)(.*)/, '\1')
        if p == 'admin'
          p = request.env['PATH_INFO'].gsub(/\/([^\/]+)\/([^\/]+)(.*)/, '\2')
        end
        p
      end
    end
  end
end