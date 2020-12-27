FactoryBot.define do
  factory :item do
    name                  {Faker::Commerce.product_name}
    price                 {Faker::Commerce.price(range: 300..9999999)}
    description           {Faker::Lorem.sentence}
    category_id           {Faker::Number.between(from: 2, to: 11)}
    status_id             {Faker::Number.between(from: 2, to: 7)}
    cost_id               {Faker::Number.between(from: 2, to: 3)}
    prefecture_id         {Faker::Number.between(from: 2, to: 48)}
    day_id                {Faker::Number.between(from: 2, to: 4)}
    association :user
    end
end