# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'News', type: :request do
  let!(:news_list) do
    [
      create(:news, location: 'hk'),
      create(:news, location: 'sg'),
      create(:news, location: 'cn'),
      create(:news, location: 'tw')
    ]
  end
  let!(:bookmark_list) do
    [
      create(:bookmark, news: news_list[0]),
      create(:bookmark, news: news_list[1])
    ]
  end

  before do
    news_list[0].update!(bookmarks: bookmark_list)
  end

  context 'GET /api/news without location param' do
    before do
      get '/api/news'
    end

    it 'return success' do
      expect(response.status).to eq(200)

      response_body = JSON.parse(response.body)
      expect(response_body).to be_present
      expect(response_body['news'].length).to eq(4)
    end
  end

  context 'GET /api/news with location param' do
    before do
      get '/api/news', params: { location: 'hk' }
    end

    it 'return success' do
      expect(response.status).to eq(200)

      response_body = JSON.parse(response.body)
      expect(response_body).to be_present
      expect(response_body['news'].length).to eq(1)
    end
  end

  context 'GET /api/news with location, page, page_size param' do
    before do
      get '/api/news', params: { location: 'hk', page: '1', page_size: '2' }
    end

    it 'return success' do
      expect(response.status).to eq(200)

      response_body = JSON.parse(response.body)
      expect(response_body).to be_present
      expect(response_body['news'].length).to eq(1)
    end
  end

  context 'GET /api/news/:id' do
    before do
      get "/api/news/#{news_list[0].id}"
    end

    it 'return success' do
      expect(response.status).to eq(200)

      response_body = JSON.parse(response.body)
      expect(response_body).to be_present
      expect(response_body['news']).to be_present
    end
  end
end
