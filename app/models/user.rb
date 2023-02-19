class User < ApplicationRecord
  has_secure_password

  # relations
  has_many :posts
  has_one_attached :avatar

  # callbacks
  before_save { self.email.downcase! }

  # validations
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX },
                    length: { minimum: 5, maximum: 40 },
                    uniqueness: true

  validates :nickname, presence: true,
                       length: { minimum: 3, maximum: 40 },
                       uniqueness: true

  validates :avatar, content_type: [:png, :jpg, :jpeg, :gif],
                     size: { less_than: 2.megabytes },
                     limit: { max: 1 }                       

  validates :full_name, presence: true,
                        length: { minimum: 3, maximum: 50 }

  # presence validation for password is not necessary                      
  # because has_secure_password automatically adds it
  validates :password, length: { minimum: 8, maximum: 60 }

  validates :password_confirmation, presence: true, 
                                    length: { minimum: 8, maximum: 60 }

end
