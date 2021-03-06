# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140409172712) do

  create_table "accounts", force: true do |t|
    t.integer  "customer_id"
    t.integer  "number"
    t.integer  "balance"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "checking_accounts", force: true do |t|
    t.string   "account_number"
    t.integer  "customer_id"
    t.decimal  "balance"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "checking_accounts", ["customer_id"], name: "index_checking_accounts_on_customer_id"

  create_table "customers", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "gender"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
  end

  add_index "customers", ["email"], name: "index_customers_on_email", unique: true

  create_table "transactions", force: true do |t|
    t.string   "from_account_id"
    t.string   "to_account_id"
    t.decimal  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "transaction_type"
  end

end
