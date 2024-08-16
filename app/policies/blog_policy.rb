class BlogPolicy
  attr_reader :user, :record, :permission_service

  def initialize(user, record)
    @user = user
    @record = record
    @permission_service = PermissionService.new(user)
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.present? && user.admin?
        scope.all
      elsif user.present? && user.blogger?
        scope.where(user_id: user.id)
      else
        scope.all
      end
   end

    private

    attr_reader :user, :scope
  end
end
