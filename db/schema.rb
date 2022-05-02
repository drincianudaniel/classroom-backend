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

ActiveRecord::Schema[7.0].define(version: 2022_05_01_123045) do
  create_table "assignments", force: :cascade do |t|
    t.integer "classroom_id"
    t.string "name"
    t.string "details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["classroom_id"], name: "index_assignments_on_classroom_id"
  end

  create_table "classrooms", force: :cascade do |t|
    t.string "name"
    t.string "details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "solutions", force: :cascade do |t|
    t.integer "assignment_id"
    t.integer "user_id"
    t.integer "grade"
    t.string "solution_content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assignment_id"], name: "index_solutions_on_assignment_id"
    t.index ["user_id"], name: "index_solutions_on_user_id", unique: true
  end

  create_table "userassignments", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "assignment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assignment_id"], name: "index_userassignments_on_assignment_id"
    t.index ["user_id"], name: "index_userassignments_on_user_id"
  end

  create_table "userclassrooms", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "classroom_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["classroom_id"], name: "index_userclassrooms_on_classroom_id"
    t.index ["user_id"], name: "index_userclassrooms_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.string "password_digest"
    t.string "user_type"
  end

  add_foreign_key "assignments", "classrooms"
  add_foreign_key "solutions", "assignments"
  add_foreign_key "solutions", "users"
end
