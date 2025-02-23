class VideosController < ApplicationController
  def index
    @videos = Video.all
  end
  
  def new
    @video = Video.new
  end

  def create
    @video = Video.new(video_params)
    p "current_user", current_user
    @video.user_id = current_user.id
    p "current_user.group_users:", current_user.group_users[0].group_id
    @video.group_id = current_user.group_users[0].group_id
    if @video.save
      redirect_to @video
    else
      render 'new'
    end
  end

  def show
    @video = Video.find_by(id: params[:id])
    
    if @video.nil?
      redirect_to videos_path, alert: '指定されたビデオは存在しません'
      return
    end

    unless @video.video.attached?
      redirect_to videos_path, alert: 'ビデオファイルが見つかりません'
      return
    end

    begin
      # blobの情報をログ出力
      logger.debug "Video Blob Info:"
      logger.debug "  Blob ID: #{@video.video.blob.id}"
      logger.debug "  Blob Key: #{@video.video.blob.key}"
      logger.debug "  Content Type: #{@video.video.content_type}"
      logger.debug "  Byte Size: #{@video.video.blob.byte_size}"
      
      # ファイルの存在確認を試みる
      @video.video.blob.open do |file|
        logger.debug "Video file exists at: #{file.path}"
        logger.debug "File size: #{File.size(file.path)} bytes"
      end

      # URLの生成をログ出力
      blob_url = rails_blob_path(@video.video)
      logger.debug "Generated Blob URL: #{blob_url}"
      
    rescue ActiveStorage::FileNotFoundError => e
      logger.error "Video file not found: #{e.message}"
      logger.error "Backtrace:\n\t#{e.backtrace.join("\n\t")}"
      redirect_to videos_path, alert: 'ビデオファイルの読み込みに失敗しました'
      return
    rescue StandardError => e
      logger.error "Error accessing video file: #{e.message}"
      logger.error "Backtrace:\n\t#{e.backtrace.join("\n\t")}"
      redirect_to videos_path, alert: 'ビデオファイルへのアクセスに失敗しました'
      return
    end

    @video_id = params[:id]
    @group = Group.find(@video.group_id)
  end

  def destroy
    # video = ActiveStorage::Attachment.find(params[:id])
    @video = Video.find(params[:id])
    @video.video.purge
    @video.destroy
    redirect_to videos_path
  end

  private
  def video_params
    params.require(:video).permit(:id, :title, :introduction, :video)
  end
end
  