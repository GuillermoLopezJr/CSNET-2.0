require 'rails_helper'

RSpec.describe Roster, type: :model do

  it "has a valid course num" do
    course = FactoryGirl.build(:course)
    roster = Roster.create!(course_num: course.number, attachment: nil)
    expect(Roster.find_by(course_num: course.number)).to be_truthy
  end
  
end
