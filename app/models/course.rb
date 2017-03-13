class Course < ApplicationRecord
    belongs_to :instructor
    
    has_many :assignments, dependent: :destroy
    has_many :students, dependent: :destroy
    
    validates :name, presence: true,
                    length: { minimum: 1 }
    validates :number, presence: true, 
                    length: { minimum: 3, maximum: 3 }
end
