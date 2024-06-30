class ChatGptService
    require 'openai'

    def initialize
        @openai = OpenAI::Client.new()
    end

    def extract_what_happend_good(prompt)
        response = @openai.chat(
        parameters: {
            model: "gpt-4", # Required. # 使用するGPT-3のエンジンを指定
            messages: [{ role: "system", content: "今から入力する文章はサッカーノートの「上手くいったこと」の欄に書かれている文章です。起こった現象の原因を除き、起こった現象を抜き出して、出力してください。output only answer." }, { role: "user", content: prompt }],
            temperature: 0.1, # 応答のランダム性を指定
            max_tokens: 100,  # 応答の長さを指定
        },
        )
        response['choices'].first['message']['content']
    end

    def check_specific_good(prompt)
        response = @openai.chat(
        parameters: {
            model: "gpt-4", # Required. # 使用するGPT-3のエンジンを指定
            messages: [{ role: "system", content: "今から入力する文章はサッカーノートの「上手くいったこと」の欄に書かれている文章です。上手くいった現象の理由が書かれていたら「True」を、書かれていなかったら「False」を出力してください。output only answer." }, { role: "user", content: prompt }],
            temperature: 0.3, # 応答のランダム性を指定
            max_tokens: 200,  # 応答の長さを指定
        },
        )
        response['choices'].first['message']['content']
    end

    def extract_what_happend_bad(prompt)
        response = @openai.chat(
        parameters: {
            model: "gpt-4", # Required. # 使用するGPT-3のエンジンを指定
            messages: [{ role: "system", content: "今から入力する文章はサッカーノートの「上手くいかなかったこと」の欄に書かれている文章です。原因を除き、起こった現象を簡潔に出力してください。output only answer except full stop." }, { role: "user", content: prompt }],
            temperature: 0.1, # 応答のランダム性を指定
            max_tokens: 100,  # 応答の長さを指定
        },
        )
        prompt_to_add_info_bad(response['choices'].first['message']['content'])
    end

    def check_specific_bad(prompt)
        response = @openai.chat(
        parameters: {
            model: "gpt-4",
            messages: [{ role: "system", content: "今から入力する文章はサッカーノートの「上手くいかなかったこと」の欄に書かれている文章です。上手くいかなかった現象の理由が書かれていたら「True」を、書かれていなかったら「False」を出力してください。output only answer." }, { role: "user", content: prompt }],
            temperature: 0.3, # 応答のランダム性を指定
            max_tokens: 200,  # 応答の長さを指定
        },
        )
        response['choices'].first['message']['content']
    end

    def check_specific_next(prompt)
        response = @openai.chat(
        parameters: {
            model: "gpt-4",
            messages: [{ role: "system", content: "今から入力する文章はサッカーノートの「次に意識すること・次までに取り組むこと」の欄に書かれている文章です。実現させるために必要なものや今ある課題に対しての解決策が書かれていたら「True」を、書かれていなかったら「False」を出力してください。output only answer." }, { role: "user", content: prompt }],
            temperature: 0.3, # 応答のランダム性を指定
            max_tokens: 200,  # 応答の長さを指定
        },
        )
        response['choices'].first['message']['content']
    end
end