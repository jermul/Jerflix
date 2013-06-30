# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

monk = Video.create(title: "Monk", small_cover_url: "monk.jpg", large_cover_url: "monk_large.jpg", description: "Lorem Ipsum for Monk")
Video.create(title: "Family Guy", small_cover_url: "family_guy.jpg", large_cover_url: "family_guy.jpg", description: "Lorem Ipsum for Family Guy")
Video.create(title: "Futurama", small_cover_url: "futurama.jpg", large_cover_url: "futurama.jpg", description: "Lorem Ipsum for Futurama")
Video.create(title: "South Park", small_cover_url: "south_park.jpg", large_cover_url: "south_park.jpg", description: "Lorem Ipsum for South Park")
Video.create(title: "Monk", small_cover_url: "monk.jpg", large_cover_url: "monk_large.jpg", description: "Lorem Ipsum for Monk")
Video.create(title: "Family Guy", small_cover_url: "family_guy.jpg", large_cover_url: "family_guy.jpg", description: "Lorem Ipsum for Family Guy")
Video.create(title: "Futurama", small_cover_url: "futurama.jpg", large_cover_url: "futurama.jpg", description: "Lorem Ipsum for Futurama")
Video.create(title: "South Park", small_cover_url: "south_park.jpg", large_cover_url: "south_park.jpg", description: "Lorem Ipsum for South Park")
Video.create(title: "South Park", small_cover_url: "south_park.jpg", large_cover_url: "south_park.jpg", description: "Lorem Ipsum for South Park")

Category.create(name: "TV Comedies")
Category.create(name: "TV Dramas")
Category.create(name: "Reality TV")

VideoCategory.create(video_id: 1, category_id: 2)
VideoCategory.create(video_id: 2, category_id: 1)
VideoCategory.create(video_id: 3, category_id: 1)
VideoCategory.create(video_id: 4, category_id: 1)
VideoCategory.create(video_id: 5, category_id: 2)
VideoCategory.create(video_id: 6, category_id: 1)
VideoCategory.create(video_id: 7, category_id: 1)
VideoCategory.create(video_id: 8, category_id: 1)
VideoCategory.create(video_id: 9, category_id: 1)

jim = User.create(full_name: 'Jim Jim', password: 'password', email: 'jim@example.com')
bob = User.create(full_name: 'Bob Bob', password: 'password', email: 'bob@example.com')

Review.create(user: jim, video: monk, rating: 4, content: "This is a really good movie!")
Review.create(user: jim, video: monk, rating: 2, content: "Not as good the second time around.")
