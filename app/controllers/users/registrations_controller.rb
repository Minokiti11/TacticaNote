class Users::RegistrationsController < Devise::RegistrationsController
    protected
    def update_resource(resource, params)
        resource.update_without_password(params)
    end

    def after_update_path_for(resource)
        my_page_path
    end
end