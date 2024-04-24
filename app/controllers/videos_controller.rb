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
    @video = Video.find(params[:id])
    @group = Group.find(@video.group_id)
    p "This note is for: ", @group
  end

  def destroy
    video = ActiveStorage::Attachment.find(params[:id])
    @video = Video.find(params[:id])
    video.purge
    @video.destroy
    redirect_to videos_path
  end

  private
  def video_params
    params.require(:video).permit(:title, :introduction, :video)
  end
end
  