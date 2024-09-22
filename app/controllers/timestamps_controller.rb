class TimestampsController < ApplicationController
    def create
        @timestamp = Timestamp.new(timestamp_params)
        if @timestamp.save
            render json: {success: true}
        else
            render json: {success: false, error: "TimeStamp could not be created."}
        end
    end

    private
    def timestamp_params
        params.require(:timestamp).permit(:description, :time_s, :video_id)
    end
end