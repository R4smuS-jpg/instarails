class Like < ApplicationRecord
  # relations
  belongs_to :user
  belongs_to :post

  # validations
  validates :user_id, presence: true
  validates :post_id, presence: true
  validates_uniqueness_of :user_id, scope: [:post_id]
end
