require 'rails_helper'

RSpec.describe BlogCategory, type: :model do
  let(:blog) { create(:blog) }
  let(:category) { create(:category) }
  let(:blog_category) { create(:blog_category, blog: blog, category: category) }

  # Associations
  describe 'associations' do
    it 'belongs to a blog' do
      expect(blog_category.blog).to eq(blog)
    end

    it 'belongs to a category' do
      expect(blog_category.category).to eq(category)
    end
  end
end
