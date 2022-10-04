require 'securerandom'

class Room < ApplicationRecord
  before_create :generate_token

  has_one :user

  validates :name, presence: true, length: { in: 2..40 }

  private

    def generate_token
      self.token = SecureRandom.urlsafe_base64(6)
    end
end
