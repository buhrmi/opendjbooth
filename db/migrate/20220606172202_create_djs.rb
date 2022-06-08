class CreateDjs < ActiveRecord::Migration[7.0]
  def change
    create_table :djs do |t|
      t.string :name
      t.string :email

      t.index :email, unique: true
      t.timestamps
    end    
  end
end
