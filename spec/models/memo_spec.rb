require 'rails_helper'

RSpec.describe Memo, type: :model do
  let!(:memo) { create(:memo) }
  let!(:memo_yesterday) { create(:memo, :yesterday) }
  let!(:memo_one_week_ago) { create(:memo, :one_week_ago) }
  let!(:memo_one_month_ago) { create(:memo, :one_month_ago) }

  context "バリデーション" do
    it "有効な状態であること" do
      expect(memo).to be_valid
    end

    it "離乳食名がなければ無効な状態であること" do
      memo = build(:memo, name: nil)
      memo.valid?
      expect(memo.errors[:name]).to include("を入力してください")
    end

    it "離乳食名が20文字以内であること" do
      memo = build(:memo, name: "あ" * 21)
      memo.valid?
      expect(memo.errors[:name]).to include("は20文字以内で入力してください")
    end

    it "作り方が60文字以内であること" do
      memo = build(:memo, description: "あ" * 61)
      memo.valid?
      expect(memo.errors[:description]).to include("は60文字以内で入力してください")
    end

    it "ユーザーIDがなければ無効な状態であること" do
      memo = build(:memo, user_id: nil)
      memo.valid?
      expect(memo.errors[:user_id]).to include("を入力してください")
    end
  end

  context "作成日時の並び順" do
    it "最新の投稿が最初になっていること" do
      expect(memo).to eq Memo.first
    end
  end
end
