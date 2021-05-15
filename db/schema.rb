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

ActiveRecord::Schema.define(version: 2021_05_15_163805) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "agents", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "media_server_type"
    t.string "media_types"
    t.string "job_types"
    t.string "addr", null: false
    t.string "display_name"
    t.uuid "access_key", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "jobs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "agent_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["agent_id"], name: "index_jobs_on_agent_id"
  end

  create_table "media_items", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "storage_backend_id", null: false
    t.string "path"
    t.boolean "uploaded", default: false, null: false
    t.string "sha256"
    t.jsonb "data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["storage_backend_id"], name: "index_media_items_on_storage_backend_id"
  end

  create_table "storage_backends", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "url"
    t.string "bucket"
    t.string "prefix"
    t.string "backend_type"
    t.text "access_key_ciphertext"
    t.text "secret_key_ciphertext"
    t.text "encrypted_kms_key"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tasks", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.jsonb "data", null: false
    t.integer "state", default: 0, null: false
    t.uuid "job_id", null: false
    t.uuid "agent_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "preassigned"
    t.index ["agent_id"], name: "index_tasks_on_agent_id"
    t.index ["job_id"], name: "index_tasks_on_job_id"
  end

  add_foreign_key "jobs", "agents"
  add_foreign_key "media_items", "storage_backends"
  add_foreign_key "tasks", "agents"
  add_foreign_key "tasks", "jobs"
end
