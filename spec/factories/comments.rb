FactoryBot.define do
    factory :comment do
        user
        project
        content { Faker::Lorem.characters(number: 20) }
    end
end