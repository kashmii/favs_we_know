class Restaurant < ApplicationRecord
  belongs_to :room
  has_many :reports, dependent: :destroy

  validates :name, presence: true, length: { maximum: 100 }
  validates :genre, presence: true, length: { maximum: 50 }
  validates :place, presence: true, length: { maximum: 20 }
  validates :holiday, length: { maximum: 20 }
  validates :url, length: { maximum: 2000 }
  validates :tel, allow_blank: true, length: { maximum: 11 }, numericality: {only_integer: true}
end
