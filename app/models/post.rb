class Post < ApplicationRecord
  # relations
  belongs_to :user
  has_many_attached :images

  # validations
  validates :content, length: {maximum: 200}
  validates :images, attached: true,
                     content_type: [:png, :jpg, :jpeg],
                     size: {between: 1.kilobyte..5.megabytes},
                     limit: {min: 1, max: 10}
end
