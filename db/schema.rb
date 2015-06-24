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

ActiveRecord::Schema.define(version: 20141209132431) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_contacts", force: true do |t|
    t.string   "email"
    t.string   "name"
    t.string   "contact_no"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "card_infos", force: true do |t|
    t.string   "card_no"
    t.integer  "expire_month"
    t.integer  "expire_year"
    t.integer  "ccv"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token_id"
    t.string   "brand"
    t.string   "last4"
    t.string   "country"
    t.string   "name"
    t.string   "address_line1"
    t.string   "address_line2"
    t.string   "address_city"
    t.string   "address_state"
    t.string   "address_zip"
    t.string   "address_country"
  end

  create_table "contact_messages", force: true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "contact_request_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "agreement_file_name"
    t.string   "agreement_content_type"
    t.integer  "agreement_file_size"
    t.datetime "agreement_updated_at"
  end

  add_index "contact_messages", ["contact_request_id"], name: "index_contact_messages_on_contact_request_id", using: :btree
  add_index "contact_messages", ["user_id"], name: "index_contact_messages_on_user_id", using: :btree

  create_table "contact_requests", force: true do |t|
    t.datetime "preffered_time"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "from_user_id"
    t.integer  "to_user_id"
    t.string   "status"
    t.integer  "property_id"
    t.string   "agreement_file_name"
    t.string   "agreement_content_type"
    t.integer  "agreement_file_size"
    t.datetime "agreement_updated_at"
    t.boolean  "agreement_letter_sent",  default: false
  end

  create_table "identities", force: true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "identities", ["user_id"], name: "index_identities_on_user_id", using: :btree

  create_table "properties", force: true do |t|
    t.string   "title"
    t.text     "short_desc"
    t.string   "price"
    t.integer  "saleable_area"
    t.integer  "gross_size"
    t.string   "property_for"
    t.string   "landmark"
    t.string   "location"
    t.string   "property_in"
    t.string   "total_no_of_floors"
    t.integer  "bed_rooms"
    t.integer  "total_rooms"
    t.integer  "bathrooms"
    t.string   "parking"
    t.string   "flooring"
    t.string   "furnishing"
    t.string   "open_for_inspection"
    t.string   "address"
    t.string   "city"
    t.string   "district"
    t.string   "zipcode"
    t.date     "available_from"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "posting_local"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "user_id"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "contact_hours"
    t.text     "long_desc"
    t.text     "feature"
    t.integer  "gross_area"
    t.string   "floor_level"
    t.text     "facilities_and_features"
    t.string   "vacant_or_possession"
    t.string   "landlord_name"
    t.string   "hkid_no"
    t.integer  "furniture_and_fittings"
    t.integer  "electronic_appliences"
    t.integer  "no_of_keys"
    t.text     "other_assets"
    t.text     "terms_and_condition_of_sale"
    t.boolean  "accept_short_lease"
    t.boolean  "accept_shared_rent"
    t.boolean  "require_income_proof"
    t.integer  "deposite"
    t.integer  "tenancy_terms"
    t.integer  "fixed_period"
    t.integer  "break_clause_notice"
    t.string   "availability_date"
    t.boolean  "rent_inclusive_of_management_fee"
    t.boolean  "rent_inclusive_of_govt_rent"
    t.string   "meter_reading"
    t.integer  "rent"
    t.string   "property_type"
    t.boolean  "available_for_rent"
    t.boolean  "available_for_sale"
    t.string   "agreement_file_name"
    t.string   "agreement_content_type"
    t.integer  "agreement_file_size"
    t.datetime "agreement_updated_at"
    t.boolean  "step_1",                           default: false
    t.boolean  "step_2",                           default: false
    t.boolean  "step_3",                           default: false
    t.boolean  "step_4",                           default: false
    t.boolean  "step_5",                           default: false
    t.string   "facing"
    t.boolean  "balcony"
    t.boolean  "rooftop"
    t.boolean  "clubhouse"
    t.boolean  "swiming_pool"
    t.boolean  "gym_room"
    t.boolean  "shuttle_bus"
    t.boolean  "sea_view"
    t.boolean  "parking_garage"
    t.boolean  "private_parking_space"
    t.boolean  "is_active"
    t.string   "building_name"
    t.string   "flat"
    t.string   "street"
    t.string   "english_address"
    t.string   "chinese_address"
    t.string   "year_build"
    t.boolean  "private_garden"
    t.boolean  "pet_allowed"
    t.date     "expiration_date"
  end

  create_table "property_comments", force: true do |t|
    t.integer  "user_id"
    t.integer  "property_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "property_comments", ["property_id"], name: "index_property_comments_on_property_id", using: :btree
  add_index "property_comments", ["user_id"], name: "index_property_comments_on_user_id", using: :btree

  create_table "property_images", force: true do |t|
    t.integer  "property_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  add_index "property_images", ["property_id"], name: "index_property_images_on_property_id", using: :btree

  create_table "property_translations", force: true do |t|
    t.integer  "property_id",         null: false
    t.string   "locale",              null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.text     "short_desc"
    t.string   "price"
    t.string   "property_for"
    t.string   "landmark"
    t.string   "location"
    t.string   "property_in"
    t.string   "parking"
    t.string   "flooring"
    t.string   "furnishing"
    t.string   "open_for_inspection"
    t.string   "address"
    t.string   "city"
    t.string   "district"
    t.string   "zipcode"
    t.string   "available_from"
    t.string   "contact_hours"
    t.text     "long_desc"
  end

  add_index "property_translations", ["locale"], name: "index_property_translations_on_locale", using: :btree
  add_index "property_translations", ["property_id"], name: "index_property_translations_on_property_id", using: :btree

  create_table "property_visiteds", force: true do |t|
    t.integer  "user_id"
    t.integer  "property_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
  end

  create_table "temp_contact_requests", force: true do |t|
    t.integer  "user_id"
    t.integer  "property_id"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_searches", force: true do |t|
    t.integer  "user_id"
    t.string   "query"
    t.string   "listing_type"
    t.string   "property_type"
    t.integer  "min_budget"
    t.integer  "max_budget"
    t.integer  "no_of_rooms"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_searches", ["user_id"], name: "index_user_searches_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                     default: "",        null: false
    t.string   "encrypted_password",        default: "",        null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",             default: 0,         null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "contact_no"
    t.boolean  "mail_notification"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.text     "address"
    t.boolean  "profile_completed",         default: false
    t.string   "highest_education"
    t.string   "yearly_income"
    t.string   "occupation"
    t.date     "date_of_birth"
    t.string   "gender"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "phone_number"
    t.integer  "facebook_friend_count"
    t.text     "about_me"
    t.text     "school"
    t.string   "phone_verification_status", default: "Pending"
    t.string   "provider"
    t.string   "uid"
    t.string   "token"
    t.datetime "expires_at"
    t.text     "unconfirmed_email"
    t.boolean  "is_admin",                  default: false
    t.string   "age"
    t.string   "allowing_institution"
    t.string   "monthly_income"
    t.string   "company"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
