require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  let!(:user) { create(:user) }

  it "正しいレスポンスを返すこと" do
    get login_path
    expect(response).to be_success
    expect(response).to have_http_status "200"
  end

  it "有効なユーザーでログイン・ログアウト" do
    get login_path
    post login_path, params: { session: { name: user.name,
                                          password: user.password } }
    redirect_to user
    follow_redirect!
    expect(response).to render_template('static_pages/home')
    expect(is_logged_in?).to be_truthy
    delete logout_path
    expect(is_logged_in?).not_to be_truthy
    redirect_to root_url
  end

  it "無効なユーザーでログイン" do
    get login_path
    post login_path, params: { session: { name: " ",
                                          password: user.password } }
    expect(is_logged_in?).not_to be_truthy
  end
end
