# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Bookmark', type: :request do
  let!(:news_list) do
    create_list(:news, 2)
  end
  let!(:bookmark_list) do
    [
      create(:bookmark, news: news_list[0]),
      create(:bookmark)
    ]
  end

  describe 'POST /api/bookmark' do
    context 'when create bookmark' do
      before do
        post '/api/bookmark', params: { news_id: news_list[0].id }
      end

      it 'return bookmark' do
        expect(response.status).to eq(201)

        response_body = JSON.parse(response.body)
        expect(response_body).to be_present
        expect(response_body['bookmark']).to be_present
      end
    end
  end

  describe 'GET /api/bookmark' do
    context 'with news_id param' do
      before do
        get '/api/bookmark', params: { news_id: news_list[0].id }
      end

      it 'return bookmarks' do
        expect(response.status).to eq(200)

        response_body = JSON.parse(response.body)
        expect(response_body).to be_present
        expect(response_body['bookmarks'].length).to eq(1)
      end
    end

    context 'with news_id, page, page_size param' do
      before do
        get '/api/bookmark', params: { news_id: news_list[0].id, page: '1', page_size: '5' }
      end

      it 'return bookmarks' do
        expect(response.status).to eq(200)

        response_body = JSON.parse(response.body)
        expect(response_body).to be_present
        expect(response_body['bookmarks'].length).to eq(1)
      end
    end

    context 'without news_id param' do
      before do
        get '/api/bookmark'
      end

      it 'return bookmarks' do
        expect(response.status).to eq(400)
      end
    end
  end

  describe 'GET /api/bookmark/:id' do
    before do
      get "/api/bookmark/#{bookmark_list[0].id}"
    end

    it 'return bookmark by id' do
      expect(response.status).to eq(200)

      response_body = JSON.parse(response.body)
      expect(response_body).to be_present
      expect(response_body['bookmark']).to be_present
    end
  end
end
