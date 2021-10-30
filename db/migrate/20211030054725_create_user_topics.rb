class CreateUserTopics < ActiveRecord::Migration[6.1]
  def change
    create_table :user_topics do |t|
      t.references :user, null: false, foreign_key: true
      t.references :topic, null: false, foreign_key: true
      t.integer :last_read_post_id
      t.boolean :subscribed

      t.timestamps
    end
  end
end
