class Animal < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  mount_uploader :image, ImageUploader

  belongs_to :animal_kind

  validates :name, :image, :date_of_birth, presence: true
  validates :adoption_status, inclusion: [true, false]
  validate :verify_adoption_status

  scope :animal_sort, -> (sort_params) {
    if sort_params == 'waiting'
      where(adoption_status: false)
    elsif sort_params == 'adopted'
      where(adoption_status: true)
    end
  }

  def date_of_birth_br
    self.date_of_birth.to_s.split('-').reverse().join('/')
  end

  private

  def verify_adoption_status
    errors.add(:adopter_name, 'não pode ficar em branco') if adoption_status == true && adopter_name.blank?
  end
end
