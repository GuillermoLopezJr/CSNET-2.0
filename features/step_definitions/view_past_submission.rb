
When (/^I visit the past submissions page$/) do
    visit submissions_path
end

Then (/^I should see the link to a submission for "(.*?)"$/) do |assignment|
    expect(page).to have_content(assignment)
end