# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

=begin
manager		child
	1		4,5
	2		3
	3		2
	4		1
=end

managers = [
	[ "teste", "teste", "teste@teste.com", "918273662", "987654321", "Porto"],#1
	[ "joana", "joana44", "joanamae@gmail.com", "965783662", "987654321", "Lisboa"],#2
	[ "nelson", "nelson36", "nelsonpai@hotmail.com", "916983642", "987654321", "Aveiro"],#3
	[ "ana", "ana38", "ana@hotmail.com", "916987153", "987654321", "Guimaraes"],#4
	#[ "filipe", "filipe_ms", "filipe_ms@gmail.com", "939163534", "987654321", "Guimaraes"]
]

children = [
	[ "childteste", "childteste", "childteste@teste.com", "938273662", "987654321", "Porto"],
	[ "joao", "joazinho", "joaozinho@gmail.com", "925783662", "987654321", "Lisboa"],
	[ "rui", "ruizinho10", "ruizinho10@hotmail.com", "936983642", "987654321", "Aveiro"],
	[ "maria", "maria9", "maria9@hotmail.com", "966987153", "987654321", "Guimaraes"],
	[ "diana", "diana12", "diana_js@gmail.com", "919163534", "987654321", "Guimaraes"]
]

managers.each do |name,nick,email,telef,pass,cidade|

		Manager.create([{ :account_attributes => {
												:name => name,
												:nickname => nick,
												:email => email,
												:birthday => Date.parse(Time.now.to_s)-rand(20..40).years,
												:phone => telef,
												:address => cidade,
												:password => pass,
												:password_confirmation => pass,
												:uid => email,
												:provider => 'email'
												}}])
	
end

i = 4
children.each do |name,nick,email,telef,pass,cidade|

			Child.create([{ :account_attributes => {
												:name => name,
												:nickname => nick,
												:email => email,
												:birthday => Date.parse(Time.now.to_s)-rand(10..50).years,
												:phone => telef,
												:address => cidade,
												:password => pass,
												:password_confirmation => pass,
												:uid => email,
												:provider => 'email'
												},
												:manager_id => i
												}])
			
			if i > 1
				i -= 1
			end
end