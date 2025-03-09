require 'uppy/s3_multipart'

# S3マルチパートアップロードの基本設定
Uppy::S3Multipart::App.opts[:upload_options] = {
  acl: 'private',
  cache_control: 'max-age=31536000'
}