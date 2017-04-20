class Student < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_and_belongs_to_many :courses

  has_many :submissions
  
  attr_accessor :course_num, :course_year, :course_session
  
end
