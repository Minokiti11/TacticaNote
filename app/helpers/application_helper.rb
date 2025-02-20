module ApplicationHelper
    def default_meta_tags
        {
            site: 'TacticaNote',
            title: 'TacticaNote',
            reverse: true,
            charset: 'utf-8',
            description: 'LLMで選手の思考を深堀る、映像同期型&共有型のサッカーノート。',
            keywords: 'サッカーノート, 言語化, 育成年代, ユース年代, LLM, AI, Webアプリ, Webサービス',
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
end