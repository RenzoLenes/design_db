use NORTHWND1

create view orders_quantity_by_product
as
select ProductName, count(*) cantidad
from [Order Details] OD
         join Products P on OD.ProductID = P.ProductID
group by ProductName;
go;


select ProductName,cantidad
from orders_quantity_by_product
where cantidad = (select max(cantidad) from orders_quantity_by_product)


select ProductName,cantidad
from orders_quantity_by_product
where cantidad = (select min(cantidad) from orders_quantity_by_product)


--Indicar el empleado con la mayor cantidad de ordenes atendidas

select LastName+' '+FirstName,count(*) from Employees join Orders O on Employees.EmployeeID = O.EmployeeID
group by LastName+' '+FirstName;


create view temp as
select LastName+' '+FirstName as empleado, count(*) cantidad
from Employees E
         join Orders O on E.EmployeeID = O.EmployeeID
group by LastName+' '+FirstName;
go;



select empleado, cantidad
from temp
where cantidad = (select max(cantidad) from temp)



    select ProductName,cantidad
from orders_quantity_by_product
where cantidad = (select max(cantidad) from orders_quantity_by_product)

create view temp4 as
select * from Orders
where  ShipCountry='France'
go;

select * from temp4

create function cantidadempleados() returns integer
as begin
    declare @cantidad integer
    select @cantidad=count(*) from Employees
    return @cantidad
end

print dbo.cantidadempleados()

--Crear una funcion que retorne la cnatidad deordenes para un determinado pais
create function orden_por_pais(@country varchar(100)) returns int
as begin
    declare @q int
    select @q=count(*) from Orders where ShipCountry=@country
    return @q
end
go;

drop function orden_por_pais

select ShipCountry from Orders

print dbo.orden_por_pais('Germany')
--Obtener tipo de datos
exec sp_help Orders

--Crear una funcion que retonre el pais de procedencia del cliente con la menor cantidad de pedidos
--atendidos en un año
--variables año y pais
--Alejandra Camino


create view asd as

select Country,year(OrderDate) year,count(*) cantidad
from Customers C
         join Orders O on C.CustomerID = O.CustomerID
group by Country,year(OrderDate);
go;

select * from asd

select * from asd where year=2016 and cantidad=(
    select min(cantidad) from asd where year=2016)

create function ll(@year int) returns table
    return
    select * from asd where year=@year and cantidad=(
    select min(cantidad) from asd where year=@year)
go;

select * from dbo.ll(2018)

--Crear una vista que muestre cantidad d epeido por cada cleinte por cada año
--var cliente

select ContactName, year(OrderDate) year,count(*) cantidad
from Customers C
         join Orders O on C.CustomerID = O.CustomerID
group by year(OrderDate), ContactName