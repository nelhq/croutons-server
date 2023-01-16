class CreateBrands < ActiveRecord::Migration[7.0]
  def change
    create_table :brands, options: "DEFAULT CHARSET=utf8mb4" do |t|
      t.string :name, null: false
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
