class Category < ActiveRecord::Base
	has_many :video_categories
	has_many :videos, through: :video_categories, order: :title

	validates_presence_of :name
end