module ApplicationHelper
    def default_meta_tags
        {
            site: 'TacticaNote',
            title: 'TacticaNote',
            reverse: true,
            charset: 'utf-8',
            description: 'AIで選手の思考を深堀る、映像同期型&共有型のサッカーノート。',
            keywords: 'サッカー, サッカーノート, 言語化, 育成年代, 育成, ユース, LLM, AI, Webアプリ, Webサービス',
            canonical: request.original_url,
            separator: '|',
            icon: [
                { href: image_url('icon5.ico') }
            ],
            og: {
                site_name: :site,
                title: :title,
                description: :description,
                type: 'website',
                url: request.original_url,
                image: 'https://tactica-note.com/images/tacticanote-logo.png',
                local: 'ja-JP',
            },
            twitter: {
                card: 'summary_large_image', # Twitterで表示する場合は大きいカードに変更
                site: '@minorex14', # アプリの公式Twitterアカウントがあれば、アカウント名を記載
                image: 'https://tactica-note.com/images/tacticanote-logo.png',
            }
        }
    end

    def markdown(text)
        renderer = Redcarpet::Render::HTML.new(filter_html: true, hard_wrap: true)
        markdown = Redcarpet::Markdown.new(renderer)
        markdown.render(text).html_safe
    end

    def page_specific_meta_tags
        case "#{controller_name}##{action_name}"
        when 'groups#join'
            {
                title: @group.name,
                description: "招待リンクが届きました！「#{@group.name}」に参加しよう",
                og: {
                    title: @group.name,
                    description: "招待リンクが届きました！「#{@group.name}」に参加しよう",
                    type: 'website'
                }
            }
        # 他のコントローラー・アクションのケースを追加
        else
            {}
        end
    end

    def meta_tags
        default_meta_tags.merge(page_specific_meta_tags)
    end
end