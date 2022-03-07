# frozen_string_literal: true

# == Schema Information
#
# Table name: bookmarks
#
#  id         :uuid             not null, primary key
#  news_id    :uuid
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
module NewsApi
  class Bookmark < ApplicationRecord
    # association
    belongs_to :news, optional: true
  end
end
