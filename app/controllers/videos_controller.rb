class VideosController < ApplicationController
  def index
    @videos = Video.all
  end
  
  def new
    @video = Video.new
    @group = Group.find(session[:current_group_id])
  end

  def create
    @video = Video.new(video_params)
    p "current_user", current_user
    @video.user_id = current_user.id
    p "current_user.group_users:", current_user.group_users[0].group_id
    @video.group_id = current_user.group_users[0].group_id
    @video.video.attach(params[:video][:uploaded_video]) if params[:video][:uploaded_video].present?
    if @video.save
      redirect_to @video
    else
      render 'new'
    end
  end

  def register_blob
    blob = ActiveStorage::Blob.create_before_direct_upload!(
      filename: params[:blob][:filename],
      byte_size: params[:blob][:byte_size],
      checksum: params[:blob][:checksum],
      content_type: params[:blob][:content_type],
      key: params[:blob][:key],
    )
    p "key: " + params[:blob][:key]
    render json: { signed_id: blob.signed_id }
  end

  def show
    @video = Video.find_by(id: params[:id])
    @video_id = params[:id]
    @group = Group.find(@video.group_id)
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
    params.require(:video).permit(:id, :title, :introduction, :video, :uploaded_video)
  end
end