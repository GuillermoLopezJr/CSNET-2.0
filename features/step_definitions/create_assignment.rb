

Given(/^A course with number (\d+) exists$/) do |number|
 visit courses_new_path
 fill_in "name", :with => "Software Eng"
 fill_in "number", :with => number
 click_button "submit"
 expect( Course.find_by( number: number)).to be_truthy
end

When(/^I submit a new assignment form with number (\d+)$/) do |number|
 visit assignments_new_path
 fill_in "name", :with => "Reading 1"
 select number, from: @courses
 fill_in "due_date", with: "2017/01/01"
 click_button "submit"
end

Then(/^I should add an assignment to the database$/) do
    @a = Assignment.find_by( name: 'Reading 1', due_date: '2017/01/01')
    expect( @a ).to be_truthy
end
