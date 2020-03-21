class CreateWeathers < ActiveRecord::Migration
  def change
    create_table :weathers do |t|
      t.string :date
      t.references :location, type: :integer, foreign_key: true, null: false
      t.string :temperature
    end
  end
end
