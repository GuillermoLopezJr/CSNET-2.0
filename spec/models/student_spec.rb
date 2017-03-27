require 'rails_helper'

RSpec.describe Student, :type => :model do

  it "has a valid email" do
    student = Student.create!(email: "user@gmail.com", password: "password")
    expect(Student.find_by(email: "user@gmail.com")).to be_truthy
  end
  
  it "has a valid password" do
    student = Student.create!(email: "user@gmail.com", password: "password")
    expect(student.password).to eq("password")
  end

end
