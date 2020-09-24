FactoryBot.define do
  factory :animal_type do
    kind { Faker::Creature::Animal.name }
  end
end
