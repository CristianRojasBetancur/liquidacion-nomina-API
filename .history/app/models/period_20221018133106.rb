class Period < ApplicationRecord
  has_many :payrolls, dependent: :destroy
  belongs_to :company, dependent: :destroy

  validates :year, inclusion: {in: (2000..2022), message: "Only can generate a payroll beetwen 2000 and 2022.", code: "009"}
  validate :valid_month

  private

  def valid_month
    errors.add(:base, "Invalid month", code: "011") unless self.month in (1..12)
  end
end
