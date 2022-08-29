FactoryBot.define do
  factory :order_address do
    post_code           {"111-2222"}
    city                {"港区"}  
    address             {"1-1-1"}
    building_name       {"港マンション"}
    phone_number        {"09011112222"}
    prefecture_id       {Faker::Number.between(from: 2, to: 48)}
    token               {"tok_abcdefghijk00000000000000000"}
  end
end
