require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user, role: :blogger) }

  # Validations
  it 'is valid with valid attributes' do
    expect(user).to be_valid
  end

  it 'is not valid without a first_name' do
    user.first_name = nil
    expect(user).not_to be_valid
  end

  it 'is not valid without an email' do
    user.email = nil
    expect(user).not_to be_valid
  end

  it 'is not valid with a duplicate email' do
    duplicate_user = user.dup
    duplicate_user.email = user.email.upcase
    expect(duplicate_user).not_to be_valid
  end

  it 'is not valid with an improperly formatted email' do
    user.email = 'invalid_email'
    expect(user).not_to be_valid
  end

  # Enums
  describe 'enums' do
    it 'has a role of blogger' do
      expect(user.blogger?).to be_truthy
    end

    it 'has a gender of male' do
      user.gender = :male
      expect(user.male?).to be_truthy
    end
  end

  # Methods
  describe '#display_role' do
    it 'returns the correct role' do
      expect(user.display_role).to eq(I18n.t("users.roles.#{user.role}"))
    end
  end

  describe '#display_name' do
    it 'returns the correct display name' do
      expect(user.display_name).to eq("#{user.first_name} #{user.paternal_surname}")
    end
  end

  describe '#create_alias' do
    context 'when alias is unique' do
      it 'generates a unique alias' do
        alias_name = user.create_alias
        expect(alias_name).to eq("#{user.first_name.downcase}_#{user.paternal_surname.downcase}")
      end
    end

    context 'when alias is not unique' do
      before do
        create(:user, alias: "#{user.first_name.downcase}_#{user.paternal_surname.downcase}")
      end

      it 'appends a number to the alias' do
        alias_name = user.create_alias
        expect(alias_name).to match(/#{user.first_name.downcase}_#{user.paternal_surname.downcase}\d+/)
      end
    end
  end
end
