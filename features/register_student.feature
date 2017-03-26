Feature: Upload Howdy Registered Students File
As a logged in instructor
So that the students will see assignments posted to their courses
I want to upload the file of registered students from Howdy to the website that will parse it and add the students to the appropriate courses. 


Scenario: Instructor uploads course roster
Given I am an instructor logged in as "user@gmail.com" with password "password"
Given A course with number 431 exists
When I enter select course 431 and upload a roster with student "s1@gmail.com" and "s2@gmail.com" in it
Then "s1@gmail.com" and "s2@gmail.com" should be added to course 431