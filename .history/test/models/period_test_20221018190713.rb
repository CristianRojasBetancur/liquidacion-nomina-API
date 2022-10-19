require "test_helper"

class PeriodTest < ActiveSupport::TestCase
  include CommonMethods

  def setup
    @company = companies(:one)
    @period = periods(:one)
    @payroll_one = payrolls(:one)
    @payroll_two = payrolls(:two)
  end

  # Columns

  test 'year column' do
    #                Model  Column  null? expected type
    validate_column(Company, 'year', true,   'integer')
  end

  test 'month column' do
    validate_column(Company, 'month', true, 'integer')
  end

  test 'company_id column' do
    validate_column(Period, 'company_id', false, 'integer')
  end

  # associations

  test 'has_many payrolls relation' do
    assert_equal [@payroll_one, @payroll_two], @period.payrolls, "Company must have property 'user'"
  end
  
  test 'has_many workers relation' do
    assert_equal [@worker_one, @worker_two], @company.workers, "Company must have property 'workers'"
  end

  test 'has_many periods relation' do
    assert_equal [@period_one], @company.periods, "Company must have property 'periods'"
  end

  # Indexes

  test 'user_id indexes' do
    indexes = ::ActiveRecord::Base.connection.indexes(Company.table_name)
    matched_index = indexes.detect {|i| i.columns == ['user_id']}

    assert matched_index.present?, 'user_id index must exist in company table'
  end

  # Validations

  test 'name nil' do
    @company.name = nil

    assert_not @company.valid?, "Company name can't be empty"
  end

  test 'nit nil' do
    @company.nit = nil

    assert_not @company.valid?, "company nit can't be empty"
  end

  test 'nit uniqueness' do
    company_two = @company.dup

    assert_not company_two.valid?, "Company nit must be unique"
  end

  test 'nit numericality' do
    @company.nit = "Hola"

    assert_not @company.valid?, "Company nit must be numeric"
  end
end
