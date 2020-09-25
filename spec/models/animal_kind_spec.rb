require 'rails_helper'

RSpec.describe AnimalKind, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:kind) }
    it { is_expected.to validate_uniqueness_of(:kind).case_insensitive }
  end

  describe 'associations' do
    it { is_expected.to have_many(:animals) }
  end
end
