class UserPolicy
  attr_reader :user, :record, :permission_service

  def initialize(user, record)
     @user = user
     @record = record
     @permission_service = PermissionService.new(user)
  end

  def index?
     user.admin? || user.blogger?
  end

  def show?
     user.admin? || user.blogger?
  end

  class Scope
     def initialize(user, scope)
        @user = user
        @scope = scope
     end
  
     def resolve
        if user.admin?
           scope.all
        elsif user.blogger?
           scope.where(id: user.id)
        else
           scope.none
        end
     end
  
     private
  
     attr_reader :user, :scope
  end
end