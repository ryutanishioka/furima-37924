class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user
  belongs_to :category
  belongs_to :condition
  belongs_to :payment
  belongs_to :prefecture
  belongs_to :day
  #バリデーションの設定忘れずに

  validates :category_id, numericality: { other_than: 1, message: "category can't be blank" }
  validates :condition_id, numericality: { other_than: 1, message: "condition can't be blank" }
  validates :payment_id, numericality: { other_than: 1, message: "payment can't be blank" }
  validates :prefecture_id, numericality: { other_than: 1, message: "prefecture can't be blank" }
  validates :day_id, numericality: { other_than: 1, message: "day can't be blank" }

end
