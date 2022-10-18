class AddTotalCompanyCostToPayrolls < ActiveRecord::Migration[7.0]
  def change
    add_column :payrolls, :total_company_cost, :integer
  end
end
