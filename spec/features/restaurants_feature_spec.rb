require 'rails_helper'
require 'helpers/users'
require 'helpers/restaurants'

feature 'restaurants' do

  include UserSpecHelpers
  include RestaurantSpecHelpers

  before :each do
    sign_up_and_sign_in
  end

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

    context 'an invalid restaurant' do
      it 'does not let you submit a name that is too short' do
        visit '/restaurants'
        click_link 'Add a restaurant'
        fill_in 'Name', with: 'aa'
        click_button 'Create Restaurant'
        expect(page).not_to have_css 'h2', text: 'aa'
        expect(page).to have_content 'error'
      end
    end

  end

  context 'viewing restaurants' do
    let!(:nobu){Restaurant.create(name: 'Nobu')}

    scenario 'lets a user view a restaurant' do
      visit '/restaurants'
      click_link 'Nobu'
      expect(page).to have_content 'Nobu'
      expect(current_path).to eq "/restaurants/#{nobu.id}"
    end
  end

  context 'editing and deleting restaurants' do
    
    before {add_restaurant}

    scenario 'let a user edit a restaurant' do
      visit '/restaurants'
      click_link 'Edit Nobu'
      fill_in 'Name', with: 'Nobu Matsuhisa'
      click_button 'Update Restaurant'
      expect(page).to have_content 'Nobu Matsuhisa'
      expect(current_path).to eq '/restaurants'
    end
  
    scenario 'removes a restaurant when a user clicks a delete link' do
      visit '/restaurants'
      click_link 'Delete Nobu'
      expect(page).not_to have_content 'Nobu'
      expect(page).to have_content 'Restaurant deleted successfully'
    end
  end
end
