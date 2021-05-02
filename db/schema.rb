# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_05_02_153904) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "agents", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "media_server_type"
    t.string "media_types"
    t.string "job_types"
    t.string "addr"
    t.string "display_name"
    t.uuid "access_key"
    t.uuid "group_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["group_id"], name: "index_agents_on_group_id"
  end

  create_table "groups", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_groups_on_name", unique: true
  end

  create_table "jobs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "type"
    t.uuid "group_id", null: false
    t.uuid "agent_id", null: false
    t.jsonb "params"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["agent_id"], name: "index_jobs_on_agent_id"
    t.index ["group_id"], name: "index_jobs_on_group_id"
  end

  create_table "storage_backends", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "url"
    t.string "bucket"
    t.string "prefix"
    t.string "backend_type"
    t.string "access_key"
    t.string "secret_key"
    t.uuid "group_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["group_id"], name: "index_storage_backends_on_group_id"
  end

  create_table "user_groups", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "role"
    t.uuid "user_id", null: false
    t.uuid "group_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["group_id"], name: "index_user_groups_on_group_id"
    t.index ["user_id", "group_id"], name: "index_user_groups_on_user_id_and_group_id", unique: true
    t.index ["user_id"], name: "index_user_groups_on_user_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "username", default: ""
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "agents", "groups"
  add_foreign_key "jobs", "agents"
  add_foreign_key "jobs", "groups"
  add_foreign_key "storage_backends", "groups"
  add_foreign_key "user_groups", "groups"
  add_foreign_key "user_groups", "users"
end
