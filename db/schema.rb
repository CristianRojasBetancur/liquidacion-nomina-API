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

ActiveRecord::Schema[7.0].define(version: 2022_10_19_224834) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.integer "nit"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_companies_on_user_id"
  end

  create_table "modifications", force: :cascade do |t|
    t.bigint "period_id", null: false
    t.bigint "worker_id", null: false
    t.integer "other_salary_incomes"
    t.integer "no_salary_incomes"
    t.integer "deductions"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["period_id"], name: "index_modifications_on_period_id"
    t.index ["worker_id"], name: "index_modifications_on_worker_id"
  end

  create_table "payrolls", force: :cascade do |t|
    t.bigint "period_id", null: false
    t.integer "employeed_payment"
    t.integer "reten_deduc"
    t.integer "total_payrolls"
    t.integer "social_benefits"
    t.integer "parafiscal_cont"
    t.integer "social_security"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "worker_id", null: false
    t.integer "total_company_cost"
    t.index ["period_id"], name: "index_payrolls_on_period_id"
    t.index ["worker_id"], name: "index_payrolls_on_worker_id"
  end

  create_table "periods", force: :cascade do |t|
    t.integer "year"
    t.integer "month"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "company_id", null: false
    t.index ["company_id"], name: "index_periods_on_company_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "workers", force: :cascade do |t|
    t.string "name"
    t.string "cc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "salary"
    t.bigint "company_id", null: false
    t.integer "risk"
    t.string "transport_subsidy"
    t.index ["company_id"], name: "index_workers_on_company_id"
  end

  add_foreign_key "companies", "users"
  add_foreign_key "modifications", "periods"
  add_foreign_key "modifications", "workers"
  add_foreign_key "payrolls", "periods"
  add_foreign_key "payrolls", "workers"
  add_foreign_key "periods", "companies"
  add_foreign_key "workers", "companies"
end
