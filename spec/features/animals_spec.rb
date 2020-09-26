require 'rails_helper'

RSpec.feature 'Animals', type: :feature do
  include ActionView::Helpers::NumberHelper
  include ApplicationHelper

  let!(:animal_kind) { create(:animal_kind) }

  context 'animal index' do
    let!(:animals) { create_list(:animal, 5, animal_kind: animal_kind) }

    before do
      visit animals_path
    end

    scenario 'returns status code ok' do
      expect(page).to have_http_status(:ok)
    end

    scenario 'must list animals' do
      animals.each do |animal|
        expect(page.find("#animal_photo_list_#{animal.id}")['src']).to eq("/uploads/test/animal/image/#{animal.id}/medium_dog.jpg")
        expect(page).to have_content animal.name
        expect(page).to have_content 'Aguardando'
      end
    end

    scenario 'must have the new link' do
      expect(page).to have_link 'Novo'
    end

    scenario 'the new link successfully redirects' do
      click_on 'Novo'
      expect(page).to have_selector 'h1', text: 'Novo Animal'
    end

    scenario 'must have the edit link' do
      expect(page).to have_link 'Editar'
    end

    scenario 'the edit link successfully redirects' do
      click_on 'Editar', match: :first
      expect(page).to have_selector 'h1', text: 'Editar Animal'
    end

    scenario 'must have the exclusion link' do
      expect(page).to have_link 'Excluir'
    end

    scenario 'the exclusion link works', js: true do
      click_on 'Excluir', match: :first
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_content 'Animal excluído com sucesso.'
    end
  end

  context 'sorting by waiting adoption status' do
    let!(:animal01) { create(:animal, animal_kind: animal_kind) }
    let!(:animal02) { create(:animal, adoption_status: true, adopter_name: 'John Doe', animal_kind: animal_kind) }
    let!(:animal03) { create(:animal, animal_kind: animal_kind) }
    let!(:animals) { Animal.all }

    before do
      visit animals_path
    end

    scenario 'must list only animals whose adoption status is waiting', js: true do
      find('#animal_sort').find(:xpath, 'option[2]').select_option
      animals.each do |animal|
        expect(page).to have_selector 'td', text: 'Aguardando'
        expect(page).to_not have_selector 'td', text: 'Adotado'
      end
    end
  end

  context 'sorting by adopted adoption status' do
    let!(:animal01) { create(:animal, adoption_status: true, adopter_name: 'John Doe', animal_kind: animal_kind) }
    let!(:animal02) { create(:animal, animal_kind: animal_kind) }
    let!(:animal03) { create(:animal, adoption_status: true, adopter_name: 'Anastasia Steele', animal_kind: animal_kind) }
    let!(:animals) { Animal.all }

    before do
      visit animals_path
    end

    scenario 'must list only animals whose adoption status is adopted', js: true do
      find('#animal_sort').find(:xpath, 'option[3]').select_option

      animals.each do |animal|
        expect(page).to have_selector 'td', text: 'Adotado'
        expect(page).to_not have_selector 'td', text: 'Aguardando'
      end
    end
  end

  context 'new animal' do
    before do
      visit new_animal_path
    end

    scenario 'returns status code ok' do
      expect(page).to have_http_status(:ok)
    end

    scenario 'must have a back link' do
      expect(page).to have_link 'Voltar'
    end

    scenario 'back link works' do
      click_on 'Voltar'
      expect(page).to have_selector 'h1', text: 'Animais'
    end

    scenario 'must have the link to cancel' do
      expect(page).to have_link 'Cancelar'
    end

    scenario 'cancel link works', js: true do
      click_on 'Cancelar'
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_selector 'h1', text: 'Animais'
    end
  end

  context 'create animal' do
    let(:animal) { build(:animal, animal_kind: animal_kind) }

    before do
      visit new_animal_path
    end

    scenario 'with valid inputs', js: true do
      within('form') do
        find('#animal_animal_kind_id').find(:xpath, 'option[2]').select_option
        fill_in 'Nome',	with: animal.name
        attach_file('Imagem', Rails.root.join('spec/support/files/dog.jpg'))
        fill_in 'Data de nascimento',	with: '10/10/2018'
      end
      click_on 'Criar Animal'
      expect(page).to have_content 'Animal cadastrado com sucesso.'
    end

    scenario 'when adoption status is true', js: true do
      within('form') do
        find('#animal_animal_kind_id').find(:xpath, 'option[2]').select_option
        fill_in 'Nome',	with: animal.name
        attach_file('Imagem', Rails.root.join('spec/support/files/dog.jpg'))
        fill_in 'Data de nascimento',	with: '10/10/2018'
        find('#animal_adoption_status').find(:xpath, 'option[2]').select_option
        fill_in 'Nome do adotante',	with: 'John Doe'
      end
      click_on 'Criar Animal'
      expect(page).to have_content 'Animal cadastrado com sucesso.'
    end

    scenario 'with invalid inputs' do
      click_on 'Criar Animal'
      expect(page).to have_content '4 erros proibiram este animal de ser salvo:'
      expect(page).to have_content 'Tipo de animal é obrigatório(a)'
      expect(page).to have_content 'Nome não pode ficar em branco'
      expect(page).to have_content 'Imagem não pode ficar em branco'
      expect(page).to have_content 'Data de nascimento não pode ficar em branco'
    end

    scenario 'when adoption status is true and adopter name blank' do
      find('#animal_adoption_status').find(:xpath, 'option[2]').select_option
      click_on 'Criar Animal'
      expect(page).to have_content '5 erros proibiram este animal de ser salvo:'
      expect(page).to have_content 'Tipo de animal é obrigatório(a)'
      expect(page).to have_content 'Nome não pode ficar em branco'
      expect(page).to have_content 'Imagem não pode ficar em branco'
      expect(page).to have_content 'Data de nascimento não pode ficar em branco'
      expect(page).to have_content 'Nome do adotante não pode ficar em branco'
    end
  end

  context 'show animal' do
    let(:animal) { create(:animal, animal_kind: animal_kind) }

    before do
      visit animal_path(animal)
    end

    scenario 'returns status code ok' do
      expect(page).to have_http_status(:ok)
    end

    scenario 'must have a back link' do
      expect(page).to have_link 'Voltar'
    end

    scenario 'back link works' do
      click_on 'Voltar'
      expect(page).to have_selector 'h1', text: 'Animais'
    end

    scenario 'should be successful' do
      expect(page).to have_content animal.animal_kind.kind
      expect(page.find('#animal_photo')['src']).to eq("/uploads/test/animal/image/#{animal.id}/dog.jpg")
      expect(page).to have_content animal.name
      expect(page).to have_content I18n.l(animal.date_of_birth, format: :long)
      expect(page).to have_content get_age(animal.date_of_birth)
      expect(page).to have_content 'Aguardando'
    end
  end

  context 'edit animal' do
    let(:animal) { create(:animal, animal_kind: animal_kind) }

    before do
      visit edit_animal_path(animal)
    end

    scenario 'returns status code ok' do
      expect(page).to have_http_status(:ok)
    end

    scenario 'must have a back link' do
      expect(page).to have_link 'Voltar'
    end

    scenario 'back link works' do
      click_on 'Voltar'
      expect(page).to have_selector 'h1', text: 'Animais'
    end

    scenario 'must have the link to cancel' do
      expect(page).to have_link 'Cancelar'
    end

    scenario 'cancel link works', js: true do
      click_on 'Cancelar'
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_selector 'h1', text: 'Animais'
    end
  end

  context 'update animal' do
    let(:animal) { create(:animal, animal_kind: animal_kind) }

    before do
      visit edit_animal_path(animal)
    end

    scenario 'with valid inputs' do
      within('form') do
        fill_in 'Nome',	with: 'Other name'
      end
      click_on 'Atualizar Animal'
      expect(page).to have_content 'Animal atualizado com sucesso.'
    end

    scenario 'when adoption status is true', js: true do
      within('form') do
        find('#animal_adoption_status').find(:xpath, 'option[2]').select_option
        fill_in 'Nome do adotante',	with: 'John Doe'
      end
      click_on 'Atualizar Animal'
      expect(page).to have_content 'Animal atualizado com sucesso.'
    end

    scenario 'with invalid inputs' do
      within('form') do
        fill_in 'Nome',	with: nil
      end
      click_on 'Atualizar Animal'
      expect(page).to have_content '1 erro proibiu este animal de ser salvo:'
      expect(page).to have_content  'Nome não pode ficar em branco'
    end

    scenario 'when adoption status is true and adopter name is blank', js: true do
      within('form') do
        find('#animal_adoption_status').find(:xpath, 'option[2]').select_option
        fill_in 'Nome do adotante',	with: ''
      end
      click_on 'Atualizar Animal'
      expect(page).to have_content '1 erro proibiu este animal de ser salvo:'
      expect(page).to have_content  'Nome do adotante não pode ficar em branco'
    end
  end
end
