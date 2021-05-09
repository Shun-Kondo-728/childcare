class MemosController < ApplicationController
  before_action :logged_in_user

  def index
    @feed_items = current_user.feed.page(params[:page]).per(5)
  end

  def show
    @memo = Memo.find(params[:id])
  end

  def new
    @memo = Memo.new
  end

  def create
    @memo = Memo.new(memo_params)
    @memo.user_id = current_user.id
    if @memo.save
      flash[:success] = "離乳食が登録されました！"
      redirect_to memo_path(@memo)
    else
      render 'memos/new'
    end
  end

  def edit
    @memo = Memo.find(params[:id])
  end

  def update
    @memo = Memo.find(params[:id])
    if @memo.update_attributes(memo_params)
      flash[:success] = "離乳食メモ情報が更新されました！"
      redirect_to @memo
    else
      render 'edit'
    end
  end

  def destroy
    @memo = Memo.find(params[:id])
    if current_user?(@memo.user)
      @memo.destroy
      flash[:success] = "離乳食メモが削除されました"
      redirect_to request.referrer == user_url(@memo.user) ? user_url(@memo.user) : memos_url
    else
      flash[:danger] = "他のアカウントの離乳食メモは削除できません"
      redirect_to root_url
    end
  end

  private

    def memo_params
      params.require(:memo).permit(:name, :description)
    end
end
