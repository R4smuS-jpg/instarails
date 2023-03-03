class Post < ApplicationRecord
  # relations
  belongs_to :user
  has_many :comments, dependent: :delete_all
  has_many_attached :images, dependent: :delete_all

  # scopes
  scope :with_user_with_attached_avatar,
    -> { includes(:user).merge(User.with_attached_avatar) }
  scope :with_attached_images, -> { includes(images_attachments: :blob) }
  scope :with_comments_with_user,
    -> { includes(:comments).merge(Comment.with_user) }  

  scope :by_created_at, ->(order) { order(created_at: order) }

  # validations
  validates :user_id, presence: true
  validates :content, length: { maximum: 200 }
  validates :images, attached: true,
                     content_type: [:png, :jpg, :jpeg, :gif],
                     size: { less_than: 3.megabytes },
                     limit: { min: 1, max: 10 }
  
  # instance methods
  def created_at_formatted
    self.created_at.strftime("%d/%m/%Y at %H:%M")
  end
end
