CREATE DATABASE FastFood_DB
ON
( 
   NAME = 'FasFoodDB_Data', 
   FILENAME = 'C:\SQL_DB\FastFoodDB_Data.mdf',
   SIZE = 50 MB,
   MAXSIZE = 1GB,
   FILEGROWTH = 5MB
)
LOG ON 
( 
   NAME = 'Carrera_DB_Log',
   FILENAME = 'C:\SQL_DB\FastFoodDBx_log.ldf',  
   SIZE = 25 MB,
   MAXSIZE = 256 MB,
   FILEGROWTH = 5 MB 
);



USE FastFood_DB;

SELECT
name,database_id,create_date
FROM sys.databases
WHERE name = 'FastFood_DB'
;


CREATE TABLE Categorias
(
	CategoriaID INT PRIMARY KEY IDENTITY(1,1),
	Nombre VARCHAR(100) NOT NULL
)
;

CREATE TABLE Productos
(
	ProductoID INT PRIMARY KEY IDENTITY,
	Nombre VARCHAR(100) NOT NULL,
	CategoriaID INT,
	Precio DECIMAL(10,2) NOT NULL,
	FOREIGN KEY(CategoriaID) REFERENCES Categorias(CategoriaID)
)
;


CREATE TABLE Sucursales
(
	SucursalID INT PRIMARY KEY IDENTITY,
	Nombre VARCHAR(100) NOT NULL,
	Direccion VARCHAR(100) NOT NULL
)
;


CREATE TABLE Empleados
(
	EmpleadoID INT PRIMARY KEY IDENTITY,
	Nombre VARCHAR(100) NOT NULL,
	Posicion VARCHAR(100),
	Departamento VARCHAR(100),
	SucursalID INT,
	Rol VARCHAR(50) NOT NULL,
	FOREIGN KEY(SucursalID) REFERENCES Sucursales(SucursalID)
)
;


CREATE TABLE Clientes
(
	ClienteID INT PRIMARY KEY IDENTITY,
	Nombre VARCHAR(100) NOT NULL,
	Direccion VARCHAR(100)
)
;


CREATE TABLE OrigenOrden
(
	OrigenID INT PRIMARY KEY IDENTITY,
	Descripcion VARCHAR(255) NOT NULL
)
;




CREATE TABLE TiposPago
(
	TipoPagoID INT PRIMARY KEY IDENTITY,
	Descripcion VARCHAR(100) NOT NULL
)
;


CREATE TABLE Mensajeros
(
	MensajeroID INT PRIMARY KEY IDENTITY,
	Nombre VARCHAR(100) NOT NULL,
	EsExterno BIT NOT NULL
)
;

CREATE TABLE Ordenes
(
	OrdenID INT PRIMARY KEY IDENTITY,
	ClienteID INT,
	EmpleadoID INT,
	SucursalID INT,
	MensajeroID INT,
	TipoPagoID INT,
	OrigenID INT,
	HorarioVenta VARCHAR(100) NOT NULL,
	TotalCompra DECIMAL(10,2) NOT NULL,
	KilometrosRecorrer DECIMAL(10,2),
	FechaDespacho DATETIME,
	FechaEntrega DATETIME,
	FechaOrdenTomada DATETIME,
	FechaOrdenLista DATETIME,
	FOREIGN KEY(ClienteID) REFERENCES Clientes(ClienteID),
	FOREIGN KEY(EmpleadoID) REFERENCES Empleados(EmpleadoID),
	FOREIGN KEY(SucursalID) REFERENCES Sucursales(SucursalID),
	FOREIGN KEY(MensajeroID) REFERENCES Mensajeros(MensajeroID),
	FOREIGN KEY(TipoPagoID) REFERENCES TiposPago(TipoPagoID),
	FOREIGN KEY(OrigenID) REFERENCES OrigenOrden(OrigenID)
)
;

CREATE TABLE DetalleOrdenes
(
	OrdenID INT,
	ProductoID INT,
	Cantidad INT,
	Precio DECIMAL(10,2),
	PRIMARY KEY (OrdenID,ProductoID),
	FOREIGN KEY(ProductoID) REFERENCES Productos(ProductoID),
	FOREIGN KEY(OrdenID) REFERENCES Ordenes(OrdenID)
)
;

ALTER TABLE DetalleOrdenes
ADD Comentarios VARCHAR(100)

;