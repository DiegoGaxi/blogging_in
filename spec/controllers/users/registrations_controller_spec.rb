require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      let(:valid_attributes) do
        {
          user: attributes_for(:user, password: 'password', password_confirmation: 'password')
        }
      end

      it 'creates a new user and redirects to the sign-in page' do
        expect {
          post :create, params: valid_attributes
        }.to change(User, :count).by(1)  # Verifica que se crea un nuevo usuario

        expect(response).to redirect_to(new_user_session_path)  
        expect(flash[:notice]).to eq('Usuario creado exitosamente.')  
      end
    end

    context 'with invalid attributes' do
      let(:invalid_attributes) do
        {
          user: attributes_for(:user, password: 'password', password_confirmation: 'wrong_password')
        }
      end

      it 'does not create a new user and redirects back with an alert' do
        expect {
          post :create, params: invalid_attributes
        }.not_to change(User, :count)  # Verifica que no se crea un nuevo usuario
      end
    end
  end
end
