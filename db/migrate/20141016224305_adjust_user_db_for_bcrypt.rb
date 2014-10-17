class AdjustUserDbForBcrypt < ActiveRecord::Migration
  def change
    remove_column(:users, :password_digest)
    add_column(:users, :encrypted_password, :string)
  end
end
