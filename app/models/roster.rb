class Roster < ApplicationRecord
    
    mount_uploader :attachment, RosterUploader
    
    attr_accessor :course_num, :course_year, :course_session
    
    validates :course_num, presence: true
    validates :course_id, presence: true
end
