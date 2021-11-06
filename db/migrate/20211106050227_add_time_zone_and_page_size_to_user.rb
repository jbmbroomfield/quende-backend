class AddTimeZoneAndPageSizeToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :time_zone, :string, default: 'UTC'
    add_column :users, :page_size, :integer, default: 50
  end
end
