class AddSlugAndSuperslugToNotification < ActiveRecord::Migration[6.1]
  def change
    add_column :notifications, :slug, :string
    add_column :notifications, :superslug, :string
  end
end
