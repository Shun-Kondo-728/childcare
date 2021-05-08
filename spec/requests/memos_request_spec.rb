require 'rails_helper'

RSpec.describe "Memos", type: :request do
  let!(:user) { create(:user) }
  let!(:memo) { create(:memo, user: user) }

  context "ログインしているユーザーの場合" do
    it "レスポンスが正常に表示されること" do
      login_for_request(user)
      get new_memo_path
      expect(response).to have_http_status "200"
      expect(response).to render_template('memos/new')
    end
  end

  context "ログインしてないユーザーの場合" do
    it "ログイン画面に戻ること" do
      get new_memo_path
      expect(response).to have_http_status "302"
      expect(response).to redirect_to login_path
    end
  end
end
