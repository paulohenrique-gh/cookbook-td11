FactoryBot.define do
  factory :rating do
    score { 1 }
    comment { "MyString" }
    recipe { nil }
    user { nil }
  end
end
