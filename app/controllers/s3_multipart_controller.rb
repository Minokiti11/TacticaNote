class S3MultipartController < ApplicationController
  include Uppy::S3Multipart::ControllerHelper

  before_action :authenticate_user!

  def auth_check
    # すでにbefore_actionで認証を行っているため、
    # このメソッドは常にtrueを返します
    true
  end

  def update_model(upload)
    begin
      if params[:model_type] == 'video'
        video = Video.find(params[:model_id])
        
        # ActiveStorageのアタッチメントを作成
        blob = ActiveStorage::Blob.create_before_direct_upload!(
          filename: upload.metadata['filename'],
          byte_size: upload.metadata['size'],
          checksum: upload.metadata['checksum'],
          content_type: upload.metadata['contentType']
        )

        # S3のオブジェクトキーをActiveStorageのキーに変換
        blob.update!(key: upload.key)
        
        # ビデオモデルにアタッチ
        video.movie.attach(blob)
        
        # 処理が完了したことを示すレスポンスを返す
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

  def blob_attributes
    {
      filename: upload.metadata['filename'],
      byte_size: upload.metadata['size'],
      checksum: upload.metadata['checksum'],
      content_type: upload.metadata['contentType']
    }
  end
end