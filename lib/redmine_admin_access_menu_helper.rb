require_dependency 'application_controller'

module RedmineAdminAccess
  module MenuHelper
    def render_menu(menu, project=nil)
      if :admin_menu == menu.to_sym && 1 != User.current.id
        admin_access_value = get_user_admin_access_custom_field_value

        unless admin_access_value.nil?
          links = []

          menu_items_for(menu, project) do |node|
            unless admin_access_value.value.index(node.name.to_s).nil?
              links << render_menu_node(node, project)
            end
          end

          links.empty? ? nil : content_tag('ul', links.join("\n").html_safe)
        end
      else
        super
      end
    end

    def get_user_admin_access_custom_field_value
      admin_access_value = nil

      User.current.custom_field_values.each do |value|
        admin_access_value = value if 'admin_access' == value.custom_field.name
      end

      admin_access_value
    end
  end
end