# encoding: utf-8

class AttachmentUploader < CarrierWave::Uploader::Base

  # S3 Upload helper
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  # storage :file
  # fog is used to upload to Amazon S3
  storage :fog

  # Override the directory where uploaded files will be stored.
  def store_dir
    #  Change the next line according to your desired directory
    # "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(pdf)
  end

end
