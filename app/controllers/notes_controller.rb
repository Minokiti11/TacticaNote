class NotesController < ApplicationController
    def index
        @notes = Note.all
    end
    
    def new
        @note = Note.new
        @@video_id = params[:video_id]
    end

    def post_api_request_good
        # JSON リクエストからデータを取得
        data = params.require(:data).permit(:value)

        chat_gpt_service = ChatGptService.new
        specific_or_not = chat_gpt_service.check_specific_good(data[:value])

        if specific_or_not == "False"
            # ジョブを定義する
            # perform_syncはジョブを非同期で実行するためsidekiqのメソッド
            GetAiResponse.perform_async(data[:value], "good")
        else

        end
    end

    def post_api_request_bad
        # JSON リクエストからデータを取得
        data = params.require(:data).permit(:value)

        chat_gpt_service = ChatGptService.new
        specific_or_not = chat_gpt_service.check_specific_bad(data[:value])

        if specific_or_not == "False"
            GetAiResponse.perform_async(data[:value], "bad")
        else
            
        end
    end

    def post_api_request_next
        # JSON リクエストからデータを取得
        data = params.require(:data).permit(:value)

        chat_gpt_service = ChatGptService.new
        specific_or_not = chat_gpt_service.check_specific_next(data[:value])

        if specific_or_not == "False"
            GetAiResponse.perform_async(data[:value], "next")
        else

        end
    end

    def create
        @note = Note.new(note_params)
        @note.user_id = current_user.id
        @note.group_id = current_user.group_users[0].group_id
        @note.video_id = @@video_id
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
            redirect_to group_video_path(@note.group_id)
        end
    end

    private
    def note_params
        params.require(:note).permit(:id, :title, :content, :good, :bad, :next, :video_id)
    end
end
