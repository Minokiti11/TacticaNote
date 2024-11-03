class SummaryGenerator include ActionView::RecordIdentifier
    include Sidekiq::Worker
    sidekiq_options retry: 3
    RESPONSES_PER_MESSAGE = 1
    MODEL_NAME = "gpt-4o-mini"
    TEMPERATURE = 0.2

    PROMPTS_SUMMARIZE = "
    以下のサッカーノートを箇条書きで要約してください。
    チームの課題と個人の課題はそれぞれのユーザーのポジションで判断し、分けてください。
    チームの課題について、議論する必要があるポイントがあれば、📓アイコンでまとめてください。
    個人の課題はユーザーネームとポジションを添えてください。
    出力例:
    system:
    minorex16
    ポジション: CB
    上手くいった点:
    サイドで一時的に3対2の数的有利ができて崩せた。(39:30)
    理由:
    この時はリスタート後のフリーキックで偶然、トップ下の〇〇がサイドに流れていて、サイドバックとウイングで3人がサイドに流れていた。

    上手くいかなかった点
    縦パスを入れたあと、スペースが狭くなってボールロストした。
    理由: 
    1. 縦パスを出した後の動き出しが遅れ、相手に囲まれてしまったため。
    2. フォワードが降りてきたので、縦方向のスペースが狭くなり、足元で繋ごうとすると狭いスペースでプレーせざるを得なかった。
    - 自チームは4-1-3-2で2トップだったが、片方のフォワードが降りた後もう一人のフォワードがそのスペースに走り込んでいたら、シンプルに背後にロングパスしていたかもしれない。
    - また、センターバックである自分も縦パスを入れた後にもっと後ろにポジショニングしていたら逃げ道となるパスコースを作れた。

    次に意識すること・次に向けて取り組むこと
    - トップ下やフォワードがサイドに流れて数的有利を作る動きを試合を通して意識的に増やしたい。
    - センターバックである自分は、縦パスを入れたあとすぐに下がってバックパスできるようにしてあげる。
    チームで話し合いたいこと・確認したいこと
    - 2トップの降りてくる「スペースを作る・使う」を意識できる練習を考えたい
    - トップ下やフォワードがサイドに流れて数的有利を作る動きを試合を通して意識的に増やしたい。
    you:
    ### チームの課題
    - フォワードが降りてきて縦パスを入れたあと、スペースが狭くなってボールをロストした。
    - #### 考えられる原因:
        - 縦パスを通した後のサポートが不足していた
        - フォワードの受けるアクションによって奥行きが狭くなった
        - 2トップが連動してスペースを使う動きがなかった
    📓 議論する必要があるポイント
    - 2トップの動きに関する戦術の明確化
    - サイドでの数的有利を作る動きの練習方法は？
    - 前線の選手がサイドに流れて数的有利を作る動きを増やす

    ### 個人の課題
    ユーザーネーム: minorex16
    ポジション: CB
    縦パス後にポジショニングを見直し、逃げ道となるパスコースを作る
    "

    def perform(channel, summary_id, date_string, group_id)
        date = Date.parse(date_string)
        @summary = Summary.find(summary_id)
        group = Group.find(group_id)

        notes = group.notes.where("DATE(created_at) = ?", date).order(created_at: :desc)
        notes_for_summary = ""
        notes.each do |note|
            notes_for_summary += "#{User.find(note.user_id).username}\n"
            notes_for_summary += "ポジション: #{User.find(note.user_id).username}\n"
            notes_for_summary += "上手くいったこと:\n#{note.good}\n"
            notes_for_summary += "上手くいかなかったこと:\n#{note.bad}\n"
            notes_for_summary += "次に意識すること・次までに取り組むこと:\n#{note.next}\n"
            notes_for_summary += "チームで話し合いたいこと:\n#{note.discuss}\n"
        end

        response_from_gpt4o_mini = OpenAI::Client.new.chat(
            parameters: {
                model: "gpt-4o-mini",
                messages: [{ role: "system", content: PROMPTS_SUMMARIZE }, { role: "user", content: notes_for_summary} ],
                temperature: 0.2,
                max_tokens: 1000,
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