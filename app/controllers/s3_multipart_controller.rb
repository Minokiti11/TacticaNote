class S3MultipartController < ApplicationController
  # include Uppy::S3Multipart::ControllerHelper

  before_action :authenticate_user!
  before_action :set_upload_options, only: [:create, :batch_create]

  def auth_check
    true
  end

  def update_model(upload)
    begin
      if params[:model_type] == 'video'
        video = Video.find(params[:model_id])

        # ActiveStorage::Blobの作成とアタッチ
        blob = create_blob_for_upload(upload)
        video.video.attach(blob)

        render json: { success: true, video_id: video.id }, status: :ok
      else
        render json: { error: 'Invalid model type' }, status: :unprocessable_entity
      end
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Video not found' }, status: :not_found
    rescue StandardError => e
      Rails.logger.error "Error in update_model: #{e.message}"
      render json: { error: 'Internal server error' }, status: :internal_server_error
    end
  end

  private

  def set_upload_options
    # マルチパートアップロードのオプションを設定
    s3_client = Aws::S3::Client.new(
      region: Rails.application.config.active_storage.service_configurations[:amazon][:region],
      credentials: Aws::Credentials.new(
        Rails.application.config.active_storage.service_configurations[:amazon][:access_key_id],
        Rails.application.config.active_storage.service_configurations[:amazon][:secret_access_key]
      )
    )

    @upload_options = {
      acl: 'private',
      cache_control: 'max-age=31536000',
      client: s3_client,
      part_size: 104857600 # 100MB
    }
  end

  def create_blob_for_upload(upload)
    ActiveStorage::Blob.create_before_direct_upload!(
      filename: upload.metadata['filename'],
      byte_size: upload.metadata['size'],
      checksum: upload.metadata['checksum'],
      content_type: upload.metadata['contentType']
    ).tap do |blob|
      blob.update!(key: upload.key)
    end
  end
end