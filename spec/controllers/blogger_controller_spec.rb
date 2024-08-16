require 'rails_helper'

RSpec.describe BloggerController, type: :controller do
  let(:user) { create(:user, alias: 'example_alias') }
  let(:blog) { create(:blog, user: user) }
  let(:category) { create(:category) }

  before do
    sign_in user
  end

  describe 'GET #show' do
    let!(:blogs) { create_list(:blog, 3, user: user) }

    it 'sets @landing with title and subtitle' do
      get :show, params: { alias: user.alias }
      expect(assigns(:landing)).to eq({
        title: "Bienvenido a mi blog",
        subtitle: user.display_name.humanize
      })
    end

    it 'assigns paginated blogs to @blogs' do
      get :show, params: { alias: user.alias }
      expect(assigns(:blogs).length).to eq(3)
    end

    it 'paginates the blogs' do
      get :show, params: { alias: user.alias }
      expect(response).to have_http_status(:success)
      expect(assigns(:pagy_blogs)).not_to be_nil
    end
  end

  describe 'GET #blog' do
    let!(:blogs) { create_list(:blog, 3, user: user, category_ids: [category.id]) }

    it 'assigns paginated blogs to @blogs' do
      get :blog, params: { alias: user.alias, id: blog.id }
      expect(assigns(:blogs)).to include(blog)
    end

    it 'assigns categories including "Todos"' do
      get :blog, params: { alias: user.alias, id: blog.id }
      expect(assigns(:categories)).to include(an_instance_of(OpenStruct))
      expect(assigns(:categories).find { |c| c.id == 0 }).to be_present
    end

    it 'assigns the requested blog to @showing_blog' do
      get :blog, params: { alias: user.alias, id: blog.id }
      expect(assigns(:showing_blog)).to eq(blog)
    end

    it 'assigns nil if the blog is not found' do
      get :blog, params: { alias: user.alias, id: 99999 }
      expect(assigns(:showing_blog)).to be_nil
    end
  end
end
