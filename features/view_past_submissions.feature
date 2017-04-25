Feature: View past submissions:
As a logged in student
So that I can know what I turned in when
Display database data about what assignments this student has uploaded submissions for 

Scenario: Student views past submission
Given A course with number 431 in "SPRING" 2017 exists for instructor "user@gmail.com"
Given An assignment "assignment1" exists for course 431 "SPRING" 2017 which is due "2017-04-21 08:00:00"
Given I am a student logged in as "student@gmail.com" with password "password"
Given Student "student@gmail.com" is registered for course 431 in "SPRING" 2017
Given I select "assignment1" and course 431 and select the filepath for my submission and submit
When I visit the past submissions page
Then I should see the link to a submission for "assignment1"
