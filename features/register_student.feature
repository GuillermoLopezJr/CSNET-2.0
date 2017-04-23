Feature: Upload Howdy Registered Students File
As a logged in instructor
So that the students will see assignments posted to their courses
I want to upload the file of registered students from Howdy to the website that will parse it and add the students to the appropriate courses. 


# :) Happy Path
Scenario: Instructor adds new student to course
Given I am an instructor logged in as "user@gmail.com" with password "password"
Given A course with number 431 in "SPRING" 2017 exists for instructor "user@gmail.com"
When I enter select course 431 in "SPRING" 2017 and add student "Jane" "Doe" "s1@gmail.com"
Then "Jane" "Doe" "s1@gmail.com" should be added to course 431 in "SPRING" 2017

# :) Happy Path
Scenario: Instructor adds existing student to course
Given I am an instructor logged in as "user@gmail.com" with password "password"
Given A course with number 431 in "SPRING" 2017 exists for instructor "user@gmail.com"
Given A student with email "s1@gmail.com" exists
When I enter select course 431 in "SPRING" 2017 and add student "Jane" "Doe" "s1@gmail.com"
Then "Jane" "Doe" "s1@gmail.com" should be added to course 431 in "SPRING" 2017
And One student with email "s1@gmail.com" exists

# :( Sad Path
Scenario: Instructor adds student to non-existant course
Given I am an instructor logged in as "user@gmail.com" with password "password"
Given A course with number 431 in "SPRING" 2017 exists for instructor "user@gmail.com"
Given A course with number 431 in "SUMMER" 2017 DOES NOT exist for instructor "user@gmail.com" 
When I enter select course 431 in "SUMMER" 2017 and add student "Jane" "Doe" "s1@gmail.com"
Then Add student should fail