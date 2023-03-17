# Quake Parser

Desafio 'Quake Parser' desenvolvido para residência.<br>
---
<b>Foi utilizado:</b><br>
Ruby 3.1.3p185 (2022-11-24 revision 1a6b16756e).<br>
Sinatra 3.0.5 gem.<br>

# Solução Proposta
Console:.<br>
  Imprimir as informações em formato JSON como relatório no console.<br>
  Imprimir um relatório simplificado da partida.<br>
  Imprimir o Ranking geral de kills dos players.<br>

Arquivo:.<br>
  Criar um arquivo date.json com as informações extraídas do games.log.<br>

Site:.<br>
  A construção de uma API(quake_parser/api) que busca pelos dados do (date.json) presentes localmente(quake_parser/src) e retorna as informações da partida de acordo com o seu ID<br>

# Rodando o desafio

<b>Requerimentos:</b> Ruby 3.1.3 | Sinatra 3.0.5
Caso o desafio não funcione em uma versão atualizada do Ruby, será necessário usar o gerenciador de versões do ruby(rbenv ou RVM)

## Instale o Sinatra
Inicialmente instale o Ruby na sua máquina de acordo com o seu Sistema Operacional, para prosseguir.
```console
quake_parser> gem install sinatra
```

## Verifique o local
Verifique se no seu terminal o desafio está localizado na pasta certa antes de rodar para evitar possíveis erros. Exemplo:
```console
B:\user\desktop\GitHub\quake_parser> cd src
B:\user\desktop\GitHub\quake_parser\src> cd view
```
```console
B:\user\desktop\GitHub\quake_parser> cd api
```

Inicialmente 
## Rode o desafio - TASK 1 | 2 | 3
1 e 2 - Terminal
```console
quake_parser\src\view> ruby main.rb
```
3 - Web
```console
quake_parser\api> ruby app.rb
```
Caso continue dando erro ao tentar rodar, instale a extensão "Code Runner" no VS Code.
Vá no mesmo local pelo terminal e rode a partir do Runner

## Para rodar a API e buscar as informações
Acesse o link: [http://localhost:4567](http://localhost:4567/)

Caso o Sinatra esteja dando erro ao tentar fazer a requisição, tente se localizar no terminal e use o Runner.

# Tasks
- Task 01 [x]
- Task 02 [x]
- Task 03 [x]