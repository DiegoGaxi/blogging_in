module Admin
   class UsersController < ApplicationController
     layout 'admin'
     include Pundit::Authorization
     include Pagy::Backend
     before_action :authorize_user
     rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found
 
     def index
       @pagy_users, @users = pagy(search_records, page_param: :pagy_users, items: 10)
     end
 
     def show
       @user = User.find(params[:id])
     end
     
     private
 
     def search_records
       policy_scope find_records(params.permit(:q))
     end
 
     def find_records(criteria)
       UserQuery.new(criteria).call
     end
 
     def authorize_user
       authorize current_user, policy_class: UserPolicy
     end
 
     def handle_record_not_found
       redirect_to admin_users_path, alert: 'No se encontraron registros'
     end
   end
 end
 