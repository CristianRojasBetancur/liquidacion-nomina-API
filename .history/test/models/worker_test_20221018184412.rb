require "test_helper"

class WorkerTest < ActiveSupport::TestCase
  include CommonMethods

  def setup
    @worker = users(:one)
    @company = companies(:one)
  end

  # Columns

  test 'name column' do
    #                Model  Column  null? expected type
    validate_column(Worker, 'name', true,   'string')
  end

  test 'cc column' do
    validate_column(Worker, 'cc', true, 'string')
  end

  test 'salary column' do
    validate_column(Worker, 'salary', true, 'integer')
  end

  test 'company_id column' do
    validate_column(Worker, 'company_id', false, 'integer')
  end

  test 'risk column' do
    validate_column(Worker, 'risk', true, 'integer')
  end

  test 'transport_subsidy column' do
    validate_column(Worker, 'transport_subsidy', true, 'string')
  end

  # associations

  test 'belongs_to company relation' do
    assert_equal companies(:one), @worker.company, "Worker must have property 'company'"
  end

  test 'has_many payrolls relation' do
    assert_equal payrolls(:one), @worker.payrolls, "Worker must have property 'company'"
  end

  # Indexes

  # test 'location_id indexes' do
  #   indexes = ::ActiveRecord::Base.connection.indexes(Worker.table_name)
  #   matched_index = indexes.detect {|i| i.columns == ['location_id']}

  #   assert matched_index.present?, 'location_id index must exist in worker table'
  # end

  # Validations

  test 'name nil' do
    @user.name = nil

    assert_not @user.valid?, "User name can't be empty"
  end

  test 'email nil' do
    @user.email = nil

    assert_not @user.valid?, "User email can't be empty"
  end

  test 'password nil' do
    @user.password_digest = nil

    assert_not @user.valid?, "User password can't be empty"
  end

  test 'invalid name length' do
    length_asserts(@user)
  end
end
