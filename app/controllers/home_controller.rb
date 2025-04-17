class HomeController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    if current_user
      p "current_user", current_user
      if current_user.groups.length != 0
        p current_user.groups
        if !session[:current_group_id]
          @group_id = current_user.groups[0].id
        else
          @group_id = session[:current_group_id]
        end
        @group = Group.find(@group_id)
      else
        @group = nil
        @group_id = nil
      end
    end
  end

  def about
  end
end
