class AddSlugToSubsection < ActiveRecord::Migration[6.1]
  def change
    add_column :subsections, :slug, :string
  end
end
