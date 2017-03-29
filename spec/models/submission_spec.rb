require 'rails_helper'

RSpec.describe Submission, :type => :model do

  it "has a student email" do
    stud = FactoryGirl.build(:student)
    sub = Submission.create!(name: "my_sub", assignment: "hw1", attachment: "hw1", :student => stud)
    expect(Submission.find_by(student: stud)).to be_truthy
  end

  it "has a valid assignment" do
    stud = FactoryGirl.build(:student)
    sub = Submission.create!(name: "my_sub", assignment: "hw1", attachment: "hw1", :student => stud)
    expect(Submission.find_by(assignment: "hw1")).to be_truthy
  end

  it "has a attachment" do
    stud = FactoryGirl.build(:student)
    sub = Submission.create!(name: "my_sub", assignment: "hw1", attachment: "hw1", :student => stud)
    expect(Submission.find_by(attachment: sub.attachment_url )).to be_truthy
  end

  it "has a valid submission name" do
    stud = FactoryGirl.build(:student)
    sub = Submission.create!(name: "my_sub", assignment: "hw1", attachment: "hw1", :student => stud)
    expect(Submission.find_by(name: "my_sub")).to be_truthy
  end

end
