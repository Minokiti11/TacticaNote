require 'aws-sdk-s3'

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
      video = ActiveStorage::Attachment.find(params[:id])
      # @video = Video.find(params[:id])
      if video.purge && video.destroy
        redirect_to video_path
      else
        render :edit
      end
    end
  
    private
    def video_params
      params.require(:video).permit(:title, :introduction, :video)
    end
end
  