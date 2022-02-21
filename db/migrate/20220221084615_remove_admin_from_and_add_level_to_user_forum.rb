class RemoveAdminFromAndAddLevelToUserForum < ActiveRecord::Migration[6.1]
  def change
    add_column :user_forums, :level, :string, default: "member"
    remove_column :user_forums, :admin
  end
end
