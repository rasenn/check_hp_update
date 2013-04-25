# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

CheckHistory.delete_all
Url.delete_all
User.delete_all

user = User.create(:email => "admin@example.com" , :password => "adminadmin" )
user.add_url("http://galaxyheavyblow.web.fc2.com/")
user.add_url("http://niitosyayou.sitemix.jp/")


user2 = User.create(:email => "example@example.com" , :password => "example")
user2.add_url("http://galaxyheavyblow.web.fc2.com/")
