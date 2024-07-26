class Card < ApplicationRecord
  belongs_to :category
  has_many :study_cards
end
