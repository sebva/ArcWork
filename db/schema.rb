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

ActiveRecord::Schema.define(version: 20140404190720) do

  create_table "courses", force: true do |t|
    t.string   "name"
    t.integer  "start_year"
    t.integer  "professor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "courses", ["professor_id"], name: "index_courses_on_professor_id", using: :btree

  create_table "courses_users", force: true do |t|
    t.integer "user_id"
    t.integer "course_id"
  end

  create_table "homeworks", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "due_date"
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

  add_index "homeworks", ["course_id"], name: "index_homeworks_on_course_id", using: :btree

  create_table "solutions", force: true do |t|
    t.datetime "date"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.text     "student_comment"
    t.text     "professor_comment"
    t.string   "mime"
    t.integer  "version"
    t.integer  "homework_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "solutions", ["homework_id"], name: "index_solutions_on_homework_id", using: :btree
  add_index "solutions", ["user_id"], name: "index_solutions_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "rank"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
