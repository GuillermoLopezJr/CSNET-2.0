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


Given(/^Student "(.*?)" is registered for course (\d+)$/) do |email, course| 
 @course = Course.find_by(number: course)
 expect( @course ).to be_truthy
 
 @student = Student.find_by(email: email)
 expect( @student ).to be_truthy
 
 @course.students << @student 
end 


When(/^I select "(.*?)" and enter select the filepath for my submission and submit$/) do |assignment|
 visit submissions_new_path
 fill_in "name", :with => "submission1"
 select assignment, from: @assignments
 page.attach_file("submission", Rails.root + 'features/test_assets/test_pdf.pdf')
 click_button "submit"
end


Then(/^That document should be saved as a submission for student "(.*?)"$/) do |student|
    @student = Student.find_by(email: student)
    @submission = @student.submissions.first
    expect( @submission ).to be_truthy
end
