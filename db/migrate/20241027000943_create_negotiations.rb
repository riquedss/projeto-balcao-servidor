class CreateNegotiations < ActiveRecord::Migration[7.2]
  def change
    create_table :negotiations, id: :uuid do |t|
      t.integer :status
      t.text :proposal

      t.timestamps
    end
  end
end
