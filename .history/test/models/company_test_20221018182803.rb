require "test_helper"

class CompanyTest < ActiveSupport::TestCase
  include CommonMethods

  def setup
    @user = users(:one)
    @company = companies(:one)
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
    validate_column(Company, 'nit', true, 'integer')
  end

  # associations

  test 'belongs_to user relation' do
    assert_equal users(:one), @company.user, "Company must have property 'user'"
  end

  # Indexes

  test 'user_id indexes' do
    indexes = ::ActiveRecord::Base.connection.indexes(Company.table_name)
    matched_index = indexes.detect {|i| i.columns == ['user_id']}

    assert matched_index.present?, 'user_id index must exist in company table'
  end

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
