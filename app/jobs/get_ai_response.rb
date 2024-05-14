class GetAiResponse
    include Sidekiq::Worker
    RESPONSES_PER_MESSAGE = 1
    MODEL_NAME = "gpt-4"
    TEMPERATURE = 0.3

    def perform(prompt, type)
        if type == "good"
            OpenAI::Client.new.chat(
                parameters: {
                    model: MODEL_NAME,
                    messages: [{ role: "system", content: "今から入力する文章はサッカーノートの「上手くいったこと」の欄に書かれている文章です。現象が起こった理由を、追加して書くように促してください。具体例は提示しないでください。output only answer." }, { role: "user", content: prompt}],
                    temperature: TEMPERATURE,
                    stream: stream_proc(type), # stream_procメソッドでストリーミングデータを処理
                    max_tokens: 150,
                    n: RESPONSES_PER_MESSAGE
                }
            )
        elsif type == "bad"
            OpenAI::Client.new.chat(
                parameters: {
                    model: MODEL_NAME,
                    messages: [{ role: "system", content: "今から入力する文章はサッカーノートの「上手くいかなかったこと」の欄に書かれている文章です。現象が起こった理由を、追加して書くように促してください。具体例は提示しないでください。output only answer." }, { role: "user", content: prompt}],
                    temperature: TEMPERATURE,
                    stream: stream_proc(type),
                    max_tokens: 150,
                    n: RESPONSES_PER_MESSAGE
                }
            )
        elsif type == "next"
            OpenAI::Client.new.chat(
                parameters: {
                    model: MODEL_NAME,
                    messages: [{ role: "system", content: "今から入力する文章はサッカーノートの「次に意識すること・次までに取り組むこと」の欄に書かれている文章です。実現させるために必要なものや、どんな解決策があるかを追加して書くように3文以内で促してください。解決策や具体例は提示しないでください。output only answer." }, { role: "user", content: prompt}],
                    temperature: TEMPERATURE,
                    stream: stream_proc(type),
                    max_tokens: 200,
                    n: RESPONSES_PER_MESSAGE
                }
            )
        end

    end


    def stream_proc(type)
        message = ""
        target = "notes_#{type}"
        Proc.new do |chunk, _bytesize|
            new_content = chunk.dig("choices", 0, "delta", "content")
            print new_content
            if new_content
                message += new_content # メッセージを更新
                Turbo::StreamsChannel.broadcast_replace_to target,
                    target: target,
                    partial: "notes/message",
                    locals: { message: message, target: target}
            end
        end
    end
end