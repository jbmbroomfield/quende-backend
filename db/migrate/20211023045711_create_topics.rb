class CreateTopics < ActiveRecord::Migration[6.1]
  def change
    create_table :topics do |t|
      t.references :subsection, null: false, foreign_key: true
      t.string :title
      t.string :status

      t.timestamps
    end
  end
end
