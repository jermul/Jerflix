class Video < ActiveRecord::Base
	has_many :video_categories
	has_many :categories, through: :video_categories, order: :name
	has_many :reviews, order: "created_at DESC"

	mount_uploader :large_cover, LargeCoverUploader
	mount_uploader :small_cover, SmallCoverUploader

	validates_presence_of :title, :description

	def self.search_by_title(search_term)
    return [] if search_term.blank?
    where('title LIKE ?', "%#{search_term}%").order('created_at DESC')
	end

  def rating
    reviews.average(:rating).round(1) if reviews.average(:rating)
  end
end