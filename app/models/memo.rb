class Memo < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 20 }
  validates :description, length: { maximum: 60 }
end
