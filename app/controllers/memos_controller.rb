class MemosController < ApplicationController
    before_action :logged_in_user
 
    def index
        @feed_items = current_user.feed.page(params[:page]).per(5)
    end

    def new
        @memo = Memo.new
    end
end
