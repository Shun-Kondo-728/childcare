require 'rails_helper'

RSpec.describe "StaticPages", type: :system do
  describe "トップページ" do
    context "ページ全体" do
      before do
        visit root_path
      end

      it "りにゅーしょく。のタイトルが存在すること" do
        expect(page).to have_content 'りにゅーしょく。'
      end

      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title
      end
    end
  end

  describe "使い方ページ" do
    before do
      visit about_path
    end

    it "使い方のタイトルが存在すること" do
      expect(page).to have_content '使い方'
    end

    it "正しいタイトルが表示されること" do
      expect(page).to have_title full_title('使い方')
    end
  end
end
