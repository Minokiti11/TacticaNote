# frozen_string_literal: true

# Use this setup block to configure all options available in MetaTags.
MetaTags.configure do |config|
  # タイトルの最大文字数
  config.title_limit = 70

  # 説明文の最大文字数
  config.description_limit = 300

  # キーワードの最大文字数
  config.keywords_limit = 255

  # キーワードの区切り文字
  config.keywords_separator = ', '

  # キーワードを小文字に変換
  config.keywords_lowercase = true

  # メタタグの出力を最適化
  config.minify_output = true

  # メタタグを自己終了タグとして出力
  config.open_meta_tags = true

  # コントローラー・アクション別のメタタグ設定
  config.page_specific_meta_tags = {
    'groups#join' => {
      site_name: 'TacticaNote',
      title: -> { @group.name },
      description: -> { "招待リンクが届きました！グループ「#{@group.name}」に参加しよう" },
      og: {
        site_name: 'TacticaNote',
        title: -> { @group.name },
        description: -> { "招待リンクが届きました！グループ「#{@group.name}」に参加しよう" },
        type: 'website'
      }
    }
  }
end
