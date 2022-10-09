FactoryBot.define do
  factory :room do
    name { 'Michael222' }
    users {[
      FactoryBot.build(:user, room_id: nil)
    ]}
  end
end