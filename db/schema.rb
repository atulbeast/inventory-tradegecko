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

ActiveRecord::Schema.define(version: 2019_02_08_120750) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "address_one"
    t.string "city"
    t.string "state"
    t.string "postal_code"
    t.string "uid"
    t.boolean "tax_exempt"
    t.boolean "tax_exempt_approved"
    t.boolean "commercial"
    t.integer "address_id"
    t.boolean "flag"
    t.integer "key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "company_name"
  end

  create_table "line_items", force: :cascade do |t|
    t.integer "quantity"
    t.string "price"
    t.string "discount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "tax_rate_override"
    t.string "tax_rate"
  end

  create_table "orders", force: :cascade do |t|
    t.string "order_id"
    t.datetime "entry_date"
    t.integer "billing_address_id"
    t.integer "user_id"
    t.integer "assignee_id"
    t.string "default_price_list_id"
    t.string "order_number"
    t.string "order_line_item_ids"
    t.string "notes"
    t.string "reference_number"
    t.string "status"
    t.string "packed_status"
    t.string "fulfillment_status"
    t.string "invoice_status"
    t.string "payment_status"
    t.string "return_status"
    t.string "returning_status"
    t.string "shippability_status"
    t.string "backordering_status"
    t.string "tax_treatment"
    t.date "issued_at"
    t.date "ship_at"
    t.string "tax_label"
    t.string "source_url"
    t.string "document_url"
    t.string "total"
    t.string "tracking_number"
    t.integer "currency_id"
    t.string "phone_number"
    t.string "tags"
    t.string "source_Id"
    t.timestamp "created_at"
    t.integer "shipping_address_id"
    t.index ["order_id"], name: "index_orders_on_order_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "company_name"
    t.string "address_one"
    t.string "city"
    t.string "state"
    t.string "postal_code"
    t.string "email"
    t.integer "uid"
    t.boolean "tax_exempt"
    t.boolean "tax_exempt_approved"
    t.boolean "commercial"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uid"], name: "index_users_on_uid", unique: true
  end

end
