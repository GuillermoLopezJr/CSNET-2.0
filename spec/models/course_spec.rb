require 'rails_helper'

RSpec.describe Course, :type => :model do
  it "has a valid name" do
    course = Course.create!(name: "csce-313", number: 233)

    t = User.reflect_on_association(:instructor)
    t.macro.should == :belongs_to

    expect(@Course.name).to be_valid
  end
  #it "has a valid name"
end
