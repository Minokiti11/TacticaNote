class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    callback_for(:google)
  end

  def callback_for(provider)
    @omniauth = request.env["omniauth.auth"]
    info = User.find_oauth(@omniauth)
    @user = info[:user]

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: provider.to_s.capitalize) if is_navigational_format?
    else
      session["devise.#{provider}_data"] = @omniauth
      redirect_to new_user_registration_url
    end
  rescue => e
    Rails.logger.error "OAuth Authentication Error: #{e.message}"
    flash[:error] = "認証に失敗しました。もう一度お試しください。"
    redirect_to new_user_session_path
  end

  def failure
    Rails.logger.error "OmniAuth Authentication Failed:"
    Rails.logger.error "Error Reason: #{params[:message]}"
    Rails.logger.error "Strategy: #{params[:strategy]}"
    Rails.logger.error "Environment: #{request.env['omniauth.error'].inspect}" if request.env['omniauth.error']
    
    flash[:error] = "認証に失敗しました。もう一度お試しください。"
    redirect_to new_user_session_path
  end
end
