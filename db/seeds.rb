if Rails.env.development?

  permissions = [
    { name: 'admin', description: 'manage application', active: true }
  ]
  
  permissions.each do |attributes|
    Permission.find_or_create_by(attributes)
  end
  
  admin_permission = Permission.find_by_name('admin')
  
  # create admin
  unless User.admin.find_by_email('admin@bloggingin.com')
    admin = User.admin.new.tap do |user|
      user.first_name = 'admin'
      user.paternal_surname = 'admin'
      user.maternal_surname = 'admin'
      user.email = 'admin@bloggingin.com'
      user.password = '123456'
      user.password_confirmation = '123456'
    end

    admin.transaction do
      admin.save!(validate: false)
      admin.user_permissions.create!(permission: admin_permission)
    end
  end
  
  #create categories
  categories = [
    { name: 'Software' },
    { name: 'Hardware' },
    { name: 'Security' },
    { name: 'Networking' },
    { name: 'Other' }
  ]
  
  categories.each do |attributes|
    Category.find_or_create_by(attributes)
  end
end