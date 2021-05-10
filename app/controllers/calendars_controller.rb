class CalendarsController < ApplicationController
  before_action :logged_in_user

  def index
    @calendars = current_user.calendars
  end

  def new
    @calendar = Calendar.new
  end

  def show
    @calendar = Calendar.find(params[:id])
  end

  def create
    @calendar = Calendar.new(calendar_params)
    @calendar.user_id = current_user.id
    if @calendar.save
      flash[:success] = "離乳食が登録されました！"
      redirect_to calendars_path
    else
      render 'calendars/new'
    end
  end

  def destroy
    @calendar = Calendar.find(params[:id])
    if current_user?(@calendar.user)
      @calendar.destroy
      flash[:success] = "離乳食メモが削除されました"
      redirect_to request.referrer == user_url(@calendar.user) ? user_url(@calendar.user) : calendars_url
    else
      flash[:danger] = "他のアカウントの離乳食メモは削除できません"
      redirect_to root_url
    end
  end

  def edit
    @calendar = Calendar.find(params[:id])
  end

  def update
    @calendar = Calendar.find(params[:id])
    if @calendar.update_attributes(calendar_params)
      flash[:success] = "離乳食メモ情報が更新されました！"
      redirect_to @calendar
    else
      render 'edit'
    end
  end

  private

  def calendar_params
    params.require(:calendar).permit(:name, :start_time)
  end
end
