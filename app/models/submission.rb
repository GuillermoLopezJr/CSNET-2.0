class Submission < ApplicationRecord
    belongs_to :student
    belongs_to :assignment
    
    attr_accessor :course_num, :course_year, :course_session
    
    mount_uploader :attachment, SubmissionUploader # Tells rails to use this uploader for this model.
    validates :name, presence: true # Make sure the owner's name is present.
    validates :attachment, presence: true # Make sure the owner's name is present.

    validates :assignment, presence: true # Make sure the owner's name is present.

end
