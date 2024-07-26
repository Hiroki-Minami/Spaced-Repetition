class StudyCard < ApplicationRecord
  belongs_to :card
  belongs_to :study_category
end
