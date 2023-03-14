FactoryBot.define do
  factory :user do
    email  { FFaker::Internet.email }
    nickname { FFaker::Internet.user_name }
    full_name { 'User Userov' }
    biography {'I am User =)'}
    password { 'password' }
    password_confirmation { 'password'}
  end
end
