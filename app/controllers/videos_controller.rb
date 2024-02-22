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
      s3 = Aws::S3::Resource.new(client: Aws::S3::Client.new(http_wire_trace: true))
      if s3.bucket(ARGV[0]).exists?
        puts "Bucket #{ARGV[0]} exists"
      else
        puts "Bucket #{ARGV[0]} does not exist"
      end
      
      video = ActiveStorage::Attachment.find(params[:id])
      @video = Video.find(params[:id])
      if video.purge && @video.destroy
        redirect_to videos_path
      else
        render :edit
      end
    end
  
    private
    def video_params
      params.require(:video).permit(:title, :introduction, :video)
    end
end
  