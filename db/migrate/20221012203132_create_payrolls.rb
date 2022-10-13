class CreatePayrolls < ActiveRecord::Migration[7.0]
  def change
    create_table :payrolls do |t|
      t.references :period, null: false, foreign_key: true
      t.integer :employeed_payment
      t.integer :reten_deduc
      t.integer :total_payrolls
      t.integer :social_benefits
      t.integer :parafiscal_cont
      t.integer :social_security

      t.timestamps
    end
  end
end
