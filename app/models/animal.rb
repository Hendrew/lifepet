class Animal < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  mount_uploader :image, ImageUploader

  belongs_to :animal_kind

  validates :name, :image, :date_of_birth, presence: true
  validates :adoption_status, inclusion: [true, false]
  validate :verify_adoption_status

  def date_of_birth_br
    self.date_of_birth.to_s.split('-').reverse().join('/')
  end

  private

  def verify_adoption_status
    errors.add(:adopter_name, 'não pode ficar em branco') if adoption_status == true && adopter_name.blank?
  end
end
