class AddStartDateToWorkers < ActiveRecord::Migration[7.0]
  def change
    add_column :workers, :start_date, :datetime
    add_column :workers, :end_date, :datetime
    add_column :workers, :salary, :integer
  end
end
