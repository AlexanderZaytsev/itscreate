class AddFacebookIdToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :facebook_id, :string
  end
end
