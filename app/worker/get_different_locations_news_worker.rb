# frozen_string_literal: true

require 'faraday'

class GetDifferentLocationsNewsWorker
  include Sidekiq::Worker

  def perform
    Rails.logger.info '### GetDifferentLocationsNewsWorker start ###'

    # hong kong
    news_request('hk')
    # singapore
    news_request('sg')
    # china
    news_request('cn')
    # taiwan
    news_request('tw')

    Rails.logger.info '### GetDifferentLocationsNewsWorker end ###'
  end

  def news_request(location)
    conn = Faraday.new(
      url: 'https://newsapi.org/v2/top-headlines'
    )
    response = conn.get('') do |req|
      req.params['country'] = location
      req.params['apiKey'] = ENV['NEWS_API_KEY']
    end

    if response.present? && response.status == 200
      response_body = JSON.parse(response.body)
      if response_body.present?
        articles = response_body['articles']
        if articles.present?
          articles.each do |article|
            source = article['source']
            author = article['author']
            title = article['title']
            description = article['description']
            url = article['url']
            url_to_image = article['urlToImage']
            published_at = article['publishedAt']
            content = article['content']

            NewsAPI::News.create!(
              source: source,
              author: author,
              title: title,
              description: description,
              url: url,
              url_to_image: url_to_image,
              published_at: published_at,
              content: content,
              location: location
            )
          end
        end
      end
    end
  end
end

Sidekiq::Cron::Job.create(name: 'GetDifferentLocationsNewsWorker - every day', cron: '0 0 * * *',
                          class: 'GetDifferentLocationsNewsWorker')
