class AddOnDeleteCascadeToUserForumForeignKeys < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :user_forums, :forums
    add_foreign_key :user_forums, :forums, on_delete: :cascade
    remove_foreign_key :user_forums, :users
    add_foreign_key :user_forums, :users, on_delete: :cascade
  end
end
