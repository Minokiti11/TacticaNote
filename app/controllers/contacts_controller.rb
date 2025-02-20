class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)

    if @contact.valid? && @contact.save
      # 問い合わせ者へ自動返信メール送信
      ContactMailer.inquiry(@contact).deliver_later
      # 管理者へ通知メール送信
      ContactMailer.received(@contact).deliver_later
      
      flash[:notice] = 'お問い合わせを受け付けました。自動返信メールをご確認ください。'
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :message)
  end
end
