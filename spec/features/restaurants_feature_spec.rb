require 'rails_helper'

feature 'restaurants' do
  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurants have been added' do
    before do
      Restaurant.create(name: 'Nobu')
    end

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content('Nobu')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'creating restaurants' do
    scenario 'prompts user to fill out a form, then displays the new restaurant' do
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'Nobu'
      click_button 'Create Restaurant'
      expect(page).to have_content 'Nobu'
      expect(current_path).to eq '/restaurants'
    end
  end

  context 'viewing restaurants' do
    let!(:nobu){Restaurant.create(name: 'Nobu')}

    scenario 'lets a user view a restaurant' do
      visit '/restaurants'
      click_link 'Nobu'
      expect(page).to have_content 'Nobu'
      expect(current_path).to eq "restaurants/#{nobu.id}"
    end
  end
end
