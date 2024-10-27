class AddTransactionRefToReviews < ActiveRecord::Migration[7.2]
  def change
    add_reference :reviews, :transaction, null: false, foreign_key: true, type: :uuid
  end
end
