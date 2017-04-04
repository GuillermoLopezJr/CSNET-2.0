class Assignment < ApplicationRecord
  
  belongs_to :course
  
  has_many :submissions, dependent: :destroy
  
  validates :name, presence: true,
                    length: { minimum: 1 }
  validates :due_date, presence: true, 
                    length: { minimum: 6 }
    

    #ADDED FOR UPLOADING FILES 
  mount_uploader :attachment, AttachmentUploader # Tells rails to use this uploader for this model.
  
end
