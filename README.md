# DIO - Projeto Lógico de Banco de Dados (Oficina Mecânica)

## 📁 Descrição do Desafio
Criar um esquema conceitual do zero. 
Para este cenário será utilizado o esquema conceitual da Oficina Mecânica, criado no desafio do módulo de modelagem de BD com modelo ER, e a partir dele será criado um esquema lógico para o contexto de uma oficina. Neste desafio, deve-se definir todas as etapas, desde o esquema até a implementação do banco de dados.
Após a criação do esquema lógico, realize a criação do Script SQL para criação do esquema do banco de dados. 
Posteriormente, realize a persistência de dados para realização de testes.
Sendo assim, crie queries SQL com as cláusulas abaixo:
  - Recuperações simples com SELECT Statement.
  - Filtros com WHERE Statement.
  - Crie expressões para gerar atributos derivados.
  - Defina ordenações dos dados com ORDER BY.
  - Condições de filtros aos grupos – HAVING Statement.
  - Crie junções entre tabelas para fornecer uma perspectiva mais complexa dos dados.

## 🧩 Narrativa
- Sistema de controle e gerenciamento de execução de ordens de serviço em uma oficina mecânica.
- Clientes levam veículos à oficina mecânica para serem consertados ou para passarem por revisões periódicas.
- Cada veículo é designado a uma equipe de mecânicos que identifica os serviços a serem executados e preenche uma OS com data de entrega.
- A partir da OS, calcula-se o valor de cada serviço, consultando-se uma tabela de referência de mão-de-obra.
- O valor de cada peça também irá compor a OS.
- O cliente autoriza a execução dos serviços.
- A mesma equipe avalia e executa os serviços.
- Os mecânicos possuem código, nome, endereço e especialidade.
- Cada OS possui: número, data de emissão, um valor, status e uma data para conclusão dos trabalhos.
- Uma OS pode ser composta por diversos serviços e um mesmo serviço pode estar contido em mais de uma OS.
- Uma OS pode ter vários tipos de peça e uma peça pode estar presente em mais de uma OS.

## 🧠 Diretrizes
- Não há um mínimo de queries a serem realizadas.
- Os tópicos supracitados devem estar presentes nas queries.
- Elabore perguntas que podem ser respondidas pelas consultas.
- As cláusulas podem estar presentes em mais de uma query.
