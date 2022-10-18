class User < ApplicationRecord
  # Associations
  has_one :company, dependent: :destroy
  
  has_secure_password

  validates :email, presence: {code: "0001"}, uniqueness: {code: "0004"}
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, code: "0003" }
  validates :name, presence: {code: "0001"}, length: { in: (3..30), code: "0002" }
  validates :password, presence: {code: "0001"}, length: { minimum: 6, code: "0002" }
end
