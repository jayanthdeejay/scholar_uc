class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :alternate_phone_number, :string
    add_column :users, :blog, :string
    add_column :users, :uc_affiliation, :string
    add_column :users, :alternate_email, :string
  end
end
