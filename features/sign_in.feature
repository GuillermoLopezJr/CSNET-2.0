Feature: Login
As an instructor or student
So that I can access my class assignments
I want to login using a tamu email and an instructor assigned password

Scenario: Instructor logs in and is brought to home page
Given I am an instructor registered as "user@gmail.com" with password "password"
When I enter credentials "user@gmail.com" and "password" at sign in page
Then I should be signed in and brought to home page
