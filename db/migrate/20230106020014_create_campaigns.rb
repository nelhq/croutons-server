class CreateCampaigns < ActiveRecord::Migration[7.0]
  def change
    create_table :campaigns, options: "DEFAULT CHARSET=utf8mb4" do |t|
      t.references :product, null: false, foreign_key: true
      t.string :name, null: false
      t.datetime :posted_period, null: false
      t.float :play_unit_price, null: false

      t.timestamps
    end
  end
end
