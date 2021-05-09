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

  private

    def memo_params
      params.require(:memo).permit(:name, :description)
    end
end
