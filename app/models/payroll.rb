class Payroll < ApplicationRecord
  belongs_to :period
  belongs_to :worker

  validate :can_settle_payroll

  private

  def can_settle_payroll
    last_period = Period.last
    errors.add(:base, "you already settle payroll this period", code: "014") if !last_period.payroll.nil?
  end
end
