require 'securerandom'

class Room < ApplicationRecord
  before_create :generate_token

  has_many :users
  has_many :member_requests, dependent: :destroy
  has_many :room_restaurants, dependent: :destroy
  has_one :room_founder, dependent: :destroy

  validates :name, presence: true, length: { in: 2..50 }

  private

    def generate_token
      self.token = SecureRandom.urlsafe_base64(6)
    end
end
