class CreateSlots < ActiveRecord::Migration[7.0]
  def change
    create_table :slots do |t|
      t.integer :event_id
      t.integer :dj_id

      t.timestamps
    end
    add_index :slots, :event_id
    add_index :slots, :dj_id
  end
end
