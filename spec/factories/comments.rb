FactoryBot.define do
    factory :comment do
        user
        project
        content { Faker::Lorem.paragraph }
    end
end