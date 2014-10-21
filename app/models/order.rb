class Order < ActiveRecord::Base
  has_many :products, through: :order_items
  has_many :order_items

  # these validations when we update status to paid, and more
  # validates :email, presence: true, uniqueness: true
  # validates_uniqueness_of :email, format: {with: /@/}

  validates :email, format: {with: /@/}, if: :paid?
  validates :buyer_name, presence: true, if: :paid?
  validates :last_four, numericality: { only_integer: true }, length:  { is: 4 }, if: :paid?
  validates :address, presence: true, if: :paid?
  validates :expiration, format: {with: /\//}, length: { in: 4..7 }, if: :paid?

  def paid?
    state == "paid"
  end

end
