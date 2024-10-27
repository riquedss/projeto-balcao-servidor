class CreateMessages < ActiveRecord::Migration[7.2]
  def change
    create_table :messages, id: :uuid do |t|
      t.text :text
      t.boolean :edited
      t.integer :status

      t.timestamps
    end
  end
end
