class PracticesController < ApplicationController
    def show
        @practice = Practice.find(params[:id])
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
