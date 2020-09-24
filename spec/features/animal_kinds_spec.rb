require 'rails_helper'

RSpec.feature 'AnimalKinds', type: :feature do
  context 'animal kind index' do
    let!(:animal_kinds) { create_list(:animal_kind, 5) }

    before do
      visit animal_kinds_path
    end

    scenario 'returns status code ok' do
      expect(page).to have_http_status(:ok)
    end

    scenario 'must list animal_kinds' do
      animal_kinds.each do |animal_kind|
        expect(page).to have_content animal_kind.kind
      end
    end

    scenario 'must have the new link' do
      expect(page).to have_link 'Novo'
    end

    scenario 'the new link successfully redirects' do
      click_on 'Novo'
      expect(page).to have_selector 'h1', text: 'Novo Tipo de Animal'
    end

    scenario 'must have the edit link' do
      expect(page).to have_link 'Editar'
    end

    scenario 'the edit link successfully redirects' do
      click_on 'Editar', match: :first
      expect(page).to have_selector 'h1', text: 'Editar Tipo de Animal'
    end

    scenario 'must have the exclusion link' do
      expect(page).to have_link 'Excluir'
    end

    scenario 'the exclusion link works', js: true do
      click_on 'Excluir', match: :first
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_content 'Tipo de animal excluído com sucesso.'
    end
  end

  context 'new animal kind' do
    before do
      visit new_animal_kind_path
    end

    scenario 'returns status code ok' do
      expect(page).to have_http_status(:ok)
    end

    scenario 'must have a back link' do
      expect(page).to have_link 'Voltar'
    end

    scenario 'back link works' do
      click_on 'Voltar'
      expect(page).to have_selector 'h1', text: 'Tipos de Animais'
    end

    scenario 'must have the link to cancel' do
      expect(page).to have_link 'Cancelar'
    end

    scenario 'cancel link works', js: true do
      click_on 'Cancelar'
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_selector 'h1', text: 'Tipos de Animais'
    end
  end

  context 'create animal kind' do
    let(:animal_kind) { build(:animal_kind) }

    before do
      visit new_animal_kind_path
    end

    scenario 'with valid inputs', js: true do
      within('form') do
        fill_in 'Tipo',	with: animal_kind.kind
      end
      click_on 'Criar Tipo de Animal'
      expect(page).to have_content 'Tipo de animal cadastrado com sucesso.'
    end

    scenario 'with invalid inputs' do
      click_on 'Criar Tipo de Animal'
      expect(page).to have_content '1 erro proibiu este tipo de animal de ser salvo:'
      expect(page).to have_content 'Tipo não pode ficar em branco'
    end
  end

  context 'edit animal kind' do
    let(:animal_kind) { create(:animal_kind) }

    before do
      visit edit_animal_kind_path(animal_kind)
    end

    scenario 'returns status code ok' do
      expect(page).to have_http_status(:ok)
    end

    scenario 'must have a back link' do
      expect(page).to have_link 'Voltar'
    end

    scenario 'back link works' do
      click_on 'Voltar'
      expect(page).to have_selector 'h1', text: 'Tipos de Animais'
    end

    scenario 'must have the link to cancel' do
      expect(page).to have_link 'Cancelar'
    end

    scenario 'cancel link works', js: true do
      click_on 'Cancelar'
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_selector 'h1', text: 'Tipos de Animais'
    end
  end

  context 'update animal kind' do
    let(:animal_kind) { create(:animal_kind) }

    before do
      visit edit_animal_kind_path(animal_kind)
    end

    scenario 'with valid inputs' do
      within('form') do
        fill_in 'Tipo',	with: 'Other kind'
      end
      click_on 'Atualizar Tipo de Animal'
      expect(page).to have_content 'Tipo de animal atualizado com sucesso.'
    end

    scenario 'with invalid inputs' do
      within('form') do
        fill_in 'Tipo',	with: nil
      end
      click_on 'Atualizar Tipo de Animal'
      expect(page).to have_content '1 erro proibiu este tipo de animal de ser salvo:'
      expect(page).to have_content  'Tipo não pode ficar em branco'
    end
  end
end
