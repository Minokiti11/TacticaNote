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

    def post_api_request_good
        if !@@debug
            # JSON リクエストからデータを取得
            data = params.require(:data).permit(:value)
            response = Response.create(section_type: "good", input: data["value"])
            # ジョブを非同期で実行するためsidekiqのメソッド
            GetAiResponse.perform_async("user_#{session.id}", data[:value], "good", response.id)
        end
        render json: { response_id: response.id }
    end

    def post_api_request_bad
        if !@@debug
            # JSON リクエストからデータを取得
            data = params.require(:data).permit(:value)
            response = Response.create(section_type: "bad", input: data["value"])

            GetAiResponse.perform_async("user_#{session.id}", data[:value], "bad", response.id)
        end
        render json: { response_id: response.id }
    end

    def post_api_request_next
        if !@@debug
            # JSON リクエストからデータを取得
            data = params.require(:data).permit(:value)
            response = Response.create(section_type: "good", input: data["value"])
            
            GetAiResponse.perform_async("user_#{session.id}", data[:value], "next", response.id)
        end
        render json: { response_id: response.id }
    end

    def create
        @note = Note.new(note_params)
        @note.user_id = current_user.id
        @note.group_id = current_user.group_users[0].group_id
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
            redirect_to group_video_path(@note.group_id)
        end
    end

    private
    def note_params
        params.require(:note).permit(:id, :title, :content, :good, :bad, :next)
    end
end
