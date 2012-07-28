class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :url
      t.text :context
      t.datetime :last_update
      t.datetime :last_crawl

      t.timestamps
    end
  end
end
