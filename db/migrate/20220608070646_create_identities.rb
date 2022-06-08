class CreateIdentities < ActiveRecord::Migration[7.0]
  def change
    create_table :identities do |t|
      t.string :provider
      t.string :provider_id
      t.json :provider_info
      t.integer :dj_id

      t.index [:provider, :provider_id], unique: true
      t.index :dj_id
      t.timestamps
    end
  end
end