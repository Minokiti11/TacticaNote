class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :set_current_group
    before_action :authenticate_user!, unless: -> { devise_controller? || params[:controller] == 'high_voltage/pages' ||  params[:controller] == 'contacts'}
    before_action :block_bad_ip
    
    def self.render_with_signed_in_user(user, *args)
        ActionController::Renderer::RACK_KEY_TRANSLATION['warden'] ||= 'warden'
        proxy = Warden::Proxy.new({}, Warden::Manager.new({})).tap{|i| i.set_user(user, scope: :user) }
        renderer = self.renderer.new('warden' => proxy)
        renderer.render(*args)
    end

    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email])
        devise_parameter_sanitizer.permit(:sign_in, keys: [:username, :email])
        devise_parameter_sanitizer.permit(:account_update, keys: [:username, :position])
    end

    def authenticate_user!(opts = {})
        unless current_user
            store_location_for(:user, request.fullpath)
            flash[:alert] = "ログインが必要です。"
            redirect_to new_user_session_path
        end
    end

    private

    def set_current_group
        if params[:controller] == 'groups' && params[:action] == 'show'
            session[:current_group_id] = params[:id]
        elsif params[:group_id]
            session[:current_group_id] = params[:group_id]
        elsif session[:current_group_id].nil? && current_user
            # ユーザーが所属する最初のグループを設定
            first_group = current_user.groups.first
            session[:current_group_id] = first_group.id if first_group
        end
    end

    def block_bad_ip
        if request.remote_ip == '91.92.251.54' || request.remote_ip == '172.68.242.61'
            render plain: 'Access Denied', status: :forbidden
        end
    end
end
