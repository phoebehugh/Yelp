require 'rails_helper'

feature 'reviewing' do
  before {Restaurant.create name: 'Nobu'}

  scenario 'allows users to leave a review using a form' do
     visit '/restaurants'
     click_link 'Leave Review'
     fill_in "Thoughts", with: "Dope!"
     select '3', from: 'Rating'
     click_button 'Leave Review'

     expect(current_path).to eq '/restaurants'
     expect(page).to have_content('Dope!')
  end

end
