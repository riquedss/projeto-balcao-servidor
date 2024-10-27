class CreateTransactions < ActiveRecord::Migration[7.2]
  def change
    create_table :transactions, id: :uuid do |t|
      t.integer :status

      t.timestamps
    end
  end
end
