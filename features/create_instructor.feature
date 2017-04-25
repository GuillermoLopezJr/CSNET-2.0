Feature: Create instructor account
As an administrator
So that I can add new instructors to use the system
I want to create an account for another instructor

# :) Happy Path
Scenario: Administrator creates an account for an instructor
Given I am an admin instructor signed in as "user@gmail.com" with password "password"
Given I am on the add instructor account page
When I enter new instructor credentials "user2@gmail.com" and name "Jane" "Doe" and submit
Then An instructor should exist in the database with email "user2@gmail.com"
