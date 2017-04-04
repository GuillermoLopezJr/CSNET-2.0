class Course < ApplicationRecord
    belongs_to :instructor
    
    has_many :assignments, dependent: :destroy
    has_and_belongs_to_many :students
    has_and_belongs_to_many :assistants
    

    validates :name, presence: true,
                    length: { minimum: 1 }
    validates :number, presence: true, 
                    length: { minimum: 3, maximum: 3 }
end
