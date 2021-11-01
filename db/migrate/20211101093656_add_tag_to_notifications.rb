class AddTagToNotifications < ActiveRecord::Migration[6.1]
  def change
    add_column :notifications, :tag, :string
  end
end
