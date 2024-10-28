class AddUserRefToNegotiations < ActiveRecord::Migration[7.2]
  def change
    add_reference :negotiations, :user, null: false, foreign_key: true, type: :uuid
  end
end
