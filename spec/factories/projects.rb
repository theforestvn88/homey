FactoryBot.define do
    factory :project do
        user
        title { Faker::Color.color_name }
    end
end