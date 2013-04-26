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
user.add_url("http://www.h7.dion.ne.jp/~n_circus/index.html")
user.add_url("http://cba5.boo.jp/")
user.add_url("http://www.gahako.com/WORKING!!2.htm")
user.add_url("http://komigami.haru.gs/comic.html")
user.add_url("http://enokix.web.fc2.com/comic.html")
user.add_url("http://haijin.blog7.fc2.com/blog-category-47.html")
user.add_url("http://naclhpa.dousetsu.com/")
user.add_url("http://www.geocities.jp/studioyahhoy02/")
user.add_url("http://vous.moo.jp/f/")
user.add_url("http://www.ne.jp/asahi/molmol/sky/")
user.add_url("http://sasanohaan.web.fc2.com/mousou/frame-m.html")
user.add_url("http://ryama.zatunen.com/")
user.add_url("http://www.taikaisyu.com/")
user.add_url("http://mitarashimanga.sarashi.com/")


user2 = User.create(:email => "example@example.com" , :password => "example")
user2.add_url("http://galaxyheavyblow.web.fc2.com/")
