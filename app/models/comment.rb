class Comment < ApplicationRecord
  # relations
  belongs_to :user
  belongs_to :post

  # scopes
  scope :by_created_at, ->(order) { order(created_at: order) }
  scope :with_user, -> { includes(:user) }

  # validations
  validates :content, presence: true,
                      length: { minimum: 1, maximum: 100 }
  validates :user_id, presence: true
  validates :post_id, presence: true
end
