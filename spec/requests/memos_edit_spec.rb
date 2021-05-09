require "rails_helper"

RSpec.describe "memo_editpage", type: :request do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:memo) { create(:memo, user: user) }

  context "ログインされたユーザーの場合" do
    it "レスポンスが正しく表示されること" do
      login_for_request(user)
      get edit_memo_path(memo)
      expect(response).to render_template('memos/edit')
      patch memo_path(memo), params: { memo: { name: "離乳食名",
                                               description: "ここをこうやって作ります。" } }
      redirect_to memo
      follow_redirect!
      expect(response).to render_template('memos/show')
    end
  end

  context "ログインしてないユーザーの場合" do
    it "ログイン画面に戻ること" do
      get edit_memo_path(memo)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to login_path
      patch memo_path(memo), params: { memo: { name: "離乳食名",
                                               description: "ここをこうやって作ります。" } }
      expect(response).to have_http_status "302"
      expect(response).to redirect_to login_path
    end
  end
end
