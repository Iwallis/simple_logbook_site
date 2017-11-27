class CreateUsers < ActiveRecord::Migration[5.1]
  def up
    create_table :users do |t|
      t.string "first_name", :limit => 25, :null => false
      t.string "last_name", :limit => 50, :null => false
      t.string "license_number"
      t.string "licensing_agency", :default => "Transport Canada"
      t.string "email", :null => false
      t.string "password_digest"
      t.boolean "admin", :default => false
      t.date "last_log_in"
      t.timestamps
    end
  end

  def down
    drop_table :users
  end
end
