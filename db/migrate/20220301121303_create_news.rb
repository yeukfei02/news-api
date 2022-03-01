# frozen_string_literal: true

class CreateNews < ActiveRecord::Migration[6.1]
  def change
    create_table :news, id: :uuid do |t|
      t.jsonb :source
      t.text :author
      t.text :title
      t.text :description
      t.text :url
      t.text :url_to_image
      t.text :published_at
      t.text :content
      t.text :location
      t.timestamps
    end

    add_index :news, :source, using: :gin, name: 'index_news_on_source'
    add_index :news, :author, name: 'index_news_on_author'
    add_index :news, :title, name: 'index_news_on_title'
    add_index :news, :description, name: 'index_news_on_description'
    add_index :news, :url, name: 'index_news_on_url'
    add_index :news, :url_to_image, name: 'index_news_on_url_to_image'
    add_index :news, :published_at, name: 'index_news_on_published_at'
    add_index :news, :content, name: 'index_news_on_content'
    add_index :news, :location, name: 'index_news_on_location'
    add_index :news, :created_at, name: 'index_news_on_created_at'
    add_index :news, :updated_at, name: 'index_news_on_updated_at'
  end
end
