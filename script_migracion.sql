USE GD1C2025;
GO
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'CUADRADITOS_DE_RICOTA')
BEGIN
    EXEC('CREATE SCHEMA [CUADRADITOS_DE_RICOTA]');
END
GO

IF OBJECT_ID('[CUADRADITOS_DE_RICOTA].[CLEAN]', 'P') IS NOT NULL
    DROP PROCEDURE [CUADRADITOS_DE_RICOTA].[CLEAN];
GO

IF OBJECT_ID('[CUADRADITOS_DE_RICOTA].[CREATE_DDL]', 'P') IS NOT NULL
    DROP PROCEDURE [CUADRADITOS_DE_RICOTA].[CREATE_DDL];
GO


IF OBJECT_ID('[CUADRADITOS_DE_RICOTA].[CREATE_DML]', 'P') IS NOT NULL
    DROP PROCEDURE [CUADRADITOS_DE_RICOTA].[CREATE_DML];
GO
-- aca tenes q hacer la limpieza de lo q esta antes


CREATE PROCEDURE [CUADRADITOS_DE_RICOTA].[CLEAN]
AS
BEGIN
    IF EXISTS (SELECT * FROM sys.tables WHERE name = 'Envio')
        DROP TABLE [CUADRADITOS_DE_RICOTA].[Envio];
    
    IF EXISTS (SELECT * FROM sys.tables WHERE name = 'Factura')
        DROP TABLE [CUADRADITOS_DE_RICOTA].[Factura];
    
    IF EXISTS (SELECT * FROM sys.tables WHERE name = 'detalle_facturacion')
        DROP TABLE [CUADRADITOS_DE_RICOTA].[detalle_facturacion];
    
    IF EXISTS (SELECT * FROM sys.tables WHERE name = 'Detalle_pedido')
        DROP TABLE [CUADRADITOS_DE_RICOTA].[Detalle_pedido];
    
    IF EXISTS (SELECT * FROM sys.tables WHERE name = 'Pedido')
        DROP TABLE [CUADRADITOS_DE_RICOTA].[Pedido];
    
    IF EXISTS (SELECT * FROM sys.tables WHERE name = 'Estado')
        DROP TABLE [CUADRADITOS_DE_RICOTA].[Estado];
    
    IF EXISTS (SELECT * FROM sys.tables WHERE name = 'PedidoCancelacion')
        DROP TABLE [CUADRADITOS_DE_RICOTA].[PedidoCancelacion];
    
    IF EXISTS (SELECT * FROM sys.tables WHERE name = 'Compra')
        DROP TABLE [CUADRADITOS_DE_RICOTA].[Compra];
    
    IF EXISTS (SELECT * FROM sys.tables WHERE name = 'Detalle_compra')
        DROP TABLE [CUADRADITOS_DE_RICOTA].[Detalle_compra];
    
    IF EXISTS (SELECT * FROM sys.tables WHERE name = 'Telefono')
        DROP TABLE [CUADRADITOS_DE_RICOTA].[Telefono];
    
    IF EXISTS (SELECT * FROM sys.tables WHERE name = 'proveedor')
        DROP TABLE [CUADRADITOS_DE_RICOTA].[proveedor];
    
    IF EXISTS (SELECT * FROM sys.tables WHERE name = 'Sucursal')
        DROP TABLE [CUADRADITOS_DE_RICOTA].[Sucursal];
    
    IF EXISTS (SELECT * FROM sys.tables WHERE name = 'Cliente')
        DROP TABLE [CUADRADITOS_DE_RICOTA].[Cliente];
    
    IF EXISTS (SELECT * FROM sys.tables WHERE name = 'Localidad')
        DROP TABLE [CUADRADITOS_DE_RICOTA].[Localidad];
    
    IF EXISTS (SELECT * FROM sys.tables WHERE name = 'Provincia')
        DROP TABLE [CUADRADITOS_DE_RICOTA].[Provincia];
    
    IF EXISTS (SELECT * FROM sys.tables WHERE name = 'Relleno')
        DROP TABLE [CUADRADITOS_DE_RICOTA].[Relleno];
    
    IF EXISTS (SELECT * FROM sys.tables WHERE name = 'Tela')
        DROP TABLE [CUADRADITOS_DE_RICOTA].[Tela];
    
    IF EXISTS (SELECT * FROM sys.tables WHERE name = 'Madera')
        DROP TABLE [CUADRADITOS_DE_RICOTA].[Madera];
    
    IF EXISTS (SELECT * FROM sys.tables WHERE name = 'sillon_material')
        DROP TABLE [CUADRADITOS_DE_RICOTA].[sillon_material];
    
    IF EXISTS (SELECT * FROM sys.tables WHERE name = 'Material')
        DROP TABLE [CUADRADITOS_DE_RICOTA].[Material];
    
    IF EXISTS (SELECT * FROM sys.tables WHERE name = 'Sillon')
        DROP TABLE [CUADRADITOS_DE_RICOTA].[Sillon];
    
    IF EXISTS (SELECT * FROM sys.tables WHERE name = 'Dimension')
        DROP TABLE [CUADRADITOS_DE_RICOTA].[Dimension];
    
    IF EXISTS (SELECT * FROM sys.tables WHERE name = 'ModeloSillon')
        DROP TABLE [CUADRADITOS_DE_RICOTA].[ModeloSillon];
END
GO




CREATE PROCEDURE [CUADRADITOS_DE_RICOTA].[CREATE_DDL]
AS
BEGIN
--TABLAS
CREATE TABLE [CUADRADITOS_DE_RICOTA].[ModeloSillon](
    mod_codigo bigint not null,--pk
    mod_nombre NVARCHAR(255),
    mod_descripcion NVARCHAR(255),
    mod_precio DECIMAL(18,2)
);

CREATE TABLE [CUADRADITOS_DE_RICOTA].[Dimension](
    med_codigo int IDENTITY(1,1),--pk
    med_alto DECIMAL(18,2),
    med_ancho DECIMAL(18,2),
    med_profundidad DECIMAL(18,2),
    med_precio DECIMAL(18,2)
);

CREATE TABLE [CUADRADITOS_DE_RICOTA].[Sillon](
    sill_codigo bigint not null,--pk
    sill_modelo bigint,--fk
    sill_dimension int --fk
);


CREATE TABLE [CUADRADITOS_DE_RICOTA].[Material](
    mat_codigo int IDENTITY(1,1),--pk
    mat_precio DECIMAL(18,2),
    mat_descripcion NVARCHAR(255),
    mat_nombre NVARCHAR(255)
);

CREATE TABLE [CUADRADITOS_DE_RICOTA].[sillon_material](
    sima_sillon bigint not null,--pk fk
    sima_material int not NULL, --pk fk
);

CREATE TABLE [CUADRADITOS_DE_RICOTA].[Madera](
    mad_codigo int IDENTITY(1,1),--pk
    mad_material int,--fk
    mad_dureza NVARCHAR(255),
    mad_color NVARCHAR(255)
);

CREATE TABLE [CUADRADITOS_DE_RICOTA].[Tela](
    tela_codigo int IDENTITY(1,1),--pk
    tela_material int,--fk
    tela_color NVARCHAR(255),
    tela_textura NVARCHAR(255)    
);

CREATE TABLE [CUADRADITOS_DE_RICOTA].[Relleno](
    rell_codigo int IDENTITY(1,1),--pk
    rell_material int,--fk
    rell_densidad DECIMAL(18,2)
);

CREATE TABLE [CUADRADITOS_DE_RICOTA].[Provincia](
    prov_codigo int IDENTITY(1,1),--pk
    prov_nombre NVARCHAR(255)
);

CREATE TABLE [CUADRADITOS_DE_RICOTA].[Localidad](
    loc_codigo int IDENTITY(1,1),--pk
    loc_nombre NVARCHAR(255),
    loc_provincia int --fk
);

CREATE TABLE [CUADRADITOS_DE_RICOTA].[Cliente](
    clie_codigo int IDENTITY(1,1), --pk
    clie_dni bigint,
    clie_nombre NVARCHAR(255),
    clie_apellido NVARCHAR(255),
    clie_fechaNacimiento DATETIME2(6),
    clie_direccion NVARCHAR(255),
    clie_mail NVARCHAR(255),
    clie_localidad int--fk
);

CREATE TABLE [CUADRADITOS_DE_RICOTA].[Sucursal](
    sucu_codigo bigint not null,--pk
    sucu_direccion NVARCHAR(255),
    sucu_mail NVARCHAR(255),
    sucu_localidad int--fk
);

CREATE TABLE [CUADRADITOS_DE_RICOTA].[proveedor](
    pro_codigo int IDENTITY(1,1),--pk
    pro_razonSocial NVARCHAR(255),
    pro_cuit NVARCHAR(255),
    pro_direccion NVARCHAR(255),
    pro_mail NVARCHAR(255),
    pro_localidad int --fk
);

CREATE TABLE [CUADRADITOS_DE_RICOTA].[Telefono](
    tel_codigo int IDENTITY(1,1),--pk
    tel_numero NVARCHAR(255),
    tel_cliente int,--fk
    tel_sucursal bigint,--fk
    tel_proveedor int--fk
);

CREATE TABLE [CUADRADITOS_DE_RICOTA].[Detalle_compra](
    detC_codigo int IDENTITY(1,1),
    detC_material int,--fk
    detC_precioUnitario DECIMAL(18,2),
    detC_cantidad DECIMAL(18,0),
    detC_subtotal DECIMAL(18,2)
);

CREATE TABLE [CUADRADITOS_DE_RICOTA].[Compra](
    com_codigo int IDENTITY(1,1),--pk
    com_sucursal bigint,--fk
    com_proveedor int,--fk
    com_fecha DATETIME2(6),
    com_detalle int,--fk
    com_total DECIMAL(18,2),
    com_numero DECIMAL(18,0)
);

CREATE TABLE [CUADRADITOS_DE_RICOTA].[PedidoCancelacion](
    pedCan_codigo int IDENTITY(1,1),--pk
    pedCan_fecha DATETIME2(6),
    pedCan_motivo VARCHAR(255)
);

CREATE TABLE [CUADRADITOS_DE_RICOTA].[Estado](
    est_codigo int IDENTITY(1,1),--pk
    est_nombre NVARCHAR(255)
);

CREATE TABLE [CUADRADITOS_DE_RICOTA].[Pedido](
    ped_codigo int IDENTITY(1,1),--pk
    ped_sucursal bigint,--fk
    ped_cliente int,--fk
    ped_fecha DATETIME2(6),
    ped_total DECIMAL(18,2),
    ped_estado int,--fk
    ped_cancelacion int,--fk
    ped_numero DECIMAL(18,0)
);

CREATE TABLE [CUADRADITOS_DE_RICOTA].[Detalle_pedido](
    detP_codigo int IDENTITY(1,1),--pk
    detP_cantidad bigint,
    detP_precio DECIMAL(18,2),
    detP_pedido int,--fk
    detP_subtotal DECIMAL(18,2),
    detP_sillon bigint--sk
);

CREATE TABLE [CUADRADITOS_DE_RICOTA].[detalle_facturacion](
    detF_codigo int IDENTITY(1,1),--pk
    detF_detallePedido int,--fk
    detF_precioUnitario DECIMAL(18,2),
    detF_cantidad DECIMAL(18,0),
    detF_subtotal DECIMAL(18,2)
);

CREATE TABLE [CUADRADITOS_DE_RICOTA].[Factura](
    fac_codigo int IDENTITY(1,1),--pk
    fac_cliente int,--fk
    fac_numero bigint,
    fac_sucursal bigint,--fk
    fac_fecha DATETIME2(6),
    fac_detalle int,--fk
    fac_total DECIMAL(38,2)
);

CREATE TABLE [CUADRADITOS_DE_RICOTA].[Envio](
    env_codigo int IDENTITY(1,1),--pk
    env_factura int,--fk
    env_fechaProgramada DATETIME2(6),
    env_fechaEntrega DATETIME2(6),
    env_importeTraslado DECIMAL(18,2),
    env_importeDeSubida DECIMAL(18,2),
    env_total DECIMAL(18,2),
    env_numero DECIMAL(18,0)
);

--PKS

ALTER TABLE [CUADRADITOS_DE_RICOTA].[ModeloSillon]
ADD CONSTRAINT PK_ModeloSillon PRIMARY KEY (mod_codigo);

ALTER TABLE [CUADRADITOS_DE_RICOTA].[Dimension]
ADD CONSTRAINT PK_Dimension PRIMARY KEY (med_codigo);

ALTER TABLE [CUADRADITOS_DE_RICOTA].[Sillon]
ADD CONSTRAINT PK_Sillon PRIMARY KEY (sill_codigo);

ALTER TABLE [CUADRADITOS_DE_RICOTA].[Material]
ADD CONSTRAINT PK_Material PRIMARY KEY (mat_codigo);

ALTER TABLE [CUADRADITOS_DE_RICOTA].[sillon_material]
ADD CONSTRAINT PK_sillon_material PRIMARY KEY (sima_sillon,sima_material);

ALTER TABLE [CUADRADITOS_DE_RICOTA].[Madera]
ADD CONSTRAINT PK_Madera PRIMARY KEY (mad_codigo);

ALTER TABLE [CUADRADITOS_DE_RICOTA].[Tela]
ADD CONSTRAINT PK_Tela PRIMARY KEY (tela_codigo);

ALTER TABLE [CUADRADITOS_DE_RICOTA].[Relleno]
ADD CONSTRAINT PK_Relleno PRIMARY KEY (rell_codigo);

ALTER TABLE [CUADRADITOS_DE_RICOTA].[Provincia]
ADD CONSTRAINT PK_Provincia PRIMARY KEY (prov_codigo);

ALTER TABLE [CUADRADITOS_DE_RICOTA].[Localidad]
ADD CONSTRAINT PK_Localidad PRIMARY KEY (loc_codigo);

ALTER TABLE [CUADRADITOS_DE_RICOTA].[Cliente]
ADD CONSTRAINT PK_Cliente PRIMARY KEY (clie_codigo);

ALTER TABLE [CUADRADITOS_DE_RICOTA].[Sucursal]
ADD CONSTRAINT PK_Sucursal PRIMARY KEY (sucu_codigo);

ALTER TABLE [CUADRADITOS_DE_RICOTA].[Proveedor]
ADD CONSTRAINT PK_Proveedor PRIMARY KEY (pro_codigo);

ALTER TABLE [CUADRADITOS_DE_RICOTA].[Telefono]
ADD CONSTRAINT PK_Telefono PRIMARY KEY (tel_codigo);

ALTER TABLE [CUADRADITOS_DE_RICOTA].[Detalle_compra]
ADD CONSTRAINT PK_Detalle_compra PRIMARY KEY (detC_codigo);

ALTER TABLE [CUADRADITOS_DE_RICOTA].[Compra]
ADD CONSTRAINT PK_Compra PRIMARY KEY (com_codigo);

ALTER TABLE [CUADRADITOS_DE_RICOTA].[PedidoCancelacion]
ADD CONSTRAINT PK_PedidoCancelacion PRIMARY KEY (pedCan_codigo);

ALTER TABLE [CUADRADITOS_DE_RICOTA].[Estado]
ADD CONSTRAINT PK_Estado PRIMARY KEY (est_codigo);

ALTER TABLE [CUADRADITOS_DE_RICOTA].[Pedido]
ADD CONSTRAINT PK_Pedido PRIMARY KEY (ped_codigo);

ALTER TABLE [CUADRADITOS_DE_RICOTA].[Detalle_pedido]
ADD CONSTRAINT PK_Detalle_pedido PRIMARY KEY (detP_codigo);

ALTER TABLE [CUADRADITOS_DE_RICOTA].[detalle_facturacion]
ADD CONSTRAINT PK_detalle_facturacion PRIMARY KEY (detF_codigo);

ALTER TABLE [CUADRADITOS_DE_RICOTA].[Factura]
ADD CONSTRAINT PK_Factura PRIMARY KEY (fac_codigo);

ALTER TABLE [CUADRADITOS_DE_RICOTA].[Envio]
ADD CONSTRAINT PK_Envio PRIMARY KEY (env_codigo);



--FKS


ALTER TABLE [CUADRADITOS_DE_RICOTA].[Sillon]
ADD CONSTRAINT FK_Sillon_ModeloSillon
FOREIGN KEY (sill_modelo) REFERENCES [CUADRADITOS_DE_RICOTA].ModeloSillon(mod_codigo);

ALTER TABLE [CUADRADITOS_DE_RICOTA].[Sillon]
ADD CONSTRAINT FK_Sillon_Dimension
FOREIGN KEY (sill_dimension) REFERENCES [CUADRADITOS_DE_RICOTA].Dimension(med_codigo);


ALTER TABLE [CUADRADITOS_DE_RICOTA].[sillon_material]
ADD CONSTRAINT FK_sillon_material_Sillon
FOREIGN KEY (sima_sillon) REFERENCES [CUADRADITOS_DE_RICOTA].Sillon(sill_codigo);

ALTER TABLE [CUADRADITOS_DE_RICOTA].[sillon_material]
ADD CONSTRAINT FK_sillon_material_Material
FOREIGN KEY (sima_material) REFERENCES [CUADRADITOS_DE_RICOTA].Material(mat_codigo);


ALTER TABLE [CUADRADITOS_DE_RICOTA].[Madera]
ADD CONSTRAINT FK_Madera_Material
FOREIGN KEY (mad_material) REFERENCES [CUADRADITOS_DE_RICOTA].Material(mat_codigo);


ALTER TABLE [CUADRADITOS_DE_RICOTA].[Tela]
ADD CONSTRAINT FK_Tela_Material
FOREIGN KEY (tela_material) REFERENCES [CUADRADITOS_DE_RICOTA].Material(mat_codigo);


ALTER TABLE [CUADRADITOS_DE_RICOTA].[Relleno]
ADD CONSTRAINT FK_Relleno_Material
FOREIGN KEY (rell_material) REFERENCES [CUADRADITOS_DE_RICOTA].Material(mat_codigo);


ALTER TABLE [CUADRADITOS_DE_RICOTA].[Localidad]
ADD CONSTRAINT FK_Localidad_Provincia
FOREIGN KEY (loc_provincia) REFERENCES [CUADRADITOS_DE_RICOTA].Provincia(prov_codigo);


ALTER TABLE [CUADRADITOS_DE_RICOTA].[Cliente]
ADD CONSTRAINT FK_Ciente_Localidad
FOREIGN KEY (clie_localidad) REFERENCES [CUADRADITOS_DE_RICOTA].Localidad(loc_codigo);


ALTER TABLE [CUADRADITOS_DE_RICOTA].[Sucursal]
ADD CONSTRAINT FK_Sucursal_Localidad
FOREIGN KEY (sucu_localidad) REFERENCES [CUADRADITOS_DE_RICOTA].Localidad(loc_codigo);


ALTER TABLE [CUADRADITOS_DE_RICOTA].[Proveedor]
ADD CONSTRAINT FK_Proveedor_Localidad
FOREIGN KEY (pro_localidad) REFERENCES [CUADRADITOS_DE_RICOTA].Localidad(loc_codigo);


ALTER TABLE [CUADRADITOS_DE_RICOTA].[Telefono]
ADD CONSTRAINT FK_Telefono_Cliente
FOREIGN KEY (tel_cliente) REFERENCES [CUADRADITOS_DE_RICOTA].Cliente(clie_codigo);

ALTER TABLE [CUADRADITOS_DE_RICOTA].[Telefono]
ADD CONSTRAINT FK_Telefono_Sucursal
FOREIGN KEY (tel_sucursal) REFERENCES [CUADRADITOS_DE_RICOTA].Sucursal(sucu_codigo);

ALTER TABLE [CUADRADITOS_DE_RICOTA].[Telefono]
ADD CONSTRAINT FK_Telefono_Proveedor
FOREIGN KEY (tel_proveedor) REFERENCES [CUADRADITOS_DE_RICOTA].Proveedor(pro_codigo);


ALTER TABLE [CUADRADITOS_DE_RICOTA].[Detalle_compra]
ADD CONSTRAINT FK_Detalle_compra_Material
FOREIGN KEY (detC_material) REFERENCES [CUADRADITOS_DE_RICOTA].Material(mat_codigo);


ALTER TABLE [CUADRADITOS_DE_RICOTA].[Compra]
ADD CONSTRAINT FK_Compra_Sucursal
FOREIGN KEY (com_sucursal) REFERENCES [CUADRADITOS_DE_RICOTA].Sucursal(sucu_codigo);

ALTER TABLE [CUADRADITOS_DE_RICOTA].[Compra]
ADD CONSTRAINT FK_Compra_Proveedor
FOREIGN KEY (com_proveedor) REFERENCES [CUADRADITOS_DE_RICOTA].Proveedor(pro_codigo);

ALTER TABLE [CUADRADITOS_DE_RICOTA].[Compra]
ADD CONSTRAINT FK_Compra_Detalle_compra
FOREIGN KEY (com_detalle) REFERENCES [CUADRADITOS_DE_RICOTA].Detalle_compra(detC_codigo);


ALTER TABLE [CUADRADITOS_DE_RICOTA].[Pedido]
ADD CONSTRAINT FK_Pedido_Sucursal
FOREIGN KEY (ped_sucursal) REFERENCES [CUADRADITOS_DE_RICOTA].Sucursal(sucu_codigo);

ALTER TABLE [CUADRADITOS_DE_RICOTA].[Pedido]
ADD CONSTRAINT FK_Pedido_Cliente
FOREIGN KEY (ped_cliente) REFERENCES [CUADRADITOS_DE_RICOTA].Cliente(clie_codigo);

ALTER TABLE [CUADRADITOS_DE_RICOTA].[Pedido]
ADD CONSTRAINT FK_Pedido_Estado
FOREIGN KEY (ped_estado) REFERENCES [CUADRADITOS_DE_RICOTA].Estado(est_codigo);

ALTER TABLE [CUADRADITOS_DE_RICOTA].[Pedido]
ADD CONSTRAINT FK_Pedido_Cancelacion
FOREIGN KEY (ped_cancelacion) REFERENCES [CUADRADITOS_DE_RICOTA].PedidoCancelacion(pedCan_codigo);


ALTER TABLE [CUADRADITOS_DE_RICOTA].[Detalle_pedido]
ADD CONSTRAINT FK_Detalle_pedido_Pedido
FOREIGN KEY (detP_pedido) REFERENCES [CUADRADITOS_DE_RICOTA].Pedido(ped_codigo);

ALTER TABLE [CUADRADITOS_DE_RICOTA].[Detalle_pedido]
ADD CONSTRAINT FK_Detalle_pedido_Sillon
FOREIGN KEY (detP_sillon) REFERENCES [CUADRADITOS_DE_RICOTA].Sillon(sill_codigo);


ALTER TABLE [CUADRADITOS_DE_RICOTA].[detalle_facturacion]
ADD CONSTRAINT FK_detalle_facturacion_Detalle_pedido
FOREIGN KEY (detF_detallePedido) REFERENCES [CUADRADITOS_DE_RICOTA].Detalle_pedido(detP_codigo);


ALTER TABLE [CUADRADITOS_DE_RICOTA].[Factura]
ADD CONSTRAINT FK_Factura_Cleinte
FOREIGN KEY (fac_cliente) REFERENCES [CUADRADITOS_DE_RICOTA].Cliente(clie_codigo);

ALTER TABLE [CUADRADITOS_DE_RICOTA].[Factura]
ADD CONSTRAINT FK_Factura_Sucursal
FOREIGN KEY (fac_sucursal) REFERENCES [CUADRADITOS_DE_RICOTA].Sucursal(sucu_codigo);

ALTER TABLE [CUADRADITOS_DE_RICOTA].[Factura]
ADD CONSTRAINT FK_Factura_detalle_facturacion
FOREIGN KEY (fac_detalle) REFERENCES [CUADRADITOS_DE_RICOTA].detalle_facturacion(detF_codigo);


ALTER TABLE [CUADRADITOS_DE_RICOTA].[Envio]
ADD CONSTRAINT FK_Envio_Factura
FOREIGN KEY (env_factura) REFERENCES [CUADRADITOS_DE_RICOTA].Factura(fac_codigo);

END;
GO



CREATE PROCEDURE [CUADRADITOS_DE_RICOTA].[CREATE_DML]
AS
BEGIN   
        PRINT 'cargando tabla ModeloSillon'
    BEGIN
        INSERT INTO [CUADRADITOS_DE_RICOTA].[ModeloSillon] (mod_codigo,mod_nombre,mod_descripcion,mod_precio)
        SELECT distinct [Sillon_Modelo_Codigo],[Sillon_Modelo],[Sillon_Modelo_Descripcion],[Sillon_Modelo_Precio]
        FROM [GD1C2025].[gd_esquema].[Maestra]
        where Sillon_Modelo_Codigo is not null
    END;
        PRINT 'carga tabla Dimension'
    BEGIN
        INSERT INTO [CUADRADITOS_DE_RICOTA].[Dimension] (med_alto,med_ancho,med_profundidad,med_precio)
        SELECT distinct [Sillon_Medida_Alto],[Sillon_Medida_Ancho],[Sillon_Medida_Profundidad],[Sillon_Medida_Precio]
        FROM [GD1C2025].[gd_esquema].[Maestra]
        where Sillon_Medida_Alto is not null
    END;
        PRINT 'carga tabla Sillon'
    BEGIN
        INSERT INTO [CUADRADITOS_DE_RICOTA].[Sillon] (sill_codigo,sill_modelo,sill_dimension)
        SELECT distinct CAST([Sillon_Codigo] AS bigint),[Sillon_Modelo_Codigo],D.med_codigo
        FROM [GD1C2025].[gd_esquema].[Maestra] 
        JOIN [CUADRADITOS_DE_RICOTA].[Dimension] D on [Sillon_Medida_Alto]+[Sillon_Medida_Ancho]+[Sillon_Medida_Profundidad]+[Sillon_Medida_Precio]=med_alto+med_ancho+med_profundidad+med_precio
        where Sillon_Codigo is not null 
    END;
        PRINT 'carga tabla Material'
    BEGIN
        INSERT INTO [CUADRADITOS_DE_RICOTA].[Material] (mat_precio,mat_descripcion,mat_nombre)
        SELECT distinct [Material_Precio],[Material_Descripcion],[Material_Nombre]
        FROM [GD1C2025].[gd_esquema].[Maestra]
        where Material_Precio is not null
    END;
    PRINT 'carga tabla sillon_material'
    BEGIN
        INSERT INTO [CUADRADITOS_DE_RICOTA].[sillon_material] (sima_sillon, sima_material)
        SELECT DISTINCT [Sillon_Codigo], M.mat_codigo
        FROM [GD1C2025].[gd_esquema].[Maestra] Maestra
        JOIN [CUADRADITOS_DE_RICOTA].[Material] M 
            ON Maestra.[Material_Descripcion] = M.mat_descripcion 
            AND Maestra.[Material_Nombre] = M.mat_nombre
            AND Maestra.[Material_Precio] = M.mat_precio
        WHERE Maestra.[Sillon_Codigo] IS NOT NULL 
          AND Maestra.[Material_Descripcion] IS NOT NULL
    END;

        PRINT 'cargar tabla Madera'
    BEGIN
        INSERT INTO [CUADRADITOS_DE_RICOTA].[Madera] (mad_material,mad_dureza,mad_color)
        select distinct mat_codigo,[Madera_Dureza],[Madera_Color]
        from [GD1C2025].[gd_esquema].[Maestra] join [CUADRADITOS_DE_RICOTA].Material on mat_descripcion=[Material_Descripcion]
        where Material_Tipo = 'Madera'
    END;
        PRINT 'carga tabla Tela'
    BEGIN
        INSERT INTO [CUADRADITOS_DE_RICOTA].[Tela](tela_material,tela_color,tela_textura)
        select distinct mat_codigo,Tela_Color,Tela_Textura
        from [GD1C2025].[gd_esquema].[Maestra] join [CUADRADITOS_DE_RICOTA].Material on mat_descripcion=[Material_Descripcion]
        where Material_Tipo = 'Tela'
    END;
        PRINT 'carga tabla Relleno'
    BEGIN
        INSERT INTO [CUADRADITOS_DE_RICOTA].[Relleno](rell_material,rell_densidad)
        select distinct mat_codigo,Relleno_Densidad
        from [GD1C2025].[gd_esquema].[Maestra] join [CUADRADITOS_DE_RICOTA].Material on mat_descripcion=[Material_Descripcion]
        where Material_Tipo = 'Relleno'
    END;
        PRINT 'carga tabla Provincia' 
        /*Las prov se encuentran en tres filas, para cliente, suscursal y proveedor, sin embargo cliente cuenta con las 24 provincias posibles asi q las tomaremos de ahi*/
    BEGIN
        INSERT INTO [CUADRADITOS_DE_RICOTA].[Provincia](prov_nombre)
        select distinct Cliente_Provincia
        from [GD1C2025].[gd_esquema].[Maestra]
        WHERE Cliente_Provincia is not null
    END;
        PRINT 'carga tabla Localidad'
    BEGIN
        INSERT into [CUADRADITOS_DE_RICOTA].[Localidad] (loc_nombre,loc_provincia)
            select distinct Cliente_Localidad,prov_codigo
            from [GD1C2025].[gd_esquema].[Maestra] JOIN [CUADRADITOS_DE_RICOTA].Provincia on Cliente_Provincia=prov_nombre
            WHERE Cliente_Localidad is not null
        union --Union descarta lineas iguales(Union all no)
            select distinct Sucursal_Localidad,prov_codigo
            from [GD1C2025].[gd_esquema].[Maestra] JOIN [CUADRADITOS_DE_RICOTA].Provincia on Sucursal_Provincia=prov_nombre
            where Sucursal_Localidad is not null
        union
            select distinct Proveedor_Localidad,prov_codigo
            from [GD1C2025].[gd_esquema].[Maestra] JOIN [CUADRADITOS_DE_RICOTA].Provincia on Proveedor_Provincia=prov_nombre
            where Proveedor_Localidad is not null
    END;
        PRINT 'carga tabla Cliente'
    BEGIN
        INSERT into [CUADRADITOS_DE_RICOTA].[Cliente] (clie_dni,clie_nombre,clie_apellido,clie_fechaNacimiento,clie_direccion,clie_mail,clie_localidad)
        select distinct Cliente_Dni,Cliente_Nombre,Cliente_Apellido,Cliente_FechaNacimiento,Cliente_Direccion,Cliente_Mail,loc_codigo
        from [GD1C2025].[gd_esquema].[Maestra]  JOIN [CUADRADITOS_DE_RICOTA].[Provincia] on Cliente_Provincia=prov_nombre
                                                join [CUADRADITOS_DE_RICOTA].[Localidad] on Cliente_Localidad=loc_nombre and prov_codigo=loc_provincia
        where Cliente_Dni is not null
    END;
        PRINT 'carga tabla Sucursal'
    BEGIN
        INSERT INTO [CUADRADITOS_DE_RICOTA].[Sucursal] (sucu_codigo,sucu_direccion,sucu_mail,sucu_localidad)
        select distinct Sucursal_NroSucursal,Sucursal_Direccion,Sucursal_mail,loc_codigo
        from [GD1C2025].[gd_esquema].[Maestra]  JOIN [CUADRADITOS_DE_RICOTA].[Provincia] on Sucursal_Provincia=prov_nombre
                                                join [CUADRADITOS_DE_RICOTA].[Localidad] on Sucursal_Localidad=loc_nombre and prov_codigo=loc_provincia
        where Sucursal_NroSucursal is not null
    END;
        PRINT 'carga tabla Proveedor'
    BEGIN
        INSERT INTO [CUADRADITOS_DE_RICOTA].[proveedor] (pro_razonSocial,pro_cuit,pro_direccion,pro_mail,pro_localidad)
        select distinct Proveedor_RazonSocial,Proveedor_Cuit,Proveedor_Direccion,Proveedor_Mail,loc_codigo
        from [GD1C2025].[gd_esquema].[Maestra]  JOIN [CUADRADITOS_DE_RICOTA].[Provincia] on Proveedor_Provincia=prov_nombre
                                                join [CUADRADITOS_DE_RICOTA].[Localidad] on Proveedor_Localidad=loc_nombre and prov_codigo=loc_provincia
        where Proveedor_RazonSocial is not null
    END;
        PRINT 'carga tabla Telefono'
    BEGIN
        INSERT INTO [CUADRADITOS_DE_RICOTA].[Telefono] (tel_numero,tel_cliente,tel_sucursal,tel_proveedor)
            select distinct Proveedor_Telefono,null,null,pro_codigo
            from [GD1C2025].[gd_esquema].[Maestra] JOIN [CUADRADITOS_DE_RICOTA].[proveedor] on pro_razonSocial=Proveedor_RazonSocial
            where Proveedor_RazonSocial is not null        union
            select distinct Sucursal_telefono,null,sucu_codigo,null
            from [GD1C2025].[gd_esquema].[Maestra] JOIN [CUADRADITOS_DE_RICOTA].[Sucursal] on Sucursal_NroSucursal=sucu_codigo
            where Sucursal_NroSucursal is not null
        union
            select distinct Cliente_Telefono,clie_codigo,null,null
            from [GD1C2025].[gd_esquema].[Maestra] JOIN [CUADRADITOS_DE_RICOTA].[Cliente] on    clie_dni    +clie_nombre    +clie_apellido    +clie_fechaNacimiento    +clie_direccion    +clie_mail = 
                                                                                                Cliente_Dni +Cliente_Nombre +Cliente_Apellido +Cliente_FechaNacimiento +Cliente_Direccion +Cliente_Mail
            where Cliente_Telefono is not null
    END;
        PRINT 'carga tabla Detalle_compra'
    BEGIN
        INSERT INTO [CUADRADITOS_DE_RICOTA].[Detalle_compra](detC_material,detC_precioUnitario,detC_cantidad,detC_subtotal)
        select distinct mat_codigo,Detalle_Compra_Precio,Detalle_Compra_Cantidad,Detalle_Compra_SubTotal
        from [GD1C2025].[gd_esquema].[Maestra] JOIN [CUADRADITOS_DE_RICOTA].Material on mat_descripcion=Material_Descripcion
        where Material_Descripcion is not null
    end;
        PRINT 'carga tabla Compra'
    BEGIN
        INSERT INTO [CUADRADITOS_DE_RICOTA].[Compra](com_sucursal,com_proveedor,com_fecha,com_detalle,com_total,com_numero)
        select distinct sucu_codigo,pro_codigo,Compra_Fecha,detC_codigo,Compra_Total,Compra_Numero
        from [GD1C2025].[gd_esquema].[Maestra]  JOIN [CUADRADITOS_DE_RICOTA].[Detalle_compra] on Detalle_Compra_Cantidad +Detalle_Compra_Precio +Detalle_Compra_SubTotal =
                                                                                                detC_cantidad           +detC_precioUnitario   +detC_subtotal                                                JOIN [CUADRADITOS_DE_RICOTA].[proveedor] on Proveedor_RazonSocial=pro_razonSocial
                                                left JOIN [CUADRADITOS_DE_RICOTA].[Sucursal] on Sucursal_NroSucursal=sucu_codigo
        where Compra_Numero is not null
    END;
        PRINT 'carga tabla PedidoCancelacion'
    BEGIN
        INSERT INTO [CUADRADITOS_DE_RICOTA].[PedidoCancelacion](pedCan_fecha,pedCan_motivo)
        select distinct Pedido_Cancelacion_Fecha,Pedido_Cancelacion_Motivo
        from [GD1C2025].[gd_esquema].[Maestra] 
        where Pedido_Cancelacion_Fecha is not null
    END;
        PRINT 'carga tabla Estado'
    BEGIN
        INSERT INTO [CUADRADITOS_DE_RICOTA].[Estado](est_nombre)  
        select distinct Pedido_Estado
        from [GD1C2025].[gd_esquema].[Maestra] 
        where Pedido_Estado is not null   
    END;
    PRINT 'carga tabla Pedido'
    BEGIN
        INSERT INTO [CUADRADITOS_DE_RICOTA].[Pedido](ped_sucursal,ped_cliente,ped_fecha,ped_total,ped_estado,ped_cancelacion,ped_numero)
        select distinct sucu_codigo,clie_codigo,Pedido_Fecha,Pedido_Total,est_codigo,pedCan_codigo,Pedido_Numero
        from [GD1C2025].[gd_esquema].[Maestra]  
        JOIN [CUADRADITOS_DE_RICOTA].[Sucursal] on Sucursal_NroSucursal=sucu_codigo
        JOIN [CUADRADITOS_DE_RICOTA].[Cliente] on clie_dni = Cliente_Dni
        JOIN [CUADRADITOS_DE_RICOTA].[Estado] on Pedido_Estado=est_nombre
        LEFT JOIN [CUADRADITOS_DE_RICOTA].[PedidoCancelacion] on Pedido_Cancelacion_Fecha=pedCan_fecha and Pedido_Cancelacion_Motivo=pedCan_motivo
        where Pedido_Numero is not null
    END;
        PRINT 'carga tabla Detalle_pedido'
    BEGIN
        INSERT INTO [CUADRADITOS_DE_RICOTA].[Detalle_pedido](detP_cantidad,detP_precio,detP_pedido,detP_subtotal,detP_sillon)    
        select distinct Detalle_Pedido_Cantidad,Detalle_Pedido_Precio,ped_codigo,Detalle_Pedido_SubTotal,Sillon_Codigo
        from [GD1C2025].[gd_esquema].[Maestra]  JOIN [CUADRADITOS_DE_RICOTA].[Pedido] on Pedido_Numero=ped_numero
        where Detalle_Pedido_Cantidad is not null
    END;
    PRINT 'carga tabla detalle_facturacion'
    BEGIN
        INSERT INTO [CUADRADITOS_DE_RICOTA].[detalle_facturacion](detF_detallePedido,detF_precioUnitario,detF_cantidad,detF_subtotal)     
        SELECT DISTINCT detP_codigo, Detalle_Factura_Precio, Detalle_Factura_Cantidad, Detalle_Factura_SubTotal
        FROM [GD1C2025].[gd_esquema].[Maestra] M
        INNER JOIN [CUADRADITOS_DE_RICOTA].[Pedido] P ON P.ped_numero = M.Pedido_Numero
        INNER JOIN [CUADRADITOS_DE_RICOTA].[Detalle_pedido] DP ON DP.detP_pedido = P.ped_codigo
            AND DP.detP_cantidad = M.Detalle_Pedido_Cantidad
            AND DP.detP_precio = M.Detalle_Pedido_Precio
            AND DP.detP_subtotal = M.Detalle_Pedido_SubTotal
        WHERE M.Detalle_Factura_Cantidad IS NOT NULL
    END;
    PRINT 'carga tabla Factura'
    BEGIN
        INSERT INTO [CUADRADITOS_DE_RICOTA].[Factura](fac_cliente,fac_numero,fac_sucursal,fac_fecha,fac_detalle,fac_total)     
        SELECT DISTINCT clie_codigo, M.Factura_Numero, sucu_codigo, M.Factura_Fecha, detF_codigo, M.Factura_Total
        FROM [GD1C2025].[gd_esquema].[Maestra] M
        INNER JOIN [CUADRADITOS_DE_RICOTA].[Sucursal] S ON S.sucu_codigo = M.Sucursal_NroSucursal
        INNER JOIN [CUADRADITOS_DE_RICOTA].[Cliente] C ON C.clie_dni = M.Cliente_Dni
        INNER JOIN [CUADRADITOS_DE_RICOTA].[detalle_facturacion] DF ON  
            DF.detF_precioUnitario = M.Detalle_Factura_Precio AND
            DF.detF_cantidad = M.Detalle_Factura_Cantidad AND
            DF.detF_subtotal = M.Detalle_Factura_SubTotal
        WHERE M.Factura_Numero IS NOT NULL
    END;
    PRINT 'carga tabla Envio'
    BEGIN
        INSERT INTO [CUADRADITOS_DE_RICOTA].[Envio](env_factura,env_fechaProgramada,env_fechaEntrega,env_importeTraslado,env_importeDeSubida,env_total,env_numero)
        select distinct fac_codigo,Envio_Fecha_Programada,Envio_Fecha,Envio_ImporteTraslado,Envio_importeSubida,Envio_Total,Envio_Numero
        from [GD1C2025].[gd_esquema].[Maestra] 
        JOIN [CUADRADITOS_DE_RICOTA].[Factura] on fac_numero = Factura_Numero 
            AND fac_fecha = Factura_Fecha 
            AND fac_total = Factura_Total
        where Envio_Numero is not null
    END;
END;
GO


/* Ejecutamos los SP en una transaccion, para pasar de un estado consistente a otro consistente.*/
 BEGIN TRANSACTION
 BEGIN TRY
	EXEC [CUADRADITOS_DE_RICOTA].[CLEAN]
	EXEC [CUADRADITOS_DE_RICOTA].[CREATE_DDL];
	EXEC [CUADRADITOS_DE_RICOTA].[CREATE_DML];
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
	--THROW 50001, 'Error al cargar el modelo OLTP, ninguna tabla fue cargada',1;
    PRINT ERROR_MESSAGE();  -- Agrega esto
    PRINT ERROR_LINE();     -- Línea del error original
    PRINT ERROR_PROCEDURE(); -- Procedimiento que falló (si aplica)
    THROW; 
END CATCH

 IF (EXISTS (SELECT 1 FROM [CUADRADITOS_DE_RICOTA].[Pedido])
   AND EXISTS (SELECT 1 FROM [CUADRADITOS_DE_RICOTA].[Factura]))

   BEGIN
	PRINT 'Modelo OLTP creado y cargado correctamente.';
	COMMIT TRANSACTION;
   END
	 ELSE
   BEGIN
    ROLLBACK TRANSACTION;
	THROW 50002, 'Hubo un error al cargar una o más tablas. Rollback Transaction: ninguna tabla fue cargada en la base.',1;
   END

GO
