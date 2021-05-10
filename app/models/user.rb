class User < ApplicationRecord
  has_many :memos, dependent: :destroy
  has_many :calenders
  validates :name, presence: true, length: { maximum: 30 },
                   uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

    def feed
      Memo.where("user_id = ?", id)
    end
end
