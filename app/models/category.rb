class Category < ApplicationRecord
  belongs_to :user
  has_many :cards
  has_many :study_categories
  after_initialize :set_default_is_public, if: :new_record?

  validates :name, presence: true
  validates :description, presence: true

  def set_default_is_public
    self.is_public ||= true
  end
end
