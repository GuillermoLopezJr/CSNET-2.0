class Roster < ApplicationRecord
    mount_uploader :attachment, AttachmentUploader
    validates :course_num, presence: true
end
