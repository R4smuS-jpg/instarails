FactoryBot.define do
  factory :user do
    email  { FFaker::Internet.email }
    nickname { "#{FFaker::Internet.user_name}123" }
    full_name { FFaker::Name.name }
    biography { FFaker::Lorem.phrase }
    password { 'password123' }
    password_confirmation { 'password123' }
  end
end
