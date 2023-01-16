class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products, options: "DEFAULT CHARSET=utf8mb4" do |t|
      t.references :brand, null: false, foreign_key: true
      t.string :name, null: false
      t.text :description, null: false
      t.integer :price

      t.timestamps
    end
  end
end
