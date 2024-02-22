class VideosController < ApplicationController
    def index
        @videos = Video.all
    end
    
    def new
      @video = Video.new
    end
  
    def create
      @video = Video.new(video_params)
      if @video.save
        redirect_to @video
      else
        render 'new'
      end
      
    end
  
    def show
      @video = Video.find(params[:id])
    end

    def destroy
      @video = ActiveStorage::Attachment.find(params[:id])
      
      if @video.video.attached?
        if @video.purge && @video.destroy
          render :index
        else
          # render :edit
        end
      else
        if @video.destroy
          redirect_to :index
        else
          # render :edit
        end
      end
    end
  
    private
    def video_params
      params.require(:video).permit(:title, :introduction, :video)
    end
end
  