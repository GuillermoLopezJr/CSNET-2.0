class Course < ApplicationRecord
    belongs_to :instructor
    
    has_many :assignments, dependent: :destroy
end
