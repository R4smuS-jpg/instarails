FactoryBot.define do
  factory :user_1 do
    email  { FFaker::Internet.email }
    nickname { "#{FFaker::Internet.user_name}123" }
    full_name { 'User Userov 1' }
    biography {'I am User 1 =)'}
    password { 'password' }
    password_confirmation { 'password'}
  end

  factory :user_2 do
    email  { FFaker::Internet.email }
    nickname { "#{FFaker::Internet.user_name}123" }
    full_name { 'User Userov 2' }
    biography {'I am User 2 =)'}
    password { 'password' }
    password_confirmation { 'password'}
  end

  factory :user_3 do
    email  { FFaker::Internet.email }
    nickname { "#{FFaker::Internet.user_name}123" }
    full_name { 'User Userov 3' }
    biography {'I am User 3 =)'}
    password { 'password' }
    password_confirmation { 'password'}
  end
end
