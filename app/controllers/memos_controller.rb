class MemosController < ApplicationController
    def index
        @feed_items = current_user.feed.page(params[:page]).per(5)
    end
end
