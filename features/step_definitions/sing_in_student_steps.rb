
Given(/^I am a student registered as "(.*?)" with password "(.*?)"$/) do |email, pass|
  #visit new_student_registration_path
  #fill_in "email", :with => email
  #fill_in "password", :with => pass
  #fill_in "password2", :with => pass
  #click_button "signup"
  #click_button "Logout"
  Student.create!({:email => email, :password => pass, :password_confirmation => pass})
end

Given(/^I am on the student login page$/) do
  visit new_student_session_path
end

When (/^I enter credentials "(.*?)" and "(.*?)" and submit$/) do |email, password|
  fill_in "email", :with => email
  fill_in "password", :with => password
  click_button "Sign in"
end




