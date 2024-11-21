class Review < ApplicationRecord
  belongs_to :card
  belongs_to :user
  validates :rating, presence: true
end
