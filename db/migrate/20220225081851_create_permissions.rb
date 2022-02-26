class CreatePermissions < ActiveRecord::Migration[6.1]
  def change
    create_table :permissions do |t|
      t.bigint :owner_id, null: false
      t.string :owner_class, null: false

      t.string :authority, null: false
      t.string :permission_type, null: false
      
      t.timestamps
    end
  end
end
