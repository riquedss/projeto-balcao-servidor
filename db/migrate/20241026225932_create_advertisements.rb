class CreateAdvertisements < ActiveRecord::Migration[7.2]
  def change
    create_table :advertisements, id: :uuid do |t|
      t.string :title
      t.text :description
      t.decimal :price, precision: 7, scale: 2
      t.integer :status, default: 0
      t.integer :kind, default: 0
      t.integer :category
      t.integer :campus
      t.string :phone_contact
      t.string :email_contact

      t.timestamps
    end
  end
end
