class Review < ApplicationRecord
  belongs_to :card
  validates :rating, presence: true
end
