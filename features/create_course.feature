Feature: Create a course
As a logged in instructor
So that I can add organize my assignments and students by course
I want to add a course to the database

# :) Happy Path
Scenario: Instructor creates a new course
Given I am an instructor logged in as "user@gmail.com" with password "password"
When I submit a new course form with name "Software Engineering" number 431 and semester "SPRING" 2017
Then I should add a course 431 in "SPRING" 2017 to "user@gmail.com"s course list

# :( Sad Path 
Scenario: Course creation fails because it is a duplicate
Given I am an instructor logged in as "user@gmail.com" with password "password"
Given A course with number 431 in "SPRING" 2017 exists for instructor "user@gmail.com"
When I submit a new course form with name "Software Engineering" number 431 and semester "SPRING" 2017
Then Course creation should fail