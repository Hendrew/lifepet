FactoryBot.define do
  factory :animal do
    name { Faker::Name.name }
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/support/files/dog.jpg')) }
    date_of_birth { Faker::Date.between(from: '2010-01-01', to: '2019-12-31') }
    adoption_status { false }
    adopter_name { '' }
    animal_kind { nil }
  end
end
