class CreateReviews < ActiveRecord::Migration[7.2]
  def change
    create_table :reviews, id: :uuid do |t|
      t.float :rating
      t.text :comments

      t.timestamps
    end
  end
end
