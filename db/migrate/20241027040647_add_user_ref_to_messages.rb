class AddUserRefToMessages < ActiveRecord::Migration[7.2]
  def change
    add_reference :messages, :user, null: false, foreign_key: true, type: :uuid
  end
end
