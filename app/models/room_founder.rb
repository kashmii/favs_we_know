class RoomFounder < ApplicationRecord
  belongs_to :room

  validates :founder_id, presence: true
  validates :room_id, presence: true
end
