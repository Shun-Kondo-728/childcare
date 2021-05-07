require 'rails_helper'

RSpec.describe "Sessions", type: :system do
  let!(:user) { create(:user) }

  before do
    visit login_path
  end

  describe "ログインページ" do
    context "ページレイアウト" do
      it "ログインのタイトルが存在すること" do
        expect(page).to have_content 'ログイン'
      end

      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title('ログイン')
      end

      it "ヘッダーにログインページへのリンクがあることを確認" do
        expect(page).to have_link 'ログイン', href: login_path
      end

      it "ログインフォームの文字が正しく表示される" do
        expect(page).to have_content '名前'
        expect(page).to have_content 'パスワード'
      end

      it "ログインフォームが正しく表示される" do
        expect(page).to have_css 'input#user_name'
        expect(page).to have_css 'input#user_password'
      end

      it "ログインボタンが表示される" do
        expect(page).to have_button 'ログイン'
      end
    end

    context "ログイン処理" do
      it "無効なユーザーでログインを行うとログインが失敗すること" do
        fill_in "user_name", with: "abcde"
        fill_in "user_password", with: "pass"
        click_button "ログイン"
        expect(page).to have_content '名前とパスワードの組み合わせが誤っています'

        visit root_path
        expect(page).not_to have_content "名前とパスワードの組み合わせが誤っています"
      end

      it "有効なユーザーでログイン前後のヘッダーが正しく表示されていること" do
        expect(page).to have_link 'りにゅーしょく。の使い方', href: about_path
        expect(page).to have_link 'ユーザー登録', href: signup_path
        expect(page).to have_link 'ログイン', href: login_path
        expect(page).not_to have_link 'ログアウト', href: logout_path

        fill_in "user_name", with: user.name
        fill_in "user_password", with: user.password
        click_button "ログイン"

        expect(page).to have_link 'りにゅーしょく。の使い方', href: about_path
        expect(page).to have_link 'ログアウト', href: logout_path
        expect(page).not_to have_link 'ログイン', href: login_path
      end
    end
  end
end
