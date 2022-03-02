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

ActiveRecord::Schema.define(version: 2022_03_02_071803) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookmarks", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "news_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["news_id"], name: "index_bookmarks_on_news_id"
  end

  create_table "news", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.jsonb "source"
    t.text "author"
    t.text "title"
    t.text "description"
    t.text "url"
    t.text "url_to_image"
    t.text "published_at"
    t.text "content"
    t.text "location"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author"], name: "index_news_on_author"
    t.index ["content"], name: "index_news_on_content"
    t.index ["created_at"], name: "index_news_on_created_at"
    t.index ["description"], name: "index_news_on_description"
    t.index ["location"], name: "index_news_on_location"
    t.index ["published_at"], name: "index_news_on_published_at"
    t.index ["source"], name: "index_news_on_source", using: :gin
    t.index ["title"], name: "index_news_on_title"
    t.index ["updated_at"], name: "index_news_on_updated_at"
    t.index ["url"], name: "index_news_on_url"
    t.index ["url_to_image"], name: "index_news_on_url_to_image"
  end

  add_foreign_key "bookmarks", "news"
end
