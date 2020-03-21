class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.float :lat
      t.float :lon
      t.string :city
      t.string :state
    end
  end
end
