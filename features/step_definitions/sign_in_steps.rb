When(/^I enter credentials and click login$/) do
	visit after_sign_in_path_for_instructor
end

Then(/^I should be signed in and brought to home page$/) do
	expect(page).to have_content("You are signed in")
end