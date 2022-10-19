class CreateModifications < ActiveRecord::Migration[7.0]
  def change
    create_table :modifications do |t|
      t.references :period, null: false, foreign_key: true
      t.references :worker, null: false, foreign_key: true
      t.integer :other_salary_incomes
      t.integer :no_salary_incomes
      t.integer :deductions

      t.timestamps
    end
  end
end
