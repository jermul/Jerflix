class RelationshipsController < ApplicationController
	before_filter :require_user
	
	def index
		@relationships = current_user.following_relationships
	end

	def destroy
		relationship = Relationship.find(params[:id])
		if relationship.follower == current_user
			relationship.destroy
			flash[:success] = "You are no longer following that user."
			redirect_to people_path
		else
			flash[:error] = "You are not authorized to do that."
			redirect_to people_path
		end
	end

	def create
		leader = User.find(params[:leader_id])
		Relationship.create(leader_id: params[:leader_id], follower: current_user) if current_user.can_follow?(leader)
		redirect_to people_path
	end
end