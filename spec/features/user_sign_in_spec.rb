require 'spec_helper'

feature "user signs in" do 
	scenario "with valid email and password" do
		jim = Fabricate(:user)
		sign_in(jim)
		page.should have_content jim.full_name
	end
end