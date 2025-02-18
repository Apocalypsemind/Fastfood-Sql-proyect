-- AVANCE NUMERO 3 PROYECTO SOY HENRY
-- VENTAS GLOBALES 
USE [FastFood_DB]
SELECT SUM(TotalCompra) AS Total_Ventas
FROM[dbo].[Ordenes]
;

--Promedios en precios de productos por categoria 
SELECT CategoriaID,
CAST(AVG(Precio) AS decimal(10,2))Promedio_Precio
FROM [dbo].[Productos]
GROUP BY CategoriaID
ORDER BY Promedio_Precio DESC

--ORDEN MINIMA Y MAXIMA POR SUCURSAL 
SELECT SucursalID AS Sucursal,
MIN(TotalCompra) AS Minimo_Orden,
MAX(TotalCompra) AS Maximo_Compra
FROM [dbo].[Ordenes]
GROUP BY SucursalID

-- Mayor numero de Kms recorridos para entrega

SELECT 
MAX(KilometrosRecorrer) AS Numero_Maximo_KM
FROM [dbo].[Ordenes]
;

SELECT 
TOP 1 
OrdenID FROM [dbo].[Ordenes]


--Cual es la cantidad promedio de productos por orden?
SELECT 
OrdenID,
AVG(Cantidad) AS Promedio_Cantidad
FROM [dbo].[DetalleOrdenes]
GROUP BY OrdenID

--Total de Ventas por tipo de pago 
SELECT B.Descripcion AS Tipo_Pago,
SUM(TotalCompra) AS Total_Venta
FROM [dbo].[Ordenes] AS A,[dbo].[TiposPago] AS B
WHERE A.[TipoPagoID] = B.[TipoPagoID]
GROUP BY B.Descripcion
ORDER BY Total_Venta DESC

SELECT
 [TipoPagoID] AS Tipo_Pago,
 SUM(TotalCompra) AS Total_Venta
 FROM[dbo].[Ordenes]
 GROUP BY[TipoPagoID]
 ORDER BY Total_Venta DESC
 
 -- Sucursal Con la venta promedio más alta
 SELECT
 TOP 1
 AVG(TotalCompra) Venta_Promedio
 FROM[dbo].[Ordenes]
 GROUP BY SucursalID
 ORDER BY Venta_Promedio DESC
 ;

 -- Mayor cantidad de ventas por sucursal por encima del umbral de 1000$
 SELECT
 AVG(TotalCompra) AS Venta_Promedio
 FROM[dbo].[Ordenes]
 GROUP BY SucursalID
 HAVING SUM(TotalCompra) > 1000
 -- Comparacíon de ventas promedios antes y despues de una fecha especifica
 SELECT
 AVG(TotalCompra) AS Venta_Promedio_luego_1_julio
 FROM [dbo].[Ordenes]
 WHERE FechaOrdenTomada >= '2023-07-01'
 ;
  SELECT
 AVG(TotalCompra) AS Venta_Promedio_luego_1_julio
 FROM [dbo].[Ordenes]
 WHERE FechaOrdenTomada < '2023-07-01'
;
-- Durante que horario del dia ( mañana,tade,noche) se registra la mayor cantidad de ventas , 
--cual es ele ingreso promedio de estas ventas , y cvual ah sido el; iomporte maximo alcanzado por una orden en dicha jornada?

SELECT HorarioVenta,
COUNT(OrdenID)AS Venta_Total,
AVG(TotalCompra) AS Venta_Promedio,
AVG(TotalCompra) AS Venta_Maxima
FROM [dbo].[Ordenes] 
GROUP BY HorarioVenta
