class ChatGptService
    require 'openai'

    def initialize
        @openai = OpenAI::Client.new()
    end

    # def chat(prompt)
    #     response = @openai.chat(
    #     parameters: {
    #         model: "gpt-4-turbo", # Required. # 使用するGPT-3のエンジンを指定
    #         messages: [{ role: "user", content: prompt }],
    #         temperature: 0.5, # 応答のランダム性を指定
    #         max_tokens: 2000,  # 応答の長さを指定
    #     },
    #     )
    #     response['choices'].first['message']['content']
    # end

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

    def prompt_to_add_info_good(prompt)
        response = @openai.chat(
            parameters: {
                model: "gpt-4", # Required. # 使用するGPT4のエンジンを指定
                messages: [{ role: "system", content: "今から入力する文章はサッカーノートの「上手くいったこと」の欄に書かれている文章です。現象が起こった理由を、追加して書くように促してください。具体例は提示しないでください。output only answer." }, { role: "user", content: prompt}],
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

    def prompt_to_add_info_bad(prompt)
        response = @openai.chat(
        parameters: {
            model: "gpt-4",
            messages: [{ role: "system", content: "今から入力する文章はサッカーノートの「上手くいかなかったこと」の欄に書かれている文章です。現象が起こった理由を、追加して書くように促してください。具体例は提示しないでください。output only answer." }, { role: "user", content: prompt}],
            temperature: 0.3, # 応答のランダム性を指定
            max_tokens: 200,  # 応答の長さを指定
        },
        )
        response['choices'].first['message']['content']
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

    def prompt_to_add_info_next(prompt)
        response = @openai.chat(
        parameters: {
            model: "gpt-4",
            messages: [{ role: "system", content: "今から入力する文章は育成年代のサッカー選手が、試合を振り返って「次に意識すること・次までに取り組むこと」の欄に書かれている文章です。具体的な解決策を追加して書くように促してください。解決策や具体例は提示しないでください。3文以内で出力してください。output only answer." }, { role: "user", content: prompt}],
            temperature: 0.3, # 応答のランダム性を指定
            max_tokens: 200,  # 応答の長さを指定
        },
        )
        response['choices'].first['message']['content']
    end
end