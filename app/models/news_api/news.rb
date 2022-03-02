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
module NewsApi
  class News < ApplicationRecord
    enum location_value: {
      'hk': 'hk',
      'sg': 'sg',
      'cn': 'cn',
      'tw': 'tw'
    }

    # association
    has_many :bookmarks, dependent: :destroy

    # validation
    validates :location, inclusion: { in: location_values.keys }
  end
end
