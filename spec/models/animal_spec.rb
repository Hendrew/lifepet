require 'rails_helper'

RSpec.describe Animal, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:image) }
    it { is_expected.to validate_presence_of(:date_of_birth) }
  end

  describe 'customer validation' do
    context 'when adoption status is true' do
      let(:animal_kind) { create(:animal_kind) }
      let(:animal) { build(:animal, adoption_status: true, animal_kind: animal_kind) }
      it 'the adopter name become required' do
        expect(animal.valid?).to eq(false)
        expect(animal.errors[:adopter_name]).to include('não pode ficar em branco')
      end
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:animal_kind) }
  end
end
