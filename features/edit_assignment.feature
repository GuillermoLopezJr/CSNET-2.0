Feature: Edit an assignment
As a logged in instructor
So that I can correct/fix an existing assignment
I want to select an assignment from a list and be able to edit the title, due date, and description.

# :) Happy Path
Scenario: Instructor edit assignment
Given I am an instructor logged in as "user@gmail.com" with password "password"
Given A course with number 431 in "SPRING" 2017 exists for instructor "user@gmail.com"
Given An assignment "a1" exists for course 431 "SPRING" 2017 which is due "2017-04-21 08:00:00"
When I submit an edit assignment form to change the due date for "a1" in 431 "SPRING" 2017 to "2017-04-25 10:00:00" 
Then The due date saved in the database for "a1" in 431 "SPRING" 2017 should be "2017-04-25 10:00:00"