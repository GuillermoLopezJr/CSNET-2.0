Feature: Student Login
As a student
So that I can access my class assignments
I want to login using a tamu email and an instructor assigned password

Scenario: Student logs in and is brought to home page
Given I am a student registered as "student@gmail.com" with password "password"
Given I am on the student login page
When I enter credentials "student@gmail.com" and "password" and submit
Then I should be signed in and brought to home page