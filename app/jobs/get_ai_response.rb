require 'ostruct'

class GetAiResponse
    RESPONSES_PER_MESSAGE = 1
    MODEL_NAME = "gpt-4"
    TEMPERATURE = 0.3
    PROMPTS = {good: "今から入力する文章は育成年代のサッカー選手が試合を振り返って、サッカーノートの「上手くいったこと」の欄に書かれている文章です。起こった現象の理由が書かれていなかったら、現象が起こった理由を書くように促してください。書かれていたら、現象が起こった理由が明確になっていることを丁寧語で褒め、追加すべき情報を提示してください。(e.g. ビルドアップのことについて言及されていたら=>自チームと相手チームのフォーメーションが何だったか聞く)。書かれていない事実を含めるのを避けること。具体例を提示することは避けてください。ビルドアップについて書かれていたら、相手のフォーメーションと自分たちのフォーメーションを追加して書くように促してください。output only answer less than 3 sentences.",
                bad: "今から入力する文章は育成年代の選手が試合を振り返って、サッカーノートの「上手くいかなかったこと」の欄に書かれている文章です。上手くいかなかった現象の理由が書かれていなかったら、現象が起こった理由や具体的なシチュエーションを書くように促してください。書かれていたら、現象が起こった理由が明確になっていることを丁寧語で褒め、追加すべき情報を提示してください。（e.g. ビルドアップのことについて言及されていたら=>自チームと相手チームのフォーメーションが何だったか聞く）3文以内で具体的でありながら簡潔に回答し、考えられる原因や解決策は提示しないでください。チームの戦術的な原因も書くように促すこと。output only answer.",
                next: "今から入力する文章は育成年代のサッカー選手が試合を振り返って、サッカーノートの「次に意識すること・次までに取り組むこと」の欄に書いた文章です。実現させるために必要なものや今ある課題に対しての解決策が書かれていたら、解決策が明確になっていることを褒めてください。書かれていなかったら具体的な解決策を書くように促してください。（e.g. 「崩し方を練習する」=> 「具体的にどのような崩し方を想定していますか？」）具体的な練習方法については質問しないでください。解決策や具体例は提示しないでください。3文以内で出力してください。output only answer." }

    def perform(channel, prompt, type, response_id)
        response = Response.find(response_id)
        if type == "good"
            OpenAI::Client.new.chat(
                parameters: {
                    model: MODEL_NAME,
                    messages: [{ role: "system", content: PROMPTS[:good] }, { role: "user", content: prompt}],
                    temperature: TEMPERATURE,
                    stream: stream_proc(channel, type, prompt, response),
                    max_tokens: 200,
                    n: RESPONSES_PER_MESSAGE
                }
            )
        elsif type == "bad"
            OpenAI::Client.new.chat(
                parameters: {
                    model: MODEL_NAME,
                    messages: [{ role: "system", content: PROMPTS[:bad] }, { role: "user", content: prompt}],
                    temperature: TEMPERATURE,
                    stream: stream_proc(channel, type, prompt, response),
                    max_tokens: 200,
                    n: RESPONSES_PER_MESSAGE
                }
            )
        elsif type == "next"
            OpenAI::Client.new.chat(
                parameters: {
                    model: MODEL_NAME,
                    messages: [{ role: "system", content: PROMPTS[:next]}, { role: "user", content: prompt}],
                    temperature: TEMPERATURE,
                    stream: stream_proc(channel, type, prompt, response),
                    max_tokens: 200,
                    n: RESPONSES_PER_MESSAGE
                }
            )
        end
    end

    def stream_proc(channel, type, prompt, response)
        message = ""
        target = "notes_#{type}"
        max_retries = 3
        retry_delay = 0.5
        proc do |chunk, _bytesize|
            begin
                new_content = chunk.dig("choices", 0, "delta", "content")
                retries = 0
                while new_content.nil? && retries < max_retries
                    sleep(retry_delay)
                    new_content = chunk.dig("choices", 0, "delta", "content")
                    retries += 1
                end
                if new_content
                    message += new_content
                    response.response = message

                    Turbo::StreamsChannel.broadcast_replace_later_to(
                        channel,
                        target: "notes_#{type}",
                        partial: "notes/message",
                        locals: { message: message, target: target }
                    )
                end
                sleep(0.05) # Small delay between chunk processing
            rescue => e
                # Error handling can be added here if needed
            end
        end
    end
end
