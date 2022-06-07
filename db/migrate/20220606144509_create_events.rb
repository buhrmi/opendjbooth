class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :google_place_id
      t.timestamp :start_at

      t.float :latitude
      t.float :longitude
      t.string :name
      t.timestamps
    end
  end
end
