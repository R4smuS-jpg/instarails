class Comment < ApplicationRecord
  # relations
  belongs_to :user
  belongs_to :post, counter_cache: true

  # scopes
  scope :by_created_at, ->(order) { order(created_at: order) }
  scope :with_user_with_attached_avatar,
    -> { includes(:user).merge(User.with_attached_avatar) }

  # validations
  validates :content, presence: true,
                      length: { in: 1..300 }
  validates :user_id, presence: true
  validates :post_id, presence: true
end
