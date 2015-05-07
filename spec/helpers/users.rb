module UserSpecHelpers

  def sign_up_and_sign_in options = {}
    visit '/'
    click_link('Sign up')
    fill_in 'Email', with: options.fetch(:email, 'phoebehugh@gmail.com')
    fill_in 'Password', with: options.fetch(:password, '11111111')
    fill_in 'Password confirmation', with: options.fetch(:password, '11111111')
    click_button 'Sign up'
  end

end
