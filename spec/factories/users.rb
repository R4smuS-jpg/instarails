FactoryBot.define do
  factory :user do
    email  { FFaker::Internet.email }
    nickname { "#{FFaker::Internet.user_name}123" }
    full_name { 'User Userov 1' }
    biography {'I am User 1 =)'}
    password { 'password' }
    password_confirmation { 'password'}
  end
end
