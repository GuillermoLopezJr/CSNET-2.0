
Given(/^An assignment with course (\d+) exists$/) do |number|
  visit assignments_new_path
  fill_in "name", :with => "Reading 1"
  select number, from: @courses
  fill_in "due_date", with: "2017/01/01"
  click_button "submit" 
  expect( Assignment.find_by( course_num: number)).to be_truthy
end

When(/^I submit an edit assignment form on the assignment from (\d+), changing it to course (\d+)$/) do |oldNum, newNum|
  @assignment = Assignment.find_by( course_num: oldNum)
  visit "/assignments/#{@assignment.id}/edit"
  fill_in "name", :with => "Reading 2"
  select newNum, from: @courses
  fill_in "due_date", with: "2017/02/02"
  click_button "submit" 
end

Then(/^I should change an assignment from course (\d+) to course (\d+) in the database$/)  do |oldNum, newNum|
    @aOld = Assignment.find_by( course_num: oldNum )
    @aNew = Assignment.find_by( name: 'Reading 2', course_num: newNum, due_date: "2017/02/02")
    expect( @aNew ).to be_truthy
    expect( @aOld ).to be_nil
end