require 'spec_helper'

describe User do
	it { should validate_presence_of(:email) }
	it { should validate_presence_of(:password) }
	it { should validate_presence_of(:full_name) }
	it { should validate_uniqueness_of(:email) }
	it { should have_many(:queue_items).order(:position) }
	it { should have_many(:reviews).order("created_at DESC") }

	it_behaves_like "tokenable" do
		let(:object) { Fabricate(:user) }
	end

	describe "#queued_video?" do
		it "returns true when the user queued the video" do
			user  = Fabricate(:user)
			video = Fabricate(:video)
			Fabricate(:queue_item, user: user, video: video)
			user.queued_video?(video).should be_true
		end

		it "returns false when the user hasn't queued the video" do
			user  = Fabricate(:user)
			video = Fabricate(:video)
			user.queued_video?(video).should be_false
		end
	end

	describe "#follows?" do
		it "returns true if the user has a following relationship with another user" do
			jim = Fabricate(:user)
			bob = Fabricate(:user)
			Fabricate(:relationship, leader: bob, follower: jim)
			expect(jim.follows?(bob)).to be_true
		end

		it "returns false if the user does not have a following relationship with another user" do
			jim = Fabricate(:user)
			bob = Fabricate(:user)
			Fabricate(:relationship, leader: jim, follower: bob)
			expect(jim.follows?(bob)).to be_false
		end
	end

	describe "#follow" do
		it "follows another user" do
			jim = Fabricate(:user)
			bob = Fabricate(:user)
			jim.follow(bob)
			expect(jim.follows?(bob)).to be_true
		end

		it "does not follow one self" do
			jim = Fabricate(:user)
			jim.follow(jim)
			expect(jim.follows?(jim)).to be_false
		end
	end
end