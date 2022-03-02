# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NewsApi::News, type: :model do
  let!(:news) do
    create(:news)
  end

  describe 'associations' do
    it { is_expected.to have_many(:bookmarks) }
  end

  describe 'validations' do
    it { is_expected.to validate_inclusion_of(:location).in_array(described_class.location_values.keys) }
  end
end
