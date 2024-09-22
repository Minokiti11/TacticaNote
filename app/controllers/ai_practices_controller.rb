class AiPracticesController < ApplicationController
    def create
        @ai_practice = AiPractice.new(ai_practice_params)
        if @ai_practice.save
            RecommendPractice.perform_async("ai_practice_user_#{session.id}", @ai_practice.date_for.to_s, @ai_practice.id, @ai_practice.group_id)
            # スピナーを開始
            Turbo::StreamsChannel.broadcast_replace_later_to(
                "ai_practice_spinner",
                target: "ai_practice_spinner_#{@ai_practice.date_for}",
                partial: "spinner/show",
                locals: {target: "ai_practice_spinner_#{@ai_practice.date_for}"}
            )
            # JSONレスポンスを追加
            render json: { success: true, data: @ai_practice }, status: :created
        else
            # エラーレスポンスを追加
            render json: { success: false, errors: @ai_practice.errors.full_messages }, status: :unprocessable_entity
        end
    end

    private

    def set_group
        @group = Group.find(params[:group_id])
    end

    def ai_practice_params
        params.require(:ai_practice).permit(:date_for, :content, :group_id)
    end
end
