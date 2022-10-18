class Company < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :workers, dependent: :destroy
  has_many :periods, dependent: :destroy

  validates :nit, presence: true, uniqueness: {message: "Already exist an company with this NIT", code: "018"}, numericality: {message: "Invalid NIT", code: "019"}
  validates :name, presence: true
end
