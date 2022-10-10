class User < ApplicationRecord
  # Associations
  has_one :company, dependent: :destroy
  
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name, presence: true, length: { in: (3..30) }
  validates :password, length: { minimum: 6 }
end
