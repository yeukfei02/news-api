# frozen_string_literal: true

# == Schema Information
#
# Table name: news
#
#  id           :uuid             not null, primary key
#  source       :jsonb
#  author       :text
#  title        :text
#  description  :text
#  url          :text
#  url_to_image :text
#  published_at :text
#  content      :text
#  location     :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
module NewsAPI
  class News < ApplicationRecord
    enum location: {
      'hk': 'hk',
      'sg': 'sg',
      'cn': 'cn',
      'tw': 'tw'
    }

    # validation
    validates :location, inclusion: { in: locations.keys }
  end
end
