class BlogPolicy
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

  def new?
    user.admin?
  end

  def create?
    user.admin?
  end

  def edit?
    user.admin?
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin?
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
