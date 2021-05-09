require 'rails_helper'

RSpec.describe "Memos", type: :request do
  let!(:user) { create(:user) }
  let!(:memo) { create(:memo, user: user) }

  context "ログインしているユーザーの場合" do
    before do
      login_for_request(user)
      get new_memo_path
    end

    it "レスポンスが正常に表示されること" do
      expect(response).to have_http_status "200"
      expect(response).to render_template('memos/new')
    end

    it "有効なデータで登録できること" do
      expect {
        post memos_path, params: { memo: { name: "離乳食名",
                                           description: "ここをこうやって作ります。" } }
      }.to change(Memo, :count).by(1)
      follow_redirect!
      expect(response).to render_template('memos/show')
    end

    it "無効なデータでは登録できないこと" do
      expect {
        post memos_path, params: { memo: { name: "",
                                           description: "ここをこうやって作ります。"} }
      }.not_to change(Memo, :count)
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
