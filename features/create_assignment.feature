Feature: Create an assignment
As a logged in instructor
So that students can know of assignments and upload their work
I want to add an assignment to the database and relate it to courses in the database

# :) Happy Path
Scenario: Instructor successfully creates a new assignment
Given I am an instructor logged in as "user@gmail.com" with password "password"
Given A course with number 431 in "SPRING" 2017 exists for instructor "user@gmail.com"
When I submit a new assignment "a1" for course number 431 with a due date "2017-04-21 08:00:00"
Then I should add an assignment "a1" to the database

# :( Sad Path
Scenario: Create assignemnt fails because another assignment for that class exists with the same name
Given I am an instructor logged in as "user@gmail.com" with password "password"
Given A course with number 431 in "SPRING" 2017 exists for instructor "user@gmail.com"
Given An assignemnt "a1" exists for 431 in "SPRING" 2017
When I submit a new assignment "a1" for course number 431 with a due date "2017-04-21 08:00:00"
Then Create assignment should fail
And Only one assignment "a1" should exist for course 431 in "SPRING" 2017

# :( Sad Path
Scenario: Create assignment fails because the due date is not within an existing course
Given I am an instructor logged in as "user@gmail.com" with password "password"
Given A course with number 431 in "FALL" 2016 exists for instructor "user@gmail.com"
Given A course with number 431 in "SPRING" 2017 DOES NOT exist for instructor "user@gmail.com" 
When I submit a new assignment "a1" for course number 431 with a due date "2017-04-21 08:00:00"
Then Create assignment should fail