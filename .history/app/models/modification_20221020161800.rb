class Modification < ApplicationRecord
  belongs_to :period, dependent: :destroy
  belongs_to :worker, dependent: :destroy
  before_save :params_nil?

  validates :period_id, :worker_id, presence: {code: "032"}

  private

  def params_nil?
    self.other_salary_incomes = 0 if self.other_salary_incomes.nil? || self.other_salary_incomes.class != Integer
    self.no_salary_incomes = 0 if self.no_salary_incomes.nil? || self.no_salary_incomes.class != Integer
    self.deductions = 0 if self.deductions.nil? || self.deductions.class != Integer
  end
end
