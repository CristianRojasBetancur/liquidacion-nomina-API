class Modification < ApplicationRecord
  belongs_to :period, dependent: :destroy
  belongs_to :worker, dependent: :destroy

  validates :period_id, :worker_id, presence: {code: "032"}
  validates :other_salary_incomes, :no_salary_incomes, :deductions, numericality: {greather_than: 0, only_integer: true, code: "034"}
end
