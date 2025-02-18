USE [StartupSoftware]
GO
-- Crear una vista llamada VistaFechaProyectos que muestre los nombres
CREATE VIEW VistasFechasProyectos AS 

SELECT 
Nombre AS NombreProyecto,
Descripcion,
FechaInicio AS InicioProyecto,
FechaFin AS FinProyecto
FROM [dbo].[Proyectos]
;

SELECT * FROM VistasFechasProyectos

GO
-- Utilizar variables locales para calcular el salario total y el numero promedio de horas 
-- asignadas a proyectos por empleados . Muestra estos valores ( usar SELECT)

DECLARE @SalarioTotal DECIMAL(10,2), @HorasPromedio INT;
SELECT @SalarioTotal= SUM([Salario]) FROM [dbo].[Empleados];
SELECT @HorasPromedio = AVG([HorasAsignadas]) FROM [dbo].[AsignacionesProyecto];
SELECT @SalarioTotal AS SalarioTotal,
@HorasPromedio AS HorasPromedio

-- Crear una funcion UDF que reciba un ClienteID y devuelva el numero total de proyectos asociados al cliente
CREATE FUNCTION TotalProyectosCliente(@ClienteID INT)
RETURNS INT 
AS
BEGIN
DECLARE @TotalProyectos INT;
SELECT @TotalProyectos = COUNT (*)  
FROM [dbo].[Proyectos]
WHERE ClienteID = @ClienteID
RETURN @TotalProyectos
END;
GO

SELECT [dbo].[TotalProyectosCliente](1) AS TotalProyectosCliente


-- Detalles de cada empleado 
-- Dado un empleadoID , Devuelva su nombre , posicion y salario 
CREATE PROCEDURE DetallesEmpleado
@EmpleadoID INT
AS 
BEGIN
SELECT EmpleadoID,
Nombre AS NombreEmpleado,
posicion AS PosicionEmpleado,
Salario
FROM [dbo].[Empleados]
WHERE EmpleadoID = @EmpleadoID
END
;
EXEC [dbo].[DetallesEmpleado] 3 

--Escribe una consulta que liste todos los proyectos que tiene al menos una factura en estado ''PENDIENTE''
-- Mostrando el nombre del proyecto y la descripcion
SELECT
Nombre AS NombreProyecto, 
Descripcion AS DescripcionProyecto
FROM [dbo].[Proyectos]
WHERE ProyectoID IN (SELECT ProyectoID FROM [dbo].[Facturas] WHERE Estado = 'Pendiente')
;
SELECT * FROM [dbo].[Empleados]
WHERE Salario BETWEEN 29000 AND 31000 
