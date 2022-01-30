class CreateForum < ActiveRecord::Migration[6.1]
  def change
    create_table :forums do |t|
      t.string :title
      t.string :slug

      t.timestamps
    end
  end
end
