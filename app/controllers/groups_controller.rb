class GroupsController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_correct_user, only: [:edit, :update]
  
    def index
      @groups = Group.all
      @group_joining = GroupUser.where(user_id: current_user.id)
      @group_lists_none = "グループに参加していません。"
    end
  
    def show
      @group = Group.find(params[:id])
    end

    def join
      @group = Group.find(params[:group_id])
      @group.users << current_user
      redirect_to  groups_path
    end

    def new
      @group = Group.new
      @group.users << current_user
    end
  
    def create
      @group = Group.new(group_params)
      @group.owner_id = current_user.id
      #追記しています！！！
      @group.users << current_user
      if @group.save
        redirect_to groups_path
      else
        render 'new'
      end
    end

    # 追記
    def destroy
      @group = Group.find(params[:id])
      #current_userは、@group.usersから消されるという記述。
      @group.users.delete(current_user)
      redirect_to groups_path
    end

    def edit
    end
  
    def update
      if @group.update(group_params)
        redirect_to groups_path
      else
        render "edit"
      end
    end
  
    private
  
    def group_params
      params.require(:group).permit(:name, :introduction, :image)
    end
  
    def ensure_correct_user
      @group = Group.find(params[:id])
      unless @group.owner_id == current_user.id
        redirect_to groups_path
      end
    end
end