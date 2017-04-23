
Given(/^A course with number (\d+) in "(.*?)" (\d+) exists for instructor "(.*?)"$/) do |number, semester, year, instructor|
 @instructor = Instructor.find_by( email: instructor)
 if (@instructor == nil) 
  @instructor = Instructor.create(email: instructor, password: "password", password_confirmation: "password")
 end
 expect( @instructor ).to be_truthy
 
 @instructor.courses.create(number: number, name: "Software Eng", year: year, session: semester)
 expect( Course.find_by( number: number)).to be_truthy
end


When(/^I submit a new assignment "(.*?)" for course number (\d+) with a due date "(.*?)"$/) do |name, number, due_date|
 visit assignments_new_path
 fill_in "name", :with => name
 select number, from: @courses
 fill_in "due_date", with: due_date
 click_button "submit"
end

Then(/^I should add an assignment "(.*?)" to the database$/) do |name|
    @a = Assignment.find_by( name: name )
    expect( @a ).to be_truthy
end


Given(/^An assignemnt "(.*?)" exists for (\d+) in "(.*?)" (\d+)$/) do |name, course_num, semester, year|
 @course = Course.find_by( number: course_num, year: year, session: semester)
 if (@course == nil)
  @course = Course.create(number: course_num, name: "Software Engineering", session: semester, year: year)
 end
 expect( @course ).to be_truthy
 
 @assignment = @course.assignments.create(name: name, course_num: course_num, due_date: "2000-01-01 00:00:00")
 expect( @assignment ).to be_truthy
end


Then (/^Create assignment should fail$/) do 
 expect(page).to have_content("Could not create")
end

And (/^Only one assignment "(.*?)" should exist for course (\d+) in "(.*?)" (\d+)$/) do |name, course_num, semester, year|
 @course = Course.find_by( number: course_num, year: year, session: semester)
 expect( @course ).to be_truthy
 
 @assignments = @course.assignments.where( name: name )
 expect( @assignments.size ).to eq(1)
end


Given(/^A course with number (\d+) in "(.*?)" (\d+) DOES NOT exist for instructor "(.*?)"$/) do |number, semester, year, instructor|
 @instructor = Instructor.find_by( email: instructor)
 if (@instructor == nil) 
  return 
 else 
  @course = @instructor.courses.find_by(number: number, year: year, session: semester)
 end
 expect( @course ).to be_nil
end