class Users::RegistrationsController < Devise::RegistrationsController
    # For Bussinesses
    
    skip_before_action :require_no_authentication, only: [:new]
  
    def create
      begin
        @user = User.new(user_params)
        @user.role = :blogger
        @user.alias = @user.create_alias
        @user.save!
        redirect_to new_user_session_path, notice: 'Usuario creado exitosamente.'
      rescue StandardError => e
        redirect_to fallback_location: :back, alert: e.message
      end
    end
  
    private
  
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :paternal_surname)
    end
  end