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
FactoryBot.define do
  factory :news, class: 'NewsApi::News' do
    source { Faker::Json.shallow_json(width: 3) }
    author { Faker::Lorem.word }
    title { Faker::Lorem.word }
    description { Faker::Lorem.sentence }
    url { Faker::Internet.url }
    url_to_image { Faker::Internet.url }
    published_at { Faker::Date.in_date_period }
    content { Faker::Lorem.sentence }
    location { NewsApi::News.location_values.keys.sample }
  end
end
