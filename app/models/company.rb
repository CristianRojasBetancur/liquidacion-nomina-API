class Company < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :workers
  has_many :periods

  validates :nit, presence: true, uniqueness: {message: "Already exist an company with this NIT", code: "018"}, numericality: {message: "Invalid NIT", code: "019"}
  validates :name, presence: true
end
