class NotesController < ApplicationController
    def index
        @notes = Note.all
    end
    
    def new
        @note = Note.new
    end

    def create
        @note = Note.new(note_params)
        @note.user_id = current_user.id
        @note.group_id = current_user.group_users[0].group_id
        if @note.save
            redirect_to @note
        else
            render 'new'
        end
    end

    def show
        @note = Note.find(params[:id])
    end

    def destroy
        @note = Note.find(params[:id])
        if @note.destroy
            redirect_to notes_path
        end
    end

    private
    def note_params
        params.require(:note).permit(:id, :good, :bad, :next)
    end
end
