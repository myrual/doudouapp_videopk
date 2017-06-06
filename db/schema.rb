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

ActiveRecord::Schema.define(version: 20170606061542) do

  create_table "battle_comments", force: :cascade do |t|
    t.integer  "battle_id"
    t.integer  "user_id"
    t.text     "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "battles", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "left_video_id"
    t.integer  "right_video_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "user_id"
    t.boolean  "is_hidden",      default: true
    t.index ["user_id"], name: "index_battles_on_user_id"
  end

  create_table "challengevideos", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "video_id"
    t.integer  "stream_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stream_id"], name: "index_challengevideos_on_stream_id"
    t.index ["user_id"], name: "index_challengevideos_on_user_id"
    t.index ["video_id"], name: "index_challengevideos_on_video_id"
  end

  create_table "ext_videos", force: :cascade do |t|
    t.string   "provider"
    t.string   "videourl"
    t.string   "posturl"
    t.integer  "video_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["video_id"], name: "index_ext_videos_on_video_id"
  end

  create_table "favor_left_video_relationships", force: :cascade do |t|
    t.integer  "battle_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "favor_right_video_relationships", force: :cascade do |t|
    t.integer  "battle_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "favor_video_relationships", force: :cascade do |t|
    t.integer  "video_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "battle_id"
  end

  create_table "multivotes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.integer  "battle_id"
    t.integer  "stream_id"
    t.integer  "order"
    t.index ["battle_id"], name: "index_multivotes_on_battle_id"
    t.index ["stream_id"], name: "index_multivotes_on_stream_id"
    t.index ["user_id"], name: "index_multivotes_on_user_id"
  end

  create_table "streams", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.boolean  "approved"
    t.boolean  "running"
    t.index ["user_id"], name: "index_streams_on_user_id"
  end

  create_table "t1topics", force: :cascade do |t|
    t.string   "title"
    t.boolean  "running"
    t.integer  "order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "topic_videos", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "topic_id"
    t.integer  "video_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["topic_id"], name: "index_topic_videos_on_topic_id"
    t.index ["user_id"], name: "index_topic_videos_on_user_id"
    t.index ["video_id"], name: "index_topic_videos_on_video_id"
  end

  create_table "topics", force: :cascade do |t|
    t.string   "title"
    t.boolean  "running"
    t.integer  "order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "t1topic_id"
    t.index ["t1topic_id"], name: "index_topics_on_t1topic_id"
  end

  create_table "useravatars", force: :cascade do |t|
    t.string   "url"
    t.string   "provider"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_useravatars_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                             default: "",    null: false
    t.string   "encrypted_password",                default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.boolean  "is_admin",                          default: false
    t.string   "name"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "authentication_token",   limit: 30
    t.string   "provider"
    t.string   "uid"
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "video_comments", force: :cascade do |t|
    t.integer  "video_id"
    t.integer  "user_id"
    t.text     "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "videos", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "pkvideo"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
    t.string   "video"
    t.string   "image"
  end

  create_table "visitor_votes", force: :cascade do |t|
    t.text     "visitorID"
    t.integer  "battle_id"
    t.boolean  "voteLeft"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["battle_id"], name: "index_visitor_votes_on_battle_id"
  end

  create_table "wxappsessions", force: :cascade do |t|
    t.string   "openid"
    t.string   "session"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
