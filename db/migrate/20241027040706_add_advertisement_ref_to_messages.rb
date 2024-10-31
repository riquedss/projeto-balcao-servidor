class AddAdvertisementRefToMessages < ActiveRecord::Migration[7.2]
  def change
    add_reference :messages, :advertisement, null: false, foreign_key: true, type: :uuid
  end
end
