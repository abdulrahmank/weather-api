class AddUniquenessConstraintToLocations < ActiveRecord::Migration[5.0]
  def change
    add_index :locations, [:lat, :lon], unique: true, name: 'uniq_reference_lat_lon_per_location'
  end
end
