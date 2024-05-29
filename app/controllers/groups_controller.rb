class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]
  
  def index
    @groups = current_user.groups
    @group_joining = GroupUser.where(user_id: current_user.id)
    p "@group_joining: ", @group_joining
    if @group_joining.empty?
      p "グループに参加していません。"
      @not_joining_group = true
    end
    @group_lists_none = "グループに参加していません。"
  end

  def show
    @group = Group.find(params[:id])
  end

  def join_by_invite
    token = params[:invite_token]
    group = Group.find_by(invite_token: token)
    p "group_id: ", params[:group_id]
    group_joining = GroupUser.where(group_id: params[:group_id], user_id: current_user.id)
    p "group_joining: ", group_joining
    if group
      if group_joining.empty?
        # ユーザーをグループに追加する処理
        group.users << current_user
        redirect_to group_path(group), notice: 'グループに参加しました。'
      else
        redirect_to group_path(group), notice: 'すでにこのグループに参加しています。'
      end
    else
      redirect_to root_path, alert: '無効な招待リンクです。'
    end
  end

  def new
    @group = Group.new
    @group.users << current_user
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    #追記
    @group.users << current_user
    if @group.save
      redirect_to groups_path
    else
      render 'new'
    end
  end

  # グループから抜ける関数
  def destroy
    @group = Group.find(params[:id])
    #current_userは、@group.usersから消されるという記述。
    @group.users.delete(current_user)
    redirect_to groups_path
  end

  # グループを削除する関数
  def all_destroy
    @group = Group.find(params[:group_id])
    if @group.destroy
      redirect_to groups_path
    end
  end

  def edit
    @group=Group.find(params[:id])
  end

  def update
    if @group.update(group_params)
      redirect_to group_path
    else
      render "edit"
    end
  end

  def chat
    @group = Group.find(params[:group_id])
    @messages = @group.messages
  end

  def video
    @group = Group.find(params[:group_id])
    @videos = @group.videos
  end

  def generate_invite_link
    @group = Group.find(params[:id])
    @group.generate_invite_token
    @group.save
    if Rails.env.production?
      @group_invite_link = "tactica-chat.com/groups/#{params[:id]}/join/#{@group.invite_token}?openExternalBrowser=1"
    elsif Rails.env.development?
      @group_invite_link = "localhost:3000/groups/#{params[:id]}/join/#{@group.invite_token}"
    end
    
    flash[:notice] = "招待リンクを発行しました: #{@group_invite_link}"
    redirect_to group_path(@group)
  end

  private

  def group_params
    params.require(:group).permit(:id, :name, :introduction, :teams_behaviour, :monthly_target, :image, :invite_token, :invite_token_expires_at)
  end

  def ensure_correct_user
    @group = Group.find(params[:id])
    unless @group.owner_id == current_user.id
      redirect_to groups_path
    end
  end
end
