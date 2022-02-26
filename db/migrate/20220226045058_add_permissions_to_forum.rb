class AddPermissionsToForum < ActiveRecord::Migration[6.1]
  def change
    add_column :forums, :permissions, :json, default: {}
  end
end
