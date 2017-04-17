class Course < ApplicationRecord
    belongs_to :instructor
    
    has_many :assignments, dependent: :destroy
    has_and_belongs_to_many :students
    has_and_belongs_to_many :assistants
    

    validates :name, presence: true,
                    length: { minimum: 1 }
    validates :number, presence: true, 
                    length: { minimum: 3, maximum: 3 }
    
    validates :year, presence: true,
                    length: { minimum: 4, maximum: 4 }

    validates :session, presence: true,
                    length: { minimum: 1}

    @sessions = ['FALL', 'SPRING', 'SUMMER']
    def self.getSessions
      @sessions
    end
end
