class AddForumToSection < ActiveRecord::Migration[6.1]
  def change
    add_reference :sections, :forum, null: true, foreign_key: true
  end
end
