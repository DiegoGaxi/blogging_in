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
  validates :mobile_phone, length: { is: 10 }, format: { with: /\A\d+\Z/ }, uniqueness: true

  def display_role
    I18n.t("users.roles.#{role}")
  end

  def display_name
    "#{first_name} #{paternal_surname}"
  end
end
