FactoryBot.define do
  factory :user do |f|
    f.sequence(:email) { |n| "user-#{n}@email.com" }
    f.first_name { Faker::Name.first_name }
    f.last_name { Faker::Name.last_name }
    f.employee { true }
  end
end
