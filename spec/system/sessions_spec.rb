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
  end
end
