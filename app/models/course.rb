class Course < ApplicationRecord
    belongs_to :instructor
    
    has_many :assignments, dependent: :destroy
    has_and_belongs_to_many :students
    
    validates :name, presence: true,
                    length: { minimum: 1 }
    validates :number, presence: true, 
                    length: { minimum: 3, maximum: 3 }
                    
    def addStudentToCourse( student )
       students << Student.find( student )
    end 
end
