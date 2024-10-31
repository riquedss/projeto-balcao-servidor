class CreateAdvertisements < ActiveRecord::Migration[7.2]
  def change
    create_table :advertisements, id: :uuid do |t|
      t.string :title
      t.text :description
      t.float :price
      t.integer :status
      t.integer :category
      t.integer :campus
      t.string :phone_contact
      t.string :email_contact

      t.timestamps
    end
  end
end
