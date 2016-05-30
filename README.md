# Redmine Admin Access plugin >= Redmine 3.0

Redmine plugin used to grant access to redmine administration features for specific users.

### Features

* Shows/hides access to administration sub-menu items to redmine users.

**Screenshots**

![Screenshot 1](https://raw.githubusercontent.com/xeagle2/redmine_admin_access/master/screenshot_01.png)
![Screenshot 2](https://raw.githubusercontent.com/xeagle2/redmine_admin_access/master/screenshot_02.png)
![Screenshot 3](https://raw.githubusercontent.com/xeagle2/redmine_admin_access/master/screenshot_03.png)

### Install

1. Follow Redmine [plugin installation instructions](http://www.redmine.org/projects/redmine/wiki/Plugins#Installing-a-plugin).
2. Add new Custom field at "Administration" > "Custom fields" > "Users" > "admin_access".
3. It's important to give it a name "admin_access", make the format of field "List", check on "Multiple values", Uncheck the following options: Required, Visible, Editable, Used as a filter.
4. Fill out the "Possible values" by uri paths accessible by administration sub-menu items.
5. Modify user account, check on "Administrator" option, and select the sub-menu items from "admin_access" to grant access to.
6. Save changes & try to log in with recently granted user account.

### Uninstall

1. Follow Redmine [plugin uninstall instructions](http://www.redmine.org/projects/redmine/wiki/Plugins#Uninstalling-a-plugin).

### Changelog

* **3.0 (2016-05-31)**
    * Initial release.