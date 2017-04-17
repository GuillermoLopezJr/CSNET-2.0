
Given(/^I am an instructor logged in as "(.*?)" with password "(.*?)"$/) do |email, pass|
  visit new_instructor_registration_path
  fill_in "email", :with => email
  fill_in "password", :with => pass
  fill_in "password2", :with => pass
  click_button "signup"
end

When(/^I submit a new course form$/) do
 visit courses_new_path
 fill_in "name", :with => "Software Eng"
 fill_in "number", :with => 431
 fill_in "year", :with => "2017"
 #fill_in "session", :with => "SPRING"
 select "SPRING", from: "course_session"
 click_button "submit"
end

Then(/^I should add a course to the database$/) do
    @c = Course.find_by( name: 'Software Eng', number: 431 )
    expect( @c ).to be_truthy
end
