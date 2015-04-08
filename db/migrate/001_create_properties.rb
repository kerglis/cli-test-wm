class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties, force: true do |t|
      t.string :title
      t.string :property_type
      t.string :address
      t.decimal :nightly_rate
      t.integer :max_guests
      t.string :email
      t.string :phone_number
      t.boolean :is_completed
    end

    add_index :properties, :is_completed
  end
end
