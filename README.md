ywallet-backend
===============


Testes
------


Registo Pais:
- Request: curl -H "Content-Type: application/json" -X POST -d '{"manager": {"account_attributes": {"name":"teste", "email":"teste@teste.com", "password":"987654321", "password_confirmation":"987654321"}}}' http://localhost:3000/managers.json
- Response: {"id":1, "created_at":"2014-12-09T12:55:03.974Z", "updated_at":"2014-12-09T12:55:03.974Z"}

Login Pais:
- Request: curl -H "Content-Type: application/json" -X POST -d '{"email":"teste@teste.com", "password":"987654321"}' http://localhost:3000/auth/sign_in.json
- Response: {"data": {"id":1, "provider":"email", "uid":"teste@teste.com", "name":"teste", "nickname":null, "image":null, "email":"teste@teste.com", "manager_id":1, "child_id":null, "address":null, "phone":null, "birthday":null}}


Registo Filhos:
- Request: curl -H "Content-Type: application/json" -X POST -d '{"child": {"manager_id":3, "account_attributes": {"name":"childteste", "email":"childteste@teste.com", "password":"987654321", "password_confirmation":"987654321"}}}' http://localhost:3000/children.json
- Response: {"id":1, "manager_id":3, "created_at":"2014-12-09T13:10:49.838Z", "updated_at":"2014-12-09T13:10:49.838Z"}

Login Filhos:
- Request: curl -H "Content-Type: application/json" -X POST -d '{"email":"childteste@teste.com", "password":"987654321"}' http://localhost:3000/auth/sign_in.json
- Response: {"data":{"id":4, "provider":"email", "uid":"childteste@teste.com", "name":"childteste", "nickname":null, "image":null, "email":"childteste@teste.com", "manager_id":null, "child_id":1, "address":null, "phone":null, "birthday":null}}
