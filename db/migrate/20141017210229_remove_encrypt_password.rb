class RemoveEncryptPassword < ActiveRecord::Migration
def change
  remove_column :users, :encrypted_password, :string
end
end
