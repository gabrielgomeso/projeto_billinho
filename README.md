# PROJETO BILLINHO

<h3 align="center">  
  <a href="#sobre">Sobre</a> |
  <a href="#tecnologias">Tecnologias</a> | 
  <a href="#instruções">Instruções</a> | 
  <a href="#rotas">Rotas</a>
</h3>

## Sobre

<p align="justify">O Billinho é um projeto realizado no início do estágio em Web Ops pela Quero Educação. Sua intenção é recriar, em menor escala, a API do produto Quero Pago, uma ferramenta para gerenciar o pagamento das mensalidades de cursos de graduação, facilitando a administração dessa área para as instituições de ensino e para os alunos.</p>

## Tecnologias

As tecnologias e ferramentas utilizadas nesse projeto foram:
- Ruby versão 2.7.2p137
- Rails versão 6.0.3.4
- Postman
- PostgreSQL

O projeto foi realizado com base no tutorial "Criando API REST com Rails 5" de Vicente Correia https://bit.ly/2Ml0in9
A estrutura do projeto, suas entidades e seus requisitos, foi criado pelo time do Quero Pago.

## Instruções

Após instalar corretamente todas as depedências, dê um fork e clone o projeto em seu ambiente local. Na pasta do projeto, rode:

<code> bundle install </code>

Em seguida, para criar as migrations e estabilizar o banco de dados:

<code> rails db:migrate </code>

E então, para que a API rode:

<code> rails server </code>

## Rotas

<table>
	<caption>Rotas da Aplicação</caption>
	<thead>
	<tr>
		<th>Model</th>
		<th>Método</th>
		<th>Rota</th>
		<th>Função</th>
	</tr>
	</thead>
	<tbody>
	<tr>
		<td>Instituição</td>
		<td>GET</td>
		<td>/api/v1/institutions</td>
		<td>Vizualizar todas as instituições</td>
	</tr>
	<tr>
		<td>Instituição</td>
		<td>GET</td>
		<td>/api/v1/institutions/2</td>
		<td>Vizualizar instituição por ID</td>
	</tr>
	<tr>
		<td>Instituição</td>
		<td>POST</td>
		<td>/api/v1/institutions</td>
		<td>Adicionar instituição</td>
	</tr>
	<tr>
		<td>Instituição</td>
		<td>DELETE</td>
		<td>/api/v1/institutions/52</td>
		<td>Excluir instituição por ID</td>
	</tr>
	<tr>
		<td>Instituição</td>
		<td>PUT</td>
		<td>/api/v1/institutions/51</td>
		<td>Atualizar instituição</td>
	</tr>
	<tr>
		<td>Estudante</td>
		<td>GET</td>
		<td>/api/v1/students</td>
		<td>Vizualizar todos os estudantes</td>
	</tr>
	<tr>
		<td>Estudante</td>
		<td>GET</td>
		<td>/api/v1/students/2</td>
		<td>Vizualizar estudante por ID</td>
	</tr>
	<tr>
		<td>Estudante</td>
		<td>POST</td>
		<td>/api/v1/students</td>
		<td>Adicionar estudante</td>
	</tr>
	<tr>
		<td>Estudante</td>
		<td>DELETE</td>
		<td>/api/v1/students/52</td>
		<td>Excluir estudante por ID</td>
	</tr>
	<tr>
		<td>Estudante</td>
		<td>PUT</td>
		<td>/api/v1/students/51</td>
		<td>Atualizar estudante</td>
	</tr>
	<tr>
		<td>Matrícula</td>
		<td>GET</td>
		<td>/api/v1/enrollments</td>
		<td>Vizualizar todas as matrículas</td>
	</tr>
	<tr>
		<td>Matrícula</td>
		<td>GET</td>
		<td>/api/v1/enrollments/2</td>
		<td>Vizualizar matrícula por ID</td>
	</tr>
	<tr>
		<td>Matrícula</td>
		<td>POST</td>
		<td>/api/v1/enrollments</td>
		<td>Adicionar matrícula</td>
	</tr>
	<tr>
		<td>Matrícula</td>
		<td>DELETE</td>
		<td>/api/v1/enrollments/52</td>
		<td>Excluir matrícula por ID</td>
	</tr>
	<tr>
		<td>Matrícula</td>
		<td>PUT</td>
		<td>/api/v1/enrollments/51</td>
		<td>Atualizar matrícula</td>
	</tr>
	<tr>
		<td>Fatura</td>
		<td>GET</td>
		<td>/api/v1/bills</td>
		<td>Vizualizar todas as faturas</td>
	</tr>
	<tr>
		<td>Fatura</td>
		<td>GET</td>
		<td>/api/v1/bills/2</td>
		<td>Vizualizar fatura por ID</td>
	</tr>
	<tr>
		<td>Fatura</td>
		<td>POST</td>
		<td>/api/v1/bills</td>
		<td>Adicionar fatura</td>
	</tr>
	<tr>
		<td>Fatura</td>
		<td>DELETE</td>
		<td>/api/v1/bills/52</td>
		<td>Excluir fatura por ID</td>
	</tr>
	<tr>
		<td>Fatura</td>
		<td>PUT</td>
		<td>/api/v1/bills/51</td>
		<td>Atualizar fatura</td>
	</tr>
	<tbody>
</table>
