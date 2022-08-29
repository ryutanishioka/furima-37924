class OrderAddress
  include ActiveModel::Model
  attr_accessor :post_code, :city, :address, :phone_number, :prefecture_id, :user_id, :item_id, :building_name, :token

  with_options presence: true do
    validates :post_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :city
    validates :address
    validates :phone_number, format: {with: /\A[0-9]+\z/, message: "is invalid. not hyphen"}, length: {in: 10..11}, numericality: {only_integer: true}
    validates :user_id
    validates :item_id
    validates :token
  end
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }

  def save

    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(post_code: post_code, city: city, address: address, building_name: building_name,
      phone_number: phone_number, prefecture_id: prefecture_id, order_id: order.id)
  end

end