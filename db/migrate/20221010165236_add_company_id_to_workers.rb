class AddCompanyIdToWorkers < ActiveRecord::Migration[7.0]
  def change
    add_reference :workers, :company, null: false, foreign_key: true
  end
end
