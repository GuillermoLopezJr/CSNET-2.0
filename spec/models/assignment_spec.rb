require 'rails_helper'
RSpec.describe Assignment, :type => :model do

  it "has a valid name" do
    course = FactoryGirl.build(:course)
    assign = Assignment.create!(due_date: "2/13/17", name: "hw1", :course => course)
    expect(Assignment.find_by(name: "hw1")).to be_truthy
  end

  it "has a valid due date" do
    course = FactoryGirl.build(:course)
    assign = Assignment.create!(due_date: "2/13/17", name: "hw1", :course => course)
    expect(Assignment.find_by(due_date: "2/13/17")).to be_truthy
  end

end
