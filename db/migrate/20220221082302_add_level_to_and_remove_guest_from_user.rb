class AddLevelToAndRemoveGuestFromUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :level, :string, default: "member"
    remove_column :users, :guest
  end
end
