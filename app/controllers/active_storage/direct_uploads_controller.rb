# frozen_string_literal: true

# based on https://github.com/rails/rails/blob/v6.1.4.6/activestorage/app/controllers/
class ActiveStorage::DirectUploadsController < ActiveStorage::BaseController
    # override
    def initialize
        # このController経由でアップロードされたファイルに設定する共通prefix
        @prefix = 'activestorage/blobs/uploaded' 
    end

    # override
    # ActiveStorage::Blob.create_before_direct_upload!() に設定する key を明示的に指定するようにする
    def create
        key = File.join(@prefix, ActiveStorage::Blob.generate_unique_secure_token)
        blob = ActiveStorage::Blob.create_before_direct_upload!(key: key, **blob_args) # key は引数などで外から指定されない想定
        # blob.key = File.join(@prefix, blob.key) # create_before_direct_upload! の時点でDBレコードが作成されてしまうので、ここでkeyを上書きしても遅い
        render json: direct_upload_json(blob)
    end

    private
    def blob_args
        params.require(:blob).permit(:filename, :byte_size, :checksum, :content_type, metadata: {}).to_h.symbolize_keys
    end

    def direct_upload_json(blob)
        blob.as_json(root: false, methods: :signed_id).merge(direct_upload: {
        url: blob.service_url_for_direct_upload,
        headers: blob.service_headers_for_direct_upload
        })
    end
end