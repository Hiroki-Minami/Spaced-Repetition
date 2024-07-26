class StudyCategory < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :study_cards, dependent: :destroy
end
