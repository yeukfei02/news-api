# frozen_string_literal: true

class Api < Grape::API
  format :json
  prefix :api

  mount News::News
  mount Bookmark::Bookmark
end
