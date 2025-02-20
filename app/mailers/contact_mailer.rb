class ContactMailer < ApplicationMailer
  default to: 'macminosp@icloud.com' # 管理者のメールアドレスに変更してください

  def inquiry(contact_form)
    @contact_form = contact_form
    mail(
      subject: 'お問い合わせを受け付けました',
      to: @contact_form.email
    )
  end

  def received(contact_form)
    @contact_form = contact_form
    mail(
      subject: '【新規お問い合わせ】Webサイトからのお問い合わせ',
      from: contact_form.email
    )
  end
end
