# frozen_string_literal: true

class CreateBookmarks < ActiveRecord::Migration[6.1]
  def change
    create_table :bookmarks, id: :uuid do |t|
      t.uuid :news_id
      t.timestamps
    end

    add_index :bookmarks, :news_id, name: 'index_bookmarks_on_news_id'
    add_foreign_key :bookmarks, :news, column: :news_id
  end
end
