class AddAdvertisementRefToNegotiations < ActiveRecord::Migration[7.2]
  def change
    add_reference :negotiations, :advertisement, null: false, foreign_key: true, type: :uuid
  end
end
