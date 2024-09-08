class DailyPracticeItemsController < ApplicationController
    def destroy
        @daily_practice_item = DailyPracticeItem.find(params[:id])
        if @daily_practice_item.destroy
            if session[:current_group_id]
                redirect_to group_path(session[:current_group_id], anchor: 'write_note')
            else
                redirect_to group_path(1, anchor: 'write_note')
            end
            
        end
    end
end
