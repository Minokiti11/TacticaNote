class PracticesController < ApplicationController
    def show
        @practice = Practice.find(params[:id])
        if !(session[:current_group_id].to_i == @practice.group_id)
            @group = Group.find(@practice.group_id)
            @videos = @group.videos
            @feeds = @group.notes.order('created_at DESC').first(7)
            @recent_videos = @videos.where("created_at > ?", Time.now - 14.days)
            @timeline = (@feeds + @recent_videos).sort_by(&:created_at).reverse
            render "groups/show"
        end
    end

    def new
        @practice = Practice.new
    end

    def create
        @practice = Practice.new(practice_params)
        @practice.group_id = session[:current_group_id]
        if @practice.save
            redirect_to @practice
        else
            flash.now[:alert] = "有効なURLを入力してください"
            render "new"
        end
    end

    def edit
        @practice = Practice.find(params[:id])
    end

    def update
        @practice = Practice.find(params[:id])
        if @practice.update(practice_params)
            redirect_to practice_path(@practice)
        else
            render "edit"
        end
    end

    def destroy
        @practice = Practice.find(params[:id])
        if @practice.destroy
            redirect_to practices_path
        end
    end

    private
    def practice_params
        params.require(:practice).permit(:id, :name, :issue, :number_of_people, :introduction, :key_points, :applicable_situation, :links)
    end
end
