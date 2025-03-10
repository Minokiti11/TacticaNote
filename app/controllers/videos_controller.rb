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
    @video_id = params[:id]
    @group = Group.find(@video.group_id)

    # begin
    #   # blobの情報をログ出力
    #   logger.debug "Video Blob Info:"
    #   logger.debug "  Blob ID: #{@video.video.blob.id}"
    #   logger.debug "  Blob Key: #{@video.video.blob.key}"
    #   logger.debug "  Content Type: #{@video.video.content_type}"
    #   logger.debug "  Byte Size: #{@video.video.blob.byte_size}"
    # rescue ActiveStorage::FileNotFoundError => e
    #   logger.error "Video file not found: #{e.message}"
    #   logger.error "Backtrace:\n\t#{e.backtrace.join("\n\t")}"
    #   redirect_to group_video_path(@group.id), alert: 'ビデオファイルの読み込みに失敗しました'
    #   return
    # rescue StandardError => e
    #   logger.error "Error accessing video file: #{e.message}"
    #   logger.error "Backtrace:\n\t#{e.backtrace.join("\n\t")}"
    #   redirect_to group_video_path(@group.id), alert: 'ビデオファイルへのアクセスに失敗しました'
    #   return
    # end


  end

  def destroy
    # video = ActiveStorage::Attachment.find(params[:id])
    @video = Video.find(params[:id])
    @video.video.purge
    @video.destroy
    redirect_to group_video_path(session[:current_group_id])
  end

  private
  def video_params
    params.require(:video).permit(:id, :title, :introduction, :video)
  end
end
  