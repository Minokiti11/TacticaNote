class GetAiResponse include ActionView::RecordIdentifier
    include Sidekiq::Worker
    sidekiq_options retry: 3
    RESPONSES_PER_MESSAGE = 1
    MODEL_NAME = "gpt-4o-mini"
    TEMPERATURE = 0.2

    # 試合用のプロンプト
    PROMPTS_MATCH = {
        good: "今から入力する文章は育成年代のサッカー選手が試合を振り返って、サッカーノートの「上手くいったこと」の欄に書いた文章です。
                起こった現象の理由が書かれていなかったら、現象が起こった理由を書くように促してください。
                書かれていたら、現象が起こった理由が明確になっていることを丁寧語で褒め、追加すべき情報を提示してください。(e.g. ビルドアップのことについて言及されていたら=>自チームと相手チームのフォーメーションが何だったか聞く)。
                書かれていない事実を含めることや、具体例を提示することは避けてください。
                「#前回のノート」の「次に意識すること・次に向けて取り組むこと」を参照し、その具体的な内容をユーザーに伝えてから、今回意識できていたかどうか確認してください。また、「#前回のノート」の「上手くいかなかったこと」を参照し、具体的な内容をユーザーに伝えてから、今回どうだったか聞いてください。このプロンプト自体に「#前回のノート」が与えられていない場合は、前回のノートについて言及するのを避けること。
                output only answer less than 10 sentences.
                選手の意識によるものでそれ以上深掘りようがない現象を除いて、それぞれの現象について箇条書きでフィードバックするようにして。
                以下の例を参考にしてください。
                user: 狭い中でもパスを通せた。
                you: 狭い中でもパスを通せた理由は何だったと思いますか？相手のプレスの強度や掛け方、それによってどこにスペースが生まれていたかなど、具体的な原因を考えてみましょう。また、動画の中でそれが起きた秒数を指定すると他のメンバーが理解しやすくなるでしょう。04:46のように書くと4分46秒を再生するリンクが生成されます。\n",
        bad: "今から入力する文章は育成年代の選手が試合を振り返って、サッカーノートの「上手くいかなかったこと」の欄に書いた文章です。
                上手くいかなかった具体的な理由（自チームと相手チームのフォーメーションを書いただけのものは「具体的な理由」とは呼ばない。）が書かれていなかったら、現象が起こった原因やその時のシチュエーションを具体的に書くように促してください。
                具体的な原因が書かれていたら、現象が起こった理由が具体的になっていることを認め、追加すべき情報を提示してください。
                「#前回のノート」の「次に意識すること・次に向けて取り組むこと」を参照し、ユーザーに伝えてから、今回意識できていたかどうか確認してください。また、「#前回のノート」の「上手くいかなかったこと」についても言及し、今回どうなったか聞いてください。
                具体的でありながら簡潔に回答し、考えられる原因や解決策は提示しないでください。
                選手の意識次第で、それ以上深掘りようがない現象を除いて、それぞれの現象について箇条書きでフィードバックするようにして。
                output less than 10 sentences.
                以下の例を参考にしてください。
                例: user:「相手のチームの4-4-2のブロックに対して、4-3-3でのビルドアップが上手くいかなかった。」=> you:「ビルドアップが上手くいかなかった原因を考えてみましょう。相手のプレスの掛け方や、相手とのフォーメーションの噛み合わせで発生した問題など、原因を具体的に考えてみましょう。」\n",
        next: "今から入力する文章は育成年代のサッカー選手が試合を振り返って、サッカーノートの「次に意識すること・次までに取り組むこと」の欄に書いた文章です。
                実現させるために必要なものや今ある課題に対しての解決策が書かれていたら、解決策が明確になっていることを褒めてください。
                書かれていなかったら具体的な解決策を書くように促してください。（e.g. 「崩し方を練習する」=> 「具体的にどのような崩し方を想定していますか？」）
                具体的な練習方法については質問しないでください。解決策や具体例は提示しないでください。output only answer less than 5 sentences.\n"
    }

    #練習用のプロンプト
    PROMPTS_PRACTICE = {
        good: "
        今から入力する文章は育成年代のサッカー選手が以下の練習を振り返って、サッカーノートの「上手くいったこと」の欄に書いた文章です。
        「今日の練習内容」を踏まえて、選手が有意義な練習をできていたか振り返らせるようにしてください。
        (e.g. 与えられた練習内容の「意識するポイント」について具体的に言及し、意識できていたか聞く, 前回のノートの「次に意識すること・次に向けて取り組むこと」を参照し、ユーザーに伝えてから、意識できていたかどうか確認する, 前回の「上手くいかなかったこと」が今回どうなったか聞く)。
        ※ userの入力ではなく、このプロンプト自体に「前回のノート」が与えられていない場合は、前回のノートについて言及するのを避けること。
        書かれていない事実を含めることや、具体例を提示することは避けてください。
        output only answer less than 5 sentences.
        以下の例を参考にしてください。※ {練習メニュー名}には与えられた「今日の練習内容」の「練習メニュー名」が入る。userの入力ではなく、このプロンプト自体に「今日の練習内容」が与えられていない場合は、他の練習について聞くこと自体を避けること。
        例: user: '3対1の時、ワンタッチ目を2人に出せる方向に置いて相手を困らせた' => you: 'ワンタッチ目を2人にも出せる方向に置くことで、パスコースを複数確保し、ボール保持の時間を増やすことができたのですね。他の練習メニューについてはどうでしたか？{練習メニュー名}や{練習メニュー名}についても振り返ってみましょう。（「今日の練習内容」が与えられている場合。）'\n",
        bad: "
        今から入力する文章は育成年代の選手が以下の練習を振り返って、サッカーノートの「上手くいかなかったこと」の欄に書いた文章です。
        練習内容を踏まえて、選手が有意義な練習をできていたか振り返らせるようにしてください。
        上手くいかなかった具体的な理由（自チームと相手チームのフォーメーションを書いただけのものは「具体的な理由」とは呼ばない。）が書かれていなかったら、現象が起こった原因やその時のシチュエーションを具体的に書くように促してください。
        具体的な原因が書かれていたら、現象が起こった理由が具体的になっていることを認め、追加すべき情報を提示してください。
        具体的でありながら簡潔に回答し、考えられる原因や解決策は提示しないでください。output less than 5 sentences.
        以下の例を参考にしてください。
        例: user:「」=> you:「」\n",
        next: "
        今から入力する文章は育成年代のサッカー選手が以下の練習を振り返って、サッカーノートの「次に意識すること・次までに取り組むこと」の欄に書いた文章です。
        次に取り組むことや意識することが明確に書かれていたら、アクションプランが明確になっていることを褒めてください。
        書かれていなかったら具体的なアクションを書くように促してください。（e.g. 「崩し方を練習する」=> 「具体的にどのような崩し方を想定していますか？」）
        具体的な練習方法については質問しないでください。output only answer less than 5 sentences.\n"
    }

    # ユーザーの文章を５段階評価するプロンプト(試合用)
    PROMPTS_RATE_MATCH = {
        good: "今から入力する文章は育成年代のサッカー選手が試合を振り返って、サッカーノートの「上手くいったこと」の欄に書いた文章です。
            この文章を5段階で評価してください。
            各段階ごとの評価基準を以下に記します。
            1点: サッカーの練習や試合の振り返りに関係のない文章
            2点: 上手くいった現象が書かれているか
            3点: 上手くいった現象と考えられる要因が書いてあるか
            4点: 上手くいった現象と考えられる具体的な要因が書いてあるか
            5点: 上手くいった現象と考えられる具体的な要因が書いてあり、具体的なプレーの動画内での秒数が00:00の形で示してあるか
            以下の段階ごとの文章例を参考にしてください。
            1点: 「あいうえお」「こんにちは」
            2点: 「ビルドアップが上手くいった。」「シュートの本数が多かった。」「相手の縦パスや地上でのビルドアップから失点することがなかった。」
            3点: 「それぞれが早めに準備していて、ビルドアップが上手くいった。」
            4点: 「相手の中盤があまりプレスをかけてこなかったのと、相手の3トップが作るゲートに対して2ボランチがポジショニングをとり、ビルドアップが上手くいった。」
            5点: 「相手の中盤があまりプレスをかけてこなかったのと、相手の3トップが作るゲートに対して2ボランチがポジショニングをとり、ビルドアップが上手くいった。(07:36)」
            output only integer from 1 to 5.",
        bad: "今から入力する文章は育成年代のサッカー選手が試合を振り返って、サッカーノートの「上手くいかなかったこと」の欄に書いた文章です。
            この文章を5段階で評価してください。
            各段階ごとの評価基準を以下に記します。
            1点: サッカーの練習や試合の振り返りに関係のない文章
            2点: 上手くいかなかった現象が書かれているか
            3点: 上手くいかなかった現象と考えられる要因が書いてあるか
            4点: 上手くいかなかった現象と考えられる具体的な要因が書いてあるか
            5点: 上手くいかなかった現象と考えられる具体的な要因が書いてあり、具体的なプレーの動画内での秒数が00:00の形で示してあるか
            以下の段階ごとの文章例を参考にしてください。
            1点: 「あいうえお」「こんにちは」
            2点: 「ビルドアップが上手くいかなかった。」「サイドから崩された。」「狭いところでパスが繋がらなかった。」
            3点: 「サイドバックにボールが入った時にパスコースがなくなり、ビルドアップが上手くいかなかった。」
            4点: 「サイドバックからウイングへのパスが縦関係になり、ウイングが後ろ向きで受けることになり、ビルドアップが上手くいかなかった。」
            5点: 「サイドバックからウイングへのパスが縦関係になり、ウイングが後ろ向きで受けることになり、ビルドアップが上手くいかなかった。(07:36)」
            output only integer from 1 to 5.",
        next: ""
    }

    # ユーザーの文章を５段階評価するプロンプト(練習用)
    PROMPTS_RATE_PRACTICE = {
        good: "今から入力する文章は育成年代のサッカー選手が練習を振り返って、サッカーノートの「上手くいったこと」の欄に書いた文章です。
            この文章を5段階で評価してください。
            各段階ごとの評価基準を以下に記します。
            1点: サッカーの練習や試合の振り返りに関係のない文章
            2点: 上手くいった現象が書かれているか
            3点: 上手くいった現象と考えられる要因が書いてあるか
            4点: 上手くいった現象と考えられる具体的な要因が書いてあるか
            5点: 上手くいった現象と考えられる具体的な要因が書いてあり、具体的なプレーの動画内での秒数が00:00の形で示してあるか
            以下の段階ごとの文章例を参考にしてください。
            1点: 「あいうえお」「こんにちは」
            2点: 「ビルドアップが上手くいった。」「シュートの本数が多かった。」「相手の縦パスや地上でのビルドアップから失点することがなかった。」
            3点: 「それぞれが早めに準備していて、ビルドアップが上手くいった。」
            4点: 「3対1の時、ワンタッチ目を2人にも出せる方向に置いて相手を困らせた」
            5点: 「相手の中盤があまりプレスをかけてこなかったのと、相手の3トップが作るゲートに対して2ボランチがポジショニングをとり、ビルドアップが上手くいった。(07:36)」
            output only integer from 1 to 5.",
        bad: "今から入力する文章は育成年代のサッカー選手が試合を振り返って、サッカーノートの「上手くいかなかったこと」の欄に書いた文章です。
            この文章を5段階で評価してください。
            各段階ごとの評価基準を以下に記します。
            1点: サッカーの練習や試合の振り返りに関係のない文章
            2点: 上手くいかなかった現象が書かれているか
            3点: 上手くいかなかった現象と考えられる要因が書いてあるか
            4点: 上手くいかなかった現象と考えられる具体的な要因が書いてあるか
            5点: 上手くいかなかった現象と考えられる具体的な要因が書いてあり、具体的なプレーの動画内での秒数が00:00の形で示してあるか
            以下の段階ごとの文章例を参考にしてください。
            1点: 「あいうえお」「こんにちは」
            2点: 「ビルドアップが上手くいかなかった。」「サイドから崩された。」「狭いところでパスが繋がらなかった。」
            3点: 「サイドバックにボールが入った時にパスコースがなくなり、ビルドアップが上手くいかなかった。」
            4点: 「サイドバックからウイングへのパスが縦関係になり、ウイングが後ろ向きで受けることになり、ビルドアップが上手くいかなかった。」
            5点: 「サイドバックからウイングへのパスが縦関係になり、ウイングが後ろ向きで受けることになり、ビルドアップが上手くいかなかった。(07:36)」
            output only integer from 1 to 5.",
        next: ""
    }

    def perform(note_for, channel, input, type, user_id, group_id, response_id)
        response = Response.find(response_id)
        target = "notes_#{type}"
        rate_prompt = nil
        if type != "next" && note_for == "match"
            if note_for == "match"
                rate_prompt = PROMPTS_RATE_MATCH[type.to_sym]
            elsif note_for == "practice"
                rate_prompt = PROMPTS_RATE_PRACTICE[type.to_sym]
            end

            rate_response_from_gpt4o_mini = OpenAI::Client.new.chat(
                parameters: {
                    model: MODEL_NAME,
                    messages: [{ role: "system", content: rate_prompt }, { role: "user", content: input}],
                    temperature: TEMPERATURE,
                    max_tokens: 10,
                    n: RESPONSES_PER_MESSAGE
                }
            )

            rate = rate_response_from_gpt4o_mini.dig("choices", 0, "message", "content")

            Turbo::StreamsChannel.broadcast_replace_later_to(
                "rate_" + channel,
                target: "notes_#{type}_rate",
                partial: "notes/rate",
                locals: { rate: rate.to_i, target: "notes_#{type}_rate" }
            )
        end

        if note_for == "match"
            previous_note = "#前回のノート\n"
            latest_note = Note.where(user_id: user_id, group_id: group_id, note_for: "match").order(created_at: :desc).first
            if latest_note
                previous_note += "上手くいったこと: \n"
                previous_note += "#{latest_note.good}\n"
                previous_note += "上手くいかなかったこと: \n"
                previous_note += "#{latest_note.bad}\n"
                previous_note += "次に意識すること・次に向けて取り組むこと: \n"
                previous_note += "#{latest_note.next}\n"
                previous_note += "チームで話し合いたいこと・確認したいこと: \n"
                previous_note += "#{latest_note.discuss.to_s}\n"
            else
                previous_note = ""
            end
            prompt = PROMPTS_MATCH[type.to_sym] + previous_note
            p :prompt, prompt
        elsif note_for == "practice"
            group = Group.find(group_id)
            previous_note = "前回のノート:\n"
            latest_note = Note.where(user_id: user_id, group_id: group_id, note_for: "practice").order(created_at: :desc).first
            if latest_note
                previous_note += "上手くいったこと: \n"
                previous_note += "#{latest_note.good}\n"
                previous_note += "上手くいかなかったこと: \n"
                previous_note += "#{latest_note.bad}\n"
                previous_note += "次に意識すること・次に向けて取り組むこと: \n"
                previous_note += "#{latest_note.next}\n"
                previous_note += "チームで話し合いたいこと・確認したいこと: \n"
                previous_note += "#{latest_note.discuss.to_s}\n"
            else
                previous_note = ""
            end
            if group.daily_practice.daily_practice_items.length != 0
                content_of_practice = "今日の練習内容:\n"
                group.daily_practice.daily_practice_items.each do |daily_practice_item|
                    practice_name = daily_practice_item.practice.name
                    number_of_people = daily_practice_item.practice.number_of_people
                    solvable_issues = daily_practice_item.practice.issue
                    key_points = daily_practice_item.practice.key_points
                    applicable_situation = daily_practice_item.practice.applicable_situation
                    content_of_practice += "練習メニュー名: #{practice_name}\n"
                    content_of_practice += "トレーニング内容: #{daily_practice_item.practice.introduction}\n"
                    content_of_practice += "練習時間(分): #{daily_practice_item.training_time}\n"
                    content_of_practice += "意識するポイント: #{key_points}\n"
                    content_of_practice += "試合で該当するシチュエーション: #{applicable_situation}\n"
                    content_of_practice += "解決する課題: #{solvable_issues}\n"
                end
            else
                content_of_practice = ""
            end
            prompt = PROMPTS_PRACTICE[type.to_sym] + previous_note + content_of_practice
            print "prompt:\n", prompt
        end

        response_from_gpt4o_mini = OpenAI::Client.new.chat(
            parameters: {
                model: MODEL_NAME,
                messages: [{ role: "system", content: prompt }, { role: "user", content: input} ],
                temperature: TEMPERATURE,
                max_tokens: 400,
                n: RESPONSES_PER_MESSAGE
            }
        )

        message = response_from_gpt4o_mini.dig("choices", 0, "message", "content")

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
    rescue Faraday::BadRequestError => e
        Rails.logger.error("BadRequestError: #{e.message}")
        # 必要に応じてリトライや通知を実装
    rescue => e
        Rails.logger.error("Unexpected error: #{e.message}")
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