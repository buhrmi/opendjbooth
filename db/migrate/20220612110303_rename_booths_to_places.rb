class RenameBoothsToPlaces < ActiveRecord::Migration[7.0]
  def change
    rename_table :booths, :places
    rename_column :events, :booth_id, :place_id
    rename_column :slots, :booth_id, :place_id
    
    add_column :places, :city_id, :integer
    add_column :places, :country_id, :integer
  end
end
