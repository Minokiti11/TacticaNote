class SummariesController < ApplicationController
  def create
    @summary = Summary.new(summary_params)
    if @summary.save
      SummaryGenerator.perform_async("summary_user_#{session.id}", @summary.id, @summary.date_for.to_s, @summary.group_id)
      # スピナーを開始
      Turbo::StreamsChannel.broadcast_replace_later_to(
          "spinner_summary",
          target: "spinner_#{@summary.date_for}",
          partial: "spinner/show",
          locals: {target: "spinner_#{@summary.date_for}"}
      )
    end
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def summary_params
    params.require(:summary).permit(:date_for, :group_id)
  end
end
