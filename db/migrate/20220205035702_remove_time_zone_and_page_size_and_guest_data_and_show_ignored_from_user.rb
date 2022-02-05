class RemoveTimeZoneAndPageSizeAndGuestDataAndShowIgnoredFromUser < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :time_zone
    remove_column :users, :page_size
    remove_column :users, :guest_data
    remove_column :users, :show_ignored
  end
end
