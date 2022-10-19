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

  test 'employeed_payment column' do
    validate_column(Payroll, 'employeed_payment', true, 'integer')
  end

  test 'reten_deduc column' do
    validate_column(Payroll, 'reten_deduc', false, 'integer')
  end
end
