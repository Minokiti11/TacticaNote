class RecommendPractice include ActionView::RecordIdentifier
    include Sidekiq::Worker
    sidekiq_options retry: 3
    RESPONSES_PER_MESSAGE = 1
    MODEL_NAME = "gpt-4o-mini"
    TEMPERATURE = 0.2

    PROMPTS_RECOMMEND = "
                        <instruction>
                            - あなたはプロのサッカーコーチAIです。
                            - 与えられた課題について、考えられるチームまたは個人の課題を3つのカテゴリにまとめて記載してください。
                            - それぞれの課題にはいくつかの考えられる解決策が付随します。
                            - 解決策は、具体的な練習方法を含めてください。
                            - 練習方法は、練習メニュー名、練習のテーマ、解決する課題、必要な人数、試合で該当するシチュエーションを含めてください。
                            - 長文かつ極めて具体的、正確に記載してください。人間らしく、よどみのない文章で作成してください。
                            - 内容の薄い抽象的な箇条書きは避けて記述してください。
                        </instruction>

                        <format>
                            課題のカテゴリ
                            1. 〇〇
                            2. 〇〇
                            3. 〇〇
                            ---
                            1. **〇〇**

                            練習メニュー:

                            - **〇〇**
                            - **テーマ**: 〇〇
                            - **解決する課題**: 〇〇
                            - **必要な人数**: 〇人
                            - **試合で該当するシチュエーション**: 〇〇
                            - **練習内容**: 

                            ---
                            2. **〇〇**

                            練習メニュー:

                            - **〇〇**
                            - **テーマ**: 〇〇
                            - **解決する課題**: 〇〇
                            - **必要な人数**: 〇人
                            - **試合で該当するシチュエーション**: 〇〇
                            - **練習内容**: 
                            ---
                            3. **〇〇**

                            練習メニュー:

                            - **〇〇**
                            - **テーマ**: 〇〇
                            - **解決する課題**: 〇〇
                            - **必要な人数**: 〇人
                            - **試合で該当するシチュエーション**: 〇〇
                            - **練習内容**:
                            ---
                        </format>\n
                        "

    def perform(channel, date_string, ai_practice_id, group_id)
        date = Date.parse(date_string)
        @ai_practice = AiPractice.find(ai_practice_id)
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

        # notes_for_summary = "上手くいったところ:\n" + good_for_summary + "上手くいかなかったところ:\n" + bad_for_summary + "次に意識すること:\n" + next_for_summary + "チームで話し合いたいこと:\n" + discuss_for_summary
        p "requirements: ",  "<requirement> 課題: \n" + bad_for_summary + "</requirement>"
        response_from_gpt4o_mini = OpenAI::Client.new.chat(
            parameters: {
                model: "gpt-4o-mini",
                messages: [{ role: "system", content: PROMPTS_RECOMMEND }, { role: "user", content: "<requirement> 課題: \n" + bad_for_summary + "</requirement>"} ],
                temperature: 0.2,
                max_tokens: 2500,
                n: 1
            }
        )

        message = response_from_gpt4o_mini.dig("choices", 0, "message", "content")

        Turbo::StreamsChannel.broadcast_replace_later_to(
            channel,
            target: "ai_practice_for_#{date}",
            partial: "groups/ai_practice",
            locals: { message: message, target: "ai_practice_for_#{date}" }
        )

        @ai_practice.update(content: message)

        # スピナーを停止
        Turbo::StreamsChannel.broadcast_replace_later_to(
            "ai_practice_spinner",
            target: "ai_practice_spinner_#{date}",
            partial: "spinner/hide",
            locals: {target: "ai_practice_spinner_#{date}"}
        )
    end
end