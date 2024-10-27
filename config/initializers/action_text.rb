# config/initializers/action_text.rb

# Railsのサニタイザーに<span>タグとstyle属性を許可する
Rails.application.config.to_prepare do
    # 既存の許可されたタグに'span'を追加
    ActionText::ContentHelper.allowed_tags.add 'span'

    # 'style' 属性を許可する
    ActionText::ContentHelper.allowed_attributes.add 'style'
end

