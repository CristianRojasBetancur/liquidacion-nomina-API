class RemoveColumnWorkers < ActiveRecord::Migration[7.0]
  def change
    remove_column :workers, :start_date
  end
end
