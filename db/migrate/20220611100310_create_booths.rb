class CreatePlaces < ActiveRecord::Migration[7.0]
  def change
    create_table :places do |t|
      t.string :google_place_id
      t.string :name
      t.string :timezone
      t.float :longitude
      t.float :latitude

      t.timestamps
    end
    
    add_column :events, :place_id, :integer

    Event.all do |event|
      place = Place.where(google_place_id: event.google_place_id).first_or_create!
      event.place = place
      event.save
    end

    remove_column :slots, :event_id
    add_column :slots, :place_id, :integer
    remove_column :events, :longitude
    remove_column :events, :latitude
    remove_column :events, :google_place_id

  
  end
end
