FactoryBot.define do
  factory :item do
    name              {Faker::String.random}
    content           {Faker::Lorem.sentence}
    price             {Faker::Number.between(from: 300, to: 9999999)}
    category_id       {Faker::Number.between(from: 2, to: 11)}
    condition_id      {Faker::Number.between(from: 2, to: 7)}
    payment_id        {Faker::Number.between(from: 2, to: 3)}
    prefecture_id     {Faker::Number.between(from: 2, to: 48)}
    day_id            {Faker::Number.between(from: 2, to: 4)}

    after(:build) do |item|
      item.image.attach(io: File.open('app/assets/images/test_image.png'), filename: 'test_image.png')
    end

    association :user
  end
end
