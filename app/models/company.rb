class Company < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :workers

  validates :nit, presence: true, uniqueness: true, numericality: true
  validates :name, presence: true
end
