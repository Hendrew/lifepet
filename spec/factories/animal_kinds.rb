FactoryBot.define do
  factory :animal_kind do
    kind { Faker::Name.name }
  end
end
