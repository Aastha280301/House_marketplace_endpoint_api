class CreateProperties < ActiveRecord::Migration[7.0]
  def change
    create_table :properties do |t|
      t.string :city
      t.string :district
      t.integer :bedrooms
      t.decimal :rent
      t.string :mrt_line

      t.timestamps
    end
  end
end
