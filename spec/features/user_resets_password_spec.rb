require 'spec_helper'

feature 'User resets password' do 
	scenario 'user succesfully resets the password' do
		jim = Fabricate(:user, password: 'old_password')
		visit sign_in_path
		click_link 'Forgot Password?'
		fill_in 'Email Address', with: jim.email
		click_button 'Send Email'

		open_email(jim.email)
		current_email.click_link('Reset My Password')

		fill_in 'New Password', with: 'new_password'
		click_button 'Reset Password'

		fill_in 'Email Address', with: jim.email
		fill_in 'Password', with: 'new_password'
		click_button 'Sign in'
		expect(page).to have_content("Welcome, #{jim.full_name}")

		clear_email
	end
end