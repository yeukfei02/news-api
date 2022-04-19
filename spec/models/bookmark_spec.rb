# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NewsApi::Bookmark, type: :model do
  context 'associations' do
    it { is_expected.to belong_to(:news).optional }
  end
end
