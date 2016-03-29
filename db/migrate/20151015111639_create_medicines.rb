class CreateMedicines < ActiveRecord::Migration
  def change
    create_table :medicines do |t|
      t.string :name
      t.string :quantity
      t.string :selling_quantity
      t.date :expiry_date
      t.integer :price

      t.timestamps null: false
    end
  end
end
