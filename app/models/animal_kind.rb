class AnimalKind < ApplicationRecord
  extend FriendlyId
  friendly_id :kind, use: :slugged

  validates :kind, presence: true, uniqueness: { case_sensitive: false }
end
