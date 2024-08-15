class ApplicationController < ActionController::Base
  include Pundit::Authorization
  include Pagy::Backend
  include Pagy::Frontend
  before_action :authenticate_user!
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def after_sign_in_path_for(_resource)
    if current_user.admin?
      admin_root_path
    elsif current_user.blogger?
      root_path
    else
      root_path
    end
  end

  private

  def user_not_authorized
    redirect_to root_path, alert: 'No tienes autorización para realizar esta acción.'
  end
end