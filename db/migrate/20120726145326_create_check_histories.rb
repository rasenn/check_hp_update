class CreateCheckHistories < ActiveRecord::Migration
  def change
    create_table :check_histories do |t|
      t.string :title 
      t.integer :user_id
      t.integer :url_id
      t.datetime :last_check

      t.timestamps
    end
    add_index :check_histories ,:user_id
    add_index :check_histories ,:url_id
    add_index :check_histories ,[:user_id,:url_id] ,:unique => true

  end
end
