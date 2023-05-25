use  NORTHWND1

--2. Crear una función que retorne el nombre de la categoría con la mayor
-- cantidad de ítems de productos vendidos para un determinado año.


create view temp1
as
select year(OrderDate) Year, CategoryName, sum(Quantity) suma
from [Order Details] OD
         join Orders O on OD.OrderID = O.OrderID
         join Products P on OD.ProductID = P.ProductID
         join Categories C on P.CategoryID = C.CategoryID
group by year(OrderDate), CategoryName
go;

create function categoria_mayor_vendida_año(@year int)returns table
return
    select CategoryName
    from temp1
    where year = @year
      and (suma = (select max(suma) maximo
                   from temp1
                   where year = @year))



select * from temp1

select max(suma) maximo
from temp1
where year = 2016

select CategoryName
from temp1
where year = 2016
  and (suma = (select max(suma) maximo
               from temp1
               where year = 2016))


select * from dbo.categoria_mayor_vendida_año(2016)

--5. Crear una función que retorne el nombre del shipper con mayor
-- cantidad de pedidos atendidos para un determinado año.
create view temp2
as
select S.CompanyName,YEAR(OrderDate) Year,count(*) cant
from Shippers S
         join Orders O on S.ShipperID = O.ShipVia
group by S.CompanyName,YEAR(OrderDate)
go;

select CompanyName
from temp2
where year = 2016
  and (cant = (select max(cant) maximo from temp2 where Year = 2016))

create function shipper_mayor_pedidos_año(@year int) returns table
return
select CompanyName
from temp2
where year = @year
  and (cant = (select max(cant) maximo from temp2 where Year = @year))


select * from dbo.shipper_mayor_pedidos_año(2018)

--8. Crear un procedimiento o función que liste la relación de
-- productos para una determinada categoría.

select ProductName
from Products P
         join Categories C on P.CategoryID = C.CategoryID
where C.CategoryName='Beverages'

create function lista_productos_por_categoria(@category varchar(100)) returns table
return
select ProductName
from Products P
         join Categories C on P.CategoryID = C.CategoryID
where C.CategoryName=@category


select * from dbo.lista_productos_por_categoria('Beverages')

alter procedure listaCategoria
@category nvarchar(15)
as
begin


select ProductName
from Products P
         join Categories C on P.CategoryID = C.CategoryID
where C.CategoryName like @category
end
go;


exec dbo.listaCategoria 'Beverages'

--13. Mostrar en un procedimiento almacenado, el país donde se
-- ha vendido más órdenes durante un año
-- ingresado como parámetro.


create view temp3
as
select year(OrderDate) Year, ShipCountry, count(*) Quantity
from Orders
group by year(OrderDate), ShipCountry

select ShipCountry
from temp3
where Year = 2016
  and Quantity = (select max(Quantity) from temp3 where Year = 2016)

alter procedure pais_ordenes_mas_vendidas_año
@year int
as
begin
    select ShipCountry
    from temp3
    where Year = @year
      and Quantity = (select max(Quantity) from temp3 where Year = @year)
end;

exec dbo.pais_ordenes_mas_vendidas_año 2017


--Crear un procedimiento almacenado que actualize la cantidad de
--unidades venidadas para un deter producto, se ingresa
-- el codigo el producto y las unidades como parametro

create procedure xd
@id int,
@q int
as
begin
    update Products set UnitsInStock=UnitsInStock-@q
    where ProductID=@id
end
go;
exec xd 1,-4



select ProductName,UnitsInStock from Products