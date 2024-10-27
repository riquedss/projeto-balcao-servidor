class AddUserRefToAdvertisements < ActiveRecord::Migration[7.2]
  def change
    add_reference :advertisements, :user, null: false, foreign_key: true, type: :uuid
  end
end
