
When (/^I enter select course (\d+) in "(.*?)" (\d+) and add student "(.*?)" "(.*?)" "(.*?)"$/) do |number, semester, year, first_name, last_name, email|
  visit new_student_path 
  
  @courses = Instructor.first.courses
  expect(@courses).to be_truthy
   
  select number, from: "course_num"
  select year, from: "course_year"
  select semester, from: "course_session"
  fill_in "f_name", :with => first_name
  fill_in "l_name", :with => last_name
  fill_in "email", :with => email
  #page.attach_file("roster", Rails.root + 'features/test_assets/test_rooster.xls') 
  click_button "Submit"
end


Then (/^"(.*?)" "(.*?)" "(.*?)" should be added to course (\d+) in "(.*?)" (\d+)$/) do |first_name, last_name, email, number, semester, year|
  @course = Course.find_by(number: number, session: semester, year: year)
  expect(@course).to be_truthy

  expect(@course.students.find_by(email: email, first_name: first_name, last_name: last_name)).to be_truthy
end


Given (/^A student with email "(.*?)" exists$/) do |email|
  @student = Student.find_by( email: email)
  if (@student == nil)
    @student = Student.create( first_name: "Jane", last_name: "Doe", email: email, password: "password", password_confirmation: "password" )
  end
  
  expect(@student).to be_truthy
end


And (/^One student with email "(.*?)" exists$/) do |email|
  @students = Student.where( email: email )
  expect( @students.size ).to eq(1)
end


Then (/^Add student should fail$/) do 
  expect(page).to have_content("Could not add student")
end