module RestaurantSpecHelpers

  def add_restaurant
    visit '/'
    click_link 'Add a restaurant'
    fill_in 'Name', with: 'Nobu'
    click_button 'Create Restaurant'
  end
  
end