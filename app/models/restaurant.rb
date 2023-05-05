class Restaurant < ApplicationRecord
  FILE_NUMBER_LIMIT = 3

  mount_uploaders :images, RestaurantUploader

  belongs_to :room
  has_many :reports, dependent: :destroy

  validates :name, presence: true, length: { maximum: 100 }
  validates :genre, presence: true, length: { maximum: 50 }
  validates :place, presence: true, length: { maximum: 20 }
  validates :holiday, length: { maximum: 20 }
  validates :url, length: { maximum: 2000 }
  validates :tel, allow_blank: true, length: { maximum: 11 }, numericality: {only_integer: true}

  validate :validate_number_of_files

  private

  def validate_number_of_files
    return if images.length <= FILE_NUMBER_LIMIT
    errors.add(:images, "に添付できる画像は#{FILE_NUMBER_LIMIT}件までです。")
  end
end
