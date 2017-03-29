require 'rails_helper'

RSpec.describe Roster, type: :model do

  it "has a valid course number" do
    course = FactoryGirl.build(:course)
    roster = Roster.create!(course_num: course.number, attachment: "test.xls")
    expect(Roster.find_by(course_num: course.number)).to be_truthy
  end

  it "has a valid attachment" do
    course = FactoryGirl.build(:course)
    roster = Roster.create!(course_num: course.number, attachment: "test.xls")
    expect(Roster.find_by(attachment: roster.attachment_url)).to be_truthy
  end
  
end
