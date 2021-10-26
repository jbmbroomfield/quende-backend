class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :user, foreign_key: true
      t.references :topic, null: false, foreign_key: true
      t.string :text
      t.string :tag

      t.timestamps
    end
  end
end
