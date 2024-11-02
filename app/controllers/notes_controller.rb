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
        @note_for = params[:note_for]
        if @@with_video
            @@video_id = params[:video_id]
            @video_id = params[:video_id]
        end
        ##ランダムなトークンを生成
        @unique_token = SecureRandom.uuid
        p :@unique_token, @unique_token
    end

    def gpt_api_request_good
        data = params.require(:data).permit(:value, :user_id, :token, :group_id, :note_for)
        p "data[:value]", data[:value]
        p "token: ", data[:token]
        p :notefor, data[:note_for]

        if data[:value]
            same_session_id_responses = Response.where(section_type: "good", token: data[:token])

            if same_session_id_responses.length != 0 && same_session_id_responses
                previous_data = same_session_id_responses.last.input
                if previous_data.present?
                    similar = check_content_similarity(previous_data, data[:value])
                    p "previous: ", previous_data
                    p "present: ", data[:value]
                    p :similar, similar
                    return if similar
                end
            end
        end
        
        if !@@debug && !(data == nil) && !(data[:value] == "")
            response = Response.create(section_type: "good", input: data["value"], user_id: data[:user_id], token: data[:token], session_id: session.id.to_s)

            Turbo::StreamsChannel.broadcast_replace_later_to(
                "user_#{session.id}",
                target: "notes_good",
                partial: "notes/message",
                locals: { message: "", diff_content: "", target: "notes_good", suggestion: nil }
            )
            
            GetAiResponse.perform_async(data[:note_for], "user_#{session.id}", data[:value], "good", data[:token], current_user.id, data[:group_id], response.id)
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
        data = params.require(:data).permit(:value, :user_id, :token, :group_id, :note_for)
        p "data[:value]: ", data[:value]

        if data[:value].present?
            same_session_id_responses = Response.where(section_type: "bad", token: data[:token])
            if same_session_id_responses.length != 0 && same_session_id_responses
                previous_data = same_session_id_responses.last.input
                if previous_data.present?
                    similar = check_content_similarity(previous_data, data[:value])
                    return if similar
                end
            end
        end

        if !@@debug && !(data == nil) && !(data[:value] == "")
            response = Response.create(section_type: "bad", input: data["value"], user_id: data[:user_id], token: data[:token], session_id: session.id.to_s)

            Turbo::StreamsChannel.broadcast_replace_later_to(
                "user_#{session.id}",
                target: "notes_bad",
                partial: "notes/message",
                locals: { message: "", target: "notes_bad", diff_content: "", suggestion: nil }
            )

            GetAiResponse.perform_async(data[:note_for], "user_#{session.id}", data[:value], "bad", data[:token], current_user.id, data[:group_id], response.id)

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
        data = params.require(:data).permit(:value, :user_id, :token, :group_id, :note_for)

        if data[:value].present?
            same_token_responses = Response.where(section_type: "next", token: data[:token])
            if same_token_responses.length != 0 && same_token_responses
                previous_data = same_token_responses.last.input
                if previous_data.present?
                    similar = check_content_similarity(previous_data, data[:value])
                    return if similar
                end
            end
        end

        if !@@debug && !(data == nil) && !(data[:value] == "")
            response = Response.create(section_type: "next", input: data["value"], user_id: data[:user_id], token: data[:token], session_id: session.id.to_s)

            Turbo::StreamsChannel.broadcast_replace_later_to(
                "user_#{session.id}",
                target: "notes_next",
                partial: "notes/message",
                locals: { message: "", target: "notes_next", diff_content: "", suggestion: nil }
            )

            GetAiResponse.perform_async(data[:note_for], "user_#{session.id}", data[:value], "next", data[:token], current_user.id, data[:group_id], response.id)
            # スピナーを開始
            Turbo::StreamsChannel.broadcast_replace_later_to(
                "spinner",
                target: "spinner_next",
                partial: "spinner/show",
                locals: {target: "spinner_next"}
            )
        end
    end

    # def self.daily_job(group_id)
    #     puts "毎日昼の12時に実行されるジョブです。"
    #     @group = Group.find(group_id)
    #     p :group, @group
    #     @notes = @group.notes.where('created_at >= ?', Time.now - 24.hours).where('created_at <= ?', Time.now)
    #     p :notes, @notes
    #     Summary.create(group_id: group_id)
    # end

    def create
        @note = Note.new(note_params)
        @note.user_id = current_user.id
        if params[:group_id]
            @note.group_id = params[:group_id]
        elsif session[:current_group_id]
            @note.group_id = session[:current_group_id]
        end

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
        @@with_video = params[:with_video]
        if @@with_video
            @with_video = params[:with_video]
            @@note_for = params[:note_for]
            @video_id = params[:video_id]
        end
    end

    def update
        @note = Note.find(params[:id])
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
        else
            flash[:alert] = "ノートの削除に失敗しました。ノートの作成者があなたであることを確認してください。"
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
        head :ok
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
                    { role: "system", content: "
                        テキスト1はユーザーの前の文章、テキスト2はユーザーが編集した文章です。
                        テキスト2に新たなトピックの追加があれば'true'を、なければ'false'を出力してください。
                        以下の例を参考にすること。
                        user:
                            テキスト1: 'ゴール前でのフィニッシュのアイデアがよかった。'
                            テキスト2: 'ゴール前でのフィニッシュのアイデアがよかった。\n理由: 1. インナーラップでポケットを取りにいけた 2. 3. '
                        you: false"},
                    { role: "user", content: "テキスト1: #{text1}\nテキスト2: #{text2}" }
                ],
                temperature: 0.2
            }
        )
        #　response is 'true' or 'false'
        similarity = response.dig("choices", 0, "message", "content")

        p :is_changed, similarity
        
        return similarity == 'false' || similarity == "false"
    end
end
