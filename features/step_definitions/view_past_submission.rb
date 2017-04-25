
Given (/^A submission exists for "(.*?)" in (\d+) "(.*?)" (\d+) from student "(.*?)"$/) do |name, course_num, semester, year, student|
    @student = Student.find_by( email: student)
    expect(@student).to be_truthy
    
    @course = @student.courses.find_by(number: course_num, session: semester, year: year)
    expect(@course).to be_truthy
    
    @assignment = @course.assignments.find_by(name: name)
    expect(@assignment).to be_truthy
    
    @sub = Submission.create( name: "submission1")
end 


When (/^I visit the past submissions page$/) do
    visit submissions_path
end


Then (/^I should see the link to a submission for "(.*?)"$/) do |assignment|
    expect(page).to have_content(assignment)
end