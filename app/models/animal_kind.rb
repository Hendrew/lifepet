class AnimalKind < ApplicationRecord
  extend FriendlyId
  friendly_id :kind, use: :slugged

  has_many :animals

  validates :kind, presence: true, uniqueness: { case_sensitive: false }
end
