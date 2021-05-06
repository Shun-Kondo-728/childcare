require 'rails_helper'

RSpec.describe "Users", type: :system do
  let!(:user) { create(:user) }

  describe "ユーザー登録ページ" do
    before do
      visit signup_path
    end

    context "ページレイアウト" do
      it "新規登録のタイトルが存在すること" do
        expect(page).to have_content '新規登録'
      end

      it "正しいタイトルが表示されることを確認" do
        expect(page).to have_title full_title('新規登録')
      end
    end

    context "新規登録処理" do
      it "有効なユーザーで新規登録を行うとユーザー登録成功のメッセージが表示されること" do
        fill_in "名前", with: "Example User"
        fill_in "パスワード", with: "password"
        fill_in "パスワード(確認)", with: "password"
        click_button "登録"
        expect(page).to have_content "りにゅーしょく。へようこそ！"
      end
   
      it "無効なユーザーで新規登録を行うと新規登録失敗のエラーが表示されること" do
        fill_in "名前", with: ""
        fill_in "パスワード", with: "password"
        fill_in "パスワード(確認)", with: "pass"
        click_button "登録"
        expect(page).to have_content "名前を入力してください"
        expect(page).to have_content "パスワード(確認)とパスワードの入力が一致しません"
      end
    end
  end
end
