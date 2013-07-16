class InvitationsController < ApplicationController
	before_filter :require_user

	def new
		@invitation = Invitation.new
	end

	def create
		@invitation = Invitation.new(params[:invitation].merge!(inviter_id: current_user.id))
		if @invitation.save
			AppMailer.send_invitation_email(@invitation).deliver
			flash[:success] = "Your invitation to #{@invitation.recipient_name} has been sent!"
			redirect_to new_invitation_path
		else
			flash[:error] = "Please verify your inputs."
			render :new
		end
	end
end