# frozen_string_literal: true

module News
  class News < Grape::API
    format :json
    prefix :news

    get '/' do
      location = params[:location]
      news = if location.present?
               NewsModel::News.where(location: location)
             else
               NewsModel::News.all
             end
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
