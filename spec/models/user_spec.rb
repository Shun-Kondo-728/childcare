require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  context "バリデーション" do
    it "名前があれば有効な状態であること" do
      expect(user).to be_valid
    end

    it "名前がなければ無効な状態であること" do
      user = build(:user, name: nil)
      user.valid?
      expect(user.errors[:name]).to include("を入力してください")
    end

    it "名前が30文字以内であること" do
      user = build(:user, name: "a" * 31)
      user.valid?
      expect(user.errors[:name]).to include("は30文字以内で入力してください")
    end

    it "パスワードがなければ無効な状態であること" do
      user = build(:user, password: nil, password_confirmation: nil)
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end

    it "パスワードが6文字以上であること" do
      user = build(:user, password: "a" * 6, password_confirmation: "a" * 6)
      user.valid?
      expect(user).to be_valid
    end
  end
end
