# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
    skip_before_action :require_login, only: :create

    def create
        user = find_or_create_from_auth_hash(auth_hash)
        log_in user if user
        redirect_to root_path
    end

    def destroy
        log_out
        redirect_to root_path
    end

    private
        def auth_hash
        request.env['omniauth.auth']
        end

        def find_or_create_from_auth_hash(auth_hash)
            email = auth_hash['info']['email']
            User.find_or_create_by(email: email) do |user|
                user.update(email: email)
            end
        end
end