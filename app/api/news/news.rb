# frozen_string_literal: true

module News
  class News < Grape::API
    format :json
    prefix :news

    helpers do
      def format_news_list(news)
        news.map do |news_item|
          {
            'id': news_item.id,
            'source': news_item.source,
            'author': news_item.author,
            'title': news_item.title,
            'description': news_item.description,
            'url': news_item.url,
            'url_to_image': news_item.url_to_image,
            'published_at': news_item.published_at,
            'content': news_item.content,
            'location': news_item.location,
            'created_at': news_item.created_at,
            'updated_at': news_item.updated_at,
            'bookmarks': news_item.bookmarks
          }
        end
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
          'updated_at': news.updated_at,
          'bookmarks': news.bookmarks
        }
      end
    end

    get '/' do
      location = params[:location]
      page = params[:page] || 1
      page_size = params[:page_size] || 20

      news = if location.present?
               NewsApi::News.where(location: location)
             else
               NewsApi::News.all
             end
      news = news.page(page).per(page_size)

      formatted_news = []
      formatted_news = format_news_list(news) if news.present?

      {
        messages: 'getNews',
        news: formatted_news
      }
    end

    params do
      requires :id, type: String
    end
    get '/:id' do
      id = params[:id]
      if id.present?
        news = NewsApi::News.find(id)

        formatted_news = {}
        formatted_news = format_news_obj(news) if news.present?

        {
          messages: 'getNewsById',
          news: formatted_news
        }
      else
        {
          messages: 'getNewsById error, id is empty',
          news: {}
        }
      end
    end
  end
end
