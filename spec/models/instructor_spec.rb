require 'rails_helper'

RSpec.describe Instructor, :type => :model do

  it "has a valid email" do
    instructor = Instructor.create!(email: "user@gmail.com", password: "password")
    expect(Instructor.find_by(email: "user@gmail.com")).to be_truthy
  end
  
  it "has a valid password" do
    instructor = Instructor.create!(email: "user@gmail.com", password: "password")
    expect(instructor.password).to eq("password")
  end

end
