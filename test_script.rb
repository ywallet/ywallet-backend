#só funciona com uma BD limpa e com os dados do ficheiro seeds.rb
#system "rm db/development.sqlite3"
#system "exec rake db:migrate"
#system "exec rake db:seed"

while true

a = ["teste@teste.com", "joanaMae@gmail.com", "nelsonPai@hotmail.com", "ana@hotmail.com",
	"childteste@teste.com", "joaozinho@gmail.com", "ruizinho10@hotmail.com", "maria9@hotmail.com",
	"diana_js@gmail.com"]

puts "PAIS";
a.each_with_index do |x,i|

	if i == 4
		puts "CRIANÇAS"
	end
	puts (i+1).to_s << " " << x
end

puts "Com que utilizador se quer autenticar?"
opcao = gets.chomp

if opcao.to_i < 5
	system "curl -D- -H \"Content-Type: application/json\" -X POST -d '{\"email\":\""+a[opcao.to_i-1]+"\", \"password\":\"987654321\"}' http://localhost:3000/auth/sign_in.json > log.txt"
else
	system "curl -D- -H \"Content-Type: application/json\" -X POST -d '{\"email\":\""+a[opcao.to_i-1]+"\", \"password\":\"987654321\"}' http://localhost:3000/auth/sign_in.json > log.txt"
end

token = ""
client = ""
expiry = ""
uid = ""

IO.foreach('log.txt') do |line|
	if line =~ /^Access-Token: /
		token = line.split(' ')[line.split(' ').length-1]
	end
	if line =~ /^Client: /
		client = line.split(' ')[line.split(' ').length-1]
	end
	if line =~ /^Expiry: /
		expiry = line.split(' ')[line.split(' ').length-1]
	end
	if line =~ /^Uid: /
		uid = line.split(' ')[line.split(' ').length-1]
	end
end

puts "recurso?"
puts "1. manager"
puts "2. children"
puts "3. rules"
puts "4. wallets"
puts "5. bitcoin account"
opcao = gets.chomp

recurso = "managers" if opcao.to_i == 1
recurso = "children" if opcao.to_i == 2
recurso = "rules" if opcao.to_i == 3
recurso = "wallets" if opcao.to_i == 4
recurso = "bitcoin_accounts" if opcao.to_i == 5


puts "metodo?"
puts "1. create"
puts "2. update"
puts "3. read"
puts "4. delete"
opcao = gets.chomp

metodo = "POST" if opcao.to_i == 1
metodo = "PUT" if opcao.to_i == 2
metodo = "GET" if opcao.to_i == 3
metodo = "DELETE" if opcao.to_i == 4

id = ""
if opcao.to_i.between?(2,4)
	puts "id?"
	aux = gets.chomp
	id = "/"+aux
end

data = ""
if opcao.to_i.between?(1,2)
	puts "data?"
	aux = gets.chomp
	data = "--data '"+aux+"'"
end

5.times{ puts "" }
	
	puts "curl -H \"Content-Type: application/json\" -H \"Access-Token: "+token+"\" -H \"Client: "+client+"\" -H \"Token-Type: Bearer\" -H \"Expiry: "+expiry+"\" -H \"Uid: "+uid+"\" -X "+metodo+" "+data+" http://localhost:3000/"+recurso+""+id
	system "curl -H \"Content-Type: application/json\" -H \"Access-Token: "+token+"\" -H \"Client: "+client+"\" -H \"Token-Type: Bearer\" -H \"Expiry: "+expiry+"\" -H \"Uid: "+uid+"\" -X "+metodo+" "+data+" http://localhost:3000/"+recurso+""+id+""" | json_reformat"

5.times{ puts "" }


end