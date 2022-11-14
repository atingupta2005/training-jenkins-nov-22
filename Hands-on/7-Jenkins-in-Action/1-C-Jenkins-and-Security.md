# Jenkins and Security

## Allow users to Sign Up
 - Open Manage Jenkins\Configure Global Security
 - Enable - "Allow users to sign up"
 - Now any user can create an account on Jenkins and Login to it
 - Ideally it should be disabled

## Install a powerful security plugin
 - Manage Jenkins\Manage Plugins\Available
 - Search plugin - "Role-based Authorization Strategy"
 - Install without restart
 - Select checkbox - "Restart Jenkins when installation is complete"
 - Open Manage Jenkins\Configure Global Security
 - Enable - "Role-Based Strategy" under Authorization section
 - Save
 - Scroll down and Open "Manage and Assign Roles"


## Create users manually in Jenkins DB
 - Open Manage Jenkins\Manage Users
 - Click - "Create User"
 - Test the user created in Incognito Mode
  - Notice it's access denied
  - We need to give permissions explicitly

## What are Roles?
 - Open Manage Jenkins\Manage and Assign Roles
 - Open Manage Roles
 - Add a new Role named - readOnly
 - Assign Read permissions to the role
 - Save

## Assign Roles to users
 - Open - Manage Jenkins\Manage and Assign Roles
 - Open - Assign Roles
 - Specify user name in text box and click - Add
 - In the table above select the check box to give the role to user
 - Test the user by logging in
