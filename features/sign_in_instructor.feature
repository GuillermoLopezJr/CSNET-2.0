Feature: Instructor Login
As an instructor
So that I can access my classes and assignments
I want to login using a tamu email and a password

Scenario: Instructor logs in and is brought to home page
Given I am an instructor registered as "user@gmail.com" with password "password"
Given I am on the instructor login page
When I enter credentials "user@gmail.com" and "password" and submit
Then I should be signed in and brought to home page
