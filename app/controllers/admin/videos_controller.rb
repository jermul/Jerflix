class Admin::VideosController < ApplicationController
	before_filter :require_user
	before_filter :require_admin

	def new
		@video = Video.new
	end

	def create
		@video = Video.new(params[:video])
		if @video.save
			flash[:success] = "'#{@video.title}' has successfully been added to the video database."
			redirect_to new_admin_video_path
		else
			flash[:error] = "Please make sure your inputs are valid."
			render :new
		end
	end

	private

		def require_admin
			if !current_user.admin?
				flash[:error] = "You are not authorized to access that."
				redirect_to home_path
			end
		end
end