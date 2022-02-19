class AddAdminToUserForum < ActiveRecord::Migration[6.1]
  def change
    add_column :user_forums, :admin, :string
  end
end
