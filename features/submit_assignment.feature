Feature: Upload submission
As a logged in student
So that I can submit an assignment to the instructor and get a grade
I want to add a submission to the database

Scenario: Student uploads a submission
Given A course with number 431 exists for instructor "user@gmail.com"
Given Course 431 has an assignmnet "assignment1"
Given I am a student logged in as "student@gmail.com" with password "password"
Given Student "student@gmail.com" is registered for course 431
When I select "assignment1" and enter select the filepath for my submission and submit
Then That document should be saved as a submission for student "student@gmail.com"
