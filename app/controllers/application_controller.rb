class ApplicationController < ActionController::Base
    before_action :configurepermitted_parameters, if: :devise_controller?
    before_action :set_current_group
    
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
        devise_parameter_sanitizer.permit(:account_update, keys: [:username])
    end

    private

    def set_current_group
        @id = nil
        if params[:group_id]
            session[:current_group_id] = params[:group_id]
            @id = session[:current_group_id]
        end
    end
end
