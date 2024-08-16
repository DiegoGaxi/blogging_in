FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }
    first_name { Faker::Name.first_name.gsub(/\s+/, '_') }
    paternal_surname { Faker::Name.last_name.gsub(/\s+/, '_') }
    gender { User.genders.keys.sample }
    role { User.roles.keys.sample }
  end
end
