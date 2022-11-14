# Jenkins and Email

## Install a Mail Plugin
 - Plugin Name - mailer

## Integrate Jenkins and Gmail
 - Open - Manage Jenkins\Configure System
 - Refer to section - E-mail Notification
```
  - SMTP Server: smtp.gmail.com
  - User SMTP Authentication: Enable
  - User Name: <your email id>
  - Password: <Your email Password>
  - Use SSL: Enabled
  - SMTP Port: 465
  - Reply-To-Address:
  - Charset: UTF-8
```
 - Enable gmail option - "Less Secure Apps"
 - Test configuration by sending test e-mail: Enable
 - Test e-mail recipient: <your email id>
 - Click - "Test Configuration"
 - Verify if email is received or not

- Facing Issues?
- Refer
  - https://stackoverflow.com/questions/20337040/getting-error-while-sending-email-through-gmail-smtp-please-log-in-via-your-w


## Add notifications to your jobs
 - Open any existing job
 - Open section - "Post-build Actions"
 - Add post-build action -> E-mail Notification
 - Specify email id and enable both checkboxes
 - Build the project
 - Confirm if email is received
 - Change job to fail the Build
 - Build the project
 - Confirm if email is received
 - Change job to resolve issue
 - Build the project
 - Confirm if email is received
 - Build the project again
 - Confirm if email is received
 - You should not receive emails
