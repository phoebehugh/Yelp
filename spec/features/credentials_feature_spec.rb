require 'rails_helper'
require 'helpers/users'

feature 'Users must' do

  include UserSpecHelpers

  context 'be logged in' do
    scenario 'to create restaurants' do 
      visit '/restaurants'
      click_link 'Add a restaurant'
      expect(page).not_to have_button('Create Restaurant')
    end
  end

  context 'have created the restaurant' do

    scenario 'to edit or delete it' do
      sign_up_and_sign_in
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'Nobu'
      click_button 'Create Restaurant'
      click_link 'Sign out'
      sign_up_and_sign_in(email: '1@1.com')
      visit '/restaurants'
      expect(page).not_to have_link('Delete Nobu')
      expect(page).not_to have_link('Edit Nobu')
    end
  end

end
