class OrderSend
  include ActiveModel::Model
  attr_accessor :post_code, :city, :address, :phone_number, :prefecture_id, :user_id, :item_id

  validates :post_code, presence: true, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
  validates :city, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true, format: {/\A\d{10,11}\z/}
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :user_id, presence: true
  validates :item_id, presence: true

end