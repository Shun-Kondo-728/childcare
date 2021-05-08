require 'rails_helper'

RSpec.describe "Memos", type: :system do
  let!(:user) { create(:user) }
  let!(:memo) { create(:memo, user: user) }

  describe "離乳食メモ" do
    before do
      login_for_system(user)
      create_list(:memo, 10, user: user)
      visit memos_path
    end

    context "ページレイアウト", js: true do
      it "離乳食メモの件数が表示されていること" do
        expect(page).to have_content "離乳食名"
      end

      it "離乳食メモの情報が表示されていること" do
        Memo.take(5).each do |memo|
          expect(page).to have_link memo.name
        end
      end

      it "鈴風色メモのページネーションが表示されていること" do
        expect(page).to have_css "nav.pagination"
      end
    end
  end
end
