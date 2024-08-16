class AddMissingAttributesToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :middle_name, :string
    add_column :users, :paternal_surname, :string
    add_column :users, :maternal_surname, :string
    add_column :users, :state, :string
    add_column :users, :mobile_phone, :string
    add_column :users, :role, :integer, default: 0
    add_column :users, :gender, :integer
    add_column :users, :alias, :string
  end
end
