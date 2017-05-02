
# This uploader is used to upload files.  Files are stored on Amazon S3 in a particular bucket.
# Check out /config/initializers/carrierwave.rb for the Amazon S3 Configuration
# and /config/application.yml to see and change the credentials of your Amazon S3 account.

class SubmissionUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  # storage :file
  # fog is used to upload to Amazon S3
  storage :fog 

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    # =============== Leave this function empty for s3
    # "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
     %w(jpg jpeg gif png pdf doc docx)
 end
end
