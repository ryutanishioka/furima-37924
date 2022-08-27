class OrderAddress
  include ActiveModel::Model
  attr_accessor :post_code, :city, :address, :phone_number, :prefecture_id, :user_id, :item_id, :building_name, :token

  validates :post_code, presence: true, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
  validates :city, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true, format: {with: /\A[0-9]{10,11}\z/, message: "is invalid. not hyphen"}, length: {minimum:10, maximum:11}
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :user_id, presence: true
  validates :item_id, presence: true
  validates :token, presence: true



  def save

    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(post_code: post_code, city: city, address: address, building_name: building_name,
      phone_number: phone_number, prefecture_id: prefecture_id, order_id: order.id)
  end

end