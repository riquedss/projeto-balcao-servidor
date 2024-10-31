class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users, id: :uuid do |t|
      t.string :image
      t.string :full_name
      t.string :cpf
      t.string :email
      t.string :password_digest
      t.integer :role

      t.timestamps
    end
  end
end
