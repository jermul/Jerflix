require 'spec_helper'

describe RelationshipsController do 
	describe "GET index" do
		it "sets @relationships to the current user's following relationships" do
			jim = Fabricate(:user)
			set_current_user(jim)
			bob = Fabricate(:user)
			relationship = Fabricate(:relationship, follower: jim, leader: bob)
			get :index
			expect(assigns(:relationships)).to eq([relationship])
		end

		it_behaves_like "requires sign in" do
			let(:action){ get :index }
		end
	end

	describe "DELETE destroy" do
		it_behaves_like "requires sign in" do
			let(:action) { delete :destroy, id: 4 }
		end

		it "redirects to the people page" do
			jim = Fabricate(:user)
			set_current_user(jim)
			bob = Fabricate(:user)
			relationship = Fabricate(:relationship, follower: jim, leader: bob)
			delete :destroy, id: relationship
			expect(response).to redirect_to people_path
		end

		it "deletes the relationship if the current user is the follower" do
			jim = Fabricate(:user)
			set_current_user(jim)
			bob = Fabricate(:user)
			relationship = Fabricate(:relationship, follower: jim, leader: bob)
			delete :destroy, id: relationship
			expect(Relationship.count).to eq(0)
		end

		it "does not delete the relationship if the current user is not the follower" do
			jim = Fabricate(:user)
			set_current_user(jim)
			bob = Fabricate(:user)
			joe = Fabricate(:user)
			relationship = Fabricate(:relationship, follower: joe, leader: bob)
			delete :destroy, id: relationship
			expect(Relationship.count).to eq(1)
		end
	end

	describe "POST create" do
		it_behaves_like "requires sign in" do
			let(:action) { post :create, leader_id: 3 }
		end

		it "redirects to the people page" do
			jim = Fabricate(:user)
			bob = Fabricate(:user)
			set_current_user(jim)
			post :create, leader_id: bob.id
			expect(response).to redirect_to people_path
		end

		it "creates a relationship that the current user follows the leader" do
			jim = Fabricate(:user)
			bob = Fabricate(:user)
			set_current_user(jim)
			post :create, leader_id: bob.id
			expect(jim.following_relationships.first.leader).to eq(bob)
		end

		it "does not create duplicate relationships" do
			jim = Fabricate(:user)
			bob = Fabricate(:user)
			set_current_user(jim)
			Fabricate(:relationship, leader: bob, follower: jim)
			post :create, leader_id: bob.id
			expect(Relationship.count).to eq(1)
		end

		it "does not allow users to follow themselves" do
			jim = Fabricate(:user)
			set_current_user(jim)
			post :create, leader_id: jim.id
			expect(Relationship.count).to eq(0)
		end
	end
end
