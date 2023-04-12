class Restaurant::Report < ApplicationRecord
  belongs_to :restaurant

  validates :title, presence: true, length: { maximum: 100 }
  validates :score, length: { maximum: 2 }
  validates :content, presence: true, length: { maximum: 1000 }
end
