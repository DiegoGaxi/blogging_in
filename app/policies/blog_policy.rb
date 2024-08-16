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
      scope.all
   end

    private

    attr_reader :user, :scope
  end
end
