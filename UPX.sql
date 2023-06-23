drop database if exists PetshopAC2;
create database PetshopAC2;
use PetshopAC2;

create table cliente(
	CPF				varchar(20)			primary key,
	nome				varchar(60)
);

create table cliente_tel(
	id_cliente			varchar(20),
    	tel					varchar(45),
    
    	foreign key (id_cliente) references cliente(CPF)
);

create table cliente_end(
	id_cliente			varchar(20),
    	rua				varchar(30),
    	numero				int,
    	bairro				varchar(20),
    	cidade				varchar(20),
    
    	foreign key (id_cliente) references cliente(CPF)
);

create table pet(
	id				int				primary key auto_increment,
    	nome				varchar(45),
    	data_nasc			date,
    	raca				varchar(45),
    	cor				varchar(45),
    	peso				decimal(10,2),
	tipo				varchar(30)
);

create table fornecedor(
	id_fornecedor			int				primary key	auto_increment,
    	CNPJ				varchar(60),
	nome				varchar(45),
	site				varchar(60),
	forn_tel			varchar(45)
);

create table insumos(
	id_insumos			int					primary key auto_increment,
	nome				varchar(60),
	preco				decimal(10,2),
	peso				decimal(10,1),
	tipo				varchar(60),
	data_val			date,
	fornecedor			int,
    	quantidade			int,

	FOREIGN KEY (fornecedor) REFERENCES fornecedor(id_fornecedor)
);

create table cadastro(
	cliente_CPF			varchar(20),
    	pet_id				int,
    
    	foreign key (cliente_CPF) references cliente(CPF),
    	foreign key (pet_id) references pet(id)
);

create table compra(
	cadastro_cliente	varchar(20),
    	compra_insumos		int,
    	data_compra		date,
    
    	foreign key (cadastro_cliente) references cliente(CPF),
    	foreign key (compra_insumos) references insumos(id)
);

insert into cliente values ('12345678900', 'Naomi Rodrigues Teixeira');
insert into cliente values ('25436913598', 'Camily Evangelista Madeira');
insert into cliente values ('56379578523', 'Nicole Sajo');
insert into cliente values ('36945298712', 'Lucas Gabriel Antunes dos Santos');
insert into cliente values ('45213698752', 'Mateus Holtz Urias de Camargo');
insert into cliente values ('13652413500', 'Matheus Lessa dos Santos');

insert into cliente_tel values ('12345678900', '(15) 98852-7854');
insert into cliente_tel values ('25436913598', '(15) 98832-4136');
insert into cliente_tel values ('56379578523', '(21) 98869-9875');
insert into cliente_tel values ('36945298712', '(11) 98896-1423');
insert into cliente_tel values ('45213698752', '(15) 98726-1452');
insert into cliente_tel values ('13652413500', '(51) 98521-1463');

insert into cliente_end values ('12345678900', 'Rua Americo', 82, 'Jardim Girassol', 'Sorocaba');
insert into cliente_end values ('25436913598', 'Rua Aderlino Souza', 369, 'Jardim Pitanga', 'Sorocaba');
insert into cliente_end values ('56379578523', 'Avenida Coronel Pedro', 1397, 'Jardim Jussara', 'Sorocaba');
insert into cliente_end values ('36945298712', 'Alameda Honorio', 869, 'Jardim Diamante', 'Sorocaba');
insert into cliente_end values ('45213698752', 'Rua Felipe Antonio', 972, 'Jardim Pedroso', 'Sorocaba');
insert into cliente_end values ('13652413500', 'Rua Americo', 82, 'Jardim Girassol', 'Sorocaba');

insert into pet values (null, 'Morgana', '2022-03-11', 'N/A', 'Preto', 7.1, 'Gata');
insert into pet values (null, 'Bartolomeu', '2019-08-25', 'N/A', 'Branco', '8.0', 'Gato');
insert into pet values (null, 'Nana', '2022-06-21', 'N/A', 'Preto, Branco e Laranja', 6.1, 'Gata');
insert into pet values (null, 'Dobby', '2004-03-12', 'Pitbull', 'Marrom', 22.1, 'Cachorro');
insert into pet values (null, 'Mel', '2022-03-23', 'Labrador', 'Branco', 25.0, 'Cadela');
insert into pet values (null, 'Eros', '2010-06-14', 'Labrador e Pitbull', 'Branco', 28.00, 'Cachorro');

insert into fornecedor values (null, '82.760.503/0001-20', 'Whiskas', 'www.whiskas.com', '0800-785-5214');
insert into fornecedor values (null, '24.911.752/0001-72', 'Special Cat', 'www.specialcat.com', '0800-698-1254');
insert into fornecedor values (null, '67.118.043/0001-47', 'Pedigree', 'www.pedigree.com', '0800-874-1364');
insert into fornecedor values (null, '74.734.405/0001-90', 'Gran Plus', 'www.granplus.com', '0800-698-3214');
insert into fornecedor values (null, '74.734.405/0001-90', 'Golden', 'www.golden.com', '0800-125-9854');

insert into insumos values (null, 'Whiskas Carne +1', 211.89, 10.1, 'Ração Seca', '2025-04-21', 1, 100);
insert into insumos values (null, 'Whiskas Peixe +7', 3.29, 0.85, 'Ração Molhada (Sache)', '2024-06-21', 1, 300);
insert into insumos values (null, 'Special Cat Mix Premium', 144.90, 10.1, 'Ração Seca', '2025-07-12', 2, 30);
insert into insumos values (null, 'Special Cat Peixe', 6.90, 0.100, 'Ração Molhada (Pate)', '2024-11-08', 2, 190);
insert into insumos values (null, 'Pedigree Carne Filhotes', 209.94, 18.0, 'Ração Seca', '2025-07-21', 3, 150);
insert into insumos values (null, 'Gran Plus Frango FIlhotes', 3.35, 0.100, 'Ração Molhada (Sache)', '2025-04-21', 4, 25);
insert into insumos values (null, 'Golden Cookie Adulto', 15.90, 0.350, 'Petisco', '2025-04-21', 5, 60);

-- procedure que possibilita "linkar" os pets e os donos
delimiter //
create procedure cadastro_pet(
	in cliente		varchar(20),
    	in pet			int
)
begin
	insert into cadastro (cliente_CPF, pet_id) values (cliente, pet);

end //

call cadastro_pet ('12345678900', 1);
call cadastro_pet ('13652413500', 1);
call cadastro_pet ('25436913598', 2);
call cadastro_pet ('56379578523', 3);
call cadastro_pet ('36945298712', 4);
call cadastro_pet ('45213698752', 5);
call cadastro_pet ('45213698752', 6);

-- trigger que atualiza o estoque de acordo com as compras
CREATE TRIGGER atualiza_quantidade BEFORE INSERT ON compra
FOR EACH ROW
BEGIN
    	SET @quantidade_atual = (SELECT quantidade FROM insumos WHERE id_insumos = NEW.compra_insumos);
    	SET @nova_quantidade = @quantidade_atual - 1;

	UPDATE insumos SET quantidade = @nova_quantidade WHERE id_insumos = NEW.compra_insumos;

END;

-- procedure que possibilita o registro de compras
create procedure cadastro_compra(
	in cliente		varchar(20),
    	in produto		int,
    	in data_compra		date
)
begin
	insert into compra (cadastro_cliente, compra_insumos, data_compra) values (cliente, produto, data_compra);

end //

call cadastro_compra('12345678900', 1, '2023-06-06');
call cadastro_compra('13652413500', 3, '2023-06-07');
call cadastro_compra('25436913598', 2, '2023-06-07');
call cadastro_compra('56379578523', 3, '2023-06-08');
call cadastro_compra('36945298712', 4, '2023-06-09');
call cadastro_compra('45213698752', 5, '2023-06-10');
call cadastro_compra('45213698752', 6, '2023-06-11');

-- view que possibilita o usuário a consultar o histórico de compras
CREATE VIEW view_compras AS
SELECT DISTINCT c.nome AS nome_cliente, i.nome AS nome_produto, data_compra
FROM cliente c
JOIN cadastro ca ON c.CPF = ca.cliente_CPF
JOIN compra co ON ca.cliente_CPF = co.cadastro_cliente
JOIN insumos i ON co.compra_insumos = i.id_insumos;

SELECT * FROM view_compras;

-- select que possibilita consultar qual pet possui dois donos cadastrados no sistema
SELECT p.nome AS nome_pet
FROM pet p
JOIN cadastro c ON p.id = c.pet_id
GROUP BY p.id
HAVING COUNT(DISTINCT c.cliente_CPF) >= 2;

-- select que possibilita visualizar quantos cães e gatos estão cadastrados no sistema
SELECT
    COUNT(CASE WHEN tipo = 'Cachorro' OR tipo = 'Cadela'THEN 1 END) AS total_cachorros,
    COUNT(CASE WHEN tipo = 'Gata' OR tipo = 'Gato' THEN 1 END) AS total_gatos
FROM pet;

