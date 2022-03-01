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
               NewsModel::News.where(location: location)
             else
               NewsModel::News.all
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
        {
          messages: 'getNewsById',
          news: NewsModel::News.find(id)
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
