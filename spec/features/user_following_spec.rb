require 'spec_helper'

feature "User following" do
	scenario "user follows and unfollows someone" do

		jim 			= Fabricate(:user)
		video  		= Fabricate(:video)
		category 	= Fabricate(:category)
		
		VideoCategory.create(video: video, category: category)
		Fabricate(:review, user: jim, video: video)

		sign_in
		click_on_video_on_home_page(video)

		click_link jim.full_name
		click_link "Follow"
		expect(page).to have_content(jim.full_name)

		unfollow(jim)
		expect(page).not_to have_content(jim.full_name)
	end

	def unfollow(user)
		find("a[data-method='delete']").click
	end
end