# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if User.count == 0
  User.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
end

#if StateColor.count == 0
#  StateColor.create!([
#                         {name: 'Emerald green', color: '2dcd87'},
#                         {name: 'French Rose', color: 'ef608c'},
#                         {name: 'Coral pink', color: 'f98077'},
#                         {name: 'Soft Violet', color: 'b18cda'}])
#end
#
#if Duration.count == 0
#  Duration.create!([{name: '1ч', minutes: '60'},
#                    {name: '1.5ч', minutes: '90'}])
#end
#
#if Format.count == 0
#  Format.create!([{name: 'Очно', online: false},
#                  {name: 'Онлайн', online: true},
#                  {name: 'Skype', online: true}])
#end