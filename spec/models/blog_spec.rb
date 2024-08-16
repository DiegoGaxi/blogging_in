require 'rails_helper'

RSpec.describe Blog, type: :model do
  let(:user) { create(:user) }
  let(:category) { create(:category) }
  let(:blog) { create(:blog, user: user, category_ids: [category.id]) }

  # Validations
  it 'is valid with valid attributes' do
    expect(blog).to be_valid
  end

  it 'is not valid without a title' do
    blog.title = nil
    expect(blog).not_to be_valid
  end

  it 'is not valid without content' do
    blog.content = nil
    expect(blog).not_to be_valid
  end

  it 'is not valid without at least one category' do
    blog.category_ids = []
    expect(blog).not_to be_valid
    expect(blog.errors[:category_ids]).to include("Debe seleccionar al menos una categoría")
  end

  # Associations
  describe 'associations' do
    it 'belongs to a user' do
      expect(blog.user).to eq(user)
    end

    it 'has many categories' do
      expect(blog.categories).to include(category)
    end

    it 'has one attached image' do
      blog.image.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'thumbs-up.png')), filename: 'thumbs-up.png', content_type: 'image/png')
      expect(blog.image).to be_attached
    end
  end
end
