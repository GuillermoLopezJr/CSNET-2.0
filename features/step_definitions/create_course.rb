
Given(/^I am an instructor logged in as "(.*?)" with password "(.*?)"$/) do |email, pass|
 @instructor = Instructor.find_by( email: email)
 if (@instructor == nil) 
  @instructor = Instructor.create(email: email, password: pass, password_confirmation: pass)
 end
 expect( @instructor ).to be_truthy
 
 visit new_instructor_session_path
 fill_in "email", :with => email
 fill_in "password", :with => pass
 click_button "signin"
 expect(page).to have_content("Welcome,")
end

       
When(/^I submit a new course form with name "(.*?)" number (\d+) and semester "(.*?)" (\d+)$/) do |name, number, semester, year|
 visit courses_new_path
 fill_in "name", :with => name
 fill_in "number", :with => number
 fill_in "year", :with => year
 select semester, from: "course_session"
 click_button "submit"
end


Then(/^I should add a course (\d+) in "(.*?)" (\d+) to "(.*?)"s course list$/) do |course_num, semester, year, instructor|
 @instructor = Instructor.find_by( email: instructor)
 expect( @instructor ).to be_truthy
 
 @course = @instructor.courses.find_by( number: course_num, session: semester, year: year)
 expect( @course ).to be_truthy
end


Then(/^Course creation should fail$/) do
 expect(page).to have_content("Could not create course")
end