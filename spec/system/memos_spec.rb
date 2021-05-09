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

      it "離乳食メモのページネーションが表示されていること" do
        expect(page).to have_css "nav.pagination"
      end

      it "「メモする」が表示されること" do
        visit memos_path
        expect(page).to have_link "メモする", href: new_memo_path
      end
    end

    context "料理登録処理" do
      before do
        visit new_memo_path
      end

      it "離乳食メモのタイトルが存在すること" do
        expect(page).to have_content '離乳食メモ'
      end

      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title('離乳食投稿')
      end

      it "入力部分に適切なラベルが表示されること" do
        expect(page).to have_content '離乳食名'
        expect(page).to have_content '作り方'
      end

      it "有効な情報でメモを行うとメモ成功のフラッシュが表示されること" do
        fill_in "離乳食名", with: "離乳食名"
        fill_in "作り方", with: "ここをこうやってつくります。"
        click_button "メモする"
        expect(page).to have_content "離乳食が登録されました！"
      end

      it "無効な情報で料理登録を行うと料理登録失敗のフラッシュが表示されること" do
        fill_in "離乳食名", with: ""
        fill_in "作り方", with: "ここをこうやってつくります。"
        click_button "メモする"
        expect(page).to have_content "離乳食名を入力してください"
      end
    end
  end

  describe "離乳食メモ詳細ページ" do
    context "ページレイアウト" do
      before do
        login_for_system(user)
        visit memo_path(memo)
      end

      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title("#{memo.name}")
      end

      it "メモの情報が表示されること" do
        expect(page).to have_content memo.name
        expect(page).to have_content memo.description
      end
    end
  end

  describe "料理編集ページ" do
    before do
      login_for_system(user)
      visit memo_path(memo)
      click_link "編集"
    end

    context "ページレイアウト" do
      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title('離乳食メモの編集')
      end

      it "入力部分に適切なラベルが表示されること" do
        expect(page).to have_content '離乳食名'
        expect(page).to have_content '使い方'
      end
    end

    context "離乳食メモの更新処理" do
      it "有効な更新" do
        fill_in "離乳食名", with: "編集：離乳食名"
        fill_in "作り方", with: "編集：ここをこうやって作ります。"
        click_button "更新する"
        expect(page).to have_content "離乳食メモ情報が更新されました！"
        expect(memo.reload.name).to eq "編集：離乳食名"
        expect(memo.reload.description).to eq "編集：ここをこうやって作ります。"
      end

      it "無効な更新" do
        fill_in "離乳食名", with: ""
        click_button "更新する"
        expect(page).to have_content '離乳食名を入力してください'
        expect(memo.reload.name).not_to eq ""
      end
    end

    context "離乳食メモの削除処理", js: true do
      it "削除成功のフラッシュが表示されること" do
        click_on '削除'
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content '離乳食メモが削除されました'
      end
    end
  end
end
