Feature: Edit an assignment
As a logged in instructor
So that I can correct/fix an existing assignment
I want to select an assignment from a list and be able to edit the title, due date, and description.

Scenario: Instructor edit assignment
Given I am an instructor logged in as "user@gmail.com" with password "password"
Given A course with number 134 exists for instructor "user@gmail.com"
Given A course with number 431 exists for instructor "user@gmail.com"
Given An assignment with course 134 exists
When I submit an edit assignment form on the assignment from 134, changing it to course 431
Then I should change an assignment from course 134 to course 431 in the database