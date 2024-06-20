module ApplicationHelper
    def default_meta_tags
        {
            site: 'TacticaNote',
            title: 'TacticaNote',
            reverse: true,
            charset: 'utf-8',
            description: 'TacticaNoteは従来のサッカーノートとは異なる、選手主体のチームのための共有型でインタラクティブなデジタルサッカーノートです。',
            keywords: 'サッカーノート, 育成年代, ユース年代, LLM, AI, Webアプリ, Webサービス',
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
                image: image_url('image/logo.png'),# 配置するパスやファイル名によって変更する
                local: 'ja-JP',
            },
            twitter: {
                card: 'summary_large_image', # Twitterで表示する場合は大きいカードに変更
                site: '@minorex14', # アプリの公式Twitterアカウントがあれば、アカウント名を記載
                image: image_url('image/logo.png'),# 配置するパスやファイル名によって変更
            }
        }
    end
end