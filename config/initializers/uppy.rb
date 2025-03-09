require 'uppy/s3_multipart'

Uppy.configure do |config|
  config.upload_options[:acl] = 'private'
  config.upload_options[:cache_control] = 'max-age=31536000'
end