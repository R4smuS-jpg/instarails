class Relationship < ApplicationRecord
  # relations
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  # validations
  validates :follower_id, presence: true
  validates :followed_id, presence: true
  validates_uniqueness_of :followed_id, :scope => [:follower_id]
  validate :user_cannot_follow_himself

  private

  def user_cannot_follow_himself
    if follower_id == followed_id
      errors.add(:follower_id, 'follower_id can\'t be equal to followed_id')
    end
  end
end
