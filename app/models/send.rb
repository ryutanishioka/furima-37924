class Send < ApplicationRecord
  belongs_to :order

  validates :post_code, presence: true, format: {/\A\d{3}[-]\d{4}\z/}
  validates :city, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true, format: {/\A\d{10,11}\z/}
  validates :prefecture_id, presence: true
end
