require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do
  before do
    # Inicia sesión como un usuario administrador para tener acceso al controlador
    @admin = create(:user, role: :admin)
    sign_in @admin
  end

  describe 'GET #index' do
    let!(:users) { create_list(:user, 15) }

    it 'paginates the users and renders the index template' do
      get :index
      expect(response).to have_http_status(:success)
      expect(assigns(:users).count).to eq(10)
      expect(assigns(:pagy_users)).to be_present
    end
  end

  describe 'GET #show' do
    let(:user) { create(:user) }

    it 'shows the user details' do
      get :show, params: { id: user.id }
      expect(response).to have_http_status(:success)
      expect(assigns(:user)).to eq(user)
    end
  end
end
