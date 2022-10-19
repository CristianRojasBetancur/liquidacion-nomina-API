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
    assert_equal [@payroll_one, @payroll_two], @period.payrolls, "Period must have property 'payrolls'"
  end
  
  test 'belongs_to company relation' do
    assert_equal @company, @period.company, "Period must have property 'company'"
  end

  # Indexes

  test 'company_id indexes' do
    indexes = ::ActiveRecord::Base.connection.indexes(Period.table_name)
    matched_index = indexes.detect {|i| i.columns == ['company_id']}

    assert matched_index.present?, 'company_id index must exist in periods table'
  end

  # Validations

  test 'year inclusion' do
    unless @period.year in (2000..2022)
      assert_not @period.valid?, "Period year must be in (2000 & 2022)"
    end
  end

  test 'valid month' do
    unless @period.month in (1..12)
      assert_not @period.valid?, "Period month invalid"
    end
  end
end
