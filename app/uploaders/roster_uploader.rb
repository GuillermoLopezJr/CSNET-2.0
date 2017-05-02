# This uploader is used to upload files.  Files are stored on Amazon S3 in a particular bucket.
# Check out /config/initializers/carrierwave.rb for the Amazon S3 Configuration
# and /config/application.yml to see and change the credentials of your Amazon S3 account.

class RosterUploader < CarrierWave::Uploader::Base

  # Tool to upload to Amazon S3
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  # storage :file
  storage :fog


  def store_dir
    # "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(xls)
  end


end
