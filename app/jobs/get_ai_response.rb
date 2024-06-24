class GetAiResponse
    include Sidekiq::Worker
    sidekiq_options retry: false
    RESPONSES_PER_MESSAGE = 1
    MODEL_NAME = "gpt-4"
    TEMPERATURE = 0.3

    def perform(prompt, type, specific)
        p "perform is called..."
        if type == "good"
            if !specific
                OpenAI::Client.new.chat(
                    parameters: {
                        model: MODEL_NAME,
                        messages: [{ role: "system", content: "今から入力する文章はサッカーノートの「上手くいったこと」の欄に書かれている文章です。現象が起こった理由を、追加して書くように促してください。書かれていない事実を含めるのを避けること。具体例を提示することは避けてください。ビルドアップについて書かれていたら、相手のフォーメーションと自分たちのフォーメーションを追加して書くように促してください。output only answer." }, { role: "user", content: prompt}],
                        temperature: TEMPERATURE,
                        stream: stream_proc(type),
                        max_tokens: 200,
                        n: RESPONSES_PER_MESSAGE
                    }
                )
            else
                OpenAI::Client.new.chat(
                    parameters: {
                        model: MODEL_NAME,
                        messages: [{ role: "system", content: "今から入力する文章は育成年代のサッカー選手のサッカーノートの「上手くいったこと」の欄に書かれている文章です。現象が起こった理由が明確になっていることを褒めてください。（必ず丁寧語で回答してください。）また、追加すべき情報を提示してください。（e.g. ビルドアップのことについて言及されていたら=>自チームと相手チームのフォーメーションが何だったか聞く）（具体的でありながら簡潔であること。）output only answer less than 3 sentences." }, { role: "user", content: prompt}],
                        temperature: TEMPERATURE,
                        stream: stream_proc(type),
                        max_tokens: 200,
                        n: RESPONSES_PER_MESSAGE
                    }
                )
            end
        elsif type == "bad"
            if !specific
                OpenAI::Client.new.chat(
                    parameters: {
                        model: MODEL_NAME,
                        messages: [{ role: "system", content: "今から入力する文章は育成年代の選手のサッカーノートの「上手くいかなかったこと」の欄に書かれている文章です。現象が起こった理由や具体的なシチュエーションを、追加して書くように促してください。3文以内で簡潔に回答し、考えられる原因や解決策は提示しないでください。チームの戦術的な原因も書くように促すこと。ビルドアップについて書かれていたら、相手のフォーメーションと自分たちのフォーメーションを追加して書くように促してください。output only answer." }, { role: "user", content: prompt}],
                        temperature: TEMPERATURE,
                        stream: stream_proc(type),
                        max_tokens: 200,
                        n: RESPONSES_PER_MESSAGE
                    }
                )
            else
                OpenAI::Client.new.chat(
                    parameters: {
                        model: MODEL_NAME,
                        messages: [{ role: "system", content: "今から入力する文章は育成年代のサッカー選手のサッカーノートの「上手くいかなかったこと」の欄に書かれている文章です。現象が起こった理由が明確になっていることを褒めてください。また、追加すべき情報を提示してください。（e.g. ビルドアップのことについて言及されていたら=>自チームと相手チームのフォーメーションが何だったか聞く）（具体的でありながら簡潔であること。）output only answer less than 3 sentences." }, { role: "user", content: prompt}],
                        temperature: TEMPERATURE,
                        stream: stream_proc(type),
                        max_tokens: 200,
                        n: RESPONSES_PER_MESSAGE
                    }
                )
            end

        elsif type == "next"
            if !specific
                OpenAI::Client.new.chat(
                    parameters: {
                        model: MODEL_NAME,
                        messages: [{ role: "system", content: "今から入力する文章は育成年代のサッカー選手が、試合を振り返って「次に意識すること・次までに取り組むこと」の欄に書かれている文章です。具体的な解決策を追加して書くように促してください。（e.g. 「崩し方を練習する」=> 「具体的にどのような崩し方を想定していますか？」）解決策や具体例は提示しないでください。3文以内で出力してください。output only answer." }, { role: "user", content: prompt}],
                        temperature: TEMPERATURE,
                        stream: stream_proc(type),
                        max_tokens: 200,
                        n: RESPONSES_PER_MESSAGE
                    }
                )
            else
                OpenAI::Client.new.chat(
                    parameters: {
                        model: MODEL_NAME,
                        messages: [{ role: "system", content: "今から入力する文章は育成年代のサッカー選手が、試合を振り返って「次に意識すること・次までに取り組むこと」の欄に書かれている文章です。現象が起こった理由が明確になっていることを褒めてください。output only answer less than 3 sentences." }, { role: "user", content: prompt}],
                        temperature: TEMPERATURE,
                        stream: stream_proc(type),
                        max_tokens: 200,
                        n: RESPONSES_PER_MESSAGE
                    }
                )
            end
        end

    end


    def stream_proc(type)
        p "Got new request: stream_proc"
        message = ""
        target = "notes_#{type}"
        proc do |chunk, _bytesize|
            new_content = chunk.dig("choices", 0, "delta", "content")
            if new_content
                message += new_content # メッセージを更新
            end
            Turbo::StreamsChannel.broadcast_replace_later_to target,
                target: target,
                partial: "notes/message",
                locals: { message: message, target: target}
        end

    end
end