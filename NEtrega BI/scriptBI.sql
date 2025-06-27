USE CUADRADITOS_DE_RICOTA;

PRINT 'Inicializando la creacion del modelo de Business Intelligence'
GO

IF OBJECT_ID('[CUADRADITOS_DE_RICOTA].[BI_CLEAN]', 'P') IS NOT NULL
    DROP PROCEDURE [CUADRADITOS_DE_RICOTA].[BI_CLEAN];
GO

CREATE PROCEDURE [CUADRADITOS_DE_RICOTA].[BI_CLEAN]
AS
BEGIN
----------------------------DROP PREVENTIVO DE FUNCIONES----------------------------
IF EXISTS(SELECT [name] FROM sys.objects WHERE [name] = 'obtenerEdad')
 drop FUNCTION [CUADRADITOS_DE_RICOTA].obtenerEdad
IF EXISTS(SELECT [name] FROM sys.objects WHERE [name] = 'obtenerRangoEtario')
 drop FUNCTION [CUADRADITOS_DE_RICOTA].obtenerRangoEtario
IF EXISTS(SELECT [name] FROM sys.objects WHERE [name] = 'obtenerCuatrimestre')
 drop FUNCTION [CUADRADITOS_DE_RICOTA].obtenerCuatrimestre
IF EXISTS(SELECT [name] FROM sys.objects WHERE [name] = 'obtenerTurnos')
 drop FUNCTION [CUADRADITOS_DE_RICOTA].obtenerTurnos
IF EXISTS(SELECT [name] FROM sys.objects WHERE [name] = 'cumplioEntrega')
 drop FUNCTION [CUADRADITOS_DE_RICOTA].cumplioEntrega
IF EXISTS(SELECT [name] FROM sys.objects WHERE [name] = 'plazoFabricacion')
 drop FUNCTION [CUADRADITOS_DE_RICOTA].plazoFabricacion
IF EXISTS(SELECT [name] FROM sys.objects WHERE [name] = 'tipoMaterial')
 drop FUNCTION [CUADRADITOS_DE_RICOTA].tipoMaterial


---------------------------------DROP PREVENTIVO DE TABLAS----------------------------------

----------------------------DROP PREVENTIVO DE TABLAS TEMPORALES----------------------------
IF OBJECT_ID('tempdb.dbo.#ventasTemp') IS NOT NULL
BEGIN
DROP TABLE #ventasTemp
END

IF OBJECT_ID('tempdb.dbo.#comprasTemp') IS NOT NULL
BEGIN
DROP TABLE #comprasTemp
END

IF OBJECT_ID('tempdb.dbo.#enviosTemp') IS NOT NULL
BEGIN
DROP TABLE #enviosTemp
END

IF OBJECT_ID('tempdb.dbo.#PedidosTemp') IS NOT NULL
BEGIN
DROP TABLE #PedidosTemp
end
----------------------------DROP PREVENTIVO DE TABLAS FÁCTICAS----------------------------
IF EXISTS (SELECT * FROM sys.tables WHERE name = 'BI_Ventas')
    DROP TABLE [CUADRADITOS_DE_RICOTA].BI_Ventas;

IF EXISTS (SELECT * FROM sys.tables WHERE name = 'BI_Compras')
    DROP TABLE [CUADRADITOS_DE_RICOTA].BI_Compras;

IF EXISTS (SELECT * FROM sys.tables WHERE name = 'BI_Envios')
    DROP TABLE [CUADRADITOS_DE_RICOTA].BI_Envios;

IF EXISTS (SELECT * FROM sys.tables WHERE name = 'BI_Pedidos')
    DROP TABLE [CUADRADITOS_DE_RICOTA].BI_Pedidos;

-- DROP PREVENTIVO DE TABLAS DIMENSIONALES --

IF EXISTS (SELECT * FROM sys.tables WHERE name = 'BI_DIM_Estado_pedido')
    DROP TABLE [CUADRADITOS_DE_RICOTA].BI_DIM_Estado_pedido;

IF EXISTS (SELECT * FROM sys.tables WHERE name = 'BI_DIM_Material_tipo')
    DROP TABLE [CUADRADITOS_DE_RICOTA].BI_DIM_Material_tipo;
	
IF EXISTS (SELECT * FROM sys.tables WHERE name = 'BI_DIM_Modelo_sillon')
    DROP TABLE [CUADRADITOS_DE_RICOTA].BI_DIM_Modelo_sillon;
	
IF EXISTS (SELECT * FROM sys.tables WHERE name = 'BI_DIM_Rango_etario')
    DROP TABLE [CUADRADITOS_DE_RICOTA].BI_DIM_Rango_etario;
	
IF EXISTS (SELECT * FROM sys.tables WHERE name = 'BI_DIM_Sucursal')
    DROP TABLE [CUADRADITOS_DE_RICOTA].BI_DIM_Sucursal;
	
IF EXISTS (SELECT * FROM sys.tables WHERE name = 'BI_DIM_Tiempo')
    DROP TABLE [CUADRADITOS_DE_RICOTA].BI_DIM_Tiempo;
	
IF EXISTS (SELECT * FROM sys.tables WHERE name = 'BI_DIM_Turno_venta')
    DROP TABLE [CUADRADITOS_DE_RICOTA].BI_DIM_Turno_venta;
	
IF EXISTS (SELECT * FROM sys.tables WHERE name = 'BI_DIM_Ubicacion')
    DROP TABLE [CUADRADITOS_DE_RICOTA].BI_DIM_Ubicacion;
	
IF EXISTS (SELECT * FROM sys.tables WHERE name = 'BI_Provincia')
    DROP TABLE [CUADRADITOS_DE_RICOTA].BI_Provincia;


----------------------------DROPS PREVENTIVOS DE VISTAS----------------------------


IF EXISTS (SELECT * FROM sys.views WHERE name = 'Ganancias' AND schema_id = SCHEMA_ID('CUADRADITOS_DE_RICOTA'))
    DROP VIEW [CUADRADITOS_DE_RICOTA].[Ganancias];

IF EXISTS (SELECT * FROM sys.views WHERE name = 'LocalidadesMayorCostoEnvio' AND schema_id = SCHEMA_ID('CUADRADITOS_DE_RICOTA'))
    DROP VIEW [CUADRADITOS_DE_RICOTA].[LocalidadesMayorCostoEnvio];

IF EXISTS (SELECT * FROM sys.views WHERE name = 'PorcentajeDeCumplimientoDeEnvios' AND schema_id = SCHEMA_ID('CUADRADITOS_DE_RICOTA'))
    DROP VIEW [CUADRADITOS_DE_RICOTA].[PorcentajeDeCumplimientoDeEnvios];

IF EXISTS (SELECT * FROM sys.views WHERE name = 'ComprasPorTiepoDeMaterial' AND schema_id = SCHEMA_ID('CUADRADITOS_DE_RICOTA'))
    DROP VIEW [CUADRADITOS_DE_RICOTA].[ComprasPorTiepoDeMaterial];

IF EXISTS (SELECT * FROM sys.views WHERE name = 'PromedioDeCompras' AND schema_id = SCHEMA_ID('CUADRADITOS_DE_RICOTA'))
    DROP VIEW [CUADRADITOS_DE_RICOTA].[PromedioDeCompras];

IF EXISTS (SELECT * FROM sys.views WHERE name = 'TiempoPromedioDeFabricacion' AND schema_id = SCHEMA_ID('CUADRADITOS_DE_RICOTA'))
    DROP VIEW [CUADRADITOS_DE_RICOTA].[TiempoPromedioDeFabricacion];

IF EXISTS (SELECT * FROM sys.views WHERE name = 'ConversionDePedidos' AND schema_id = SCHEMA_ID('CUADRADITOS_DE_RICOTA'))
    DROP VIEW [CUADRADITOS_DE_RICOTA].[ConversionDePedidos];

IF EXISTS (SELECT * FROM sys.views WHERE name = 'VolumenDePedidos' AND schema_id = SCHEMA_ID('CUADRADITOS_DE_RICOTA'))
    DROP VIEW [CUADRADITOS_DE_RICOTA].[VolumenDePedidos];

IF EXISTS (SELECT * FROM sys.views WHERE name = 'RendimientoDeModelos' AND schema_id = SCHEMA_ID('CUADRADITOS_DE_RICOTA'))
    DROP VIEW [CUADRADITOS_DE_RICOTA].[RendimientoDeModelos];

IF EXISTS (SELECT * FROM sys.views WHERE name = 'FacturaPromedioMensual' AND schema_id = SCHEMA_ID('CUADRADITOS_DE_RICOTA'))
    DROP VIEW [CUADRADITOS_DE_RICOTA].[FacturaPromedioMensual];

	
----------------------------DROP PREVENTIVO DE PROCEDURES----------------------------
	
	IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'BI_Migrar_provincia' and schema_id = SCHEMA_ID('CUADRADITOS_DE_RICOTA'))
	DROP PROCEDURE [CUADRADITOS_DE_RICOTA].[BI_Migrar_provincia]
	
	IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'BI_Migrar_material' and schema_id = SCHEMA_ID('CUADRADITOS_DE_RICOTA'))
	DROP PROCEDURE [CUADRADITOS_DE_RICOTA].[BI_Migrar_material]
	
	IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'BI_Migrar_modelo' and schema_id = SCHEMA_ID('CUADRADITOS_DE_RICOTA'))
	DROP PROCEDURE [CUADRADITOS_DE_RICOTA].[BI_Migrar_modelo]
	
	IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'BI_Migrar_Turno' and schema_id = SCHEMA_ID('CUADRADITOS_DE_RICOTA'))
	DROP PROCEDURE [CUADRADITOS_DE_RICOTA].[BI_Migrar_Turno]
	
	IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'BI_Migrar_Estado' and schema_id = SCHEMA_ID('CUADRADITOS_DE_RICOTA'))
	DROP PROCEDURE [CUADRADITOS_DE_RICOTA].[BI_Migrar_Estado]
	
	IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'BI_Migrar_rango_etario' and schema_id = SCHEMA_ID('CUADRADITOS_DE_RICOTA'))
	DROP PROCEDURE [CUADRADITOS_DE_RICOTA].[BI_Migrar_rango_etario]
	
	IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'BI_Migrar_Sucursales' and schema_id = SCHEMA_ID('CUADRADITOS_DE_RICOTA'))
	DROP PROCEDURE [CUADRADITOS_DE_RICOTA].[BI_Migrar_Sucursales]
	
	IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'BI_Migrar_Ventas' and schema_id = SCHEMA_ID('CUADRADITOS_DE_RICOTA'))
	DROP PROCEDURE [CUADRADITOS_DE_RICOTA].[BI_Migrar_Ventas]
	
	IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'BI_Migrar_Envios' and schema_id = SCHEMA_ID('CUADRADITOS_DE_RICOTA'))
	DROP PROCEDURE [CUADRADITOS_DE_RICOTA].[BI_Migrar_Envios]
	
	IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'BI_Migrar_Compras' and schema_id = SCHEMA_ID('CUADRADITOS_DE_RICOTA'))
	DROP PROCEDURE [CUADRADITOS_DE_RICOTA].[BI_Migrar_Compras]
	
	IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'BI_Migrar_Pedidos' and schema_id = SCHEMA_ID('CUADRADITOS_DE_RICOTA'))
	DROP PROCEDURE [CUADRADITOS_DE_RICOTA].[BI_Migrar_Pedidos]

END
GO

EXECUTE [CUADRADITOS_DE_RICOTA].[BI_CLEAN]
----------------------------------------------------------------------------------------

----------------------------CREACIÓN DE FUNCIONES AUXILIARES----------------------------
GO

/*	Obtener edad
    @param una fecha de nacimiento (datetime2)
    @returns la edad al dia de hoy (int)
*/

CREATE FUNCTION CUADRADITOS_DE_RICOTA.obtenerEdad(@dateofbirth datetime2(6))
RETURNS int
AS
BEGIN
	DECLARE @age int;

IF (MONTH(@dateofbirth)!=MONTH(GETDATE()))
	SET @age = DATEDIFF(MONTH, @dateofbirth, GETDATE())/12;
ELSE IF(DAY(@dateofbirth) > DAY(GETDATE()))
	SET @age = (DATEDIFF(MONTH, @dateofbirth, GETDATE())/12)-1;
ELSE
BEGIN
	SET @age = DATEDIFF(MONTH, @dateofbirth, GETDATE())/12;
END
	RETURN @age;
END
GO

/*  Rango etario empleados/clientes
    @param una edad int
    @returns rango etario al que pertenece */

CREATE FUNCTION CUADRADITOS_DE_RICOTA.obtenerRangoEtario (@age int)
RETURNS NVARCHAR(255)
AS
BEGIN
	DECLARE @returnvalue NVARCHAR(255);

IF (@age < 25)
BEGIN
	SET @returnvalue = '[<25)';
END
ELSE IF (@age >= 25 AND @age < 35)
BEGIN
	SET @returnvalue = '[25 - 35)';
END
ELSE IF (@age >= 35 AND @age <= 50)
BEGIN
	SET @returnvalue = '[35 - 50]';
END
ELSE IF(@age > 50)
BEGIN
	SET @returnvalue = '(>50]';
END

	RETURN @returnvalue;
END
GO

/*  Obtener cuatrimestre
    @param una fecha con horas/min/seg un datetime
    @returns int de 1 a 4 con el correspondiente cuatrimestre
*/

CREATE FUNCTION [CUADRADITOS_DE_RICOTA].obtenerCuatrimestre (@Fecha DATETIME2(6))
RETURNS INT
AS
BEGIN
    DECLARE @Cuatrimestre INT;
    
    SET @Cuatrimestre = CASE 
        WHEN MONTH(@Fecha) IN (1, 2, 3, 4) THEN 1
        WHEN MONTH(@Fecha) IN (5, 6, 7, 8) THEN 2
        WHEN MONTH(@Fecha) IN (9, 10, 11, 12) THEN 3
    END;

    RETURN @Cuatrimestre;
END;
GO

/*  Rango de turnos
    @param una fecha con horas/min/seg un datetime
    @returns rango turno al que pertenece
*/

CREATE FUNCTION CUADRADITOS_DE_RICOTA.obtenerTurnos (@fecha datetime2(6))
RETURNS NVARCHAR(255)
AS
BEGIN
    DECLARE @returnvalue NVARCHAR(255);
    DECLARE @hora int;

    SET @hora = DATEPART(hour, @fecha);

    IF (@hora >= 8 AND @hora < 14)
    BEGIN
        SET @returnvalue = '08:00 - 14:00';
    END
    ELSE IF (@hora >= 12 AND @hora < 20)
    BEGIN
        SET @returnvalue = '14:00 - 20:00';
    END
    ELSE
    BEGIN
        SET @returnvalue = 'Fuera de Horario';
    END

    RETURN @returnvalue;
END
GO

/*  Envio cumple entrega
	@param fecha de entrega, fecha programada y hora final de entrega
	@returns 1 o 0 en caso de que haya cumplido o no
*/

CREATE FUNCTION CUADRADITOS_DE_RICOTA.cumplioEntrega (@fecha_programada datetime2(6), @fecha_entrega datetime2(6))
RETURNS int AS
BEGIN

	IF((CAST(@fecha_entrega as date)=cast(@fecha_programada as date)) OR @fecha_entrega < @fecha_programada)
	RETURN 1
	RETURN 0
END
GO

CREATE FUNCTION CUADRADITOS_DE_RICOTA.plazoFabricacion (@fecha_pedido datetime2(6), @fecha_facturacion datetime2(6))
RETURNS int AS
BEGIN
    declare @resultado int
	set @resultado = DATEDIFF(hour,@fecha_pedido,@fecha_facturacion)
	RETURN @resultado
END
GO

CREATE FUNCTION CUADRADITOS_DE_RICOTA.tipoMaterial (@material int)
RETURNS nvarchar(255) AS
BEGIN
    declare @resultado NVARCHAR(255)
	if exists (select 1 from [CUADRADITOS_DE_RICOTA].Tela where tela_material=@material)
		set @resultado= 'Tela'
	else if exists (select 1 from [CUADRADITOS_DE_RICOTA].Madera where mad_material=@material)
		set @resultado= 'Madera'
	else if exists (select 1 from [CUADRADITOS_DE_RICOTA].Relleno where rell_material=@material)
		set @resultado= 'Relleno'
	else 
	set @resultado ='Sin Tipo'
	RETURN @resultado
END
GO




----------------------------CREACIÓN DE TABLAS DIMENSIONALES----------------------------
-----------------------------Tabla dimensional de provincia-----------------------------
CREATE TABLE [CUADRADITOS_DE_RICOTA].[BI_Provincia](
    prov_codigo int PRIMARY KEY,
    prov_nombre NVARCHAR(255)
);
GO

-----------------------------Tabla dimensional de ubicacion-----------------------------
CREATE TABLE [CUADRADITOS_DE_RICOTA].[BI_DIM_Ubicacion] (
    BIUbi_codigo INT PRIMARY KEY,
    BIUbi_provincia int,
    BIUbi_localidad NVARCHAR(255)
    FOREIGN KEY (BIUbi_provincia) REFERENCES [CUADRADITOS_DE_RICOTA].[BI_Provincia](prov_codigo)
);
GO

----------------------------Tabla dimensional de tiempo----------------------------
CREATE TABLE [CUADRADITOS_DE_RICOTA].[BI_DIM_Tiempo] (
    BITie_codigo INT IDENTITY(1,1) PRIMARY KEY,
    BITie_mes INT,
    BITie_anio INT,
    BITie_cuatrimestre INT
);
GO

----------------------------Tabla dimensional de sucursal----------------------------
CREATE TABLE [CUADRADITOS_DE_RICOTA].[BI_DIM_Sucursal] (
    BISuc_codigo int PRIMARY KEY,
    BISuc_localidad INT,
    FOREIGN KEY (BISuc_localidad) REFERENCES [CUADRADITOS_DE_RICOTA].[BI_DIM_Ubicacion](BIUbi_codigo)
);
GO

----------------------------Tabla dimensional de rango etario----------------------------
CREATE TABLE [CUADRADITOS_DE_RICOTA].[BI_DIM_Rango_etario] (
    BIRang_codigo INT IDENTITY(1,1) PRIMARY KEY,
    BIRang_descripcion NVARCHAR(255)
);
GO

----------------------------Tabla dimensional de turnos----------------------------
CREATE TABLE [CUADRADITOS_DE_RICOTA].[BI_DIM_Turno_venta] (
    BITurn_codigo INT IDENTITY(1,1) PRIMARY KEY,
    BITurn_descripcion NVARCHAR(255)
);
GO

----------------------------Tabla dimensional de material----------------------------
CREATE TABLE [CUADRADITOS_DE_RICOTA].[BI_DIM_Material_tipo] ( --tela, madera o relleno
    BIMat_codigo int IDENTITY(1,1) PRIMARY KEY,
    BIMat_descripcion NVARCHAR(255)
);
GO

----------------------------Tabla dimensional de estado----------------------------
CREATE TABLE [CUADRADITOS_DE_RICOTA].[BI_DIM_Estado_pedido] (
    BIEst_codigo INT PRIMARY KEY,
    BIEst_descripcion NVARCHAR(255)
);
GO

-----------------------------Tabla dimensional de modelo-----------------------------
CREATE TABLE [CUADRADITOS_DE_RICOTA].[BI_DIM_Modelo_sillon](
	BIMod_codigo bigint PRIMARY KEY,
	BIMod_descripcion NVARCHAR(255)
);
----------------------------CREACIÓN DE TABLAS FÁCTICAS----------------------------
----------------------------------Tabla de ventas----------------------------------
CREATE TABLE [CUADRADITOS_DE_RICOTA].[BI_Ventas] (
    BIVen_fecha INT NOT NULL,
    BIVen_sucursal INT NOT NULL,

    BIVen_totalFacturado DECIMAL(18,2),
    BIVen_cantFActuras INT,
	BIVen_sumTiempoFabricacion int
);

ALTER TABLE [CUADRADITOS_DE_RICOTA].[BI_Ventas]
ADD CONSTRAINT PK_BI_Ventas PRIMARY KEY (BIVen_fecha,BIVen_sucursal);
GO

----------------------------Tabla de compras----------------------------
CREATE TABLE [CUADRADITOS_DE_RICOTA].[BI_Compras](
	BICom_fecha INT NOT NULL,
	BICom_material INT NOT NULL,
    BICom_sucursal int not null,

	BICom_totalImportes DECIMAL(18,2),
    BICom_cantCompras decimal(18,2)
);

ALTER TABLE [CUADRADITOS_DE_RICOTA].[BI_Compras]
ADD CONSTRAINT PK_BI_fact_promociones PRIMARY KEY(BICom_fecha,BICom_material,BICom_sucursal)
GO

----------------------------Tabla de envios----------------------------
CREATE TABLE [CUADRADITOS_DE_RICOTA].[BI_Envios](
    BIEnv_fecha INT NOT NULL,
    BIEnv_localidadCliente INT NOT NULL,

	BIEnv_cantCumplidos INT,
	BIEnv_cantCompletados int,
    BIEnv_cantTotal INT,
    BIEnv_sumCosto DECIMAL(18,2)
);

ALTER TABLE [CUADRADITOS_DE_RICOTA].[BI_Envios]
ADD CONSTRAINT PK_BI_fact_envios PRIMARY KEY (BIEnv_fecha,BIEnv_localidadCliente);
GO

----------------------------Tabla de pedidos----------------------------
CREATE TABLE [CUADRADITOS_DE_RICOTA].[BI_Pedidos] (
    BIPed_modelo bigint NOT NULL, 
	BIPed_fecha int NOT NULL, 
	BIPed_sucursal INT NOT NULL, 
	BIPed_turno int NOT NULL, 
	BIPed_rangoEtario int NOT NULL, 
	BIPed_estado int NOT NULL,

	BIPed_cantidadSillones int,
    BIPed_cantidadPedidos int
);

ALTER TABLE [CUADRADITOS_DE_RICOTA].[BI_Pedidos]
ADD CONSTRAINT PK_BI_fact_Pagos PRIMARY KEY (BIPed_modelo,BIPed_fecha,BIPed_sucursal,BIPed_turno,BIPed_rangoEtario,BIPed_estado) 	
GO

----------------------------CREACION DE TABLAS TEMPORALES----------------------------
CREATE TABLE #ventasTemp (
    BIVen_fecha INT,
    BIVen_sucursal INT,

    BIVen_totalFacturado DECIMAL(18,2),
    BIVen_cantFActuras INT,
	BIVen_sumTiempoFabricacion time(0)
);


----------------------------Tabla de compras----------------------------
CREATE TABLE #comprasTemp(
	BICom_fecha INT  ,
	BICom_material INT  ,
    BICom_sucursal int  ,

	BICom_totalImportes DECIMAL(18,2),
    BICom_cantCompras decimal(18,2)
);


----------------------------Tabla de envios----------------------------
CREATE TABLE #enviosTemp(
    BIEnv_fecha INT  ,
    BIEnv_localidadCliente INT  ,

	BIEnv_cantCumplidos INT  ,
    BIEnv_cantTotal INT  ,
	BIEnv_cantCompletados int,
    BIEnv_sumCosto DECIMAL(18,2)
);

----------------------------Tabla de pedidos----------------------------
CREATE TABLE #PedidosTemp (
    BIPed_modelo bigint  , 
	BIPed_fecha int  , 
	BIPed_sucursal INT  , 
	BIPed_turno int  , 
	BIPed_rangoEtario int  , 
	BIPed_estado int  ,

	BIPed_cantidadSillones int,
    BIPed_cantidadPedidos int
);

	
GO


----------------------------CREACION DE VISTAS----------------------------

-- 1----------------------------------------------------------------------------
create view [CUADRADITOS_DE_RICOTA].[Ganancias] as 
select  BITie_anio,BITie_mes,(sum(BIVen_totalFacturado)-sum(BICom_totalImportes)) ganancias
from [CUADRADITOS_DE_RICOTA].BI_Compras
                        join [CUADRADITOS_DE_RICOTA].BI_DIM_Tiempo on BITie_codigo= BICom_fecha
                        join [CUADRADITOS_DE_RICOTA].BI_Ventas on BIVen_fecha=BITie_codigo
group by BITie_anio,BITie_mes
go
-- 2----------------------------------------------------------------------------
create view [CUADRADITOS_DE_RICOTA].[FacturaPromedioMensual] as 
select  prov_nombre,BITie_anio,BITie_cuatrimestre,(sum(BIVen_totalFacturado)/sum(BIVen_cantFActuras))PromedioFacturado
from [CUADRADITOS_DE_RICOTA].[BI_Ventas] join [CUADRADITOS_DE_RICOTA].[BI_dim_Sucursal] on BIVen_sucursal=BISuc_codigo
                                            join [CUADRADITOS_DE_RICOTA].[BI_dim_Ubicacion] on BISuc_localidad=BIUbi_codigo
                                            join [CUADRADITOS_DE_RICOTA].[BI_Provincia] on BIUbi_provincia=prov_codigo
                                            join [CUADRADITOS_DE_RICOTA].BI_dim_Tiempo on BIVen_fecha=BITie_codigo
                                        
group by prov_nombre,BITie_cuatrimestre,BITie_anio
go
-- 3 ---------------------------------------------------------------------------- a probar
create view [CUADRADITOS_DE_RICOTA].[RendimientoDeModelos] as  
select BIRang_descripcion,T.BITie_anio,T.BITie_cuatrimestre,BIUbi_localidad,
----------------------------------
(select top 1 f.BIMod_descripcion
from(
    select 
        row_number() over (order by sum(BIPed_cantidadSillones) desc ) as fila,
        BIMod_descripcion
        from  [CUADRADITOS_DE_RICOTA].BI_Pedidos join [CUADRADITOS_DE_RICOTA].BI_DIM_Tiempo Ts on BITie_codigo=BIPed_fecha
                                                    join [CUADRADITOS_DE_RICOTA].BI_DIM_Sucursal on BIPed_sucursal=BISuc_codigo
													join [CUADRADITOS_DE_RICOTA].BI_DIM_Modelo_sillon ON BIPed_modelo = BIMod_codigo
            where BIPed_rangoEtario=BIRang_codigo and Ts.BITie_cuatrimestre=T.BITie_cuatrimestre and Ts.BITie_anio=T.BITie_anio and BISuc_localidad=BIUbi_codigo
		group by BIMod_codigo,BIMod_descripcion
)as f where fila=1 ) modeloI 
,
(select top 1 f.BIMod_descripcion
from(
    select 
        row_number() over (order by sum(BIPed_cantidadSillones) desc )as fila,
        BIMod_descripcion
        from  [CUADRADITOS_DE_RICOTA].BI_Pedidos join [CUADRADITOS_DE_RICOTA].BI_DIM_Tiempo on BITie_codigo=BIPed_fecha
                                                    join [CUADRADITOS_DE_RICOTA].BI_DIM_Sucursal on BIPed_sucursal=BISuc_codigo
													join [CUADRADITOS_DE_RICOTA].BI_DIM_Modelo_sillon ON BIPed_modelo = BIMod_codigo
            where BIPed_rangoEtario=BIRang_codigo and BITie_cuatrimestre=T.BITie_cuatrimestre and BITie_anio=T.BITie_anio and BISuc_localidad=BIUbi_codigo
		group by BIMod_codigo,BIMod_descripcion
)as f where fila=2) as modeloII 
---------------------------------
,
(select top 1 f.BIMod_descripcion
from(
    select 
        row_number() over (order by sum(BIPed_cantidadSillones) desc )as fila,
        BIMod_descripcion
        from  [CUADRADITOS_DE_RICOTA].BI_Pedidos join [CUADRADITOS_DE_RICOTA].BI_DIM_Tiempo on BITie_codigo=BIPed_fecha
                                                    join [CUADRADITOS_DE_RICOTA].BI_DIM_Sucursal on BIPed_sucursal=BISuc_codigo
													join [CUADRADITOS_DE_RICOTA].BI_DIM_Modelo_sillon ON BIPed_modelo = BIMod_codigo
            where BIPed_rangoEtario=BIRang_codigo and BITie_cuatrimestre=T.BITie_cuatrimestre and BITie_anio=T.BITie_anio and BISuc_localidad=BIUbi_codigo
		group by BIMod_codigo,BIMod_descripcion
) as f where fila=3) as modeloIII 

from [CUADRADITOS_DE_RICOTA].BI_Pedidos join [CUADRADITOS_DE_RICOTA].BI_DIM_Tiempo T on BITie_codigo=BIPed_fecha
                                        join [CUADRADITOS_DE_RICOTA].BI_DIM_Sucursal on BIPed_sucursal=BISuc_codigo
                                        join [CUADRADITOS_DE_RICOTA].BI_dim_Ubicacion on BISuc_localidad=BIUbi_codigo
                                        join [CUADRADITOS_DE_RICOTA].BI_DIM_Rango_etario on BIPed_rangoEtario=BIRang_codigo
group by T.BITie_anio,T.BITie_cuatrimestre,BIUbi_localidad,BIUbi_codigo,BIRang_descripcion,BIRang_codigo
go   

-- 4----------------------------------------------------------------------------
create view [CUADRADITOS_DE_RICOTA].[VolumenDePedidos] as 

select BISuc_codigo,BITie_anio,BITie_mes,BITurn_descripcion,sum(BIPed_cantidadPedidos) cantidadPedidos
from [CUADRADITOS_DE_RICOTA].BI_Pedidos join [CUADRADITOS_DE_RICOTA].BI_DIM_Tiempo on BITie_codigo=BIPed_fecha
                                        join [CUADRADITOS_DE_RICOTA].BI_DIM_Sucursal on BIPed_sucursal=BISuc_codigo
                                        join [CUADRADITOS_DE_RICOTA].BI_DIM_Turno_venta on BIPed_turno=BITurn_codigo
    group by BITie_anio,BITie_mes,BITurn_descripcion,BISuc_codigo
go   
-- 5----------------------------------------------------------------------------
create view [CUADRADITOS_DE_RICOTA].[ConversionDePedidos] as 
select BIEst_descripcion,T.BITie_cuatrimestre,T.BITie_anio,BISuc_codigo,
(
    sum(BIPed_cantidadPedidos
)/(
    select sum(BIPed_cantidadPedidos)
    from [CUADRADITOS_DE_RICOTA].BI_Pedidos join [CUADRADITOS_DE_RICOTA].BI_DIM_Tiempo on BITie_codigo=BIPed_fecha
                                            join [CUADRADITOS_DE_RICOTA].BI_DIM_Estado_pedido on BIEst_codigo=BIPed_estado
        where BITie_cuatrimestre=T.BITie_cuatrimestre and BITie_anio=T.BITie_anio and BIPed_sucursal=BISuc_codigo
))*100 as PorcentajeDePedidos
from [CUADRADITOS_DE_RICOTA].BI_Pedidos join [CUADRADITOS_DE_RICOTA].BI_DIM_Tiempo T on BITie_codigo=BIPed_fecha
                                        join [CUADRADITOS_DE_RICOTA].BI_DIM_Sucursal on BIPed_sucursal=BISuc_codigo
                                        join [CUADRADITOS_DE_RICOTA].BI_DIM_Estado_pedido on BIEst_codigo=BIPed_estado
    group by BITie_cuatrimestre,BITie_anio,BISuc_codigo,BIEst_descripcion
go  

-- 6----------------------------------------------------------------------------
create view [CUADRADITOS_DE_RICOTA].[TiempoPromedioDeFabricacion] as 
select BITie_cuatrimestre,BITie_anio,BISuc_codigo,sum(BIVen_sumTiempoFabricacion)/sum(BIVen_cantFActuras)*100 as TiempoPromedio
from [CUADRADITOS_DE_RICOTA].BI_Ventas join [CUADRADITOS_DE_RICOTA].BI_DIM_Tiempo on BIVen_fecha=BITie_codigo
                                        join [CUADRADITOS_DE_RICOTA].BI_DIM_Sucursal on BIVen_sucursal=BISuc_codigo
    group by BITie_cuatrimestre,BITie_anio,BISuc_codigo
go   
-- 7----------------------------------------------------------------------------
create view [CUADRADITOS_DE_RICOTA].[PromedioDeCompras] as 
select BITie_anio,BITie_mes,sum(BICom_totalImportes)/sum(BICom_cantCompras) as promedioDeCompras
from [CUADRADITOS_DE_RICOTA].BI_Compras join [CUADRADITOS_DE_RICOTA].BI_DIM_Tiempo on BITie_codigo=BICom_fecha
    group by BITie_anio,BITie_mes
go   
-- 8----------------------------------------------------------------------------
create view [CUADRADITOS_DE_RICOTA].[ComprasPorTiepoDeMaterial] as 
select BITie_cuatrimestre,BITie_anio,BISuc_codigo,BIMat_descripcion,sum(BICom_totalImportes) Compras
from [CUADRADITOS_DE_RICOTA].BI_Compras join [CUADRADITOS_DE_RICOTA].BI_DIM_Tiempo on BITie_codigo=BICom_fecha
                                        join [CUADRADITOS_DE_RICOTA].BI_DIM_Sucursal on BISuc_codigo=BICom_sucursal
                                        join [CUADRADITOS_DE_RICOTA].BI_DIM_Material_tipo on BIMat_codigo=BICom_material
    group by BITie_cuatrimestre,BITie_anio,BISuc_codigo,BIMat_descripcion
go   
-- 9----------------------------------------------------------------------------
create view [CUADRADITOS_DE_RICOTA].[PorcentajeDeCumplimientoDeEnvios] as 
select BITie_mes,BITie_anio,sum(BIEnv_cantCumplidos)/sum(BIEnv_cantCompletados)*100 as enviosCumplidos
from [CUADRADITOS_DE_RICOTA].BI_Envios join [CUADRADITOS_DE_RICOTA].BI_DIM_Tiempo on BITie_codigo=BIEnv_fecha
    group by BITie_mes,BITie_anio
go   
-- 10----------------------------------------------------------------------------
create view [CUADRADITOS_DE_RICOTA].[LocalidadesMayorCostoEnvio] as 
select top 3 BIUbi_localidad
from [CUADRADITOS_DE_RICOTA].BI_Envios join [CUADRADITOS_DE_RICOTA].BI_DIM_Ubicacion on BIEnv_localidadCliente=BIUbi_codigo
                                        join [CUADRADITOS_DE_RICOTA].BI_Provincia on BIUbi_provincia=prov_codigo
group by BIUbi_codigo,BIUbi_localidad
order by sum(BIEnv_sumCosto)/sum(BIEnv_cantTotal)
go   

/*
--TODO esto ni idea q onda yo lo sacaria
----------------------------Índice para BI_fact_Ventas por CODIGO_TIEMPO y CODIGO_UBICACION----------------------------
CREATE INDEX IX_BI_fact_Ventas_TIEMPO_UBICACION ON GeDeDe.BI_fact_Ventas (CODIGO_TIEMPO, CODIGO_UBICACION);
GO
------------------------------Índice para BI_fact_Ventas por CODIGO_TIEMPO y CODIGO_TURNO------------------------------
CREATE INDEX IX_BI_fact_Ventas_TIEMPO_TURNO ON GeDeDe.BI_fact_Ventas (CODIGO_TIEMPO, CODIGO_TURNO);
GO
*/
----------------------------CREACION PROCEDURES DE MIGRACION----------------------------

CREATE PROCEDURE [CUADRADITOS_DE_RICOTA].[BI_Migrar_provincia]
AS
BEGIN
	print 'Migracion de provincia'
	INSERT INTO [CUADRADITOS_DE_RICOTA].[BI_Provincia] (prov_codigo,prov_nombre)
	SELECT prov_codigo,prov_nombre
	FROM [CUADRADITOS_DE_RICOTA].provincia

END;
GO

CREATE PROCEDURE [CUADRADITOS_DE_RICOTA].[BI_Migrar_material]
AS
BEGIN
	PRINT 'Migracion de material'
	INSERT INTO [CUADRADITOS_DE_RICOTA].[BI_DIM_Material_tipo] (BIMat_descripcion)
	values ('Tela'),('Madera'),('Relleno'),('Sin Tipo')
END
GO


CREATE PROCEDURE [CUADRADITOS_DE_RICOTA].[BI_Migrar_modelo]
AS
BEGIN
	PRINT 'Migracion de modelo'
	INSERT INTO [CUADRADITOS_DE_RICOTA].[BI_DIM_Modelo_sillon] (BIMod_codigo,BIMod_descripcion)
	select mod_codigo,mod_nombre from [CUADRADITOS_DE_RICOTA].ModeloSillon
END
GO

CREATE PROCEDURE [CUADRADITOS_DE_RICOTA].[BI_Migrar_Turno]
AS
BEGIN
	PRINT 'Migracion de Turnos de venta'
	INSERT INTO [CUADRADITOS_DE_RICOTA].[BI_DIM_Turno_venta] (BITurn_descripcion)
	VALUES ('08:00 - 14:00'),('14:00 - 20:00'),('Fuera de Horario')
END
GO

CREATE PROCEDURE [CUADRADITOS_DE_RICOTA].[BI_Migrar_Estado]
AS
BEGIN
	PRINT 'Migracion de estado'
	INSERT INTO [CUADRADITOS_DE_RICOTA].[BI_DIM_Estado_pedido] (BIEst_codigo,BIEst_descripcion)
	SELECT est_codigo,est_nombre
	FROM [CUADRADITOS_DE_RICOTA].Estado
	INSERT INTO [CUADRADITOS_DE_RICOTA].[BI_DIM_Estado_pedido] (BIEst_codigo,BIEst_descripcion)
	VALUES (9999,'En proceso')
END
GO

CREATE PROCEDURE [CUADRADITOS_DE_RICOTA].[BI_Migrar_rango_etario]
AS
BEGIN
	PRINT 'Migracion de rangos etarios'
	INSERT INTO [CUADRADITOS_DE_RICOTA].[BI_DIM_Rango_etario] (BIRang_descripcion)
	VALUES ('[<25)'),('[25 - 35)'),('[35 - 50]'),('(>50]')
END
GO



--despues las ubis va a haber q seguir cagando
CREATE PROCEDURE [CUADRADITOS_DE_RICOTA].[BI_Migrar_Sucursales]
AS
BEGIN
	PRINT 'Migracion de Sucursales'
	DECLARE sucursal_cursor CURSOR FOR 
		SELECT sucu_codigo, sucu_localidad FROM [CUADRADITOS_DE_RICOTA].[Sucursal]

	DECLARE @sucu_codigo int, @sucu_localidad int
	declare @provincia int, @locNombre NVARCHAR(255)
	
	OPEN sucursal_cursor
	FETCH sucursal_cursor into @sucu_codigo,@sucu_localidad;
	
	WHILE(@@FETCH_STATUS = 0)
		BEGIN
			IF NOT EXISTS (SELECT 1 FROM [CUADRADITOS_DE_RICOTA].BI_DIM_Ubicacion WHERE (BIUbi_codigo = @sucu_localidad))
			BEGIN
				set @locNombre =   (select loc_nombre from [CUADRADITOS_DE_RICOTA].Localidad where loc_codigo=@sucu_localidad)
				set @provincia =  ( select loc_provincia from [CUADRADITOS_DE_RICOTA].Localidad where loc_codigo=@sucu_localidad)
				INSERT INTO [CUADRADITOS_DE_RICOTA].BI_DIM_Ubicacion (BIUbi_codigo, BIUbi_localidad,BIUbi_provincia) 
															VALUES (@sucu_localidad,   @locNombre,     @provincia)
			END

			INSERT INTO [CUADRADITOS_DE_RICOTA].[BI_DIM_Sucursal] (BISuc_codigo,BISuc_localidad ) 
											VALUES (@sucu_codigo,@sucu_localidad  )
			
			FETCH sucursal_cursor into @sucu_codigo,@sucu_localidad;
		END

	CLOSE sucursal_cursor;
	DEALLOCATE sucursal_cursor;
END
GO

CREATE PROCEDURE [CUADRADITOS_DE_RICOTA].[BI_Migrar_Ventas]
AS
BEGIN
	PRINT 'Migracion de Ventas'
	
	declare @Factura_Anio int, @Factura_Mes int, @Factura_Cuatrimestre int
	declare @total_factura decimal(18,2),@fecha_factura datetime2(6),@sucursal int,@codigo_fac int
	declare @fechaPed datetime2(6)
	declare @CODIGO_TIEMPO INT
	declare @tiempoFabri int
	
	DECLARE ventas_cursor CURSOR FOR
		SELECT fact_total, fact_fecha,fact_sucursal,fac_codigo
		FROM [CUADRADITOS_DE_RICOTA].Factura
		group by fact_total, fact_fecha,fact_sucursal,fac_codigo

	OPEN ventas_cursor;
	FETCH NEXT FROM ventas_cursor into @total_factura,@fecha_factura,@sucursal,@codigo_fac
	WHILE (@@FETCH_STATUS = 0)
		BEGIN
			
			--Tiempo
			SET @Factura_Anio = YEAR(@fecha_factura);
			SET @Factura_Mes = MONTH(@fecha_factura);
			SET @Factura_Cuatrimestre = [CUADRADITOS_DE_RICOTA].obtenerCuatrimestre(@fecha_factura);
			IF NOT EXISTS (SELECT 1 FROM [CUADRADITOS_DE_RICOTA].BI_DIM_Tiempo WHERE BITie_cuatrimestre = @Factura_Cuatrimestre and BITie_anio = @Factura_Anio and BITie_mes = @Factura_Mes)
			BEGIN
				INSERT INTO [CUADRADITOS_DE_RICOTA].BI_DIM_Tiempo (BITie_cuatrimestre,BITie_anio,BITie_mes) VALUES (@Factura_Cuatrimestre, @Factura_Anio, @Factura_Mes)
			END

			SELECT @CODIGO_TIEMPO = BITie_codigo  FROM [CUADRADITOS_DE_RICOTA].BI_DIM_Tiempo WHERE BITie_cuatrimestre = @Factura_Cuatrimestre and BITie_anio = @Factura_Anio and BITie_mes = @Factura_Mes
				
			select top 1 @fechaPed = ped_fecha from [CUADRADITOS_DE_RICOTA].Factura join [CUADRADITOS_DE_RICOTA].detalle_facturacion on fac_detalle=detF_codigo
															 join [CUADRADITOS_DE_RICOTA].Detalle_pedido on detF_detallePedido=detP_codigo
															 join [CUADRADITOS_DE_RICOTA].Pedido on ped_codigo =detP_pedido
			where fac_codigo=@codigo_fac
			set @tiempoFabri= DATEDIFF(hour,@fechaPed,@fecha_factura)

			INSERT INTO #ventasTemp(BIVen_fecha   ,BIVen_sucursal,BIVen_totalFacturado,BIVen_cantFActuras,BIVen_sumTiempoFabricacion) 
			VALUES 						(@CODIGO_TIEMPO,@sucursal     ,@total_factura      ,1                 ,@tiempoFabri)
			FETCH NEXT FROM ventas_cursor into @total_factura,@fecha_factura,@sucursal,@codigo_fac
		END
	CLOSE ventas_cursor;
	DEALLOCATE ventas_cursor;

	INSERT INTO [CUADRADITOS_DE_RICOTA].BI_Ventas(BIVen_fecha   ,BIVen_sucursal,BIVen_totalFacturado,BIVen_cantFActuras,BIVen_sumTiempoFabricacion)
	SELECT BIVen_fecha,BIVen_sucursal,                                    sum(BIVen_totalFacturado),sum(BIVen_cantFActuras),sum(BIVen_sumTiempoFabricacion)
	FROM #ventasTemp
	group by BIVen_fecha,BIVen_sucursal
END
GO

CREATE PROCEDURE [CUADRADITOS_DE_RICOTA].[BI_Migrar_Envios]
AS
BEGIN
	print 'Migracion de Envios'

	DECLARE @fecha_programada datetime2(6), @fecha_entrega datetime2(6), @costo_envio decimal(18,2),@costo_subida decimal(18,2),
	  @localidad int, @anio_fecha int, @mes_fecha int, @cuatrimestre_fecha int,
	 @envios_a_tiempo int, @envioRealizado int
	DECLARE @codigo_tiempo int
	

	DECLARE cursor_envios CURSOR FOR
	SELECT DISTINCT	env_fechaProgramada,
		env_fechaEntrega,
		env_ImporteTraslado,
		env_ImporteDeSubida,
		clie_localidad
	FROM [CUADRADITOS_DE_RICOTA].Envio 	join [CUADRADITOS_DE_RICOTA].Factura on fac_codigo= env_factura
										JOIN [CUADRADITOS_DE_RICOTA].Cliente ON fac_cliente = clie_codigo

	OPEN cursor_envios 
	FETCH NEXT FROM cursor_envios INTO  @fecha_programada, @fecha_entrega,  @costo_envio,@costo_subida,  @localidad
	WHILE @@FETCH_STATUS = 0
		BEGIN
			
			--ubi
			IF NOT EXISTS (SELECT 1 FROM [CUADRADITOS_DE_RICOTA].BI_DIM_Ubicacion WHERE BIUbi_codigo = @localidad)
			BEGIN
				set @locNombre =   (select loc_nombre from [CUADRADITOS_DE_RICOTA].Localidad where loc_codigo=@localidad)
				set @provincia =  ( select loc_provincia from [CUADRADITOS_DE_RICOTA].Localidad where loc_codigo=@localidad)
				INSERT INTO [CUADRADITOS_DE_RICOTA].BI_DIM_Ubicacion (BIUbi_codigo, BIUbi_localidad,BIUbi_provincia) 
															VALUES (@localidad,   @locNombre,     @provincia)
			END
			--Tiempo
			SET @anio_fecha = YEAR(@fecha_programada);
			SET @mes_fecha = MONTH(@fecha_programada);
			SET @cuatrimestre_fecha = [CUADRADITOS_DE_RICOTA].obtenerCuatrimestre(@fecha_programada);
			IF NOT EXISTS (SELECT 1 FROM [CUADRADITOS_DE_RICOTA].BI_DIM_Tiempo WHERE BITie_cuatrimestre = @cuatrimestre_fecha and BITie_anio = @anio_fecha and BITie_mes = @mes_fecha)
			BEGIN
				INSERT INTO [CUADRADITOS_DE_RICOTA].BI_DIM_Tiempo (BITie_cuatrimestre,BITie_anio,BITie_mes) VALUES (@cuatrimestre_fecha, @anio_fecha, @mes_fecha)
			END
			--se hizo la entrega
			if (@fecha_entrega is not null)
			begin
				--cumpleEntrega
				set @envios_a_tiempo = [CUADRADITOS_DE_RICOTA].cumplioEntrega(@fecha_programada, @fecha_entrega) 
				set @envioRealizado = 1
			END ELSE
			BEGIN
				set @envioRealizado = 0
				set @envios_a_tiempo = 0
			end	
			--traerCodigos
			select @codigo_tiempo = BITie_codigo from [CUADRADITOS_DE_RICOTA].BI_DIM_Tiempo where BITie_anio = @anio_fecha and BITie_cuatrimestre = @cuatrimestre_fecha and BITie_mes = @mes_fecha

			INSERT INTO #enviosTemp(BIEnv_fecha   ,BIEnv_localidadCliente,BIEnv_cantCumplidos,BIEnv_cantTotal,BIEnv_cantCompletados,BIEnv_sumCosto)
			values                 (@codigo_tiempo,@localidad      ,@envios_a_tiempo   ,1              ,@envioRealizado      ,@costo_envio+@costo_subida)

			FETCH NEXT FROM cursor_envios INTO @fecha_programada, @fecha_entrega,  @costo_envio,@costo_subida,  @localidad
		END
	CLOSE cursor_envios
	deallocate cursor_envios

	INSERT INTO [CUADRADITOS_DE_RICOTA].BI_Envios (BIEnv_fecha,BIEnv_localidadCliente,BIEnv_cantCumplidos,BIEnv_cantTotal,BIEnv_cantCompletados,BIEnv_sumCosto)
	SELECT 										   BIEnv_fecha,BIEnv_localidadCliente,sum(BIEnv_cantCumplidos),sum(BIEnv_cantTotal),sum(BIEnv_cantCompletados),sum(BIEnv_sumCosto)
	FROM #enviosTemp
	GROUP BY BIEnv_fecha,BIEnv_localidadCliente
END
GO

CREATE PROCEDURE [CUADRADITOS_DE_RICOTA].[BI_Migrar_Compras]
AS
BEGIN
	print 'Migracion de Compras'

	declare @anio_fecha int, @mes_fecha int, @cuatrimestre_fecha int
	declare @fecha datetime2(6),@sucursal int,@material int,@total decimal(18,2)
	declare @codigo_tiempo int,@material_codigo int

	declare c1 cursor for
	 	select com_sucursal,detC_material,com_fecha,com_total
		from [CUADRADITOS_DE_RICOTA].Compra join [CUADRADITOS_DE_RICOTA].Detalle_compra on detC_compra=com_codigo
											

	open c1
	fetch next from c1 into @sucursal,@material,@fecha,@total 
	while @@FETCH_STATUS = 0
	begin
		--Tiempo
		SET @anio_fecha = YEAR(@fecha);
		SET @mes_fecha = MONTH(@fecha);
		SET @cuatrimestre_fecha = [CUADRADITOS_DE_RICOTA].obtenerCuatrimestre(@fecha);
		IF NOT EXISTS (SELECT 1 FROM [CUADRADITOS_DE_RICOTA].BI_DIM_Tiempo WHERE BITie_cuatrimestre = @cuatrimestre_fecha and BITie_anio = @anio_fecha and BITie_mes = @mes_fecha)
		BEGIN
			INSERT INTO [CUADRADITOS_DE_RICOTA].BI_DIM_Tiempo (BITie_cuatrimestre,BITie_anio,BITie_mes) VALUES (@cuatrimestre_fecha, @anio_fecha, @mes_fecha)
		END

		select @codigo_tiempo = BITie_codigo from [CUADRADITOS_DE_RICOTA].BI_DIM_Tiempo where BITie_anio = @anio_fecha and BITie_cuatrimestre = @cuatrimestre_fecha and BITie_mes = @mes_fecha
		--Material

		
		select @material_codigo = BIMat_codigo from [CUADRADITOS_DE_RICOTA].BI_DIM_Material_tipo where BIMat_descripcion=[CUADRADITOS_DE_RICOTA].tipoMaterial(@material)

		--Sucursal es el mismo codigo q en la base

		insert into #comprasTemp(BICom_fecha,BICom_material,BICom_sucursal,BICom_totalImportes,BICom_cantCompras)
				values(@codigo_tiempo,@material_codigo,@sucursal,@total,1)

		fetch next from c1 into @sucursal,@material,@fecha,@total 
	end
	close c1
	deallocate c1

	INSERT INTO [CUADRADITOS_DE_RICOTA].BI_Compras(BICom_fecha,BICom_material,BICom_sucursal,BICom_totalImportes,BICom_cantCompras)
	SELECT BICom_fecha,BICom_material,BICom_sucursal,sum(BICom_totalImportes),sum(BICom_cantCompras)
	FROM #comprasTemp
	GROUP BY BICom_fecha,BICom_material,BICom_sucursal

END
GO

CREATE PROCEDURE [CUADRADITOS_DE_RICOTA].[BI_Migrar_Pedidos]
AS
BEGIN
 print 'Migracion de pedidos'
	
	declare @sucursal int
	declare @codigo_tiempo int,@fecha datetime2(6),@anio_fecha int, @mes_fecha int, @cuatrimestre_fecha int
	declare @turno int
	declare @estado int
	declare @modelo bigint
	declare @cantidad bigint
	declare  @rango_etario nvarchar(255),@edad_cliente int, @fecha_cliente datetime2(6),	 @codigo_rango_etario int

	declare c1 cursor for
		SELECT ped_fecha,
				ped_sucursal,
				ped_estado,
				--sin join
				sill_modelo, --det/sill
				clie_fechaNacimiento,--(clie)
				detP_cantidad--det

		FROM [CUADRADITOS_DE_RICOTA].Pedidos join [CUADRADITOS_DE_RICOTA].Detalle_pedido on detP_pedido=ped_codigo
											join [CUADRADITOS_DE_RICOTA].Sillon on detP_sillon=sill_codigo
											join [CUADRADITOS_DE_RICOTA].Cliente on ped_cliente=clie_codigo

	open c1
	fetch next from c1 into @fecha,@sucursal,@estado,@modelo,@fecha_cliente,@cantidad
	while @@FETCH_STATUS = 0
	begin
		--TIEMPO
		SET @anio_fecha = YEAR(@fecha);
		SET @mes_fecha = MONTH(@fecha);
		SET @cuatrimestre_fecha = [CUADRADITOS_DE_RICOTA].obtenerCuatrimestre(@fecha);
		IF NOT EXISTS (SELECT 1 FROM [CUADRADITOS_DE_RICOTA].BI_DIM_Tiempo WHERE BITie_cuatrimestre = @cuatrimestre_fecha and BITie_anio = @anio_fecha and BITie_mes = @mes_fecha)
		BEGIN
			INSERT INTO [CUADRADITOS_DE_RICOTA].BI_DIM_Tiempo (BITie_cuatrimestre,BITie_anio,BITie_mes) VALUES (@cuatrimestre_fecha, @anio_fecha, @mes_fecha)
		END

		select @codigo_tiempo = BITie_codigo from [CUADRADITOS_DE_RICOTA].BI_DIM_Tiempo where BITie_anio = @anio_fecha and BITie_cuatrimestre = @cuatrimestre_fecha and BITie_mes = @mes_fecha

		--RANGO ETARIO DEL CLIENTe			
		--TODO por ahi hacer chequeo de q exista el cliente ?
		select @edad_cliente = [CUADRADITOS_DE_RICOTA].obtenerEdad(@fecha_cliente)
		select @rango_etario = [CUADRADITOS_DE_RICOTA].obtenerRangoEtario(@edad_cliente)
		select @codigo_rango_etario = BIRang_codigo from [CUADRADITOS_DE_RICOTA].BI_DIM_Rango_etario WHERE @rango_etario = BIRang_descripcion
	
		----MODELO
		--trajiste el modelo con el codigo, asi q modelo ya es cod
		----SUCU
		--mismo
		-----TURNO
		select @turno = BITurn_codigo  from [CUADRADITOS_DE_RICOTA].BI_DIM_Turno_venta where BITurn_descripcion=CUADRADITOS_DE_RICOTA.obtenerTurnos (@fecha)
		----ESTADO

		if (@estado is null)
			set @estado=9999 -- estado en proceso, cancelado y terminado estan con si codigo ya subidos a una dimension


		INSERT INTO #PedidosTemp (BIPed_modelo,BIPed_fecha,BIPed_sucursal,BIPed_turno,BIPed_rangoEtario,BIPed_estado,BIPed_cantidadSillones,BIPed_cantidadPedidos)
		VALUES(@modelo,@codigo_tiempo,@sucursal,                          @turno,     @codigo_rango_etario,@estado, @cantidad, 1)

		fetch next from c1 into @fecha,@sucursal,@estado,@modelo,@fecha_cliente,@cantidad
	end
	close c1
	deallocate c1

	INSERT INTO [CUADRADITOS_DE_RICOTA].BI_Pedidos (BIPed_modelo,BIPed_fecha,BIPed_sucursal,BIPed_turno,BIPed_rangoEtario,BIPed_estado,BIPed_cantidadSillones,BIPed_cantidadPedidos)
	SELECT BIPed_modelo,BIPed_fecha,BIPed_sucursal,BIPed_turno,BIPed_rangoEtario,BIPed_estado,sum(BIPed_cantidadSillones),sum(BIPed_cantidadPedidos)
	FROM #PedidosTemp
	GROUP BY BIPed_modelo,BIPed_fecha,BIPed_sucursal,BIPed_turno,BIPed_rangoEtario,BIPed_estado
END
GO

----------------------------EJECUCIÓN DE PROCEDURES: MIGRACIÓN DE MODELO OLTP A MODELO BI----------------------------

 BEGIN TRANSACTION
 BEGIN TRY
	EXECUTE [CUADRADITOS_DE_RICOTA].[BI_Migrar_provincia]
	EXECUTE [CUADRADITOS_DE_RICOTA].[BI_Migrar_material]
	EXECUTE [CUADRADITOS_DE_RICOTA].[BI_Migrar_modelo]
	EXECUTE [CUADRADITOS_DE_RICOTA].[BI_Migrar_Turno]
	EXECUTE [CUADRADITOS_DE_RICOTA].[BI_Migrar_Estado]
	EXECUTE [CUADRADITOS_DE_RICOTA].[BI_Migrar_rango_etario]
	EXECUTE [CUADRADITOS_DE_RICOTA].[BI_Migrar_Sucursales]
	EXECUTE [CUADRADITOS_DE_RICOTA].[BI_Migrar_Ventas]
	EXECUTE [CUADRADITOS_DE_RICOTA].[BI_Migrar_Envios]
	EXECUTE [CUADRADITOS_DE_RICOTA].[BI_Migrar_Compras]
	EXECUTE [CUADRADITOS_DE_RICOTA].[BI_Migrar_Pedidos]
	
	
	
	
	
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
	THROW 50001, 'Error al cargar el modelo de BI, ninguna tabla fue cargada',1;
END CATCH

 IF (EXISTS (SELECT 1 FROM [CUADRADITOS_DE_RICOTA].[BI_Provincia])
   AND EXISTS (SELECT 1 FROM [CUADRADITOS_DE_RICOTA].[BI_DIM_Ubicacion])
   AND EXISTS (SELECT 1 FROM [CUADRADITOS_DE_RICOTA].[BI_DIM_Material_tipo])
   AND EXISTS (SELECT 1 FROM [CUADRADITOS_DE_RICOTA].[BI_DIM_Modelo_sillon])
   AND EXISTS (SELECT 1 FROM [CUADRADITOS_DE_RICOTA].[BI_DIM_Turno_venta])
   AND EXISTS (SELECT 1 FROM [CUADRADITOS_DE_RICOTA].[BI_DIM_Tiempo])
   AND EXISTS (SELECT 1 FROM [CUADRADITOS_DE_RICOTA].[BI_DIM_Estado_pedido])
   AND EXISTS (SELECT 1 FROM [CUADRADITOS_DE_RICOTA].[BI_DIM_Rango_etario])
   AND EXISTS (SELECT 1 FROM [CUADRADITOS_DE_RICOTA].[BI_DIM_Sucursal])
   AND EXISTS (SELECT 1 FROM [CUADRADITOS_DE_RICOTA].[BI_Compras])
   AND EXISTS (SELECT 1 FROM [CUADRADITOS_DE_RICOTA].[BI_Ventas])
   AND EXISTS (SELECT 1 FROM [CUADRADITOS_DE_RICOTA].[BI_Envios])
   AND EXISTS (SELECT 1 FROM [CUADRADITOS_DE_RICOTA].[BI_Pedidos])
   )

   BEGIN
	PRINT 'Modelo de BI creado y cargado correctamente.';
	COMMIT TRANSACTION;
   END
	 ELSE
   BEGIN
    ROLLBACK TRANSACTION;
	THROW 50002, 'Hubo un error al cargar una o más tablas. Rollback Transaction: ninguna tabla fue cargada en la base.',1;
   END

GO