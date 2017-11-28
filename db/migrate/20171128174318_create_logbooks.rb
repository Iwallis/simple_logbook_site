class CreateLogbooks < ActiveRecord::Migration[5.1]
  def up
    create_table :logbooks do |t|
      t.integer "user_id"
      t.timestamps
      t.index ["user_id"], name: "index_logbook_on_user_id"
    end    
  end

  def down
    drop_table :logbooks
  end
end
