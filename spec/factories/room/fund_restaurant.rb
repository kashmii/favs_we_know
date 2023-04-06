FactoryBot.define do
  factory :room_fund_restaurant, class: 'Room::FundRestaurant' do
    name { 'hope' }
    genre { 'diner' }
    place { 'shibuya' }
    holiday { 'Sun' }
    tel { '09099999999' }
    url { nil }
  end
end
