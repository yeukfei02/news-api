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

  describe 'GET /api/news' do
    context 'without location param' do
      before do
        get '/api/news'
      end

      it 'return news' do
        expect(response.status).to eq(200)

        response_body = JSON.parse(response.body)
        expect(response_body).to be_present
      end
    end

    context 'with location param' do
      before do
        get '/api/news', params: { location: 'hk' }
      end

      it 'return news' do
        expect(response.status).to eq(200)

        response_body = JSON.parse(response.body)
        expect(response_body).to be_present
      end
    end
  end

  describe 'GET /api/news/:id' do
    before do
      get "/api/news/#{news_list[0].id}"
    end

    it 'return news by id' do
      expect(response.status).to eq(200)

      response_body = JSON.parse(response.body)
      expect(response_body).to be_present
    end
  end
end
