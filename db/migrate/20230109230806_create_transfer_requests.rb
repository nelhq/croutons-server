class CreateTransferRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :transfer_requests do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :amount, null: false

      t.timestamps
    end
  end
end
