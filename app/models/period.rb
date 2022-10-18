class Period < ApplicationRecord
  has_many :payrolls, dependent: :destroy
  belongs_to :company, dependent: :destroy

  validates :year, inclusion: {in: (2000..2022), message: "Only can generate a payroll beetwen 2000 and 2022.", code: "009"}
<<<<<<< HEAD
  validate :same_year_and_month, :valid_month
=======
  validate :valid_month
>>>>>>> liquidar_nomina

  private

  def valid_month
    errors.add(:base, "Invalid month", code: "011") unless self.month in (1..12)
  end
<<<<<<< HEAD

  # def settled_payroll?
  #   actual_period = Period.last

  #   errors.add(:base, "you cannot create another period until you settle payroll for the current period", code: "013") if actual_period && actual_period.payroll.nil?
  # end
=======
>>>>>>> liquidar_nomina
end
