class Card < ApplicationRecord
  belongs_to :category
  has_many :study_cards

  validates :answer, presence: true
  validates :instruction, presence: true
  validates :description, presence: true
end
