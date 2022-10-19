require "test_helper"

class CompanyTest < ActiveSupport::TestCase
  include CommonMethods

  def setup
    @user = users(:one)
    @company = companies(:one)
    @worker_one = workers(:one)
    @worker_two = workers(:two)
    @period_one = periods(:one)
  end

  # Columns

  test 'name column' do
    #                Model  Column  null? expected type
    validate_column(Company, 'name', true,   'string')
  end

  test 'nit column' do
    validate_column(Company, 'nit', true, 'integer')
  end

  test 'user_id column' do
    validate_column(Company, 'user_id', false, 'integer')
  end

  # associations

  test 'belongs_to user relation' do
    assert_equal users(:one), @company.user, "Company must have property 'user'"
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

    assert_not @compnay.valid?, "Company nit must be numeric"
  end

  test 'invalid name length' do
    length_asserts(@user)
  end
end
