class Like < ApplicationRecord
  belongs_to :user
  validates :annict_id, presence: true
  validates :user_id, uniqueness: { scope: :annict_id }
end
