class CreateBooths < ActiveRecord::Migration[7.0]
  def change
    create_table :booths do |t|
      t.string :google_place_id
      t.string :name
      t.string :timezone
      t.float :longitude
      t.float :latitude

      t.timestamps
    end
    
    add_column :events, :booth_id, :integer

    Event.all do |event|
      booth = Booth.where(google_place_id: event.google_place_id).first_or_create!
      event.booth = booth
      event.save
    end

    remove_column :slots, :event_id
    add_column :slots, :booth_id, :integer
    remove_column :events, :longitude
    remove_column :events, :latitude
    remove_column :events, :google_place_id

  
  end
end
