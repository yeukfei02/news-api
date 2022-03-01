# frozen_string_literal: true

class API < Grape::API
  format :json
  prefix :api

  mount News::News
end
