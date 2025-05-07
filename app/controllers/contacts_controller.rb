class ContactsController < ApplicationController
  def new
    # @contact = Contact.new
    redirect_to root_path
  end

  def create
    # @contact = Contact.new(contact_params)

    # if @contact.save
    #   begin
    #     # 問い合わせ者へ自動返信メール送信
    #     ContactMailer.inquiry(@contact).deliver_now
    #     # 管理者へ通知メール送信
    #     ContactMailer.received(@contact).deliver_now
    #     flash[:notice] = 'お問い合わせを受け付けました。自動返信メールをご確認ください。'
    #     redirect_to root_path
    #   rescue => e
    #     Rails.logger.error "メール送信エラー: #{e.message}"
    #     flash[:alert] = 'お問い合わせは受け付けましたが、メール送信に失敗しました。'
    #     redirect_to root_path
    #   end
    # else
    #   flash.now[:alert] = 'お問い合わせの送信に失敗しました。'
    #   render :new, status: :unprocessable_entity
    # end
    redirect_to root_path
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :message)
  end
end
