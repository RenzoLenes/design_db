create database DB_BETTO;


use DB_BETTO

create table Proveedores(
    CodigoProveedor int not null ,
    NombreProveedor varchar(100) not null,
    DireccionProveedor varchar(100) not null ,
    TelefonoProveedor varchar(9) not null ,
    CorreoProveedor varchar(100) not null
    constraint PK_Proveedores primary key (CodigoProveedor)
)


select * from Proveedores


create table Telas(
    CodigoTela int not null ,
    NombreTela varchar(100),
    CodigoProveedor int not null
    constraint PK_Telas primary key (CodigoTela),
    constraint FK_Telas_Proveedores foreign key(CodigoProveedor) references Proveedores(CodigoProveedor)
)

select * from Telas


create table Clientes(
    CodigoCliente int not null,
    NombreCliente varchar(100) not null ,
    ApellidoCliente varchar(100) not null ,
    DniCliente varchar(8) not null ,
    CelularCliente varchar(9) not null ,
    DireccionCliente varchar(255) not null,
    CiudadCliente varchar(100) not null
    constraint PK_Clientes primary key (CodigoCliente)
)
select * from Clientes

create table Categorias(
    CodigoCategoria int not null ,
    NombreCategoria varchar(100) not null ,
    DescripcionCategoria varchar(250) not null
    constraint PK_Categorias primary key (CodigoCategoria)
)
select * from Categorias

create table Pedidos(
    CodigoPedido int not null ,
    FechaInicio date NOT NULL,
    FechaEntrega date,
    CodigoCliente int not null
    constraint PK_Pedidos primary key (CodigoPedido),
    constraint FK_Pedidos_Clientes foreign key (CodigoCliente) references Clientes(CodigoCliente)
)

select * from Pedidos

create table Productos(
    CodigoProducto int not null ,
    NombreProducto varchar(100) not null ,
    ColorProducto varchar(100) not null ,
    /*Modificar talla en el vertabelo se puso int*/
    TallaProducto varchar(5) not null ,
    CostoBase float,
    CodigoCategoria int not null ,
    StockDisponible int,
    FechaIngreso date not null
    constraint PK_Producto primary key(CodigoProducto),
    constraint FK_Productos_Categorias foreign key (CodigoCategoria) references Categorias(CodigoCategoria)
)

select * from Productos

create table Telas_Productos(
    CodigoTela int not null ,
    CodigoProducto int not null ,
    Porcentaje float not null
    constraint FK_Telas_Productos_Telas foreign key(CodigoTela) references Telas(CodigoTela),
    constraint FK_Telas_Productos_Productos foreign key(CodigoProducto) references  Productos(CodigoProducto),
    constraint PK_Telas_Productos primary key (CodigoTela,CodigoProducto)

)
select * from Telas_Productos
/*Aqui me quede*/
create table Detalles_Pedidos(
    CodigoProducto int not null ,
    CodigoPedido int not null ,
    Cantidad int not null ,
    PrecioUnitario float not null ,
    Descuento float not null ,
    constraint FK_Detalles_Pedidos_Productos foreign key(CodigoProducto) references Productos(CodigoProducto),
    constraint FK_Detalles_Pedidos_Pedidos foreign key (CodigoPedido) references Pedidos(CodigoPedido),
    constraint PK_Detalles_Pedidos primary key (CodigoProducto,CodigoPedido)
)
select * from Detalles_Pedidos

create table Estados(
    CodigoEstado int not null,
    DescripcionEstado varchar(125) not null
    constraint PK_Estados primary key (CodigoEstado)
)
select * from Estados

create table Seguimientos(
    CodigoEstado int not null ,
    FechaRegistro datetime not null ,
    CodigoProducto int not null ,
    CodigoPedido int not null


    constraint PK_Seguimientos primary key (CodigoPedido,CodigoProducto,FechaRegistro),
    constraint FK_Seguimientos_Detalles_Pedidos foreign key(CodigoProducto,CodigoPedido) references Detalles_Pedidos(CodigoProducto,CodigoPedido),
    constraint FK_Seguimientos_Estados foreign key (CodigoEstado) references Estados(CodigoEstado)

)

select * from Seguimientos
