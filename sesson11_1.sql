use NORTHWND1


alter procedure usp_insert_category
@name varchar(15),
@desc ntext
as
begin
insert into Categories(CategoryName,Description) values(@name,@desc)
end;
go;

execute usp_insert_category 'Test','Test'

select * from Categories

--Crear un procedimieno almacenado que permia elimnar una categoria
alter procedure usp_delete_category
@CategoryID  int,
@Cantidad int output
as
begin

    select @Cantidad=count(*) from Products where CategoryID=@CategoryID

    if @Cantidad=0
        begin
            delete from Categories where CategoryID=@CategoryID
        end
    else
        begin
            print(N'No se ha podido eliminar la categoría por tener productos asignados')
        end
end


declare @q int
exec usp_delete_category 4,@q output
print(@q)

--stock y nombres de un producto



    create procedure usp_name_stock_product
    as
    begin
        declare @ProductName nvarchar(40),@UnitsInStock smallint
        declare products_cursor cursor for
        select ProductName,UnitsInStock from Products
        open products_cursor
        fetch products_cursor into @ProductName,@UnitsInStock
        while(@@fetch_status = 0)
            begin
                print (concat(@ProductName, ': ', @UnitsInStock))
                fetch products_cursor into @ProductName,@UnitsInStock
            end

        close products_cursor
        deallocate products_cursor

    end
execute usp_name_stock_product

--crear un procediminto que imprima la cantidad de peddos realizados para un producto en un detrminado año
--varabales año

        alter procedure usp_pedidos_año @year int
        as
        begin
            declare @ProductName nvarchar(40),@Quantity smallint
            declare orders_cursor cursor for
                select ProductName, count(O.OrderID) TotalOrders
                from Products
                         join [Order Details] "[O D]" on Products.ProductID = "[O D]".ProductID
                         join Orders O on "[O D]".OrderID = O.OrderID
                where year(OrderDate) = @year
                group by ProductName

            open orders_cursor
            fetch orders_cursor into @ProductName,@Quantity
            while(@@fetch_status=0)
                begin
                    print(concat(@ProductName,': ',@Quantity))
                    fetch orders_cursor into @ProductName,@Quantity
                end
                close orders_cursor
                deallocate orders_cursor
        end

execute usp_pedidos_año 2015

        select ProductName, count(O.OrderID) TotalOrders
        from Products
                 join [Order Details] "[O D]" on Products.ProductID = "[O D]".ProductID
                 join Orders O on "[O D]".OrderID = O.OrderID
        where year(OrderDate)=2016
        group by ProductName


