require 'rails_helper'
require 'helpers/users'
require 'helpers/restaurants'

feature 'reviewing' do

  include UserSpecHelpers
  include RestaurantSpecHelpers

  scenario 'allows users to leave a review using a form' do
     Restaurant.create name: 'Nobu'
     visit '/restaurants'
     click_link 'Review Nobu'
     fill_in "Thoughts", with: "Dope!"
     select '3', from: 'Rating'
     click_button 'Leave Review'

     expect(current_path).to eq '/restaurants'
     expect(page).to have_content('Dope!')
  end

  scenario 'deleting a restaurant also deletes the reviews' do
     sign_up_and_sign_in
     add_restaurant
     visit '/restaurants'
     click_link 'Review Nobu'
     fill_in "Thoughts", with: "Dope!"
     select '3', from: 'Rating'
     click_button 'Leave Review'

     expect(current_path).to eq '/restaurants'
     click_link "Delete Nobu"
     expect(page).not_to have_content('Dope!')
  end

end
