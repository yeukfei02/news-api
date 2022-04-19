# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Mains', type: :request do
  context 'GET /' do
    before do
      get '/'
    end

    it 'return success' do
      expect(response.status).to eq(200)

      response_body = JSON.parse(response.body)
      expect(response_body).to be_present
    end
  end
end
