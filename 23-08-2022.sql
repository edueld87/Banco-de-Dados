create table tb_vendedor (codigo int, nome varchar(50) not null, endereco varchar(150) not null, comissao int not null, CONSTRAINT pk_vendedor PRIMARY KEY (codigo));
create table tb_cliente (num_codigo int, nomecliente varchar(50) not null, endcliente varchar(150) not null, fatacumulado float not null, limCredito int, num_cod_vendedor int, CONSTRAINT pk_cliente PRIMARY KEY (num_codigo), CONSTRAINT fk_cliente foreign KEY (num_cod_vendedor) references tb_vendedor(codigo));
create table tb_armazem (cod_armazem int not null auto_increment primary key, endereco_arm varchar(100) not null);
create table tb_peca  (codigo_peca int not null auto_increment primary key, descricao varchar(50) not null, preco float not null, quantidade int not null, cod_armazem int not null, constraint fk_peca foreign key(cod_armazem) references tb_armazem(cod_armazem));

create table tb_pedido (codigo_pedido int not null auto_increment primary key, dt_pedido datetime, 
cod_cliente int not null, cod_vendedor int not null, 
cod_peca int not null, CONSTRAINT fk_pedidoc foreign key(cod_cliente) references tb_cliente(num_codigo),
constraint fk_pedidov foreign key(cod_vendedor) references tb_vendedor(codigo),
constraint fk_pedidop foreign key(cod_peca) references tb_peca(codigo_peca));

create table tb_item (cod_item int auto_increment primary key, cod_pedido int not null, cod_peca int not null,
    qtde int not null, 
    constraint fk_itempedido foreign key (cod_pedido) references tb_pedido(codigo_pedido),
    constraint fk_itempeca foreign key (cod_peca) references tb_peca(codigo_peca));
    
    insert into tb_vendedor(codigo, nome, endereco, comissao)
    values(3,"joana", "rua flor", 25);
    
    insert into tb_cliente(num_codigo, nomecliente, endcliente, fatacumulado, limCredito, num_cod_vendedor)
    values(2,"Bianca" , "rua uruguai", 230, 600, 12345);
    
    insert into tb_armazem(cod_armazem, endereco_arm)
    values(1, "rua guaramirim");
    
    insert into tb_peca(codigo_peca, descricao, preco, quantidade, cod_armazem)
    values(3, "fusivel", 3, 75, 1);
    
    insert into tb_pedido(codigo_pedido, dt_pedido, cod_cliente, cod_vendedor, cod_peca)
    values(2, "20220821", 2, 12, 2);
    
    insert into tb_item(cod_item, cod_pedido, cod_peca, qtde)
    values(2, 2, 2, 35);
    
    Alter table tb_vendedor change auto_increment codigo int;
    
    describe tb_peca
    
    select * from tb_item
    

-- exercicioSQL:

CREATE TABLE TB_NOTAFISCAL(ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,ID_NF INT NOT NULL, 
ID_ITEM INT NOT NULL, COD_PROD INT NOT NULL, VALOR_UNIT DECIMAL NOT NULL, 
QUANTIDADE INT NOT NULL, DESCONTO INT);

INSERT INTO tb_notafiscal(ID_NF,ID_ITEM,COD_PROD,VALOR_UNIT,QUANTIDADE,DESCONTO)
 values(1,1,1,25,10,5);
 
 INSERT INTO tb_notafiscal(ID_NF,ID_ITEM,COD_PROD,VALOR_UNIT,QUANTIDADE,DESCONTO)
 values(1,2,2,14,3,null);
 
 INSERT INTO tb_notafiscal(ID_NF,ID_ITEM,COD_PROD,VALOR_UNIT,QUANTIDADE,DESCONTO)
 values(1,3,3,15,2,null);
 
 INSERT INTO tb_notafiscal(ID_NF,ID_ITEM,COD_PROD,VALOR_UNIT,QUANTIDADE,DESCONTO)
 values(1,4,4,10,1,null);
 
 INSERT INTO tb_notafiscal(ID_NF,ID_ITEM,COD_PROD,VALOR_UNIT,QUANTIDADE,DESCONTO)
 values(1,5,5,30,1,null);
 
 INSERT INTO tb_notafiscal(ID_NF,ID_ITEM,COD_PROD,VALOR_UNIT,QUANTIDADE,DESCONTO)
 values(4,1,5,30,10,15);
 
 INSERT INTO tb_notafiscal(ID_NF,ID_ITEM,COD_PROD,VALOR_UNIT,QUANTIDADE,DESCONTO)
 values(4,3,1,25,13,5);
 
 describe tb_notafiscal
 
 select * from tb_notafiscal

-- a)
select n.ID_NF, n.ID_ITEM, n.COD_PROD, n.VALOR_UNIT from tb_notafiscal n
where n.DESCONTO IS NULL
-- b)
select  n.ID_NF, n.ID_ITEM, n.COD_PROD, n.VALOR_UNIT, (VALOR_UNIT - (VALOR_UNIT*(DESCONTO/100))) as Valor_Vendido from tb_notafiscal n
where n.DESCONTO IS NOT NULL
-- c)
 update tb_notafiscal set tb_notafiscal.DESCONTO = 0 where tb_notafiscal.DESCONTO is null;
 
 -- d)
select  n.ID_NF, n.ID_ITEM, n.COD_PROD, n.VALOR_UNIT, n.DESCONTO, (QUANTIDADE * VALOR_UNIT) 
as Valor_Total, (VALOR_UNIT - (VALOR_UNIT*(DESCONTO/100))) as Valor_Vendido from tb_notafiscal n;

-- e)
select  n.ID_NF, SUM(QUANTIDADE * VALOR_UNIT) as Valor_Total from tb_notafiscal n 
GROUP BY n.ID_NF ORDER BY Valor_Total DESC;

-- f)
select n.ID_NF, SUM(QUANTIDADE * VALOR_UNIT) as Valor_Total, SUM(VALOR_UNIT - (VALOR_UNIT*(DESCONTO/100)))
as Valor_Vendido from tb_notafiscal n
GROUP BY n.ID_NF ORDER BY Valor_Vendido DESC;

-- g)
select n.COD_PROD, MAX(n.QUANTIDADE) from tb_notafiscal n GROUP BY n.COD_PROD;

-- h)
select n.ID_NF, n.COD_PROD, n.QUANTIDADE from tb_notafiscal n WHERE (n.QUANTIDADE > 10) 
GROUP BY n.ID_NF, n.COD_PROD;

-- i)
select n.ID_NF, SUM(QUANTIDADE * VALOR_UNIT) as Valor_Total from tb_notafiscal n 
GROUP BY n.ID_NF having Valor_Total > 500  ORDER BY Valor_Total DESC;

-- j)
select n.COD_PROD, AVG(n.DESCONTO) as MEDIA from tb_notafiscal n WHERE (n.DESCONTO > 0) 
GROUP BY n.COD_PROD;
    
-- k)
select n.COD_PROD, MIN(n.DESCONTO) as MENOR, MAX(n.DESCONTO) as MAIOR, AVG(n.DESCONTO) as MEDIA
from tb_notafiscal n WHERE (n.DESCONTO > 0) GROUP BY n.COD_PROD;

-- l)
select n.ID_NF, count(n.ID_ITEM) as QTD_ITENS from tb_notafiscal n GROUP BY n.ID_NF having QTD_ITENS > 3;
