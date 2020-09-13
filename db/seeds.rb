# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
if AdminUser.count == 0
  AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
end

if StateColor.count == 0 
  StateColor.create!([
    {name: 'Emerald green', color: '2dcd87'}, 
    {name: 'French Rose', color: 'ef608c'},
    {name: 'Coral pink', color: 'f98077'}, 
    {name: 'Soft Violet', color: 'b18cda'}])
end