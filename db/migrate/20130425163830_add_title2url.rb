class AddTitle2url < ActiveRecord::Migration
  def up
    add_column :urls, :title, :string
  end

  def down
    remove_column :urls, :title
  end
end
