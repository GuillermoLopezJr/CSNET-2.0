Feature: View past submissions:
As a logged in student
So that I can know what I turned in when
Display database data about what assignments this student has uploaded submissions for 

Given I am a student logged in as "student@gmail.com" with password "password"
Given A course with number 431 exists
Given Course 431 has an assignmnet "assignmnet1"
Given Student "student@gmail.com" is registered for course 431
Given I have uploaded a file for "assignment1"
When I visit the past submissions page
Then I should see the link to a submission for "assignment1"
