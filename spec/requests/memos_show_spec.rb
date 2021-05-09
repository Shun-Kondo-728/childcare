require "rails_helper"

RSpec.describe "料理個別ページ", type: :request do
  let!(:user) { create(:user) }
  let!(:memo) { create(:memo, user: user) }

  context "ログインされたユーザーの場合" do
    it "レスポンスが正しく表示されること" do
      login_for_request(user)
      get memo_path(memo)
      expect(response).to have_http_status "200"
      expect(response).to render_template('memos/show')
    end
  end

  context "ログインしてないユーザーの場合" do
    it "ログイン画面に戻ること" do
      get memo_path(memo)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to login_path
    end
  end
end
