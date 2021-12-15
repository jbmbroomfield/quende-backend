class AddShowIgnoredToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :show_ignored, :boolean
  end
end
