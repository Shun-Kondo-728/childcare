require 'rails_helper'

RSpec.describe "Users", type: :request do
  before do
    get signup_path
  end

  it "正しいレスポンスを返すこと" do
    expect(response).to be_success
    expect(response).to have_http_status "200"
  end

  it "有効なユーザーで登録" do
    expect {
      post users_path, params: { user: { name: "BabyFood",
                                         password: "password",
                                         password_confirmation: "password" } }
    }.to change(User, :count).by(1)
    redirect_to @user
    follow_redirect!
  end

  it "無効なユーザーで登録" do
    expect {
      post users_path, params: { user: { name: "BabyFood",
                                         password: "password",
                                         password_confirmation: "pass" } }
    }.not_to change(User, :count)
  end
end
