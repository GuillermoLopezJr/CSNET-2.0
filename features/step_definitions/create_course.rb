When(/^I submit new course form$/) do
	
end

Then(/^I should add a course to the database$/) do
	expect(Course).to have_content("You are signed in")
end
