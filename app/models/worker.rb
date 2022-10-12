class Worker < ApplicationRecord
  belongs_to :company, dependent: :destroy

  validates :name, :cc, :salary, :company_id, presence: true
  validates :name, length: {minimum:3, maximum:20}
  validates :cc, uniqueness: true
  validates :cc, :salary, :company_id, numericality: true
end
