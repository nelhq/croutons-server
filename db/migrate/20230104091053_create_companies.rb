class CreateCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :companies, options: "DEFAULT CHARSET=utf8mb4" do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
