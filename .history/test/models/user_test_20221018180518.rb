require "test_helper"

class UserTest < ActiveSupport::TestCase
  include CommonMethods

  def setup
    @user = users(:one)
    @company = companies(:one)
  end

  # Columns

  test 'name column' do
    #                Model  Column  null? expected type
    validate_column(User, 'name', true,   'string')
  end

  test 'email column' do
    validate_column(User, 'email', true, 'string')
  end

  test 'password_digest column' do
    validate_column(User, 'password_digest', true, 'string')
  end

  # associations

  test 'has_one company relation' do
    assert_equal companies(:one), @user.company, 'User must be related with company'
  end

  test 'has_many :games relation' do
    assert_equal [@game], @worker.games, 'worker table must have relation with games table'
  end

  test 'has_many :worker_games relation' do
    assert_equal [@worker_games], @worker.worker_game, 'worker_games relation'
  end

  # Indexes

  test 'location_id indexes' do
    indexes = ::ActiveRecord::Base.connection.indexes(Worker.table_name)
    matched_index = indexes.detect {|i| i.columns == ['location_id']}

    assert matched_index.present?, 'location_id index must exist in worker table'
  end

  # Validations

  test 'name nil' do
    @worker.name = nil

    assert_not @worker.valid?, 'worker name cant be empty'
  end

  test 'invalid name length' do
    length_asserts(@worker)
  end
end
