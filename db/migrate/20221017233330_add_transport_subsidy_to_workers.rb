class AddTransportSubsidyToWorkers < ActiveRecord::Migration[7.0]
  def change
    add_column :workers, :transport_subsidy, :string
  end
end
