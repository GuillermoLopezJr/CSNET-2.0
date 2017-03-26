Given (/^I am an admin instructor signed in as "(.*?)" with password "(.*?)"$/) do |email, password|
    Instructor.create!( email: email, password: password, password_confirmation: password, is_admin: true)
    
    visit new_instructor_session_path
    fill_in "email", :with => email
    fill_in "password", :with => password
    click_button "Sign in"
end

Given (/^I am on the add instructor account page$/) do
    visit instructor_new_path
end

When (/^I enter new instructor credentials "(.*?)" and "(.*?)" and submit$/) do |email, password|
    fill_in "email", :with => email
    fill_in "password", :with => password
    fill_in "password2", :with => password
    click_button "submit"
end 

Then (/^An instructor should exist in the database with email "(.*?)"$/) do |email|
    expect(Instructor.find_by(email: email)).to be_truthy
end 
#    (\d+)
#Given 
#When
#Then An instructor should exist in the database with email "user2@gmail.com"
