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

ActiveRecord::Schema.define(version: 20150129184255) do

  create_table "accounts", force: true do |t|
    t.string   "provider"
    t.string   "uid",                    default: ""
    t.string   "encrypted_password",     default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "name"
    t.string   "nickname"
    t.string   "image"
    t.string   "email"
    t.text     "tokens"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "manager_id"
    t.integer  "child_id"
    t.string   "address"
    t.string   "phone"
    t.date     "birthday"
    t.integer  "bitcoin_account_id"
  end

  add_index "accounts", ["bitcoin_account_id"], name: "index_accounts_on_bitcoin_account_id"
  add_index "accounts", ["child_id"], name: "index_accounts_on_child_id"
  add_index "accounts", ["email"], name: "index_accounts_on_email"
  add_index "accounts", ["manager_id"], name: "index_accounts_on_manager_id"
  add_index "accounts", ["reset_password_token"], name: "index_accounts_on_reset_password_token", unique: true
  add_index "accounts", ["uid", "provider"], name: "index_accounts_on_uid_and_provider", unique: true

  create_table "bitcoin_accounts", force: true do |t|
    t.string   "access_token",  null: false
    t.string   "refresh_token", null: false
    t.integer  "expires_in",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "children", force: true do |t|
    t.integer  "manager_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "wallet_id"
  end

  add_index "children", ["manager_id"], name: "index_children_on_manager_id"

  create_table "managers", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rules", force: true do |t|
    t.boolean  "active"
    t.boolean  "notifies"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "amount"
    t.string   "period"
  end

  add_index "rules", ["account_id"], name: "index_rules_on_account_id"

  create_table "savings", force: true do |t|
    t.date     "finish_date"
    t.decimal  "value"
    t.integer  "child_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "savings", ["child_id"], name: "index_savings_on_child_id"

end
