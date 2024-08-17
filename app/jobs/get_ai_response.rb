class GetAiResponse include ActionView::RecordIdentifier
    include Sidekiq::Worker
    sidekiq_options retry: 3
    RESPONSES_PER_MESSAGE = 1
    MODEL_NAME = "gpt-4o-mini"
    TEMPERATURE = 0.2
    PROMPTS = {good: "今から入力する文章は育成年代のサッカー選手が試合を振り返って、サッカーノートの「上手くいったこと」の欄に書いた文章です。
                    起こった現象の理由が書かれていなかったら、現象が起こった理由を書くように促してください。
                    書かれていたら、現象が起こった理由が明確になっていることを丁寧語で褒め、追加すべき情報を提示してください。(e.g. ビルドアップのことについて言及されていたら=>自チームと相手チームのフォーメーションが何だったか聞く)。
                    書かれていない事実を含めることや、具体例を提示することは避けてください。
                    ビルドアップについて書かれていたら、相手のフォーメーションと自分たちのフォーメーションを追加して書くように促してください。
                    output only answer less than 5 sentences.
                    以下の例を参考にしてください。
                    user: 狭い中でもパスを通せた。
                    you: 狭い中でもパスを通せた理由は何だったと思いますか？相手のプレスの強度や掛け方、それによってどこにスペースが生まれていたかなど、具体的な原因を考えてみましょう。また、動画の中でそれが起きた秒数を指定すると他のメンバーが理解しやすくなるでしょう。04:46のように書くと4分46秒を再生するリンクが生成されます。",
                bad: "今から入力する文章は育成年代の選手が試合を振り返って、サッカーノートの「上手くいかなかったこと」の欄に書いた文章です。
                    上手くいかなかった具体的な理由（自チームと相手チームのフォーメーションを書いただけのものは「具体的な理由」とは呼ばない。）が書かれていなかったら、現象が起こった原因やその時のシチュエーションを具体的に書くように促してください。
                    具体的な原因が書かれていたら、現象が起こった理由が具体的になっていることを認め、追加すべき情報を提示してください。
                    具体的でありながら簡潔に回答し、考えられる原因や解決策は提示しないでください。output less than 5 sentences.
                    以下の例を参考にしてください。
                    例: user:「相手のチームの4-4-2のブロックに対して、4-3-3でのビルドアップが上手くいかなかった。」=> you:「ビルドアップが上手くいかなかった原因が明確に書かれていません。相手のプレスの掛け方や、相手とのフォーメーションの噛み合わせで発生した問題など、原因を具体的に考えてみましょう。」",
                next: "今から入力する文章は育成年代のサッカー選手が試合を振り返って、サッカーノートの「次に意識すること・次までに取り組むこと」の欄に書いた文章です。
                    実現させるために必要なものや今ある課題に対しての解決策が書かれていたら、解決策が明確になっていることを褒めてください。
                    書かれていなかったら具体的な解決策を書くように促してください。（e.g. 「崩し方を練習する」=> 「具体的にどのような崩し方を想定していますか？」）
                    具体的な練習方法については質問しないでください。解決策や具体例は提示しないでください。output only answer less than 5 sentences." }

    def perform(channel, prompt, type, response_id)
        p "perform is called..."

        response = Response.find(response_id)
        target = "notes_#{type}"
        
        response_from_gpt4o_mini = OpenAI::Client.new.chat(
            parameters: {
                model: MODEL_NAME,
                messages: [{ role: "system", content: PROMPTS[type.to_sym] }, { role: "user", content: prompt}],
                temperature: TEMPERATURE,
                max_tokens: 400,
                n: RESPONSES_PER_MESSAGE
            }
        )

        message = response_from_gpt4o_mini.dig("choices", 0, "message", "content")

        p "response: ", message

        Turbo::StreamsChannel.broadcast_replace_later_to(
            channel,
            target: "notes_#{type}",
            partial: "notes/message",
            locals: { message: message, target: target }
        )

        response.update(response: message)

        # スピナーを停止
        Turbo::StreamsChannel.broadcast_replace_later_to(
            "spinner",
            target: "spinner_#{type}",
            partial: "spinner/hide",
            locals: {target: "spinner_#{type}"}
        )
    end

    # デバッグに時間かかるのでとりあえずspinner使う方針に変更
    # def stream_proc(channel, type, prompt, response)
    #     message = ""
    #     target = "notes_#{type}"
    #     proc do |chunk, _bytesize|
    #         new_content = chunk.dig("choices", 0, "delta", "content")
    #         if new_content
    #             message += new_content
    #             # response.update(response: message)
        
    #             Turbo::StreamsChannel.broadcast_replace_later_to(
    #                 channel,
    #                 target: "notes_#{type}",
    #                 partial: "notes/message",
    #                 locals: { message: message, target: target }
    #             )
    #         end
    #     end
    # end
end