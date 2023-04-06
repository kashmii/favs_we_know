class Room::Report < ApplicationRecord
  belongs_to :room_restaurant

  validates :title, presence: true, length: { maximum: 100 }
  validates :content, presence: true, length: { maximum: 1000 }
end
