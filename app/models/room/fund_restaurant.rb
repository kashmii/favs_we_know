class Room::FundRestaurant < ApplicationRecord

  belongs_to :room

  validates :name, presence: true, length: { maximum: 100 }
  validates :genre, presence: true, length: { maximum: 50 }
  validates :place, presence: true, length: { maximum: 20 }
  validates :holiday, length: { maximum: 20 }
  validates :tel, allow_blank: true, numericality: {only_integer: true}, length: { in: 10..12 }
end
