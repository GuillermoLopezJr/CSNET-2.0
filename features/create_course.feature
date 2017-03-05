Feature: Create a course
As a logged in instructor
So that I can add organize my assignments and students by course
I want to add a course to the database

Scenario: Instructor creates a new course
Given I am an instructor logged in as "user@gmail.com" with password "password"
When I submit a new course form
Then I should add a course to the database