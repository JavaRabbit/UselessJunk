class Order < ActiveRecord::Base
  has_many :products, through: :order_items
  has_many :order_items

  # these validations when we update status to paid, and more
  # validates :email, presence: true, uniqueness: true
  # validates_uniqueness_of :email, format: {with: /@/}

  validates :email, format: {with: /@/}, if: :paid?
  validates :name, presence: true, if: :paid?

  def paid?
    :state == "paid"
  end

end
