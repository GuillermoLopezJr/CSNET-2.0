When (/^I enter select course (\d+) and upload a roster with student "(.*?)" and "(.*?)" in it$/) do |number, email1, email2|
   visit rosters_new_path 
   select number, from: @courses
   page.attach_file("rooster", Rails.root + 'features/test_assets/test_rooster.xls') 
   click_button "Import"
end

Then (/^"(.*?)" and "(.*?)" should be added to course (\d+)$/) do |email1, email2, number|
    @course = Course.find_by(number: number)
    expect(@course).to be_truthy

    expect(@course.students.find_by(email: email1)).to be_truthy
    expect(@course.students.find_by(email: email2)).to be_truthy
end