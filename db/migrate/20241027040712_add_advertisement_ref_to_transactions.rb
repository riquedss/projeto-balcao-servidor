class AddAdvertisementRefToTransactions < ActiveRecord::Migration[7.2]
  def change
    add_reference :transactions, :advertisement, null: false, foreign_key: true, type: :uuid
  end
end
