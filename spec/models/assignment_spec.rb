#require 'spec_helper'
require 'rails_helper'

RSpec.describe Assignment, :type => :model do
  #it "is valid with valid attributes" do
    #expect(Assignment.new).to be_valid
  #end
  it "has a valid due_date" do
    assignment1 = Assignment.create!(name: "hw1", due_date: "2/10/17")
    expect(assignment1.due_date).to eq("2/10/17")
  end
    #it "has a valid name"
end
