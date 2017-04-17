class Roster < ApplicationRecord
    
    mount_uploader :attachment, RosterUploader
    
    validates :course_num, presence: true
    validates :course_id, presence: true
end
