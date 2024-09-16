class GroupsController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]
  
  def index
    @groups = current_user.groups
    @group_joining = GroupUser.where(user_id: current_user.id)
    if @group_joining.empty?
      @not_joining_group = true
    end
    @group_lists_none = "グループに参加していません。"
  end

  def show
    @group = Group.find(params[:id])
    @videos = @group.videos
    @feeds = @group.notes.order('created_at DESC').first(7)
    @recent_videos = @videos.where("created_at > ?", Time.now - 14.days)
    @timeline = (@feeds + @recent_videos).sort_by(&:created_at).reverse
    @practices = @group.practices
    if @group.daily_practice.present?
      @daily_practice = @group.daily_practice
    else
      @daily_practice = DailyPractice.new(group_id: @group.id)
      if @daily_practice.save
        p "daily_practice was saved."
      else
        p "daily_practice was not saved."
        p @daily_practice.errors.full_messages
      end
    end
    I18n.locale = :ja

    # ノートの日付を取得し、重複を排除して降順に並べる
    @note_dates = @group.notes.order(created_at: :desc).pluck("DATE(created_at)").uniq

    # 初期表示のグループ数
    initial_limit = 5
    @initial_dates = @note_dates.first(initial_limit)

    # 初期表示のノートを日付でグループ化
    @initial_note_groups = @group.notes.where("DATE(created_at) IN (?)", @initial_dates)
                                     .order(created_at: :desc)
                                     .group_by { |note| note.created_at.to_date }

    @total_date_groups = @note_dates.size
  end

  def join_by_invite
    token = params[:invite_token]
    group = Group.find_by(invite_token: token)
    group_joining = GroupUser.where(group_id: params[:group_id], user_id: current_user.id)
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
      session[:current_group_id] = nil
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

  def note
    @group = Group.find(params[:group_id])
    @notes = @group.notes
    I18n.locale = :ja
  end

  def practice
    @group = Group.find(params[:group_id])
    @practices = @group.practices
    I18n.locale = :ja
  end

  def create_daily_practice_item
    @group = Group.find(params[:id])
    practice = Practice.find(params[:practice_id])
    daily_practice = @group.daily_practice || DailyPractice.create(group_id: @group.id)

    if daily_practice.persisted?
      daily_practice.duration = params[:whole_training_time]
      daily_practice.save
      item = daily_practice.daily_practice_items.create(
        practice: practice,
        training_time: params[:training_time]
      )

      if item.persisted?
        render json: { success: true, daily_practice_item_id: item.id }
      else
        render json: { success: false, error: item.errors.full_messages.join(', ') }
      end
    else
      render json: { success: false, error: "Daily practice could not be created." }
    end
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

  def load_more_date_groups
    group = Group.find(params[:id])
    offset = params[:offset].to_i
    limit = params[:limit].to_i

    # 次に読み込む日付グループを取得
    next_dates = group.notes.order(created_at: :desc)
                       .pluck("DATE(created_at)").uniq
                       .slice(offset, limit)

    # 取得した日付に基づきノートをグループ化
    next_note_groups = group.notes.where("DATE(created_at) IN (?)", next_dates)
                            .order(created_at: :desc)
                            .group_by { |note| note.created_at.to_date }

    has_more = (offset + limit) < group.notes.order(created_at: :desc).pluck("DATE(created_at)").uniq.size

    # JSON形式でデータを準備
    grouped_notes = next_note_groups.map do |date, notes|
      {
        date: date.strftime('%Y年%m月%d日'),
        notes: notes.map do |note|
          {
            id: note.id,
            title: note.title,
            username: note.user.username
          }
        end
      }
    end

    render json: { 
      note_groups: grouped_notes,
      has_more: has_more
    }
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
