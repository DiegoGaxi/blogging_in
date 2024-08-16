require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category) { create(:category) }
  let(:blog) { create(:blog) }

  # Associations
  describe 'associations' do
    it 'has many blogs' do
      category.blogs << blog
      category.reload
      expect(category.blogs).to include(blog)
    end
  end
end
