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

    @video_id = params[:id]
    @group = Group.find(@video.group_id)

  rescue ActiveStorage::FileNotFoundError
    redirect_to videos_path, alert: 'ビデオファイルの読み込みに失敗しました'
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
  