class TimestampsController < ApplicationController
    def create
        @timestamp = Timestamp.new(timestamp_params)
        if @timestamp.save
            render json: {success: true}
        else
            render json: {success: false, error: "TimeStamp could not be created."}
        end
    end

    def edit
        @timestamp = Timestamp.find(params[:id])
    end

    def update
        @timestamp = Timestamp.find(params[:id])
        redirect_path = params[:timestamp][:redirect_path]

        if @timestamp.update(timestamp_params)
            redirect_to redirect_path, notice: 'Timestamp was successfully updated.', allow_other_host: true
        else
            redirect_to redirect_path, allow_other_host: true
            flash[:alert] = 'タイムスタンプの更新に失敗しました'
        end
    end

    def destroy
        @timestamp = Timestamp.find(params[:id])
        if @timestamp.destroy
            redirect_to video_path(@timestamp.video_id)
        else
            flash[:alert] = "タイムスタンプを削除できませんでした。ネットワーク接続を確認して再度お試しください。"
        end
    end

    private
    def timestamp_params
        params.require(:timestamp).permit(:description, :time_s, :video_id)
    end
end