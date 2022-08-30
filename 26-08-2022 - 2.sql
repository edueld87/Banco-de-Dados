-- EXERCÍCIOS DE SQL (JUNÇÕES):

alter table tb_pedido drop constraint fk_pedidov;
alter table tb_pedido drop column cod_vendedor;

-- Implemente as consultas abaixo considerando o Schema de tabelas da
-- questão 3 da lista de exercícios MER-RELACIONAL. Realizar a junção
-- SOMENTE com os comandos INNER JOIN, LEFT OUTER JOIN ou RIGHT OUTER JOIN.

-- a) Listar os nomes e cpfs dos clientes , seguido do nome do vendedor que atendeu. (pode substituir cpf por endereco)

select n.nomecliente, n.endcliente, a.codigo, a.nome from tb_cliente n, tb_vendedor a where n.num_cod_vendedor = a.codigo;

-- b) Listar os nomes dos clientes, seguido do código do seu pedido, ordenados por nome e posteriormente por codigo.

select n.nomecliente, a.codigo_pedido from tb_cliente n, tb_pedido a where n.num_codigo = a.cod_cliente 
ORDER BY n.nomecliente, a.codigo_pedido;

-- c) Listar os Clientes do vendedor que começa com a letra b que fizeram pedidos
select n.nomecliente, n.num_cod_vendedor, a.nome from tb_cliente n, tb_vendedor a where n.num_cod_vendedor = a.codigo
ORDER BY n.nomecliente;

-- d) Listar os nomes dos Clientes que possuem mais de um pedido.
select c.nomecliente as NomeCliente from tb_pedido p join tb_cliente c on c.num_codigo = p.cod_cliente group by c.nomecliente
having count(p.cod_cliente) >= 2;

-- e) Listar os nomes dos Cliente seguido dos dados do pedido e os itens do pedido
select c.nomecliente, p.dt_pedido, i.cod_peca, i.qtde from tb_cliente c join tb_pedido p, tb_item i group by c.nomecliente;

-- f)  Listar todos os clientes que tenha feito pedidos com itens de peças na loja
-- do Zé. Mostrar no resultado Nome_Cliente, cpf_cliente, Nome_Vendedor, 
-- Data_pedido, qtde, Codigo_peça, Código_pedido, Nome_Peça, Preço_total, 
-- Armazem. Obs para preço total (quantidade de itens de peça * preço)

-- g) Cria uma view do exercício da letra f


 insert into tb_vendedor(codigo, nome, endereco, comissao)
 values(5,"Simone", "rua menos de 1%", 1);
    
 insert into tb_cliente(num_codigo, nomecliente, endcliente, fatacumulado, limCredito, num_cod_vendedor)
 values(4,"Jorge" , "rua chile", 150, 400, 5);
    
 insert into tb_peca(codigo_peca, descricao, preco, quantidade, cod_armazem)
 values(4, "Fio", 5, 100, 1);
    
 insert into tb_pedido(codigo_pedido, dt_pedido, cod_cliente, cod_peca)
 values(6, "20220824", 2, 1);

