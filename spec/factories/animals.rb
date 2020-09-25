FactoryBot.define do
  factory :animal do
    name { "MyString" }
    image { "MyString" }
    date_of_birth { "2020-09-24" }
    adopted { false }
    animal_kind { nil }
  end
end
