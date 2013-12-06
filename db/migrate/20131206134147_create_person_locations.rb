class CreatePersonLocations < ActiveRecord::Migration
  def change
    create_table :person_locations do |t|
      t.belongs_to :person, index: true
      t.belongs_to :location, index: true

      t.timestamps
    end
  end
end
