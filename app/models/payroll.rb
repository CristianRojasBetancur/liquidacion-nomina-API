class Payroll < ApplicationRecord
  belongs_to :period, dependent: :destroy
  belongs_to :worker, dependent: :destroy

  validate :can_settle_payroll, :no_repeat_payroll_for_same_employee

  private

  def can_settle_payroll
    last_period_payrolls = Period.last.payrolls
    errors.add(:base, "you already settle payroll this period", code: "014") unless last_period_payrolls
  end

  def no_repeat_payroll_for_same_employee
    payroll_to_value = Period.last.payrolls.find_by(worker_id: self.worker_id)
    errors.add(:base, "have two payrolls or more for only employee in the same period", code: "015") if payroll_to_value
  end
end
