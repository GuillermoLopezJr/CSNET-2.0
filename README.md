# CSCE 431 Aggies off the Rails
A course assignment submission system for Texas A&M University.
It allows students to submit homework assignments easily and quickly (a replacement for the current CSNET course assignment submissions).

## Final Iteration
* [Report (pdf)](https://docs.google.com/document/d/1lBdV-4knJvmW_dYOLpTPH0ytpXQ28tWWlX9YCOGe0_U/edit?usp=sharing)
* [Heroku app](https://fast-shore-41666.herokuapp.com/)
  * Test User Account:
    * <b>email</b> (ADMIN):     i1@gmail.com
    * <b>password</b>:  password
 
    * <b>email</b> (Instructor):     user@gmail.com
    * <b>password</b>:  password


    * <b>email</b> (Student):        s1@gmail.com
    * <b>password</b>:  password
    
    
    * <b>email</b> (Teaching Assistant):     ta1@gmail.com
    * <b>password</b>:  password
    
 
##Instructions to run 
 * Running locally (Cloud9)
 ``` ruby 
 rails s -p $PORT -b $IP 
 ```

##Database commands
 * Reset Heroku database
 
   ```ruby
   heroku pg:reset DATABASE
   heroku run rake db:migrate
   ```
 * Seed the database
 
   ```ruby
   heroku run rake db:seed
   ```

##Services Used
 * Amazon Web Services (S3)
   * Associated files for configuration:
     * <b>/config/application.yml</b>
     * <b>/config/initializers/carrierwave.rb</b>
     * The relevant uploaders are here <b>/app/uploaders</b>
   * How to configure: 
     * Once you have created your Amazon S3 account, navigate to 'My Security Credentials' and keep note of your secret access keys.
     * If and when deploying to Heroku, be sure to change your Configuration Variables (Config Vars under settings) so it knows what keys to use.  Add the following variables and input your AWS credentials in its corresponding field. 
        * AWS_ACCESS_KEY_ID
        * AWS_DEFAULT_REGION
        * AWS_SECRET_ACCESS_KEY

 * Setting up Send-Grid (for sending emails)
    run the command
    ```ruby
    heroku addons:create sendgrid:starter
    
    ```
