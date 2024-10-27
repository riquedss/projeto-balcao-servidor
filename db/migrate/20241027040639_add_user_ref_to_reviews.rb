class AddUserRefToReviews < ActiveRecord::Migration[7.2]
  def change
    add_reference :reviews, :user, null: false, foreign_key: true, type: :uuid
  end
end
