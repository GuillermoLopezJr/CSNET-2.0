Feature: Upload submission
As a logged in student
So that I can submit an assignment to the instructor and get a grade
I want to add a submission to the database

Scenario: Student uploads a submission
Given A course with number 431 in "SPRING" 2017 exists for instructor "user@gmail.com"
Given An assignment "assignment1" exists for course 431 "SPRING" 2017 which is due "2017-04-21 08:00:00"
Given I am a student logged in as "student@gmail.com" with password "password"
Given Student "student@gmail.com" is registered for course 431 in "SPRING" 2017
When I select "assignment1" and course 431 and select the filepath for my submission and submit
Then That document should be saved as a submission for student "student@gmail.com" for "assignment1"
