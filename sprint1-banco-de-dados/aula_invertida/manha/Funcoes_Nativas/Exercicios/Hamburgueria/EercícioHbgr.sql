create database ExerciciosAp;

create table Hamburguers (
IdHamburguer int primary key identity,
Nome varchar(200),
Pre�o int,
);

insert into Hamburguers (Nome, Pre�o)
values ('X-Salada', 15),
	   ('X-Branco', 14),
	   ('XXX Tentacion', 16)

select*from Hamburguers

select sum (Pre�o) as Pre�oTotal from Hamburguers

select avg (Pre�o) as M�diaDePre�os from Hamburguers

select count (IdHamburguer) Quantidade from Hamburguers
