class Company < ApplicationRecord
  belongs_to :user, dependent: :destroy

  validates :nit, presence: true, uniqueness: true, numericality: true
  validates :name, presence: true
end
