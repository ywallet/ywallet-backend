ywallet-backend
===============


REGISTO E LOGIN
===============

Registo Pais:
- Request: curl -D- -H "Content-Type: application/json" -X POST -d '{"manager": {"account_attributes": {"name":"teste", "email":"teste@teste.com", "password":"987654321", "password_confirmation":"987654321", "uid":"teste@teste.com"}}}' http://localhost:3000/managers.json
- Response: {"id":1, "created_at":"2014-12-09T12:55:03.974Z", "updated_at":"2014-12-09T12:55:03.974Z"}

Login Pais:
- Request: curl -D- -H "Content-Type: application/json" -X POST -d '{"email":"teste@teste.com", "password":"987654321"}' http://localhost:3000/auth/sign_in.json
- Response: {"data": {"id":1, "provider":"email", "uid":"teste@teste.com", "name":"teste", "nickname":null, "image":null, "email":"teste@teste.com", "manager_id":1, "child_id":null, "address":null, "phone":null, "birthday":null}}


Registo Filhos:
- Request: curl -D- -H "Content-Type: application/json" -X POST -d '{"child": {"manager_id":3, "account_attributes": {"name":"childteste", "email":"childteste@teste.com", "password":"987654321", "password_confirmation":"987654321", "uid":"childteste@teste.com"}}}' http://localhost:3000/children.json
- Response: {"id":1, "manager_id":3, "created_at":"2014-12-09T13:10:49.838Z", "updated_at":"2014-12-09T13:10:49.838Z"}

Login Filhos:
- Request: curl -D- -H "Content-Type: application/json" -X POST -d '{"email":"childteste@teste.com", "password":"987654321"}' http://localhost:3000/auth/sign_in.json
- Response: {"data":{"id":4, "provider":"email", "uid":"childteste@teste.com", "name":"childteste", "nickname":null, "image":null, "email":"childteste@teste.com", "manager_id":null, "child_id":1, "address":null, "phone":null, "birthday":null}}

O QUE PODEM FAZER COMO MANAGER:
===============================
(Não esquecer que em cada pedido é necessário indicar o Access-Token, Client, Token-Type, Expiry e Uid)

Consultar Manager:
- curl -D- -H "Content-Type: application/json" -H "Access-Token: x" -H "Client: x" -H "Token-Type: Bearer" -H "Expiry: x" -H "Uid: x" http://localhost:3000/managers/1.json

Editar Manager:
- curl -D- -H "Content-Type: application/json" -H "Access-Token: x" -H "Client: x" -H "Token-Type: Bearer" -H "Expiry: x" -H "Uid: x" -X PUT -d '{"manager": {"account_attributes": {"nickname":"nicktest1", "address":"Lisboa1"}}}' http://localhost:3000/managers/1.json

	Repostas:

	- Sucesso (no caso de editar, os campos alterados aparecem alterados)
		{
		    "id": 1,
		    "name": "teste",
		    "nickname": "nicktest1",
		    "email": "teste@teste.com",
		    "birthday": "1980-12-23",
		    "phone": "918273662",
		    "address": "Lisboa1",
		    "account_id": 1,
		    "childrens_wallets": {
		        "4": 8,
		        "5": 9
		    }
		}

	- Insucesso
		{
		    "errors": "You can't access this manager"
		}

Consultar Criança:
- curl -D- -H "Content-Type: application/json" -H "Access-Token: x" -H "Client: x" -H "Token-Type: Bearer" -H "Expiry: x" -H "Uid: x" http://localhost:3000/children/4.json

Editar Criança:
- curl -D- -H "Content-Type: application/json" -H "Access-Token: x" -H "Client: x" -H "Token-Type: Bearer" -H "Expiry: x" -H "Uid: x" -X PUT -d '{"child": {"account_attributes": {"nickname":"nicktest1", "address":"Lisboa1"}}}' http://localhost:3000/children/4.json

	Repostas:

	- Sucesso (no caso de editar, os campos alterados aparecem alterados)
		    "id": 4,
		    "name": "maria",
		    "nickname": "maria9",
		    "email": "maria9@hotmail.com",
		    "birthday": "1981-12-23",
		    "phone": "966987153",
		    "address": "Guimaraes",
		    "account_id": 8,
		    "wallet_id": 8,
		    "manager_id": 1
		}

	- Insucesso
		{
	    "errors": "You can't access this child"
		}

Consultar Wallet da Criança:
- curl -D- -H "Content-Type: application/json" -H "Access-Token: x" -H "Client: x" -H "Token-Type: Bearer" -H "Expiry: x" -H "Uid: x" http://localhost:3000/wallets/9.json

	Repostas:

	- Sucesso
		{
		    "id": 9,
		    "balance": 0,
		    "account_id": 9,
		    "rule_ids": [

		    ]
		}

	- Insucesso
		{
	    "errors": "You can't access this wallet"
		}

Adicionar Regra:

- curl -D- -H "Content-Type: application/json" -H "Access-Token: x" -H "Client: x" -H "Token-Type: Bearer" -H "Expiry: x" -H "Uid: x" -X POST -d '{"rule": {"active":"false","notifies":"false","wallet_id":8}}' http://localhost:3000/rules.json

Consultar Regra:

- curl -D- -H "Content-Type: application/json" -H "Access-Token: x" -H "Client: x" -H "Token-Type: Bearer" -H "Expiry: x" -H "Uid: x" -X GET http://localhost:3000/rules/2

Modificar Regra:

- curl -D- -H "Content-Type: application/json" -H "Access-Token: x" -H "Client: x" -H "Token-Type: Bearer" -H "Expiry: x" -H "Uid: x" -X PUT -d '{"rule": {"active":"true"}}' http://localhost:3000/rules/10

Apagar Regra:

- curl -D- -H "Content-Type: application/json" -H "Access-Token: x" -H "Client: x" -H "Token-Type: Bearer" -H "Expiry: x" -H "Uid: x" -X DELETE http://localhost:3000/rules/4


O QUE PODEM FAZER COMO CHILD:
===============================
TO DO




API SUBDOMAIN:
===============================

Foi adicionado o subdominio api.ywallet[...] para se fazer pedidos à api.
Para testar isto no localhost é necessário instalar o prax ou o pow (linux e mac respectivamente) e podem ver como fazê-lo aqui: http://apionrails.icalialabs.com/book/chapter_one#sec-pow_prax

Depois para testar é fazer os testes de cima mas com a seguinte alteração:

Registo Pais:
- Request: curl -H "Content-Type: application/json" -X POST -d '{"manager": {"account_attributes": {"name":"teste", "email":"teste@teste.com", "password":"987654321", "password_confirmation":"987654321"}}}' api.[nome\_do\_projecto].dev:3000/managers.json

Para já ainda só está commited para um branch, depois faz-se merge.