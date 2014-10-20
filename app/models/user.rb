class User < ActiveRecord::Base
  has_secure_password


  has_many :products
  has_many :orderitems, through: :products

#  EMAIL_REGEX = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i
#  validates :username, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
#  validates :email, :presence => true, :uniqueness => true, :format => EMAIL_REGEX
#  validates :password, :confirmation => true #password_confirmation attr
#  validates_length_of :password, :in => 6..20, :on => :create

  # before_save :encrypt_password
  # after_save :clear_password

 # def encrypt_password
 #   if password.present?
 #     self.salt = BCrypt::Engine.generate_salt
 #     self.encrypted_password= BCrypt::Engine.hash_secret(password, salt)
 #   end
 # end

  # no need to validate presence of password or password
  # confirmation, has_secure_password does that for you.
  # validate format of email, length of password, etc.

  validates :email, presence: true, uniqueness: true
  validates_uniqueness_of :email, format: {with: /@/}


  #has_many :products
  #has_many :orderitems, through: :products

end
