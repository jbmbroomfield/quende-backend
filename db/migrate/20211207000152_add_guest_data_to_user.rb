class AddGuestDataToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :guest_data, :boolean, default: false
  end
end
