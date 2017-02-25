class Assignment < ApplicationRecord
  
  
  validates :name, presence: true,
                    length: { minimum: 1 }
  validates :due_date, presence: true, 
                    length: { minimum: 6 }



end
