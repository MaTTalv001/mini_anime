class Favorite < ApplicationRecord
  belongs_to :user
  validates :work_id, presence: true
  validates :user_id, uniqueness: { scope: :work_id }
end