![alt text](https://i2.wp.com/i.imgur.com/Gc979LS.gif?w=640)
# PokéTrader-2

Revisitando esse desafio para melhorar minhas práticas. Foco é melhorar conceitos de teste, clean code e maneiras de antipattern.


## Introdução

Calculadora de troca de pokémons, mostrando se a troca entre dois times, de 1 até 6 pokémons, é justa ou não.

Para sua realização, foi utilizada a api do [PokéApi](https://pokeapi.co/) para obter os pokémons e seus valores.

### Backend

O backend tem o papel de alimentar o front com as informações da Api. Foi construído em Ruby on Rails, com SQLite como banco. Além disso, foi utilizado Rubocop para melhores práticas de escritas e Rspec para realizar testes unitários e de cobertura.

#### Como compilar

Para rodar o banco, basta entrar na pasta backend e rodar o seguinte comandos:


Caso queira deletar o banco, basta rodar o seguinte comando:


Para compilar o código, basta entrar na pasta backend e rodar os seguintes comandos:

### Frontend

O frontend tem o papel de obter as informações do backend e mostrar para o usuário
#### Como compilar

Para compilar o código, basta entrar na pasta frontend e rodar os seguintes comandos:
