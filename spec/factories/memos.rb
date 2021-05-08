FactoryBot.define do
  factory :memo do
    name { "離乳食" }
    description { "このやり方で作ります。" }
    association :user
  end
end
