class Submission < ApplicationRecord
    belongs_to :student
    belongs_to :assignment
    
    mount_uploader :attachment, SubmissionUploader # Tells rails to use this uploader for this model.
    validates :name, presence: true # Make sure the owner's name is present.
end
