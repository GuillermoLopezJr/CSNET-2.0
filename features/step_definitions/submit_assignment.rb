require 'aws-sdk'

Given(/^I am a student logged in as "(.*?)" with password "(.*?)"$/) do |email, pass|
  visit new_student_registration_path
  fill_in "email", :with => email
  fill_in "password", :with => pass
  fill_in "password2", :with => pass
  click_button "signup"
end

Given(/^Course (\d+) has an assignmnet "(.*?)"$/) do |course_number, assignment|
 @course = Course.find_by(number: course_number)
 expect( @course ).to be_truthy
 
 @course.assignments.create( course_num: course_number, name: assignment, due_date: Date.today)
end


Given(/^Student "(.*?)" is registered for course (\d+) in "(.*?)" (\d+)$/) do |email, course, semester, year| 
 @course = Course.find_by(number: course, session: semester, year: year)
 expect( @course ).to be_truthy
 
 @student = Student.find_by(email: email)
 expect( @student ).to be_truthy
 
 @course.students << @student 
end 


When(/^I select "(.*?)" and course (\d+) and select the filepath for my submission and submit$/) do |assignment, course_num|
 visit submissions_new_path
 fill_in "name", :with => "submission1"
 select assignment, from: "assignment_name"
 select course_num, from: "course_num"
 page.attach_file("submission", Rails.root + 'features/test_assets/test_pdf.pdf')
 click_button "submit"
end


Then(/^That document should be saved as a submission for student "(.*?)" for "(.*?)"$/) do |student, assignment|
 @student = Student.find_by(email: student)
 @assignment = Assignment.find_by(name: assignment)
 expect( @assignment ).to be_truthy  
 expect( @student ).to be_truthy

 @submission = @student.submissions.find_by(assignment: @assignment)
 expect( @submission ).to be_truthy
end
