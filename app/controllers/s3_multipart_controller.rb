class S3MultipartController < ApplicationController
    include Uppy::S3Multipart::ControllerHelper

    # フックメソッドをオーバーライドして認証を追加
    def auth_check
        unless user_signed_in?
        head :unauthorized
        return
        end
    end

    # アップロード完了時のコールバック
    def update_model(upload)
        # アップロード完了後の処理
        if params[:model_type] == 'video'
            video = Video.find(params[:model_id])
            video.movie.attach(
                key: upload.key,
                filename: upload.metadata['filename'],
                content_type: upload.metadata['contentType'],
                byte_size: upload.metadata['size']
            )
        end
    end
end