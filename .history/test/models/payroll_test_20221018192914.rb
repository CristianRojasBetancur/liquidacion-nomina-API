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
    validate_column(Payroll, 'reten_deduc', true, 'integer')
  end

  test 'total_payrolls column' do
    validate_column(Payroll, 'total_payrolls', true, 'integer')
  end

  test 'social_benefits column' do
    validate_column(Payroll, 'social_benefits', true, 'integer')
  end

  test 'parafiscal_cont column' do
    validate_column(Payroll, 'parafiscal_cont', true, 'integer')
  end

  test 'social_security column' do
    validate_column(Payroll, 'social_security', true, 'integer')
  end

  test 'social_security column' do
    validate_column(Payroll, 'social_security', true, 'integer')
  end
end
