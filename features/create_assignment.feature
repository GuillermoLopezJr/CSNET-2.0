Feature: Create an assignment
As a logged in instructor
So that students can know of assignments and upload their work
I want to add an assignment to the database and relate it to courses in the database

Scenario: Instructor creates a new assignment
Given I am an instructor logged in as "user@gmail.com" with password "password"
Given A course with number 431 exists
When I submit a new assignment form with number 431
Then I should add an assignment to the database