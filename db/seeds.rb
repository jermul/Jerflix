# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Video.create(title: "Monk", small_cover_url: "monk.jpg", large_cover_url: "monk_large.jpg", description: "Lorem Ipsum for Monk")
Video.create(title: "Family Guy", small_cover_url: "family_guy.jpg", large_cover_url: "family_guy.jpg", description: "Lorem Ipsum for Family Guy")
Video.create(title: "Futurama", small_cover_url: "futurama.jpg", large_cover_url: "futurama.jpg", description: "Lorem Ipsum for Futurama")
Video.create(title: "South Park", small_cover_url: "south_park.jpg", large_cover_url: "south_park.jpg", description: "Lorem Ipsum for South Park")
