class Period < ApplicationRecord
  has_many :payrolls, dependent: :destroy
  belongs_to :company, dependent: :destroy
  has_many :modifications

  validates :year, inclusion: {in: (2000..2022), message: "Only can generate a payroll beetwen 2000 and 2022.", code: "009"}, numericality: {message: "Year must be numeric", code: "030"}
  validates :month, inclusion: {in: (1..12), message: "Invalid month", code: "011"}, numericality: {message: "Month must be numeric", code: "030"}
end
