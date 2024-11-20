class Card < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  has_many :reviews, dependent: :destroy
end
