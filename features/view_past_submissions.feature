Feature: View past submissions:
As a logged in student
So that I can know what I turned in when
Display database data about what assignments this student has uploaded submissions for 

Scenario: Student views past submission
Given A course with number 431 exists for instructor "user@gmail.com"
Given Course 431 has an assignmnet "assignment1"
Given I am a student logged in as "student@gmail.com" with password "password"
Given Student "student@gmail.com" is registered for course 431
Given I select "assignment1" and enter select the filepath for my submission and submit
When I visit the past submissions page
Then I should see the link to a submission for "assignment1"
