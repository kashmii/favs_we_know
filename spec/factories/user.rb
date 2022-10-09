FactoryBot.define do
  factory :user do
    name { 'Michael' }
    sequence(:email) { |n| "test#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
    room_id { nil }
  end

  factory :other_user do
    name { 'Sterling' }
    email { 'duchess@example.gov' }
    password { 'password' }
    password_confirmation { 'password' }

  end
end