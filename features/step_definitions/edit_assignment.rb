
Given(/^An assignment "(.*?)" exists for course (\d+) "(.*?)" (\d+) which is due "(.*?)"$/) do |name, course_num, semester, year, due_date|
  @c1 = Course.find_by( number: course_num, session: semester, year: year)
  expect( @c1 ).to be_truthy
  
  @a1 = @c1.assignments.create(name: name, course_num: course_num, due_date: due_date)
  expect( @a1 ).to be_truthy
end


When(/^I submit an edit assignment form to change the due date for "(.*?)" in (\d+) "(.*?)" (\d+) to "(.*?)"$/) do |name, course_num, semester, year, new_due_date|
  
  @course = Course.find_by( number: course_num, session: semester, year: year)
  expect( @course ).to be_truthy
  
  @assignment = @course.assignments.find_by(name: name)
  expect( @assignment ).to be_truthy
  
  visit "/assignments/#{@assignment.id}/edit"
  fill_in "name", :with => name
  fill_in "due_date", with: new_due_date
  click_button "submit" 
end


Then(/^The due date saved in the database for "(.*?)" in (\d+) "(.*?)" (\d+) should be "(.*?)"$/)  do |name, course_num, semester, year, new_due_date|
  @course = Course.find_by( number: course_num, session: semester, year: year)
  expect( @course ).to be_truthy
  
  @assignment = @course.assignments.find_by(name: name)
  expect( @assignment ).to be_truthy
  
  expect( @assignment.due_date ).to eq(new_due_date)
end