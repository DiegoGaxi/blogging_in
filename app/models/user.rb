# app/models/user.rb
class User < ApplicationRecord
  audited

  devise :database_authenticatable, :registerable, :trackable,
         :recoverable, :rememberable, :validatable
  
  has_many :user_permissions
  has_many :permissions, through: :user_permissions
  
  enum role: %i[blogger admin]
  enum gender: %i[male female]

  validates :first_name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  def display_role
    I18n.t("users.roles.#{role}")
  end

  def display_name
    "#{first_name} #{paternal_surname}"
  end

  def create_alias
    self.alias = (self.first_name + '_' + self.paternal_surname).downcase.gsub(' ', '')
    if User.where(alias: self.alias).exists?
      self.alias = self.alias + (User.where(alias: self.alias).count + 1).to_s
    end
    return self.alias
  end
end
