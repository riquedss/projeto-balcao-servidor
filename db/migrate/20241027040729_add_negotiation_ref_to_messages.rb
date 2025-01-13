class AddNegotiationRefToMessages < ActiveRecord::Migration[7.2]
  def change
    add_reference :messages, :negotiation, null: false, foreign_key: true, type: :uuid
  end
end
