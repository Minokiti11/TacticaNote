class ContactMailer < ApplicationMailer
  def inquiry(contact_form)
    @contact_form = contact_form
    mail(
      from: 'TacticaChat <no-reply@tactica-note.com>',
      subject: 'お問い合わせを受け付けました',
      to: @contact_form.email
    )
  end

  def received(contact_form)
    @contact_form = contact_form
    mail(
      from: 'TacticaChat <no-reply@tactica-note.com>',
      to: 'macminosp@icloud.com',
      subject: '【新規お問い合わせ】Webサイトからのお問い合わせ',
      reply_to: contact_form.email
    )
  end
end
