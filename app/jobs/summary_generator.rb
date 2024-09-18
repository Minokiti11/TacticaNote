class SummaryGenerator include ActionView::RecordIdentifier
    include Sidekiq::Worker
    sidekiq_options retry: 3
    RESPONSES_PER_MESSAGE = 1
    MODEL_NAME = "gpt-4o-mini"
    TEMPERATURE = 0.2

    PROMPTS_SUMMARIZE = "以下のサッカーノートを箇条書きで要約してください。\n"

    def perform(channel, summary_id, date_string, group_id)
        date = Date.parse(date_string)
        @summary = Summary.find(summary_id)
        group = Group.find(group_id)

        notes = group.notes.where("DATE(created_at) = ?", date).order(created_at: :desc)
        good_for_summary = notes.map do |note|
            note.good
        end.join("\n")

        bad_for_summary = notes.map do |note|
            note.bad
        end.join("\n")

        next_for_summary = notes.map do |note|
            note.next
        end.join("\n")

        discuss_for_summary = notes.map do |note|
            note.discuss
        end.join("\n")

        print("上手くいったところ: \n" + good_for_summary)
        print("上手くいかなかったところ: \n" + bad_for_summary)
        print("次に意識すること: \n" + next_for_summary)
        print("チームで確認したいこと: \n" + discuss_for_summary)

        notes_for_summary = "上手くいったところ:\n" + good_for_summary + "上手くいかなかったところ:\n" + bad_for_summary + "次に意識すること:\n" + next_for_summary + "チームで話し合いたいこと:\n" + discuss_for_summary

        response_from_gpt4o_mini = OpenAI::Client.new.chat(
            parameters: {
                model: "gpt-4o-mini",
                messages: [{ role: "system", content: PROMPTS_SUMMARIZE }, { role: "user", content: notes_for_summary} ],
                temperature: 0.2,
                max_tokens: 400,
                n: 1
            }
        )

        message = response_from_gpt4o_mini.dig("choices", 0, "message", "content")

        Turbo::StreamsChannel.broadcast_replace_later_to(
            channel,
            target: "summary_for_#{date}",
            partial: "groups/summary",
            locals: { message: message, target: "summary_for_#{date}" }
        )

        @summary.update(content: message)

        # スピナーを停止
        Turbo::StreamsChannel.broadcast_replace_later_to(
            "spinner_summary",
            target: "spinner_#{date}",
            partial: "spinner/hide",
            locals: {target: "spinner_#{date}"}
        )
    end
end