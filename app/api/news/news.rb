# frozen_string_literal: true

module News
  class News < Grape::API
    format :json
    prefix :news

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

      {
        messages: 'getNews',
        news: news
      }
    end

    params do
      requires :id, type: String
    end
    get '/:id' do
      id = params[:id]
      if id.present?
        news = NewsApi::News.find(id)

        {
          messages: 'getNewsById',
          news: news
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
