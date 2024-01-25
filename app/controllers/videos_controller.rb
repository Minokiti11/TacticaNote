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
  
    private
  
    def video_params
      params.require(:video).permit(:title, :introduction, :video)
    end
end
  