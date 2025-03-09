require 'uppy/s3_multipart'

Uppy::S3Multipart.configure do |config|
  config.upload_options = {
    acl: 'private',
    cache_control: 'max-age=31536000'
  }
end