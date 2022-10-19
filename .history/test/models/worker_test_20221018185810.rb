require "test_helper"

class WorkerTest < ActiveSupport::TestCase
  include CommonMethods

  def setup
    @worker = workers(:one)
    @company = companies(:one)
    @payroll_one = payrolls(:one)
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
    assert_equal [@payroll_one], @worker.payrolls, "Worker must have property 'payrolls'"
  end

  # Indexes

  test 'company_id indexes' do
    indexes = ::ActiveRecord::Base.connection.indexes(Worker.table_name)
    matched_index = indexes.detect {|i| i.columns == ['company_id']}

    assert matched_index.present?, 'company_id index must exist in worker table'
  end

  # Validations

  test 'columns nil' do
    @worker.name = nil
    assert_not @worker.valid?, "Worker name can't be empty"

    @worker.cc = nil
    assert_not @worker.valid?, "Worker cc can't be empty"

    @worker.salary = nil
    assert_not @worker.valid?, "Worker salary can't be empty"

    @worker.company_id = nil
    assert_not @worker.valid?, "Worker company_id can't be empty"

    @worker.risk = nil
    assert_not @worker.valid?, "Worker risk can't be empty"

    @worker.transport_subsidy = nil
    assert_not @worker.valid?, "Worker tranport_subsidy can't be empty"
  end

  test 'invalid name length' do
    length_asserts(@worker)
  end

  test 'cc uniqueness' do
    worker_two = @worker.dup

    assert_not worker_two.valid?, "Worker cc must be unique"
  end

  test 'cc salary company_id numericality' do
    @worker.cc = "Hola"
    assert_not @worker.valid?, "Worker cc must be numeric"

    @worker.salary = "Chao"
    assert_not @worker.valid?, "Worker salary must be numeric"

    @worker.company_id = "Hola otra vez"
    assert_not @worker.valid?, "Worker company_id must be numeric"
  end

  test 'transport_subsidy inclusion' do
    unless @worker.tranport_subsidy in %w(yes no)
      assert_not @worker.valid?, "tranport_subsidy must be 'yes' or 'no'"
    end
  end
end
