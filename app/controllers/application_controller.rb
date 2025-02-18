class ApplicationController < ActionController::Base
    include SessionsHelper
    before_action :configurepermitted_parameters, if: :devise_controller?
    before_action :set_current_group
    before_action :authenticate_user!, unless: :devise_controller?
    before_action :block_bad_ip
    
    def self.render_with_signed_in_user(user, *args)
        ActionController::Renderer::RACK_KEY_TRANSLATION['warden'] ||= 'warden'
        proxy = Warden::Proxy.new({}, Warden::Manager.new({})).tap{|i| i.set_user(user, scope: :user) }
        renderer = self.renderer.new('warden' => proxy)
        renderer.render(*args)
    end
    protected
    def configurepermitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email])
        devise_parameter_sanitizer.permit(:sign_in, keys: [:username, :email])
        devise_parameter_sanitizer.permit(:account_update, keys: [:username, :position])
    end

    # Deviseの authenticate_user! メソッドをオーバーライド
    def authenticate_user!(opts = {})
        if !user_signed_in?
            flash[:alert] = "ログインが必要です。"
            redirect_to new_user_session_path
        end
    end

    private

    def set_current_group
        if params[:controller] == 'groups' && params[:action] == 'show'
            session[:current_group_id] = params[:id]
        end
        if params[:group_id]
            session[:current_group_id] = params[:group_id]
        end
    end

    def block_bad_ip
        if request.remote_ip == '91.92.251.54' || request.remote_ip == '172.68.242.61'
            render plain: 'Access Denied', status: :forbidden
        end
    end
end
