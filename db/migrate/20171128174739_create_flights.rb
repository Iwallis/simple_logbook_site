class CreateFlights < ActiveRecord::Migration[5.1]
  def up
    create_table :flights do |t|
      t.date "date", :null => false
      t.string "aircraft_type", :null => false
      t.string "ident", :null => false
      t.string "pic", :null => false, :default => 'Self', :limit => 75
      t.string "sic", :limit => 75, :default => ''
      t.boolean "single_engine", :default => true
      t.boolean "cross_country", :default => false
      t.boolean "dual_flight", :default => false
      t.float "day_hours", :precision => 1
      t.float "night_hours", :precision => 1
      t.float "sim_hours", :precision => 1
      t.float "imc_hours", :precision => 1
      t.float "hood_hours", :precision => 1
      t.integer "ifr_approaches", :default => 0
      t.string "route"
      t.text "comments"
      t.integer "logbook_id"
      t.timestamps
      t.index ["logbook_id"], name: "index flights on logbook_id"
    end
  end

  def down
    drop_table :flights
  end
end
