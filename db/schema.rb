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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20101101014544) do

  create_table "base_folders", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "client_comments", :force => true do |t|
    t.text     "content",    :default => ""
    t.integer  "client_id"
    t.integer  "user_id"
    t.boolean  "delta",      :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "client_comments", ["client_id"], :name => "index_client_comments_on_client_id"
  add_index "client_comments", ["delta"], :name => "index_client_comments_on_delta"
  add_index "client_comments", ["user_id"], :name => "index_client_comments_on_user_id"

  create_table "client_perms", :force => true do |t|
    t.integer  "user_id"
    t.integer  "client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "client_perms", ["client_id"], :name => "index_client_perms_on_client_id"
  add_index "client_perms", ["user_id"], :name => "index_client_perms_on_user_id"

  create_table "client_statuses", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clients", :force => true do |t|
    t.string   "client_name"
    t.string   "contact_name"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.string   "mobile"
    t.string   "fax"
    t.text     "comment"
    t.integer  "client_status_id"
    t.boolean  "permit"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "clients", ["city"], :name => "index_clients_on_city"
  add_index "clients", ["client_name"], :name => "index_clients_on_client_name"
  add_index "clients", ["client_status_id"], :name => "index_clients_on_client_status_id"

  create_table "document_statuses", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "documents", :force => true do |t|
    t.integer  "folder_id"
    t.integer  "document_status_id"
    t.string   "title"
    t.text     "description"
    t.string   "doc_file_name"
    t.string   "doc_content_type"
    t.integer  "doc_file_size"
    t.datetime "doc_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "documents", ["document_status_id"], :name => "index_documents_on_document_status_id"
  add_index "documents", ["folder_id"], :name => "index_documents_on_folder_id"

  create_table "folder_perms", :force => true do |t|
    t.integer  "user_id"
    t.integer  "client_id"
    t.integer  "folder_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "folder_perms", ["client_id"], :name => "index_folder_perms_on_client_id"
  add_index "folder_perms", ["folder_id"], :name => "index_folder_perms_on_folder_id"
  add_index "folder_perms", ["user_id"], :name => "index_folder_perms_on_user_id"

  create_table "folders", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.integer  "client_id"
    t.boolean  "permit"
    t.boolean  "eclient_flag", :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "folders", ["client_id"], :name => "index_folders_on_client_id"
  add_index "folders", ["parent_id"], :name => "index_folders_on_parent_id"

  create_table "profiles", :force => true do |t|
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "theme",      :default => "default"
    t.boolean  "help_on",    :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string "name"
    t.string "display_name"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "",   :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "",   :null => false
    t.string   "password_salt",                       :default => "",   :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "role_id"
    t.boolean  "active",                              :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
