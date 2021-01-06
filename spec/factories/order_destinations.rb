FactoryBot.define do
  factory :order_destination do
    post_code        {"333-3333"}
    prefecture_id    {3}
    city             {"青葉市"}
    address          {"青山1-1-1"}
    building_name    {"青井ビル"}
    phone_number     {77777777777}
    token            {"tok_abcdefghijk00000000000000000"}
  end
end
