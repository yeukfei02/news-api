# frozen_string_literal: true

module Bookmark
  class Bookmark < Grape::API
    format :json
    prefix :bookmark

    helpers do
      def format_bookmark_list(bookmarks)
        bookmarks.map do |bookmark|
          {
            id: bookmark.id,
            created_at: bookmark.created_at,
            updated_at: bookmark.updated_at,
            news: format_news_obj(bookmark.news)
          }
        end
      end

      def format_bookmark_obj(bookmark)
        bookmark_obj = {}
        bookmark_obj['id'] = bookmark.id
        bookmark_obj['created_at'] = bookmark.created_at
        bookmark_obj['updated_at'] = bookmark.updated_at
        bookmark_obj['news'] = format_news_obj(bookmark.news)

        bookmark_obj
      end

      def format_news_obj(news)
        {
          'id': news.id,
          'source': news.source,
          'author': news.author,
          'title': news.title,
          'description': news.description,
          'url': news.url,
          'url_to_image': news.url_to_image,
          'published_at': news.published_at,
          'content': news.content,
          'location': news.location,
          'created_at': news.created_at,
          'updated_at': news.updated_at
        }
      end
    end

    params do
      requires :news_id, type: String
    end
    post '/' do
      news_id = params[:news_id]
      if news_id.present?
        bookmark = NewsApi::Bookmark.create!(news_id: news_id)

        {
          messages: 'createBookmark',
          bookmark: bookmark
        }
      else
        {
          messages: 'createBookmark error, news_id is empty',
          bookmark: {}
        }
      end
    end

    params do
      requires :news_id, type: String
    end
    get '/' do
      news_id = params[:news_id]
      page = params[:page] || 1
      page_size = params[:page_size] || 20

      bookmarks = if news_id.present?
                    NewsApi::Bookmark.where(news_id: news_id)
                  else
                    NewsApi::Bookmark.all
                  end
      bookmarks = bookmarks.page(page).per(page_size)

      formatted_bookmarks = []
      formatted_bookmarks = format_bookmark_list(bookmarks) if bookmarks.present?

      {
        messages: 'getBookmarks',
        bookmarks: formatted_bookmarks
      }
    end

    params do
      requires :id, type: String
    end
    get '/:id' do
      id = params[:id]
      if id.present?
        bookmark = NewsApi::Bookmark.find(id)

        formatted_bookmark = {}
        formatted_bookmark = format_bookmark_obj(bookmark) if bookmark.present?

        {
          messages: 'getBookmarkById',
          bookmark: formatted_bookmark
        }
      else
        {
          messages: 'getBookmarkById error, id is empty',
          news: {}
        }
      end
    end
  end
end
