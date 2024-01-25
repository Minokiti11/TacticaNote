class OpenAi
    require 'ruby/openai'

    def self.generate_answer(users)
        client = OpenAI::Client.new
        responce = client.chat(
            parameters: {
                model: 'gpt-3.5-turbo',
                messages: [{role: 'user', content: 
                    "This is a meeting of youth soccer team.
                    Ask why caused issue like "", and if youth players were confused,
                    give advice like 'There are three possible causes: the first is ~, the second is ~, and the third is ~. Which do you think applies to this situation?'.
                    you must answer in 1 or 2 sentences in Japanese. 
                    I'll give you data of discussion, then you'll give some advice"}]
            }
        )
        responce.dig('choices', 0, 'message', 'content')
    end
end
