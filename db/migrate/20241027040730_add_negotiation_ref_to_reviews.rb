class AddNegotiationRefToReviews < ActiveRecord::Migration[7.2]
  def change
    add_reference :reviews, :negotiation, null: false, foreign_key: true, type: :uuid
  end
end
