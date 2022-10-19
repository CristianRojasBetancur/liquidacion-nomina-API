require "test_helper"

class PayrollTest < ActiveSupport::TestCase
  include CommonMethods

  def setup
    @company = companies(:one)
    @period = periods(:one)
    @payroll_one = payrolls(:one)
    @payroll_two = payrolls(:two)
  end

  # Columns

  test 'period_id column' do
    #                Model  Column  null? expected type
    validate_column(Payroll, 'period_id', false,   'integer')
  end

  test 'month column' do
    validate_column(Period, 'month', true, 'integer')
  end

  test 'company_id column' do
    validate_column(Period, 'company_id', false, 'integer')
  end
end