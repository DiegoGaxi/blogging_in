class PermissionService
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def administrate?
    permissions_any?(%w[admin])
  end
  
  private

  def permissions_any?(names)
    user.permissions.where(name: names, active: true).exists?
  end
end
