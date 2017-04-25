
Given (/^A submission exists for "(.*?)" in (\d+) "(.*?)" (\d+) from student "(.*?)"$/) do |name, number, semester, year, student|
    @student = Student.find_by( email: student)
    expect(@student).to be_truthy
    
    @course = Course.create(0)
    @assignment = 
    @sub = Submission.create( )
end 

When (/^I visit the past submissions page$/) do
    visit submissions_path
end

Then (/^I should see the link to a submission for "(.*?)"$/) do |assignment|
    expect(page).to have_content(assignment)
end