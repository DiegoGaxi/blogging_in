module Admin
  class BlogPolicy
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

    def new?
      user.admin? || user.blogger?
    end

    def create?
      user.admin? || user.blogger?
    end

    def edit?
      user.admin? || user.blogger?
    end

    def update?
      user.admin? || user.blogger?
    end

    def destroy?
      user.admin? || user.blogger?
    end

    class Scope
      def initialize(user, scope)
        @user = user
        @scope = scope
      end

      def resolve
        if user.admin? || user.blogger?
          scope.where(user_id: user.id)
        end
    end

      private

      attr_reader :user, :scope
    end
  end
end