class RemoveAFromWorkers < ActiveRecord::Migration[7.0]
  def change
    remove_column :workers, :a
    remove_column :workers, :end_date
  end
end
