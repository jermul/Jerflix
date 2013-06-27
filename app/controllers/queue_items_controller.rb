class QueueItemsController < ApplicationController
	before_filter :require_user
	
	def index
		@queue_items = current_user.queue_items
	end

	def create
		video = Video.find(params[:video_id])
		queue_video(video)
		redirect_to my_queue_path 
	end

	def destroy
		queue_item = QueueItem.find(params[:id])
		queue_item.destroy if current_user.queue_items.include?(queue_item)
		redirect_to my_queue_path
	end

	private

		def queue_video(video)
			if current_user_queued_video?(video)
				flash[:error] = "This video is already in your queue."
			else
			QueueItem.create(video: video, user: current_user, position: new_queue_item_position) 
			end
		end

		def new_queue_item_position
			current_user.queue_items.count + 1
		end

		def current_user_queued_video?(video)
			current_user.queue_items.map(&:video).include?(video)
		end
end	