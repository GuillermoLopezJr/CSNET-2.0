require 'rails_helper'

RSpec.describe Course, :type => :model do

  it "has a valid name" do
    instr = FactoryGirl.build(:instructor)
    course = Course.create!(name: "csce", number: 233, :instructor => instr)
    expect(Course.find_by(name: "csce")).to be_truthy
  end

  it "has a valid number" do
    instr = FactoryGirl.build(:instructor)
    course = Course.create!(name: "csce", number: 233, :instructor => instr)
    expect(Course.find_by(number:233)).to be_truthy
  end
end
