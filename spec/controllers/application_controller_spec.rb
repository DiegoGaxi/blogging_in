require 'rails_helper'

class TestController < ApplicationController
  def index
    head :ok
  end
end

RSpec.describe ApplicationController, type: :controller do
  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe 'Authorization handling' do
    controller(TestController) do
      before_action :authorize_user

      private

      def authorize_user
        raise Pundit::NotAuthorizedError
      end
    end

    it 'redirects to the root path with an alert message when not authorized' do
      sign_in create(:user, role: nil) 
      get :index
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq('No tienes autorización para realizar esta acción.')
    end
  end

  describe 'after_sign_in_path_for' do
    let(:admin) { create(:user, :admin) }
    let(:blogger) { create(:user, :blogger) }
    let(:regular_user) { create(:user, role: nil) }

    context 'when user is an admin' do
      before { sign_in admin }

      it 'redirects to the admin root path' do
        expect(controller.after_sign_in_path_for(admin)).to eq(admin_root_path)
      end
    end

    context 'when user is a blogger' do
      before { sign_in blogger }

      it 'redirects to the blogger root path' do
        expect(controller.after_sign_in_path_for(blogger)).to eq(blogger_root_path)
      end
    end

    context 'when user is neither admin/blogger' do
      before { sign_in regular_user }

      it 'redirects to the root path' do
        expect(controller.after_sign_in_path_for(regular_user)).to eq(root_path)
      end
    end
  end
end