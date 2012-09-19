# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Role.delete_all
Role.create(:user_role => "admin")
Role.create(:user_role => "user")

User.delete_all
User.create(:first_name => "admin", :last_name => "admin", :email => "admin@postpress.com", :pwd => "admin", :phone => "9199199191", :Role_id => 1)
User.create(:first_name => "bill", :last_name => "mike", :email => "bill.mike@postpress.com", :pwd => "billmike", :phone => "9199191111", :Role_id => 2)

Category.delete_all
Category.create(:name => "C program", :description => "This post contains discussion about C programming")
Category.create(:name => "Java program", :description => "This post contains discussion about Java programming")
