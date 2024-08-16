require 'rails_helper'

RSpec.describe LandingController, type: :controller do
  let!(:user) { create(:user) }
  let!(:category) { create(:category) }
  let!(:blog) { create(:blog, user: user) }

  before do
    create(:user)
    create(:category)
    create(:blog, user: user)
    allow_any_instance_of(BlogQuery).to receive(:call).and_return(Blog.all)
    allow(Category).to receive(:all).and_return([category, OpenStruct.new(id: 0, name: 'Todos')])
  end

  describe 'GET #index' do
    before { get :index }

    it 'assigns paginated blogs to @blogs' do
      expect(assigns(:blogs)).to include(blog)
    end

    it 'paginates the blogs' do
      expect(assigns(:pagy_blogs)).not_to be_nil
    end

    it 'renders the :index template' do
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #blog' do
    before { get :blog, params: { id: blog.id } }

    it 'assigns the requested blog to @showing_blog' do
      expect(assigns(:showing_blog)).to eq(blog)
    end

    it 'assigns paginated blogs to @blogs' do
      expect(assigns(:blogs)).to include(blog)
    end

    it 'assigns categories including "Todos"' do
      expect(assigns(:categories)).to include(category)
      expect(assigns(:categories)).to include(OpenStruct.new(id: 0, name: 'Todos'))
    end

    it 'paginates the blogs' do
      expect(assigns(:pagy_blogs)).not_to be_nil
    end

    it 'renders the :blog template' do
      expect(response).to render_template(:blog)
    end
  end

  describe 'POST #blog_like' do
    before { post :blog_like, params: { id: blog.id } }

    it 'finds the blog by id and increments likes_count' do
      expect(blog.reload.likes_count).to eq(1)
    end

    it 'renders the :blog template' do
      expect(response).to render_template(:blog)
    end
  end
end
