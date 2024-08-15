class UserPolicy
  attr_reader :user, :record, :permission_service

  def initialize(user, record)
     @user = user
     @record = record
     @permission_service = PermissionService.new(user)
  end

  def index?
     user.admin?
  end

  def show?
     user.admin?
  end

  class Scope
     def initialize(user, scope)
        @user = user
        @scope = scope
     end
  
     def resolve
        if user.admin?
           scope.all
        else
           scope.none
        end
     end
  
     private
  
     attr_reader :user, :scope
  end
end