# frozen_string_literal: true

class API < Grape::API
  format :json
  prefix :api

  mount News::News

  add_swagger_documentation
end
