# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171128174739) do

  create_table "flights", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.date "date", null: false
    t.string "aircraft_type", null: false
    t.string "ident", null: false
    t.string "pic", limit: 75, default: "Self", null: false
    t.string "sic", limit: 75, default: ""
    t.boolean "single_engine", default: true
    t.boolean "cross_country", default: false
    t.boolean "dual_flight", default: false
    t.float "day_hours", limit: 24
    t.float "night_hours", limit: 24
    t.float "sim_hours", limit: 24
    t.float "imc_hours", limit: 24
    t.float "hood_hours", limit: 24
    t.integer "ifr_approaches", default: 0
    t.string "route"
    t.text "comments"
    t.integer "logbook_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["logbook_id"], name: "index flights on logbook_id"
  end

  create_table "logbooks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_logbook_on_user_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "first_name", limit: 25, null: false
    t.string "last_name", limit: 50, null: false
    t.string "license_number"
    t.string "licensing_agency", default: "Transport Canada"
    t.string "email", null: false
    t.string "password_digest"
    t.boolean "admin", default: false
    t.date "last_log_in"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
