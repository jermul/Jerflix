require 'spec_helper'

feature "User interacts with the queue" do 
	scenario "user adds and reorders videos in the queue" do

		comedies = Fabricate(:category)
		monk = Fabricate(:video, title: "Monk")
		south_park = Fabricate(:video, title: "South Park")
		futurama = Fabricate(:video, title: "Futurama")
		VideoCategory.create(video: monk, category: comedies)
		VideoCategory.create(video: south_park, category: comedies)
		VideoCategory.create(video: futurama, category: comedies)

		sign_in

		add_video_to_queue(monk)
		expect_video_to_be_in_queue(monk)

		visit video_path(monk)
		expect_link_not_to_be_seen("+ My Queue")

		add_video_to_queue(futurama)
		add_video_to_queue(south_park)

		set_video_position(south_park, 1)
		set_video_position(futurama, 2)
		set_video_position(monk, 3)
		update_queue

		expect_video_position(south_park, 1)
		expect_video_position(futurama, 2)
		expect_video_position(monk, 3)
	end

	def expect_video_to_be_in_queue(video)
		page.should have_content(video.title)
	end

	def expect_link_not_to_be_seen(link_text)
		page.should_not have_content (link_text)
	end

	def add_video_to_queue(video)
		visit home_path
		click_on_video_on_home_page(video)
		click_link "+ My Queue"
	end

	def update_queue
		click_button "Update Instant Queue"
	end

	def set_video_position(video, position)
		within(:xpath, "//tr[contains(.,'#{video.title}')]") do
			fill_in "queue_items[][position]", with: position
		end
	end

	def expect_video_position(video, position)
		expect(find(:xpath, "//tr[contains(.,'#{video.title}')]//input[@type='text']").value).to eq(position.to_s)
	end
end