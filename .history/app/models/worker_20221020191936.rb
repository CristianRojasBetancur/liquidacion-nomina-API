class Worker < ApplicationRecord
  belongs_to :company, dependent: :destroy
  has_many :payrolls, dependent: :destroy
  has_one :modification

  validates :name, :cc, :salary, :company_id, :risk, :transport_subsidy, presence: {code: "020"}
  validates :name, length: {minimum:3, maximum:30, code: "021"}
  validates :cc, uniqueness: {message: "This cc already registered in this company or another company.", code: "017"}
  validates :cc, :salary, :company_id, :risk, numericality: true
  validates :risk, inclusion: {"Laboral risk must be included in (1..5)", in: (1..5), code: "0023"}
  validates :transport_subsidy, inclusion: {in: %w(yes no), message: "The value of transport_subsidy must be 'yes' or 'no'", code: "023"}
end
