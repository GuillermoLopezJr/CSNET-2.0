#World(Devise::TestHelpers)

Given(/^I am an instructor registered as "(.*?)" with password "(.*?)"$/) do |email, pass|
  #visit new_instructor_registration_path
  #fill_in "email", :with => email
  #fill_in "password", :with => pass
  #fill_in "password2", :with => pass
  #click_button "signup"
  #click_button "Logout"
  Instructor.create!({:email => email, :password => pass, :password_confirmation => pass})
end

Given(/^I am on the instructor login page$/) do
  visit new_instructor_session_path
end

When (/^I enter credentials "(.*?)" and "(.*?)" at sign in page$/) do |email, password|
  visit new_instructor_session_path
  fill_in "email", :with => email
  fill_in "password", :with => password
  click_button "Sign in"
end

Then (/^I should be signed in and brought to home page$/) do
	expect(page).to have_content("Signed in successfully")
end

