# frozen_string_literal: true

class MainController < ApplicationController
  def index
    data = {
      message: 'news-api'
    }
    render json: data
  end
end
