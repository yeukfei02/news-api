# frozen_string_literal: true

module NewsApi
  class Bookmark < ApplicationRecord
    # association
    belongs_to :news, optional: true
  end
end
