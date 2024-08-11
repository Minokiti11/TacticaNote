class NotesController < ApplicationController
    ## LLMを使わないデバッグモードに
    @@debug = false

    @@with_video = false
    @@video_id = nil

    def index
        @notes = Note.all
    end
    
    def new
        @note = Note.new
        @@with_video = params[:with_video]
        @with_video = params[:with_video]
        if @@with_video
            @@video_id = params[:video_id]
            @video_id = params[:video_id]
        end
    end

    def gpt_api_request_good
        data = params.require(:data).permit(:value)
        if !@@debug && !(data == nil) && !(data[:value] == "")
            response = Response.create(section_type: "good", input: data["value"])

            Turbo::StreamsChannel.broadcast_replace_later_to(
                "user_#{session.id}",
                target: "notes_good",
                partial: "notes/message",
                locals: { message: "", target: "notes_good" }
            )
            
            GetAiResponse.perform_async("user_#{session.id}", data[:value], "good", response.id)
            # スピナーを開始
            Turbo::StreamsChannel.broadcast_replace_later_to(
                "spinner",
                target: "spinner_good",
                partial: "spinner/show",
                locals: {target: "spinner_good"}
            )
        end
    end

    def gpt_api_request_bad
        data = params.require(:data).permit(:value)
        if !@@debug && !(data == nil) && !(data[:value] == "")
            response = Response.create(section_type: "bad", input: data["value"])

            Turbo::StreamsChannel.broadcast_replace_later_to(
                "user_#{session.id}",
                target: "notes_bad",
                partial: "notes/message",
                locals: { message: "", target: "notes_bad" }
            )

            GetAiResponse.perform_async("user_#{session.id}", data[:value], "bad", response.id)


            # スピナーを開始
            Turbo::StreamsChannel.broadcast_replace_later_to(
                "spinner",
                target: "spinner_bad",
                partial: "spinner/show",
                locals: {target: "spinner_bad"}
            )
        end
    end

    def gpt_api_request_next
        data = params.require(:data).permit(:value)
        if !@@debug && !(data == nil) && !(data[:value] == "")
            response = Response.create(section_type: "next", input: data["value"])

            Turbo::StreamsChannel.broadcast_replace_later_to(
                "user_#{session.id}",
                target: "notes_next",
                partial: "notes/message",
                locals: { message: "", target: "notes_next" }
            )

            GetAiResponse.perform_async("user_#{session.id}", data[:value], "next", response.id)
            # スピナーを開始
            Turbo::StreamsChannel.broadcast_replace_later_to(
                "spinner",
                target: "spinner_next",
                partial: "spinner/show",
                locals: {target: "spinner_next"}
            )
        end
    end

    def create
        @note = Note.new(note_params)
        @note.user_id = current_user.id
        @note.group_id = current_user.group_users[0].group_id
        @note.note_type = "good_bad_next_discuss"
        if @@with_video
            @note.video_id = @@video_id
        end
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
            redirect_to group_path(@note.group)
        end
    end

    private
    def note_params
        params.require(:note).permit(:id, :title, :note_type, :content, :good, :bad, :next, :discuss)
    end
end
