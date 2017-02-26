class Assignment < ApplicationRecord
  
  belongs_to :course
  
  validates :name, presence: true,
                    length: { minimum: 1 }
  validates :due_date, presence: true, 
                    length: { minimum: 6 }



end
