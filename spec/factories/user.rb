FactoryBot.define do
  factory :user do
    name { 'Michael' }
    email { 'michael@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end

  factory :other_user do
    name { 'Sterling' }
    email { 'duchess@example.gov' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end