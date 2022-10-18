class Period < ApplicationRecord
  has_many :payrolls, dependent: :destroy
  belongs_to :company, dependent: :destroy

  validates :year, inclusion: {in: (2000..2022), message: "Only can generate a payroll beetwen 2000 and 2022.", code: "009"}
  validate :valid_month, :settled_payroll?

  private

  def same_year_and_month
    year_to_value = Period.find_by(year: self.year)
    month_to_value = @current_user.company.periods.find(month: self.month)

    errors.add(:base, "This period already exists", code: "010") if year_to_value && month_to_value
  end

  def valid_month
    errors.add(:base, "Invalid month", code: "011") unless self.month in (1..12)
  end

  def settled_payroll?
    payrolls_actual_period = @current_user.company.periods.last.payrolls if @current_user.company.periods.last

    errors.add(:base, "you cannot create another period until you settle payroll for the current period", code: "013") if payrolls_actual_period == [] && Period.all.size >= 1
  end
end
