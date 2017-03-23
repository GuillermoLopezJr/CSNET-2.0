class Roster < ApplicationRecord
    
    mount_uploader :attachment, RosterUploader
    validates :course_num, presence: true
end
