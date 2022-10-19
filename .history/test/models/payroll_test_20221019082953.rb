require "test_helper"

class PayrollTest < ActiveSupport::TestCase
  include CommonMethods

  def setup
    @company = companies(:one)
    @period = periods(:one)
    @payroll = payrolls(:one)
    @worker = workers(:one)
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

  test 'worker_id column' do
    validate_column(Payroll, 'worker_id', false, 'integer')
  end

  test 'total_company_cost column' do
    validate_column(Payroll, 'total_company_cost', true, 'integer')
  end

  # Indexes

  test 'period_id indexes' do
    indexes = ::ActiveRecord::Base.connection.indexes(Period.table_name)
    matched_index = indexes.detect {|i| i.columns == ['period_id']}

    assert matched_index.present?, 'period_id index must exist in payrolls table'
  end

  test 'worker_id indexes' do
    indexes = ::ActiveRecord::Base.connection.indexes(Period.table_name)
    matched_index = indexes.detect {|i| i.columns == ['worker_id']}

    assert matched_index.present?, 'worker_id index must exist in payrolls table'
  end

  # Associations

  test 'belongs_to period association' do
    assert_equal @period, @payroll.period, "Payroll must have property 'period'"
  end
  
  test 'belongs_to worker association' do
    assert_equal @worker, @payroll.worker, "Payroll must have property 'worker'"
  end

  # Validations

  test 'can_settle_payroll' do
    payroll_two = @payroll.dup  

    assert_not payroll_two.valid?, "You can't settle payroll in a period that already settled payroll"
  end

  test 'no_repeat_payroll_for_same_employee' do
    payroll_two = @payroll.dup  

    assert_not payroll_two.valid?, "You can't settle payroll in a period that already settled payroll"
  end
end
