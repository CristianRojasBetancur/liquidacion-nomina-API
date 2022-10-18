class AddRiskToWorkers < ActiveRecord::Migration[7.0]
  def change
    add_column :workers, :risk, :integer
  end
end
