FactoryBot.define do
  factory :rating do
    score { 1 }
    comment { 'Muito bom' }
    recipe
    user
  end
end
