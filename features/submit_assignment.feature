Feature: Upload submission
As a logged in student
So that I can submit an assignment to the instructor and get a grade
I want to add a submission to the database

Given I am a student logged in as "student@gmail.com" with password "password"
Given A course with number 431 exists
Given Course 431 has an assignmnet "assignmnet1"
Given Student "student@gmail.com" is registered for course 431
Given I am on the turnin form for assignment "assignment1"
When I enter select the filepath for my submission and submit
Then That document should be saved as a submission for that assignment
