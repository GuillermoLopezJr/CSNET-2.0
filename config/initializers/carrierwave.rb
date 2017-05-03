# # config/initializers/carrierwave.rb
# https://gist.github.com/cblunt/1303386/b47377dfbddd7a29af087a64660464dfd35392d3

# This code is used to configure AWS.  It works with the Carrierwave gem to upload things.

CarrierWave.configure do |config|
config.root = Rails.root.join('tmp')
config.cache_dir = 'carrierwave'

config.fog_credentials = {
  # Configuration for Amazon S3
  :provider               => 'AWS',                            # change var's name
  :aws_access_key_id      => ENV['AWS_ACCESS_KEY_ID'],         # SEE /config/application.yml TO CHANGE YOUR ACCESS KEYS!!!!!
  :aws_secret_access_key  => ENV['AWS_SECRET_ACCESS_KEY'],
  :region                 => 'us-west-2',
}
 config.fog_directory  = '431storage'
end
