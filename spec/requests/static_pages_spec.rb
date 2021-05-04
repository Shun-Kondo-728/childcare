require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  describe "トップページ" do
    it "正しいレスポンスを返すこと" do
      get root_path
      expect(response).to be_success
      expect(response).to have_http_status "200"
    end
  end

  describe "使い方ページ" do
    it "正しいレスポンスを返すこと" do
      get about_path
      expect(response).to be_success
      expect(response).to have_http_status "200"
    end
  end
end
