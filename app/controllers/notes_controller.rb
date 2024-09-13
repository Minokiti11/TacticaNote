class NotesController < ApplicationController
    ## LLMを使わないデバッグモードに
    @@debug = false

    @@with_video = false
    @@note_for = ""
    @@video_id = nil

    def index
        @notes = Note.all
    end
    
    def new
        @note = Note.new
        @@with_video = params[:with_video]
        @with_video = params[:with_video]
        @@note_for = params[:note_for]
        if @@with_video
            @@video_id = params[:video_id]
            @video_id = params[:video_id]
        end
    end

    def gpt_api_request_good
        data = params.require(:data).permit(:value, :group_id)

        if data[:value].present?
            same_session_id_responses = Response.where(section_type: "good", session_id: session.id.to_s)
            if same_session_id_responses.length != 0 && same_session_id_responses
                previous_data = same_session_id_responses.last.input
                if previous_data.present?
                    similar = check_content_similarity(previous_data, data[:value])
                    return if similar
                end
            end
        end
        
        if !@@debug && !(data == nil) && !(data[:value] == "")
            response = Response.create(section_type: "good", input: data["value"], session_id: session.id.to_s)

            Turbo::StreamsChannel.broadcast_replace_later_to(
                "user_#{session.id}",
                target: "notes_good",
                partial: "notes/message",
                locals: { message: "", target: "notes_good" }
            )
            
            GetAiResponse.perform_async(@@note_for, "user_#{session.id}", data[:value], "good", current_user.id, data[:group_id], response.id)
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
        data = params.require(:data).permit(:value, :group_id)

        if data[:value].present?
            same_session_id_responses = Response.where(section_type: "bad", session_id: session.id.to_s)
            if same_session_id_responses.length != 0 && same_session_id_responses
                previous_data = same_session_id_responses.last.input
                if previous_data.present?
                    similar = check_content_similarity(previous_data, data[:value])
                    return if similar
                end
            end
        end

        if !@@debug && !(data == nil) && !(data[:value] == "")
            response = Response.create(section_type: "bad", input: data["value"], session_id: session.id.to_s)

            Turbo::StreamsChannel.broadcast_replace_later_to(
                "user_#{session.id}",
                target: "notes_bad",
                partial: "notes/message",
                locals: { message: "", target: "notes_bad" }
            )

            GetAiResponse.perform_async(@@note_for, "user_#{session.id}", data[:value], "bad", current_user.id, data[:group_id], response.id)


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
        data = params.require(:data).permit(:value, :group_id)

        if data[:value].present?
            same_session_id_responses = Response.where(section_type: "next", session_id: session.id.to_s)
            if same_session_id_responses.length != 0 && same_session_id_responses
                previous_data = same_session_id_responses.last.input
                if previous_data.present?
                    similar = check_content_similarity(previous_data, data[:value])
                    return if similar
                end
            end
        end

        if !@@debug && !(data == nil) && !(data[:value] == "")
            response = Response.create(section_type: "next", input: data["value"], session_id: session.id.to_s)

            Turbo::StreamsChannel.broadcast_replace_later_to(
                "user_#{session.id}",
                target: "notes_next",
                partial: "notes/message",
                locals: { message: "", target: "notes_next" }
            )

            GetAiResponse.perform_async(@@note_for, "user_#{session.id}", data[:value], "next", current_user.id, data[:group_id], response.id)
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
        @note.group_id = params[:group_id]
        @note.note_type = "good_bad_next_discuss"
        if @@with_video
            @note.video_id = @@video_id
        end
        if @@note_for == "match"
            @note.note_for = "match"
        elsif @@note_for == "practice"
            @note.note_for = "practice"
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

    def edit
        @note = Note.find(params[:id])
    end

    def update
        if @note.update(note_params)
            redirect_to note_path
        else
            render "edit"
        end
    end

    def destroy
        @note = Note.find(params[:id])
        if @note.destroy
            redirect_to group_path(@note.group)
        end
    end

    def search
        @group = Group.find(session[:current_group_id])
        @query = params[:query]
        @notes = if @query.present?
                    @group.notes.where('title LIKE ?', "%#{@query}%")
                else
                    @group.notes
                end.to_a

        Turbo::StreamsChannel.broadcast_replace_later_to(
            "index_of_notes",
            target: "notes-list",
            partial: "groups/notes_list",
            locals: {notes: @notes}
        )
    end

    private
    def note_params
        params.require(:note).permit(:id, :title, :note_type, :content, :good, :bad, :next, :discuss)
    end

    def check_content_similarity(text1, text2)
        client = OpenAI::Client.new
        response = client.chat(
            parameters: {
                model: "gpt-4o-mini",
                messages: [
                    { role: "system", content: "テキスト1はユーザーの前の文章、テキスト2はユーザーが編集した文章です。テキスト2に大きな内容の変更がなければ'true'を、変更があれば'false'を出力してください。" },
                    { role: "user", content: "テキスト1: #{text1}\nテキスト2: #{text2}" }
                ],
                temperature: 0.2
            }
        )
        #　response is 'true' or 'false'
        similarity = response.dig("choices", 0, "message", "content")
        
        return similarity == "true"
    end
end
