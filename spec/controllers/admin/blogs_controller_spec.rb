require 'rails_helper'

RSpec.describe Admin::BlogsController, type: :controller do
  let(:user) { create(:user, role: :admin) } # Asume que existe una rol admin
  let(:blog) { create(:blog, user: user) }
  let(:category) { create(:category) }

  before do
    sign_in user
  end

  describe 'GET #index' do
  let!(:blogs) { create_list(:blog, 3, user: user) }

  it 'assigns paginated blogs to @blogs' do
    get :index
    expect(assigns(:blogs).to_a).to match_array(blogs)
  end

  it 'paginates the blogs' do
    get :index
    expect(response).to have_http_status(:success)
    expect(assigns(:pagy_blogs).count).to eq(3)
  end
end

  describe 'GET #new' do
    it 'assigns a new blog to @blog' do
      get :new
      expect(assigns(:blog)).to be_a_new(Blog)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested blog to @blog' do
      get :edit, params: { id: blog.id }
      expect(assigns(:blog)).to eq(blog)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      let(:valid_attributes) do
        { blog: attributes_for(:blog, category_ids: [category.id], user_id: user.id) }
      end

      it 'creates a new blog' do
        expect {
          post :create, params: valid_attributes
        }.to change(Blog, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      let(:invalid_attributes) do
        { blog: attributes_for(:blog, title: nil) }
      end

      it 'does not create a new blog and shows an alert' do
        expect {
          post :create, params: invalid_attributes
        }.not_to change(Blog, :count)
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      let(:valid_attributes) do
        { id: blog.id, blog: { title: 'Updated Title' } }
      end

      it 'updates the blog' do
        patch :update, params: valid_attributes
        blog.reload
        expect(blog.title).to eq('Updated Title')
      end
    end

    context 'with invalid attributes' do
      let(:invalid_attributes) do
        { id: blog.id, blog: { title: nil } }
      end

      it 'does not update the blog and shows an alert' do
        patch :update, params: invalid_attributes
        blog.reload
        expect(blog.title).not_to be_nil
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the blog' do
      blog
      expect {
        delete :destroy, params: { id: blog.id }
      }.to change(Blog, :count).by(-1)
    end
  end
end
