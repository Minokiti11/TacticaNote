class MentionsController < ApplicationController
    def index
        @group = Group.find(current_user.group_users[0].group_id)
        @users = @group.users
        
        respond_to do |format|
            format.json
        end
    end
end
