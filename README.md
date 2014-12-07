ywallet-backend
===============

Testes:

REGISTO:
curl -H "Content-Type: application/json" -X POST -d '{"manager":{"account_attributes":{"uid":"teste@teste.com","provider":"email", "name":"teste", "email":"teste@teste.com", "password":"987654321", "password_confirmation":"987654321"}}}' http://localhost:3000/managers.json

LOGIN:
curl -H "Content-Type: application/json" -X POST -d '{"email":"teste@teste.com", "password":"987654321"}' http://localhost:3000/auth/sign_in.json