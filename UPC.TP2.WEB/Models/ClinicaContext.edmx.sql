
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 04/05/2017 14:50:38
-- Generated from EDMX file: E:\PROJECTS_VS\VS2017\ProyectoClinicaRP\UPC.TP2.WEB\Models\ClinicaContext.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [BD_CLINICA_RP];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_T_BASE_FINANCIERA]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[T_PLAN_BASE_FINANCIERA] DROP CONSTRAINT [FK_T_BASE_FINANCIERA];
GO
IF OBJECT_ID(N'[dbo].[FK_T_PLAN_BASE_LEGAL]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[T_PLAN_BASE_LEGAL] DROP CONSTRAINT [FK_T_PLAN_BASE_LEGAL];
GO
IF OBJECT_ID(N'[dbo].[FK__T_MUEBLE__codBie__571DF1D5]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[T_MUEBLE] DROP CONSTRAINT [FK__T_MUEBLE__codBie__571DF1D5];
GO
IF OBJECT_ID(N'[dbo].[FK_T_INMUEBLE_T_BIEN]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[T_INMUEBLE] DROP CONSTRAINT [FK_T_INMUEBLE_T_BIEN];
GO
IF OBJECT_ID(N'[dbo].[FK__T_BITACOR__idemp__4D94879B]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[T_BITACORA_INCIDENCIA] DROP CONSTRAINT [FK__T_BITACOR__idemp__4D94879B];
GO
IF OBJECT_ID(N'[dbo].[FK_T_BITACORA_INCIDENCIA_PLAN_DE_SALUD]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[T_BITACORA_INCIDENCIA] DROP CONSTRAINT [FK_T_BITACORA_INCIDENCIA_PLAN_DE_SALUD];
GO
IF OBJECT_ID(N'[dbo].[FK_T_SEGUIMIENTO_BITACORA_INCIDENCIA]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[T_SEGUIMIENTO] DROP CONSTRAINT [FK_T_SEGUIMIENTO_BITACORA_INCIDENCIA];
GO
IF OBJECT_ID(N'[dbo].[FK__T_COMPROB__id_pa__49C3F6B7]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[T_COMPROBANTE] DROP CONSTRAINT [FK__T_COMPROB__id_pa__49C3F6B7];
GO
IF OBJECT_ID(N'[dbo].[FK__T_CONFIGU__id_in__4AB81AF0]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[T_CONFIGURACION] DROP CONSTRAINT [FK__T_CONFIGU__id_in__4AB81AF0];
GO
IF OBJECT_ID(N'[dbo].[FK__T_EMPLEAD__codPe__1273C1CD]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[T_EMPLEADO] DROP CONSTRAINT [FK__T_EMPLEAD__codPe__1273C1CD];
GO
IF OBJECT_ID(N'[dbo].[FK__T_SOLICIT__idEmp__300424B4]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[T_SOLICITUD_MANTENIMIENTO] DROP CONSTRAINT [FK__T_SOLICIT__idEmp__300424B4];
GO
IF OBJECT_ID(N'[dbo].[FK__T_TECNICO__idEmp__15502E78]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[T_TECNICO_MANTENIMIENTO] DROP CONSTRAINT [FK__T_TECNICO__idEmp__15502E78];
GO
IF OBJECT_ID(N'[dbo].[FK_T_EMPLEADO_T_ESPECIALIDAD_MEDICA]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[T_EMPLEADO] DROP CONSTRAINT [FK_T_EMPLEADO_T_ESPECIALIDAD_MEDICA];
GO
IF OBJECT_ID(N'[dbo].[FK_T_PROGRAMACION_MEDICA_T_EMPLEADO]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[T_PROGRAMACION_MEDICA] DROP CONSTRAINT [FK_T_PROGRAMACION_MEDICA_T_EMPLEADO];
GO
IF OBJECT_ID(N'[dbo].[FK__T_EMPRESA__codPe__4D94879B]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[T_EMPRESA] DROP CONSTRAINT [FK__T_EMPRESA__codPe__4D94879B];
GO
IF OBJECT_ID(N'[dbo].[FK__T_MANTENI__codEm__534D60F1]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[T_MANTENIMIENTO_EQUIPO] DROP CONSTRAINT [FK__T_MANTENI__codEm__534D60F1];
GO
IF OBJECT_ID(N'[dbo].[FK__T_MUEBLE__codEmp__5812160E]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[T_MUEBLE] DROP CONSTRAINT [FK__T_MUEBLE__codEmp__5812160E];
GO
IF OBJECT_ID(N'[dbo].[FK__T_EQUIPO___codIn__2C3393D0]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[T_EQUIPO_MEDICO] DROP CONSTRAINT [FK__T_EQUIPO___codIn__2C3393D0];
GO
IF OBJECT_ID(N'[dbo].[FK__T_EQUIPO___codMu__4F7CD00D]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[T_EQUIPO_MEDICO] DROP CONSTRAINT [FK__T_EQUIPO___codMu__4F7CD00D];
GO
IF OBJECT_ID(N'[dbo].[FK__T_EQUIPO___idEqu__4CA06362]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[T_EQUIPO_USO] DROP CONSTRAINT [FK__T_EQUIPO___idEqu__4CA06362];
GO
IF OBJECT_ID(N'[dbo].[FK__T_EQUIPO___idEsp__5070F446]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[T_EQUIPO_MEDICO] DROP CONSTRAINT [FK__T_EQUIPO___idEsp__5070F446];
GO
IF OBJECT_ID(N'[dbo].[FK__T_MANTENI__idEqu__5535A963]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[T_MANTENIMIENTO_EQUIPO] DROP CONSTRAINT [FK__T_MANTENI__idEqu__5535A963];
GO
IF OBJECT_ID(N'[dbo].[FK__T_SOLICIT__idEqu__693CA210]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[T_SOLICITUD_MANTENIMIENTO] DROP CONSTRAINT [FK__T_SOLICIT__idEqu__693CA210];
GO
IF OBJECT_ID(N'[dbo].[FK_T_SERVICIO_ESPECIALIDAD]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[T_ESPECIALIDAD_SERVICIO] DROP CONSTRAINT [FK_T_SERVICIO_ESPECIALIDAD];
GO
IF OBJECT_ID(N'[dbo].[FK_T_PLAN_ESTRATEGIA_COMERCIAL]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[T_PLAN_ESTRATEGIA_COMERCIAL] DROP CONSTRAINT [FK_T_PLAN_ESTRATEGIA_COMERCIAL];
GO
IF OBJECT_ID(N'[dbo].[FK__T_PROGRAM__codIn__6754599E]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[T_PROGRAMACION_MEDICA] DROP CONSTRAINT [FK__T_PROGRAM__codIn__6754599E];
GO
IF OBJECT_ID(N'[dbo].[FK__T_PLAN_DE_SALUD1]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[T_PLAN_DE_SALUD] DROP CONSTRAINT [FK__T_PLAN_DE_SALUD1];
GO
IF OBJECT_ID(N'[dbo].[FK__T_PROYECT__id_in__656C112C]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[T_PROYECTO_PLANSALUD] DROP CONSTRAINT [FK__T_PROYECT__id_in__656C112C];
GO
IF OBJECT_ID(N'[dbo].[FK__T_MANTENI__codPl__5441852A]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[T_MANTENIMIENTO_EQUIPO] DROP CONSTRAINT [FK__T_MANTENI__codPl__5441852A];
GO
IF OBJECT_ID(N'[dbo].[FK__T_MANTENI__idSol__5629CD9C]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[T_MANTENIMIENTO_EQUIPO] DROP CONSTRAINT [FK__T_MANTENI__idSol__5629CD9C];
GO
IF OBJECT_ID(N'[dbo].[FK__T_MUEBLE__codMod__59063A47]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[T_MUEBLE] DROP CONSTRAINT [FK__T_MUEBLE__codMod__59063A47];
GO
IF OBJECT_ID(N'[dbo].[FK__T_PACIENT__codPe__59FA5E80]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[T_PACIENTE] DROP CONSTRAINT [FK__T_PACIENT__codPe__59FA5E80];
GO
IF OBJECT_ID(N'[dbo].[FK__T_RESERVA__id_pa__5DCAEF64]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[T_RESERVA_SERVICIO_SALUD] DROP CONSTRAINT [FK__T_RESERVA__id_pa__5DCAEF64];
GO
IF OBJECT_ID(N'[dbo].[FK_T_PLAN_PACIENTE_T_PACIENTE]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[T_PLAN_PACIENTE] DROP CONSTRAINT [FK_T_PLAN_PACIENTE_T_PACIENTE];
GO
IF OBJECT_ID(N'[dbo].[FK_T_PLAN_DE_SALUD]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[T_PLAN_BASE_FINANCIERA] DROP CONSTRAINT [FK_T_PLAN_DE_SALUD];
GO
IF OBJECT_ID(N'[dbo].[FK_T_PLAN]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[T_PLAN_BASE_LEGAL] DROP CONSTRAINT [FK_T_PLAN];
GO
IF OBJECT_ID(N'[dbo].[FK_T_PLAN_COMERCIAL]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[T_PLAN_ESTRATEGIA_COMERCIAL] DROP CONSTRAINT [FK_T_PLAN_COMERCIAL];
GO
IF OBJECT_ID(N'[dbo].[FK_T_PLAN_PACIENTE_T_PLAN_DE_SALUD]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[T_PLAN_PACIENTE] DROP CONSTRAINT [FK_T_PLAN_PACIENTE_T_PLAN_DE_SALUD];
GO
IF OBJECT_ID(N'[dbo].[FK__T_PLAN_MA__idTec__5EBF139D]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[T_PLAN_MANTENIMIENTO] DROP CONSTRAINT [FK__T_PLAN_MA__idTec__5EBF139D];
GO
IF OBJECT_ID(N'[dbo].[FK__T_RESERVA__id_se__5EBF139D]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[T_RESERVA_SERVICIO_SALUD] DROP CONSTRAINT [FK__T_RESERVA__id_se__5EBF139D];
GO
IF OBJECT_ID(N'[dbo].[FK__T_SOLICIT__idTec__6A30C649]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[T_SOLICITUD_MANTENIMIENTO] DROP CONSTRAINT [FK__T_SOLICIT__idTec__6A30C649];
GO
IF OBJECT_ID(N'[dbo].[FK_T_PERSONAT_PERSONA_PLANSALUD]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[T_PERSONA_PLANSALUD] DROP CONSTRAINT [FK_T_PERSONAT_PERSONA_PLANSALUD];
GO
IF OBJECT_ID(N'[dbo].[FK_T_PERSONA_PLANSALUDT_PLAN_DE_SALUD]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[T_PERSONA_PLANSALUD] DROP CONSTRAINT [FK_T_PERSONA_PLANSALUDT_PLAN_DE_SALUD];
GO
IF OBJECT_ID(N'[dbo].[FK_T_PROGRAMACION_MEDICAT_PERSONA]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[T_PROGRAMACION_MEDICA] DROP CONSTRAINT [FK_T_PROGRAMACION_MEDICAT_PERSONA];
GO
IF OBJECT_ID(N'[dbo].[FK_T_PLAN_SERVICIOT_PLAN_DE_SALUD]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[T_PLAN_SERVICIO] DROP CONSTRAINT [FK_T_PLAN_SERVICIOT_PLAN_DE_SALUD];
GO
IF OBJECT_ID(N'[dbo].[FK_T_ESPECIALIDAD_SERVICIOT_ESPECIALIDAD_MEDICA]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[T_ESPECIALIDAD_SERVICIO] DROP CONSTRAINT [FK_T_ESPECIALIDAD_SERVICIOT_ESPECIALIDAD_MEDICA];
GO
IF OBJECT_ID(N'[dbo].[FK_T_PLAN_SERVICIOT_ESPECIALIDAD_SERVICIO]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[T_PLAN_SERVICIO] DROP CONSTRAINT [FK_T_PLAN_SERVICIOT_ESPECIALIDAD_SERVICIO];
GO
IF OBJECT_ID(N'[dbo].[FK_T_PROGRAMACION_MEDICAT_ESPECIALIDAD_SERVICIO]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[T_PROGRAMACION_MEDICA] DROP CONSTRAINT [FK_T_PROGRAMACION_MEDICAT_ESPECIALIDAD_SERVICIO];
GO
IF OBJECT_ID(N'[dbo].[FK_T_ESTRATEGIA_COMERCIALT_PLAN_DE_SALUD]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[T_ESTRATEGIA_COMERCIAL] DROP CONSTRAINT [FK_T_ESTRATEGIA_COMERCIALT_PLAN_DE_SALUD];
GO
IF OBJECT_ID(N'[dbo].[FK_T_ESTRATEGIA_COMERCIAL_DETALLET_ESTRATEGIA_COMERCIAL]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[T_ESTRATEGIA_COMERCIAL_DETALLE] DROP CONSTRAINT [FK_T_ESTRATEGIA_COMERCIAL_DETALLET_ESTRATEGIA_COMERCIAL];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[T_BASE_FINANCIERA]', 'U') IS NOT NULL
    DROP TABLE [dbo].[T_BASE_FINANCIERA];
GO
IF OBJECT_ID(N'[dbo].[T_BASE_LEGAL]', 'U') IS NOT NULL
    DROP TABLE [dbo].[T_BASE_LEGAL];
GO
IF OBJECT_ID(N'[dbo].[T_BIEN]', 'U') IS NOT NULL
    DROP TABLE [dbo].[T_BIEN];
GO
IF OBJECT_ID(N'[dbo].[T_BITACORA_INCIDENCIA]', 'U') IS NOT NULL
    DROP TABLE [dbo].[T_BITACORA_INCIDENCIA];
GO
IF OBJECT_ID(N'[dbo].[T_COMPROBANTE]', 'U') IS NOT NULL
    DROP TABLE [dbo].[T_COMPROBANTE];
GO
IF OBJECT_ID(N'[dbo].[T_CONFIGURACION]', 'U') IS NOT NULL
    DROP TABLE [dbo].[T_CONFIGURACION];
GO
IF OBJECT_ID(N'[dbo].[T_EMPLEADO]', 'U') IS NOT NULL
    DROP TABLE [dbo].[T_EMPLEADO];
GO
IF OBJECT_ID(N'[dbo].[T_EMPRESA]', 'U') IS NOT NULL
    DROP TABLE [dbo].[T_EMPRESA];
GO
IF OBJECT_ID(N'[dbo].[T_EQUIPO_MEDICO]', 'U') IS NOT NULL
    DROP TABLE [dbo].[T_EQUIPO_MEDICO];
GO
IF OBJECT_ID(N'[dbo].[T_EQUIPO_USO]', 'U') IS NOT NULL
    DROP TABLE [dbo].[T_EQUIPO_USO];
GO
IF OBJECT_ID(N'[dbo].[T_ESPECIALIDAD_MEDICA]', 'U') IS NOT NULL
    DROP TABLE [dbo].[T_ESPECIALIDAD_MEDICA];
GO
IF OBJECT_ID(N'[dbo].[T_ESPECIALIDAD_SERVICIO]', 'U') IS NOT NULL
    DROP TABLE [dbo].[T_ESPECIALIDAD_SERVICIO];
GO
IF OBJECT_ID(N'[dbo].[T_ESTRATEGIA_COMERCIAL]', 'U') IS NOT NULL
    DROP TABLE [dbo].[T_ESTRATEGIA_COMERCIAL];
GO
IF OBJECT_ID(N'[dbo].[T_INMUEBLE]', 'U') IS NOT NULL
    DROP TABLE [dbo].[T_INMUEBLE];
GO
IF OBJECT_ID(N'[dbo].[T_INVESTIGACION_COMERCIAL]', 'U') IS NOT NULL
    DROP TABLE [dbo].[T_INVESTIGACION_COMERCIAL];
GO
IF OBJECT_ID(N'[dbo].[T_MANTENIMIENTO_EQUIPO]', 'U') IS NOT NULL
    DROP TABLE [dbo].[T_MANTENIMIENTO_EQUIPO];
GO
IF OBJECT_ID(N'[dbo].[T_MODELO]', 'U') IS NOT NULL
    DROP TABLE [dbo].[T_MODELO];
GO
IF OBJECT_ID(N'[dbo].[T_MUEBLE]', 'U') IS NOT NULL
    DROP TABLE [dbo].[T_MUEBLE];
GO
IF OBJECT_ID(N'[dbo].[T_PACIENTE]', 'U') IS NOT NULL
    DROP TABLE [dbo].[T_PACIENTE];
GO
IF OBJECT_ID(N'[dbo].[T_PERSONA]', 'U') IS NOT NULL
    DROP TABLE [dbo].[T_PERSONA];
GO
IF OBJECT_ID(N'[dbo].[T_PLAN_BASE_FINANCIERA]', 'U') IS NOT NULL
    DROP TABLE [dbo].[T_PLAN_BASE_FINANCIERA];
GO
IF OBJECT_ID(N'[dbo].[T_PLAN_BASE_LEGAL]', 'U') IS NOT NULL
    DROP TABLE [dbo].[T_PLAN_BASE_LEGAL];
GO
IF OBJECT_ID(N'[dbo].[T_PLAN_DE_SALUD]', 'U') IS NOT NULL
    DROP TABLE [dbo].[T_PLAN_DE_SALUD];
GO
IF OBJECT_ID(N'[dbo].[T_PLAN_ESPECIALIDADxSERVICIO]', 'U') IS NOT NULL
    DROP TABLE [dbo].[T_PLAN_ESPECIALIDADxSERVICIO];
GO
IF OBJECT_ID(N'[dbo].[T_PLAN_ESTRATEGIA_COMERCIAL]', 'U') IS NOT NULL
    DROP TABLE [dbo].[T_PLAN_ESTRATEGIA_COMERCIAL];
GO
IF OBJECT_ID(N'[dbo].[T_PLAN_MANTENIMIENTO]', 'U') IS NOT NULL
    DROP TABLE [dbo].[T_PLAN_MANTENIMIENTO];
GO
IF OBJECT_ID(N'[dbo].[T_PLAN_PACIENTE]', 'U') IS NOT NULL
    DROP TABLE [dbo].[T_PLAN_PACIENTE];
GO
IF OBJECT_ID(N'[dbo].[T_PROGRAMACION_MEDICA]', 'U') IS NOT NULL
    DROP TABLE [dbo].[T_PROGRAMACION_MEDICA];
GO
IF OBJECT_ID(N'[dbo].[T_PROYECTO_PLANSALUD]', 'U') IS NOT NULL
    DROP TABLE [dbo].[T_PROYECTO_PLANSALUD];
GO
IF OBJECT_ID(N'[dbo].[T_RESERVA_SERVICIO_SALUD]', 'U') IS NOT NULL
    DROP TABLE [dbo].[T_RESERVA_SERVICIO_SALUD];
GO
IF OBJECT_ID(N'[dbo].[T_SEGUIMIENTO]', 'U') IS NOT NULL
    DROP TABLE [dbo].[T_SEGUIMIENTO];
GO
IF OBJECT_ID(N'[dbo].[T_SERVICIO_SALUD]', 'U') IS NOT NULL
    DROP TABLE [dbo].[T_SERVICIO_SALUD];
GO
IF OBJECT_ID(N'[dbo].[T_SOLICITUD_MANTENIMIENTO]', 'U') IS NOT NULL
    DROP TABLE [dbo].[T_SOLICITUD_MANTENIMIENTO];
GO
IF OBJECT_ID(N'[dbo].[T_TECNICO_MANTENIMIENTO]', 'U') IS NOT NULL
    DROP TABLE [dbo].[T_TECNICO_MANTENIMIENTO];
GO
IF OBJECT_ID(N'[dbo].[T_TIPO_PERSONA]', 'U') IS NOT NULL
    DROP TABLE [dbo].[T_TIPO_PERSONA];
GO
IF OBJECT_ID(N'[dbo].[T_PERSONA_PLANSALUD]', 'U') IS NOT NULL
    DROP TABLE [dbo].[T_PERSONA_PLANSALUD];
GO
IF OBJECT_ID(N'[dbo].[T_PLAN_SERVICIO]', 'U') IS NOT NULL
    DROP TABLE [dbo].[T_PLAN_SERVICIO];
GO
IF OBJECT_ID(N'[dbo].[T_ESTRATEGIA_COMERCIAL_DETALLE]', 'U') IS NOT NULL
    DROP TABLE [dbo].[T_ESTRATEGIA_COMERCIAL_DETALLE];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'T_BASE_FINANCIERA'
CREATE TABLE [dbo].[T_BASE_FINANCIERA] (
    [id_base_financiera] int IDENTITY(1,1) NOT NULL,
    [descripcion] nvarchar(max)  NULL,
    [comentario] varchar(50)  NULL,
    [monto] int  NULL,
    [presupuesto] int  NULL,
    [promocion] varchar(20)  NULL,
    [fecha_registro] datetime  NULL
);
GO

-- Creating table 'T_BASE_LEGAL'
CREATE TABLE [dbo].[T_BASE_LEGAL] (
    [id_base_legal] int IDENTITY(1,1) NOT NULL,
    [nombre_normativa] nvarchar(max)  NOT NULL,
    [descripcion] varchar(50)  NULL,
    [autorizacion] varchar(10)  NULL,
    [fecha_registro] datetime  NULL
);
GO

-- Creating table 'T_BIEN'
CREATE TABLE [dbo].[T_BIEN] (
    [codBien] int  NOT NULL,
    [dscBien] varchar(100)  NULL,
    [fecAdquisicion] datetime  NULL
);
GO

-- Creating table 'T_BITACORA_INCIDENCIA'
CREATE TABLE [dbo].[T_BITACORA_INCIDENCIA] (
    [id_bitacora] int IDENTITY(1,1) NOT NULL,
    [tipo_incidencia] varchar(10)  NULL,
    [fecha_registro] datetime  NULL,
    [descripcion] nvarchar(max)  NOT NULL,
    [id_plan_salud] int  NULL,
    [idempleado] int  NULL,
    [estado] nvarchar(max)  NULL
);
GO

-- Creating table 'T_COMPROBANTE'
CREATE TABLE [dbo].[T_COMPROBANTE] (
    [id_comprobante] int IDENTITY(1,1) NOT NULL,
    [numero] varchar(11)  NULL,
    [descripcion] nvarchar(max)  NOT NULL,
    [fecha_emision] datetime  NOT NULL,
    [fecha_pago] datetime  NULL,
    [moneda] int  NULL,
    [importe] int  NULL,
    [impuesto] int  NULL,
    [area_venta] nvarchar(max)  NOT NULL,
    [total] decimal(18,0)  NOT NULL,
    [id_paciente] int  NULL
);
GO

-- Creating table 'T_CONFIGURACION'
CREATE TABLE [dbo].[T_CONFIGURACION] (
    [id_configuracion] int IDENTITY(1,1) NOT NULL,
    [modulo] nvarchar(max)  NOT NULL,
    [area] nvarchar(max)  NOT NULL,
    [indicador] nvarchar(max)  NOT NULL,
    [valor_minimo] nvarchar(max)  NOT NULL,
    [valor_maximo] nvarchar(max)  NOT NULL,
    [fecha] datetime  NOT NULL,
    [id_investigacion_comercial] int  NULL
);
GO

-- Creating table 'T_EMPLEADO'
CREATE TABLE [dbo].[T_EMPLEADO] (
    [idEmpleado] int  NOT NULL,
    [nroDni] int  NULL,
    [nomEmpleado] varchar(200)  NULL,
    [fecIngreso] datetime  NULL,
    [stdEmplead] char(3)  NULL,
    [dscCargo] varchar(100)  NULL,
    [dscProfesion] varchar(100)  NULL,
    [dscArea] varchar(100)  NULL,
    [dscCorreo] varchar(100)  NULL,
    [idEspecialidad] int  NULL,
    [codPersona] int  NULL
);
GO

-- Creating table 'T_EMPRESA'
CREATE TABLE [dbo].[T_EMPRESA] (
    [codEmpresa] int  NOT NULL,
    [nroRuc] varchar(20)  NULL,
    [razonSocial] varchar(300)  NULL,
    [direccion] varchar(300)  NULL,
    [telefono] varchar(20)  NULL,
    [codPersona] int  NULL
);
GO

-- Creating table 'T_EQUIPO_MEDICO'
CREATE TABLE [dbo].[T_EQUIPO_MEDICO] (
    [idEquipoMedico] int  NOT NULL,
    [intervaloMant] int  NULL,
    [nivelPrioridad] int  NULL,
    [fecUltimoMant] datetime  NULL,
    [estEquipo] char(3)  NULL,
    [codMueble] int  NULL,
    [idEspecialidad] int  NULL,
    [codInmueble] int  NULL
);
GO

-- Creating table 'T_EQUIPO_USO'
CREATE TABLE [dbo].[T_EQUIPO_USO] (
    [idequipousoo] int  NOT NULL,
    [idEquipoMedico] int  NULL,
    [fecUso] datetime  NULL
);
GO

-- Creating table 'T_ESPECIALIDAD_MEDICA'
CREATE TABLE [dbo].[T_ESPECIALIDAD_MEDICA] (
    [idEspecialidad] int  NOT NULL,
    [nomEspecialidad] varchar(100)  NULL
);
GO

-- Creating table 'T_ESPECIALIDAD_SERVICIO'
CREATE TABLE [dbo].[T_ESPECIALIDAD_SERVICIO] (
    [id_servicio] int  NOT NULL,
    [idEspecialidad] int  NOT NULL,
    [fecha_ingreso] datetime  NULL,
    [estado] char(1)  NULL
);
GO

-- Creating table 'T_ESTRATEGIA_COMERCIAL'
CREATE TABLE [dbo].[T_ESTRATEGIA_COMERCIAL] (
    [id_estrategia_comercial] int IDENTITY(1,1) NOT NULL,
    [nombre] nvarchar(max)  NOT NULL,
    [descripcion] varchar(50)  NULL,
    [objetivo] varchar(50)  NULL,
    [fecha_registro] datetime  NOT NULL,
    [presupuesto] decimal(18,0)  NOT NULL,
    [id_plan_salud] int  NOT NULL
);
GO

-- Creating table 'T_INMUEBLE'
CREATE TABLE [dbo].[T_INMUEBLE] (
    [codInmueble] int  NOT NULL,
    [dscTipoEstado] varchar(100)  NULL,
    [codBien] int  NULL,
    [estado] bit  NULL
);
GO

-- Creating table 'T_INVESTIGACION_COMERCIAL'
CREATE TABLE [dbo].[T_INVESTIGACION_COMERCIAL] (
    [id_investigacion_comercial] int IDENTITY(1,1) NOT NULL,
    [nombre] nvarchar(max)  NOT NULL,
    [resultado_sexo] varchar(10)  NULL,
    [resultado_edad] varchar(10)  NULL,
    [resultado_servicio] varchar(10)  NULL,
    [resultado_especialidad] varchar(10)  NULL,
    [fecha_creacion] varchar(10)  NULL
);
GO

-- Creating table 'T_MANTENIMIENTO_EQUIPO'
CREATE TABLE [dbo].[T_MANTENIMIENTO_EQUIPO] (
    [idMantEquipo] int IDENTITY(1,1) NOT NULL,
    [codPlan] int  NULL,
    [fecMantenimiento1] datetime  NULL,
    [fecMantenimiento2] datetime  NULL,
    [fecMantenimiento3] datetime  NULL,
    [dscTipoMantenimiento] varchar(200)  NULL,
    [estMantenimiento] char(3)  NULL,
    [idEquipoMedico] int  NULL,
    [idSolicitud] int  NULL,
    [codEmpresa] int  NULL
);
GO

-- Creating table 'T_MODELO'
CREATE TABLE [dbo].[T_MODELO] (
    [codModelo] int  NOT NULL,
    [nomModelo] varchar(100)  NULL,
    [dscMarca] varchar(100)  NULL
);
GO

-- Creating table 'T_MUEBLE'
CREATE TABLE [dbo].[T_MUEBLE] (
    [codMueble] int  NOT NULL,
    [dscFuncion] varchar(100)  NULL,
    [dscAplicacionMedica] varchar(100)  NULL,
    [garantia] bit  NULL,
    [tipoMueble] char(3)  NULL,
    [codBien] int  NULL,
    [codEmpresa] int  NULL,
    [codModelo] int  NULL
);
GO

-- Creating table 'T_PACIENTE'
CREATE TABLE [dbo].[T_PACIENTE] (
    [id_paciente] int IDENTITY(1,1) NOT NULL,
    [nom_paciente] nvarchar(max)  NULL,
    [fecha_nacimiento] datetime  NOT NULL,
    [segmentacion] nvarchar(max)  NOT NULL,
    [estado] varchar(10)  NULL,
    [codPersona] int  NULL
);
GO

-- Creating table 'T_PERSONA'
CREATE TABLE [dbo].[T_PERSONA] (
    [codPersona] int  NOT NULL,
    [nompersona] varchar(100)  NULL
);
GO

-- Creating table 'T_PLAN_BASE_FINANCIERA'
CREATE TABLE [dbo].[T_PLAN_BASE_FINANCIERA] (
    [id_plan_base_financiera] int IDENTITY(1,1) NOT NULL,
    [id_base_financiera] int  NULL,
    [id_plan_salud] int  NULL,
    [fecha_registro] datetime  NULL,
    [estado] char(1)  NULL
);
GO

-- Creating table 'T_PLAN_BASE_LEGAL'
CREATE TABLE [dbo].[T_PLAN_BASE_LEGAL] (
    [id_plan_base_financiera] int IDENTITY(1,1) NOT NULL,
    [id_base_legal] int  NULL,
    [id_plan_salud] int  NULL,
    [fecha_registro] datetime  NULL,
    [estado] char(1)  NULL
);
GO

-- Creating table 'T_PLAN_DE_SALUD'
CREATE TABLE [dbo].[T_PLAN_DE_SALUD] (
    [id_plan_salud] int IDENTITY(1,1) NOT NULL,
    [nombre_plan] nvarchar(max)  NOT NULL,
    [descripcion] varchar(10)  NULL,
    [fecha_inicio] datetime  NULL,
    [fecha_fin] datetime  NULL,
    [objetivo] varchar(20)  NULL,
    [id_investigacion_comercial] int  NULL,
    [estado] char(1)  NULL
);
GO

-- Creating table 'T_PLAN_ESPECIALIDADxSERVICIO'
CREATE TABLE [dbo].[T_PLAN_ESPECIALIDADxSERVICIO] (
    [id_plan_especialidad] int IDENTITY(1,1) NOT NULL,
    [id_especialidad_servicio] int  NULL,
    [id_plan_salud] int  NULL,
    [fecha_inicio] datetime  NULL,
    [fecha_fin] datetime  NULL,
    [estado] char(1)  NULL
);
GO

-- Creating table 'T_PLAN_ESTRATEGIA_COMERCIAL'
CREATE TABLE [dbo].[T_PLAN_ESTRATEGIA_COMERCIAL] (
    [id_plan_estrategia_comercial] int IDENTITY(1,1) NOT NULL,
    [id_estrategia_comercial] int  NULL,
    [id_plan_salud] int  NULL,
    [fecha_registro] datetime  NULL,
    [estado] char(1)  NULL
);
GO

-- Creating table 'T_PLAN_MANTENIMIENTO'
CREATE TABLE [dbo].[T_PLAN_MANTENIMIENTO] (
    [codPlan] int  NOT NULL,
    [fecRegistro] datetime  NULL,
    [estPlan] char(3)  NULL,
    [idTecnicoMant] int  NULL
);
GO

-- Creating table 'T_PLAN_PACIENTE'
CREATE TABLE [dbo].[T_PLAN_PACIENTE] (
    [id_plan_paciente] int IDENTITY(1,1) NOT NULL,
    [id_paciente] int  NULL,
    [id_plan_salud] int  NULL,
    [fecha_registro] datetime  NULL,
    [fecha_fin] datetime  NULL,
    [estado] char(1)  NULL
);
GO

-- Creating table 'T_PROGRAMACION_MEDICA'
CREATE TABLE [dbo].[T_PROGRAMACION_MEDICA] (
    [id_programacion] int IDENTITY(1,1) NOT NULL,
    [prestaciones] int  NULL,
    [dis_prestaciones] int  NULL,
    [fecha] datetime  NOT NULL,
    [hora_inicio] time  NOT NULL,
    [hora_fin] time  NOT NULL,
    [anotaciones] varchar(10)  NULL,
    [estado] varchar(10)  NULL,
    [descripcion] nvarchar(max)  NOT NULL,
    [id_empleado] int  NOT NULL,
    [codInmueble] int  NULL,
    [codPersona] int  NOT NULL,
    [id_servicio] int  NOT NULL,
    [idEspecialidad] int  NOT NULL
);
GO

-- Creating table 'T_PROYECTO_PLANSALUD'
CREATE TABLE [dbo].[T_PROYECTO_PLANSALUD] (
    [id_proyecto] int IDENTITY(1,1) NOT NULL,
    [nombre_proyecto] nvarchar(max)  NOT NULL,
    [descripcion] nvarchar(max)  NOT NULL,
    [fecha_inicio] datetime  NULL,
    [fecha_fin] datetime  NULL,
    [estado] smallint  NOT NULL,
    [id_investigacion_comercial] int  NULL
);
GO

-- Creating table 'T_RESERVA_SERVICIO_SALUD'
CREATE TABLE [dbo].[T_RESERVA_SERVICIO_SALUD] (
    [id_reserva] int IDENTITY(1,1) NOT NULL,
    [fecha_reserva] datetime  NULL,
    [tipo_atencion] varchar(20)  NULL,
    [estado] char(1)  NULL,
    [id_paciente] int  NULL,
    [id_servicio] int  NULL
);
GO

-- Creating table 'T_SEGUIMIENTO'
CREATE TABLE [dbo].[T_SEGUIMIENTO] (
    [id_seguimiento] int IDENTITY(1,1) NOT NULL,
    [id_bitacora] int  NULL,
    [id_plan_salud] int  NULL,
    [seguimiento] varchar(500)  NULL,
    [fecha_registro] datetime  NULL,
    [usuario] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'T_SERVICIO_SALUD'
CREATE TABLE [dbo].[T_SERVICIO_SALUD] (
    [id_servicio] int IDENTITY(1,1) NOT NULL,
    [nombre_servicio] nvarchar(max)  NOT NULL,
    [tipo_servicio] varchar(10)  NULL
);
GO

-- Creating table 'T_SOLICITUD_MANTENIMIENTO'
CREATE TABLE [dbo].[T_SOLICITUD_MANTENIMIENTO] (
    [idSolicitud] int IDENTITY(1,1) NOT NULL,
    [fecSolicitud] datetime  NULL,
    [estSolicitud] char(3)  NULL,
    [fecAtencion] datetime  NULL,
    [dscObservacion] varchar(300)  NULL,
    [idTecnicoMant] int  NULL,
    [idEmpleado] int  NULL,
    [idEquipoMedico] int  NULL
);
GO

-- Creating table 'T_TECNICO_MANTENIMIENTO'
CREATE TABLE [dbo].[T_TECNICO_MANTENIMIENTO] (
    [idTecnicoMant] int  NOT NULL,
    [idEmpleado] int  NULL,
    [experienciaTrabajoRiesgo] varchar(200)  NULL,
    [seguroRiesgo] varchar(100)  NULL,
    [vigenciaEPP] datetime  NULL,
    [vigenciaExamenMedicoOcup] datetime  NULL,
    [habilidades] varchar(300)  NULL
);
GO

-- Creating table 'T_TIPO_PERSONA'
CREATE TABLE [dbo].[T_TIPO_PERSONA] (
    [id_tipo_persona] int IDENTITY(1,1) NOT NULL,
    [nombre_servicio] nvarchar(max)  NOT NULL,
    [tipo_servicio] varchar(10)  NULL
);
GO

-- Creating table 'T_PERSONA_PLANSALUD'
CREATE TABLE [dbo].[T_PERSONA_PLANSALUD] (
    [id_persona_plansalud] int IDENTITY(1,1) NOT NULL,
    [fecha_inicio] datetime  NOT NULL,
    [fecha_fin] datetime  NOT NULL,
    [codPersona] int  NOT NULL,
    [id_plan_salud] int  NOT NULL
);
GO

-- Creating table 'T_PLAN_SERVICIO'
CREATE TABLE [dbo].[T_PLAN_SERVICIO] (
    [id_plan_servicio] int IDENTITY(1,1) NOT NULL,
    [fecha_inicio] datetime  NOT NULL,
    [fecha_fin] datetime  NULL,
    [id_plan_salud] int  NOT NULL,
    [id_servicio] int  NOT NULL,
    [idEspecialidad] int  NOT NULL,
    [estado] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'T_ESTRATEGIA_COMERCIAL_DETALLE'
CREATE TABLE [dbo].[T_ESTRATEGIA_COMERCIAL_DETALLE] (
    [id_estrategia_detalle] int IDENTITY(1,1) NOT NULL,
    [medio_campana] nvarchar(max)  NOT NULL,
    [canal] nvarchar(max)  NOT NULL,
    [fecha_inicio] datetime  NOT NULL,
    [fecha_fin] datetime  NOT NULL,
    [monto] decimal(18,0)  NOT NULL,
    [objetivo] nvarchar(max)  NOT NULL,
    [estado] nvarchar(max)  NOT NULL,
    [usuario] nvarchar(max)  NOT NULL,
    [comprobante] varbinary(max)  NULL,
    [id_estrategia_comercial] int  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [id_base_financiera] in table 'T_BASE_FINANCIERA'
ALTER TABLE [dbo].[T_BASE_FINANCIERA]
ADD CONSTRAINT [PK_T_BASE_FINANCIERA]
    PRIMARY KEY CLUSTERED ([id_base_financiera] ASC);
GO

-- Creating primary key on [id_base_legal] in table 'T_BASE_LEGAL'
ALTER TABLE [dbo].[T_BASE_LEGAL]
ADD CONSTRAINT [PK_T_BASE_LEGAL]
    PRIMARY KEY CLUSTERED ([id_base_legal] ASC);
GO

-- Creating primary key on [codBien] in table 'T_BIEN'
ALTER TABLE [dbo].[T_BIEN]
ADD CONSTRAINT [PK_T_BIEN]
    PRIMARY KEY CLUSTERED ([codBien] ASC);
GO

-- Creating primary key on [id_bitacora] in table 'T_BITACORA_INCIDENCIA'
ALTER TABLE [dbo].[T_BITACORA_INCIDENCIA]
ADD CONSTRAINT [PK_T_BITACORA_INCIDENCIA]
    PRIMARY KEY CLUSTERED ([id_bitacora] ASC);
GO

-- Creating primary key on [id_comprobante] in table 'T_COMPROBANTE'
ALTER TABLE [dbo].[T_COMPROBANTE]
ADD CONSTRAINT [PK_T_COMPROBANTE]
    PRIMARY KEY CLUSTERED ([id_comprobante] ASC);
GO

-- Creating primary key on [id_configuracion] in table 'T_CONFIGURACION'
ALTER TABLE [dbo].[T_CONFIGURACION]
ADD CONSTRAINT [PK_T_CONFIGURACION]
    PRIMARY KEY CLUSTERED ([id_configuracion] ASC);
GO

-- Creating primary key on [idEmpleado] in table 'T_EMPLEADO'
ALTER TABLE [dbo].[T_EMPLEADO]
ADD CONSTRAINT [PK_T_EMPLEADO]
    PRIMARY KEY CLUSTERED ([idEmpleado] ASC);
GO

-- Creating primary key on [codEmpresa] in table 'T_EMPRESA'
ALTER TABLE [dbo].[T_EMPRESA]
ADD CONSTRAINT [PK_T_EMPRESA]
    PRIMARY KEY CLUSTERED ([codEmpresa] ASC);
GO

-- Creating primary key on [idEquipoMedico] in table 'T_EQUIPO_MEDICO'
ALTER TABLE [dbo].[T_EQUIPO_MEDICO]
ADD CONSTRAINT [PK_T_EQUIPO_MEDICO]
    PRIMARY KEY CLUSTERED ([idEquipoMedico] ASC);
GO

-- Creating primary key on [idequipousoo] in table 'T_EQUIPO_USO'
ALTER TABLE [dbo].[T_EQUIPO_USO]
ADD CONSTRAINT [PK_T_EQUIPO_USO]
    PRIMARY KEY CLUSTERED ([idequipousoo] ASC);
GO

-- Creating primary key on [idEspecialidad] in table 'T_ESPECIALIDAD_MEDICA'
ALTER TABLE [dbo].[T_ESPECIALIDAD_MEDICA]
ADD CONSTRAINT [PK_T_ESPECIALIDAD_MEDICA]
    PRIMARY KEY CLUSTERED ([idEspecialidad] ASC);
GO

-- Creating primary key on [id_servicio], [idEspecialidad] in table 'T_ESPECIALIDAD_SERVICIO'
ALTER TABLE [dbo].[T_ESPECIALIDAD_SERVICIO]
ADD CONSTRAINT [PK_T_ESPECIALIDAD_SERVICIO]
    PRIMARY KEY CLUSTERED ([id_servicio], [idEspecialidad] ASC);
GO

-- Creating primary key on [id_estrategia_comercial] in table 'T_ESTRATEGIA_COMERCIAL'
ALTER TABLE [dbo].[T_ESTRATEGIA_COMERCIAL]
ADD CONSTRAINT [PK_T_ESTRATEGIA_COMERCIAL]
    PRIMARY KEY CLUSTERED ([id_estrategia_comercial] ASC);
GO

-- Creating primary key on [codInmueble] in table 'T_INMUEBLE'
ALTER TABLE [dbo].[T_INMUEBLE]
ADD CONSTRAINT [PK_T_INMUEBLE]
    PRIMARY KEY CLUSTERED ([codInmueble] ASC);
GO

-- Creating primary key on [id_investigacion_comercial] in table 'T_INVESTIGACION_COMERCIAL'
ALTER TABLE [dbo].[T_INVESTIGACION_COMERCIAL]
ADD CONSTRAINT [PK_T_INVESTIGACION_COMERCIAL]
    PRIMARY KEY CLUSTERED ([id_investigacion_comercial] ASC);
GO

-- Creating primary key on [idMantEquipo] in table 'T_MANTENIMIENTO_EQUIPO'
ALTER TABLE [dbo].[T_MANTENIMIENTO_EQUIPO]
ADD CONSTRAINT [PK_T_MANTENIMIENTO_EQUIPO]
    PRIMARY KEY CLUSTERED ([idMantEquipo] ASC);
GO

-- Creating primary key on [codModelo] in table 'T_MODELO'
ALTER TABLE [dbo].[T_MODELO]
ADD CONSTRAINT [PK_T_MODELO]
    PRIMARY KEY CLUSTERED ([codModelo] ASC);
GO

-- Creating primary key on [codMueble] in table 'T_MUEBLE'
ALTER TABLE [dbo].[T_MUEBLE]
ADD CONSTRAINT [PK_T_MUEBLE]
    PRIMARY KEY CLUSTERED ([codMueble] ASC);
GO

-- Creating primary key on [id_paciente] in table 'T_PACIENTE'
ALTER TABLE [dbo].[T_PACIENTE]
ADD CONSTRAINT [PK_T_PACIENTE]
    PRIMARY KEY CLUSTERED ([id_paciente] ASC);
GO

-- Creating primary key on [codPersona] in table 'T_PERSONA'
ALTER TABLE [dbo].[T_PERSONA]
ADD CONSTRAINT [PK_T_PERSONA]
    PRIMARY KEY CLUSTERED ([codPersona] ASC);
GO

-- Creating primary key on [id_plan_base_financiera] in table 'T_PLAN_BASE_FINANCIERA'
ALTER TABLE [dbo].[T_PLAN_BASE_FINANCIERA]
ADD CONSTRAINT [PK_T_PLAN_BASE_FINANCIERA]
    PRIMARY KEY CLUSTERED ([id_plan_base_financiera] ASC);
GO

-- Creating primary key on [id_plan_base_financiera] in table 'T_PLAN_BASE_LEGAL'
ALTER TABLE [dbo].[T_PLAN_BASE_LEGAL]
ADD CONSTRAINT [PK_T_PLAN_BASE_LEGAL]
    PRIMARY KEY CLUSTERED ([id_plan_base_financiera] ASC);
GO

-- Creating primary key on [id_plan_salud] in table 'T_PLAN_DE_SALUD'
ALTER TABLE [dbo].[T_PLAN_DE_SALUD]
ADD CONSTRAINT [PK_T_PLAN_DE_SALUD]
    PRIMARY KEY CLUSTERED ([id_plan_salud] ASC);
GO

-- Creating primary key on [id_plan_especialidad] in table 'T_PLAN_ESPECIALIDADxSERVICIO'
ALTER TABLE [dbo].[T_PLAN_ESPECIALIDADxSERVICIO]
ADD CONSTRAINT [PK_T_PLAN_ESPECIALIDADxSERVICIO]
    PRIMARY KEY CLUSTERED ([id_plan_especialidad] ASC);
GO

-- Creating primary key on [id_plan_estrategia_comercial] in table 'T_PLAN_ESTRATEGIA_COMERCIAL'
ALTER TABLE [dbo].[T_PLAN_ESTRATEGIA_COMERCIAL]
ADD CONSTRAINT [PK_T_PLAN_ESTRATEGIA_COMERCIAL]
    PRIMARY KEY CLUSTERED ([id_plan_estrategia_comercial] ASC);
GO

-- Creating primary key on [codPlan] in table 'T_PLAN_MANTENIMIENTO'
ALTER TABLE [dbo].[T_PLAN_MANTENIMIENTO]
ADD CONSTRAINT [PK_T_PLAN_MANTENIMIENTO]
    PRIMARY KEY CLUSTERED ([codPlan] ASC);
GO

-- Creating primary key on [id_plan_paciente] in table 'T_PLAN_PACIENTE'
ALTER TABLE [dbo].[T_PLAN_PACIENTE]
ADD CONSTRAINT [PK_T_PLAN_PACIENTE]
    PRIMARY KEY CLUSTERED ([id_plan_paciente] ASC);
GO

-- Creating primary key on [id_programacion] in table 'T_PROGRAMACION_MEDICA'
ALTER TABLE [dbo].[T_PROGRAMACION_MEDICA]
ADD CONSTRAINT [PK_T_PROGRAMACION_MEDICA]
    PRIMARY KEY CLUSTERED ([id_programacion] ASC);
GO

-- Creating primary key on [id_proyecto] in table 'T_PROYECTO_PLANSALUD'
ALTER TABLE [dbo].[T_PROYECTO_PLANSALUD]
ADD CONSTRAINT [PK_T_PROYECTO_PLANSALUD]
    PRIMARY KEY CLUSTERED ([id_proyecto] ASC);
GO

-- Creating primary key on [id_reserva] in table 'T_RESERVA_SERVICIO_SALUD'
ALTER TABLE [dbo].[T_RESERVA_SERVICIO_SALUD]
ADD CONSTRAINT [PK_T_RESERVA_SERVICIO_SALUD]
    PRIMARY KEY CLUSTERED ([id_reserva] ASC);
GO

-- Creating primary key on [id_seguimiento] in table 'T_SEGUIMIENTO'
ALTER TABLE [dbo].[T_SEGUIMIENTO]
ADD CONSTRAINT [PK_T_SEGUIMIENTO]
    PRIMARY KEY CLUSTERED ([id_seguimiento] ASC);
GO

-- Creating primary key on [id_servicio] in table 'T_SERVICIO_SALUD'
ALTER TABLE [dbo].[T_SERVICIO_SALUD]
ADD CONSTRAINT [PK_T_SERVICIO_SALUD]
    PRIMARY KEY CLUSTERED ([id_servicio] ASC);
GO

-- Creating primary key on [idSolicitud] in table 'T_SOLICITUD_MANTENIMIENTO'
ALTER TABLE [dbo].[T_SOLICITUD_MANTENIMIENTO]
ADD CONSTRAINT [PK_T_SOLICITUD_MANTENIMIENTO]
    PRIMARY KEY CLUSTERED ([idSolicitud] ASC);
GO

-- Creating primary key on [idTecnicoMant] in table 'T_TECNICO_MANTENIMIENTO'
ALTER TABLE [dbo].[T_TECNICO_MANTENIMIENTO]
ADD CONSTRAINT [PK_T_TECNICO_MANTENIMIENTO]
    PRIMARY KEY CLUSTERED ([idTecnicoMant] ASC);
GO

-- Creating primary key on [id_tipo_persona] in table 'T_TIPO_PERSONA'
ALTER TABLE [dbo].[T_TIPO_PERSONA]
ADD CONSTRAINT [PK_T_TIPO_PERSONA]
    PRIMARY KEY CLUSTERED ([id_tipo_persona] ASC);
GO

-- Creating primary key on [id_persona_plansalud] in table 'T_PERSONA_PLANSALUD'
ALTER TABLE [dbo].[T_PERSONA_PLANSALUD]
ADD CONSTRAINT [PK_T_PERSONA_PLANSALUD]
    PRIMARY KEY CLUSTERED ([id_persona_plansalud] ASC);
GO

-- Creating primary key on [id_plan_servicio] in table 'T_PLAN_SERVICIO'
ALTER TABLE [dbo].[T_PLAN_SERVICIO]
ADD CONSTRAINT [PK_T_PLAN_SERVICIO]
    PRIMARY KEY CLUSTERED ([id_plan_servicio] ASC);
GO

-- Creating primary key on [id_estrategia_detalle] in table 'T_ESTRATEGIA_COMERCIAL_DETALLE'
ALTER TABLE [dbo].[T_ESTRATEGIA_COMERCIAL_DETALLE]
ADD CONSTRAINT [PK_T_ESTRATEGIA_COMERCIAL_DETALLE]
    PRIMARY KEY CLUSTERED ([id_estrategia_detalle] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [id_base_financiera] in table 'T_PLAN_BASE_FINANCIERA'
ALTER TABLE [dbo].[T_PLAN_BASE_FINANCIERA]
ADD CONSTRAINT [FK_T_BASE_FINANCIERA]
    FOREIGN KEY ([id_base_financiera])
    REFERENCES [dbo].[T_BASE_FINANCIERA]
        ([id_base_financiera])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_T_BASE_FINANCIERA'
CREATE INDEX [IX_FK_T_BASE_FINANCIERA]
ON [dbo].[T_PLAN_BASE_FINANCIERA]
    ([id_base_financiera]);
GO

-- Creating foreign key on [id_base_legal] in table 'T_PLAN_BASE_LEGAL'
ALTER TABLE [dbo].[T_PLAN_BASE_LEGAL]
ADD CONSTRAINT [FK_T_PLAN_BASE_LEGAL]
    FOREIGN KEY ([id_base_legal])
    REFERENCES [dbo].[T_BASE_LEGAL]
        ([id_base_legal])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_T_PLAN_BASE_LEGAL'
CREATE INDEX [IX_FK_T_PLAN_BASE_LEGAL]
ON [dbo].[T_PLAN_BASE_LEGAL]
    ([id_base_legal]);
GO

-- Creating foreign key on [codBien] in table 'T_MUEBLE'
ALTER TABLE [dbo].[T_MUEBLE]
ADD CONSTRAINT [FK__T_MUEBLE__codBie__571DF1D5]
    FOREIGN KEY ([codBien])
    REFERENCES [dbo].[T_BIEN]
        ([codBien])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__T_MUEBLE__codBie__571DF1D5'
CREATE INDEX [IX_FK__T_MUEBLE__codBie__571DF1D5]
ON [dbo].[T_MUEBLE]
    ([codBien]);
GO

-- Creating foreign key on [codBien] in table 'T_INMUEBLE'
ALTER TABLE [dbo].[T_INMUEBLE]
ADD CONSTRAINT [FK_T_INMUEBLE_T_BIEN]
    FOREIGN KEY ([codBien])
    REFERENCES [dbo].[T_BIEN]
        ([codBien])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_T_INMUEBLE_T_BIEN'
CREATE INDEX [IX_FK_T_INMUEBLE_T_BIEN]
ON [dbo].[T_INMUEBLE]
    ([codBien]);
GO

-- Creating foreign key on [idempleado] in table 'T_BITACORA_INCIDENCIA'
ALTER TABLE [dbo].[T_BITACORA_INCIDENCIA]
ADD CONSTRAINT [FK__T_BITACOR__idemp__4D94879B]
    FOREIGN KEY ([idempleado])
    REFERENCES [dbo].[T_EMPLEADO]
        ([idEmpleado])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__T_BITACOR__idemp__4D94879B'
CREATE INDEX [IX_FK__T_BITACOR__idemp__4D94879B]
ON [dbo].[T_BITACORA_INCIDENCIA]
    ([idempleado]);
GO

-- Creating foreign key on [id_plan_salud] in table 'T_BITACORA_INCIDENCIA'
ALTER TABLE [dbo].[T_BITACORA_INCIDENCIA]
ADD CONSTRAINT [FK_T_BITACORA_INCIDENCIA_PLAN_DE_SALUD]
    FOREIGN KEY ([id_plan_salud])
    REFERENCES [dbo].[T_PLAN_DE_SALUD]
        ([id_plan_salud])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_T_BITACORA_INCIDENCIA_PLAN_DE_SALUD'
CREATE INDEX [IX_FK_T_BITACORA_INCIDENCIA_PLAN_DE_SALUD]
ON [dbo].[T_BITACORA_INCIDENCIA]
    ([id_plan_salud]);
GO

-- Creating foreign key on [id_bitacora] in table 'T_SEGUIMIENTO'
ALTER TABLE [dbo].[T_SEGUIMIENTO]
ADD CONSTRAINT [FK_T_SEGUIMIENTO_BITACORA_INCIDENCIA]
    FOREIGN KEY ([id_bitacora])
    REFERENCES [dbo].[T_BITACORA_INCIDENCIA]
        ([id_bitacora])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_T_SEGUIMIENTO_BITACORA_INCIDENCIA'
CREATE INDEX [IX_FK_T_SEGUIMIENTO_BITACORA_INCIDENCIA]
ON [dbo].[T_SEGUIMIENTO]
    ([id_bitacora]);
GO

-- Creating foreign key on [id_paciente] in table 'T_COMPROBANTE'
ALTER TABLE [dbo].[T_COMPROBANTE]
ADD CONSTRAINT [FK__T_COMPROB__id_pa__49C3F6B7]
    FOREIGN KEY ([id_paciente])
    REFERENCES [dbo].[T_PACIENTE]
        ([id_paciente])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__T_COMPROB__id_pa__49C3F6B7'
CREATE INDEX [IX_FK__T_COMPROB__id_pa__49C3F6B7]
ON [dbo].[T_COMPROBANTE]
    ([id_paciente]);
GO

-- Creating foreign key on [id_investigacion_comercial] in table 'T_CONFIGURACION'
ALTER TABLE [dbo].[T_CONFIGURACION]
ADD CONSTRAINT [FK__T_CONFIGU__id_in__4AB81AF0]
    FOREIGN KEY ([id_investigacion_comercial])
    REFERENCES [dbo].[T_INVESTIGACION_COMERCIAL]
        ([id_investigacion_comercial])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__T_CONFIGU__id_in__4AB81AF0'
CREATE INDEX [IX_FK__T_CONFIGU__id_in__4AB81AF0]
ON [dbo].[T_CONFIGURACION]
    ([id_investigacion_comercial]);
GO

-- Creating foreign key on [codPersona] in table 'T_EMPLEADO'
ALTER TABLE [dbo].[T_EMPLEADO]
ADD CONSTRAINT [FK__T_EMPLEAD__codPe__1273C1CD]
    FOREIGN KEY ([codPersona])
    REFERENCES [dbo].[T_PERSONA]
        ([codPersona])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__T_EMPLEAD__codPe__1273C1CD'
CREATE INDEX [IX_FK__T_EMPLEAD__codPe__1273C1CD]
ON [dbo].[T_EMPLEADO]
    ([codPersona]);
GO

-- Creating foreign key on [idEmpleado] in table 'T_SOLICITUD_MANTENIMIENTO'
ALTER TABLE [dbo].[T_SOLICITUD_MANTENIMIENTO]
ADD CONSTRAINT [FK__T_SOLICIT__idEmp__300424B4]
    FOREIGN KEY ([idEmpleado])
    REFERENCES [dbo].[T_EMPLEADO]
        ([idEmpleado])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__T_SOLICIT__idEmp__300424B4'
CREATE INDEX [IX_FK__T_SOLICIT__idEmp__300424B4]
ON [dbo].[T_SOLICITUD_MANTENIMIENTO]
    ([idEmpleado]);
GO

-- Creating foreign key on [idEmpleado] in table 'T_TECNICO_MANTENIMIENTO'
ALTER TABLE [dbo].[T_TECNICO_MANTENIMIENTO]
ADD CONSTRAINT [FK__T_TECNICO__idEmp__15502E78]
    FOREIGN KEY ([idEmpleado])
    REFERENCES [dbo].[T_EMPLEADO]
        ([idEmpleado])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__T_TECNICO__idEmp__15502E78'
CREATE INDEX [IX_FK__T_TECNICO__idEmp__15502E78]
ON [dbo].[T_TECNICO_MANTENIMIENTO]
    ([idEmpleado]);
GO

-- Creating foreign key on [idEspecialidad] in table 'T_EMPLEADO'
ALTER TABLE [dbo].[T_EMPLEADO]
ADD CONSTRAINT [FK_T_EMPLEADO_T_ESPECIALIDAD_MEDICA]
    FOREIGN KEY ([idEspecialidad])
    REFERENCES [dbo].[T_ESPECIALIDAD_MEDICA]
        ([idEspecialidad])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_T_EMPLEADO_T_ESPECIALIDAD_MEDICA'
CREATE INDEX [IX_FK_T_EMPLEADO_T_ESPECIALIDAD_MEDICA]
ON [dbo].[T_EMPLEADO]
    ([idEspecialidad]);
GO

-- Creating foreign key on [id_empleado] in table 'T_PROGRAMACION_MEDICA'
ALTER TABLE [dbo].[T_PROGRAMACION_MEDICA]
ADD CONSTRAINT [FK_T_PROGRAMACION_MEDICA_T_EMPLEADO]
    FOREIGN KEY ([id_empleado])
    REFERENCES [dbo].[T_EMPLEADO]
        ([idEmpleado])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_T_PROGRAMACION_MEDICA_T_EMPLEADO'
CREATE INDEX [IX_FK_T_PROGRAMACION_MEDICA_T_EMPLEADO]
ON [dbo].[T_PROGRAMACION_MEDICA]
    ([id_empleado]);
GO

-- Creating foreign key on [codPersona] in table 'T_EMPRESA'
ALTER TABLE [dbo].[T_EMPRESA]
ADD CONSTRAINT [FK__T_EMPRESA__codPe__4D94879B]
    FOREIGN KEY ([codPersona])
    REFERENCES [dbo].[T_PERSONA]
        ([codPersona])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__T_EMPRESA__codPe__4D94879B'
CREATE INDEX [IX_FK__T_EMPRESA__codPe__4D94879B]
ON [dbo].[T_EMPRESA]
    ([codPersona]);
GO

-- Creating foreign key on [codEmpresa] in table 'T_MANTENIMIENTO_EQUIPO'
ALTER TABLE [dbo].[T_MANTENIMIENTO_EQUIPO]
ADD CONSTRAINT [FK__T_MANTENI__codEm__534D60F1]
    FOREIGN KEY ([codEmpresa])
    REFERENCES [dbo].[T_EMPRESA]
        ([codEmpresa])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__T_MANTENI__codEm__534D60F1'
CREATE INDEX [IX_FK__T_MANTENI__codEm__534D60F1]
ON [dbo].[T_MANTENIMIENTO_EQUIPO]
    ([codEmpresa]);
GO

-- Creating foreign key on [codEmpresa] in table 'T_MUEBLE'
ALTER TABLE [dbo].[T_MUEBLE]
ADD CONSTRAINT [FK__T_MUEBLE__codEmp__5812160E]
    FOREIGN KEY ([codEmpresa])
    REFERENCES [dbo].[T_EMPRESA]
        ([codEmpresa])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__T_MUEBLE__codEmp__5812160E'
CREATE INDEX [IX_FK__T_MUEBLE__codEmp__5812160E]
ON [dbo].[T_MUEBLE]
    ([codEmpresa]);
GO

-- Creating foreign key on [codInmueble] in table 'T_EQUIPO_MEDICO'
ALTER TABLE [dbo].[T_EQUIPO_MEDICO]
ADD CONSTRAINT [FK__T_EQUIPO___codIn__2C3393D0]
    FOREIGN KEY ([codInmueble])
    REFERENCES [dbo].[T_INMUEBLE]
        ([codInmueble])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__T_EQUIPO___codIn__2C3393D0'
CREATE INDEX [IX_FK__T_EQUIPO___codIn__2C3393D0]
ON [dbo].[T_EQUIPO_MEDICO]
    ([codInmueble]);
GO

-- Creating foreign key on [codMueble] in table 'T_EQUIPO_MEDICO'
ALTER TABLE [dbo].[T_EQUIPO_MEDICO]
ADD CONSTRAINT [FK__T_EQUIPO___codMu__4F7CD00D]
    FOREIGN KEY ([codMueble])
    REFERENCES [dbo].[T_MUEBLE]
        ([codMueble])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__T_EQUIPO___codMu__4F7CD00D'
CREATE INDEX [IX_FK__T_EQUIPO___codMu__4F7CD00D]
ON [dbo].[T_EQUIPO_MEDICO]
    ([codMueble]);
GO

-- Creating foreign key on [idEquipoMedico] in table 'T_EQUIPO_USO'
ALTER TABLE [dbo].[T_EQUIPO_USO]
ADD CONSTRAINT [FK__T_EQUIPO___idEqu__4CA06362]
    FOREIGN KEY ([idEquipoMedico])
    REFERENCES [dbo].[T_EQUIPO_MEDICO]
        ([idEquipoMedico])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__T_EQUIPO___idEqu__4CA06362'
CREATE INDEX [IX_FK__T_EQUIPO___idEqu__4CA06362]
ON [dbo].[T_EQUIPO_USO]
    ([idEquipoMedico]);
GO

-- Creating foreign key on [idEspecialidad] in table 'T_EQUIPO_MEDICO'
ALTER TABLE [dbo].[T_EQUIPO_MEDICO]
ADD CONSTRAINT [FK__T_EQUIPO___idEsp__5070F446]
    FOREIGN KEY ([idEspecialidad])
    REFERENCES [dbo].[T_ESPECIALIDAD_MEDICA]
        ([idEspecialidad])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__T_EQUIPO___idEsp__5070F446'
CREATE INDEX [IX_FK__T_EQUIPO___idEsp__5070F446]
ON [dbo].[T_EQUIPO_MEDICO]
    ([idEspecialidad]);
GO

-- Creating foreign key on [idEquipoMedico] in table 'T_MANTENIMIENTO_EQUIPO'
ALTER TABLE [dbo].[T_MANTENIMIENTO_EQUIPO]
ADD CONSTRAINT [FK__T_MANTENI__idEqu__5535A963]
    FOREIGN KEY ([idEquipoMedico])
    REFERENCES [dbo].[T_EQUIPO_MEDICO]
        ([idEquipoMedico])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__T_MANTENI__idEqu__5535A963'
CREATE INDEX [IX_FK__T_MANTENI__idEqu__5535A963]
ON [dbo].[T_MANTENIMIENTO_EQUIPO]
    ([idEquipoMedico]);
GO

-- Creating foreign key on [idEquipoMedico] in table 'T_SOLICITUD_MANTENIMIENTO'
ALTER TABLE [dbo].[T_SOLICITUD_MANTENIMIENTO]
ADD CONSTRAINT [FK__T_SOLICIT__idEqu__693CA210]
    FOREIGN KEY ([idEquipoMedico])
    REFERENCES [dbo].[T_EQUIPO_MEDICO]
        ([idEquipoMedico])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__T_SOLICIT__idEqu__693CA210'
CREATE INDEX [IX_FK__T_SOLICIT__idEqu__693CA210]
ON [dbo].[T_SOLICITUD_MANTENIMIENTO]
    ([idEquipoMedico]);
GO

-- Creating foreign key on [id_servicio] in table 'T_ESPECIALIDAD_SERVICIO'
ALTER TABLE [dbo].[T_ESPECIALIDAD_SERVICIO]
ADD CONSTRAINT [FK_T_SERVICIO_ESPECIALIDAD]
    FOREIGN KEY ([id_servicio])
    REFERENCES [dbo].[T_SERVICIO_SALUD]
        ([id_servicio])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [id_estrategia_comercial] in table 'T_PLAN_ESTRATEGIA_COMERCIAL'
ALTER TABLE [dbo].[T_PLAN_ESTRATEGIA_COMERCIAL]
ADD CONSTRAINT [FK_T_PLAN_ESTRATEGIA_COMERCIAL]
    FOREIGN KEY ([id_estrategia_comercial])
    REFERENCES [dbo].[T_ESTRATEGIA_COMERCIAL]
        ([id_estrategia_comercial])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_T_PLAN_ESTRATEGIA_COMERCIAL'
CREATE INDEX [IX_FK_T_PLAN_ESTRATEGIA_COMERCIAL]
ON [dbo].[T_PLAN_ESTRATEGIA_COMERCIAL]
    ([id_estrategia_comercial]);
GO

-- Creating foreign key on [codInmueble] in table 'T_PROGRAMACION_MEDICA'
ALTER TABLE [dbo].[T_PROGRAMACION_MEDICA]
ADD CONSTRAINT [FK__T_PROGRAM__codIn__6754599E]
    FOREIGN KEY ([codInmueble])
    REFERENCES [dbo].[T_INMUEBLE]
        ([codInmueble])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__T_PROGRAM__codIn__6754599E'
CREATE INDEX [IX_FK__T_PROGRAM__codIn__6754599E]
ON [dbo].[T_PROGRAMACION_MEDICA]
    ([codInmueble]);
GO

-- Creating foreign key on [id_investigacion_comercial] in table 'T_PLAN_DE_SALUD'
ALTER TABLE [dbo].[T_PLAN_DE_SALUD]
ADD CONSTRAINT [FK__T_PLAN_DE_SALUD1]
    FOREIGN KEY ([id_investigacion_comercial])
    REFERENCES [dbo].[T_INVESTIGACION_COMERCIAL]
        ([id_investigacion_comercial])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__T_PLAN_DE_SALUD1'
CREATE INDEX [IX_FK__T_PLAN_DE_SALUD1]
ON [dbo].[T_PLAN_DE_SALUD]
    ([id_investigacion_comercial]);
GO

-- Creating foreign key on [id_investigacion_comercial] in table 'T_PROYECTO_PLANSALUD'
ALTER TABLE [dbo].[T_PROYECTO_PLANSALUD]
ADD CONSTRAINT [FK__T_PROYECT__id_in__656C112C]
    FOREIGN KEY ([id_investigacion_comercial])
    REFERENCES [dbo].[T_INVESTIGACION_COMERCIAL]
        ([id_investigacion_comercial])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__T_PROYECT__id_in__656C112C'
CREATE INDEX [IX_FK__T_PROYECT__id_in__656C112C]
ON [dbo].[T_PROYECTO_PLANSALUD]
    ([id_investigacion_comercial]);
GO

-- Creating foreign key on [codPlan] in table 'T_MANTENIMIENTO_EQUIPO'
ALTER TABLE [dbo].[T_MANTENIMIENTO_EQUIPO]
ADD CONSTRAINT [FK__T_MANTENI__codPl__5441852A]
    FOREIGN KEY ([codPlan])
    REFERENCES [dbo].[T_PLAN_MANTENIMIENTO]
        ([codPlan])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__T_MANTENI__codPl__5441852A'
CREATE INDEX [IX_FK__T_MANTENI__codPl__5441852A]
ON [dbo].[T_MANTENIMIENTO_EQUIPO]
    ([codPlan]);
GO

-- Creating foreign key on [idSolicitud] in table 'T_MANTENIMIENTO_EQUIPO'
ALTER TABLE [dbo].[T_MANTENIMIENTO_EQUIPO]
ADD CONSTRAINT [FK__T_MANTENI__idSol__5629CD9C]
    FOREIGN KEY ([idSolicitud])
    REFERENCES [dbo].[T_SOLICITUD_MANTENIMIENTO]
        ([idSolicitud])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__T_MANTENI__idSol__5629CD9C'
CREATE INDEX [IX_FK__T_MANTENI__idSol__5629CD9C]
ON [dbo].[T_MANTENIMIENTO_EQUIPO]
    ([idSolicitud]);
GO

-- Creating foreign key on [codModelo] in table 'T_MUEBLE'
ALTER TABLE [dbo].[T_MUEBLE]
ADD CONSTRAINT [FK__T_MUEBLE__codMod__59063A47]
    FOREIGN KEY ([codModelo])
    REFERENCES [dbo].[T_MODELO]
        ([codModelo])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__T_MUEBLE__codMod__59063A47'
CREATE INDEX [IX_FK__T_MUEBLE__codMod__59063A47]
ON [dbo].[T_MUEBLE]
    ([codModelo]);
GO

-- Creating foreign key on [codPersona] in table 'T_PACIENTE'
ALTER TABLE [dbo].[T_PACIENTE]
ADD CONSTRAINT [FK__T_PACIENT__codPe__59FA5E80]
    FOREIGN KEY ([codPersona])
    REFERENCES [dbo].[T_PERSONA]
        ([codPersona])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__T_PACIENT__codPe__59FA5E80'
CREATE INDEX [IX_FK__T_PACIENT__codPe__59FA5E80]
ON [dbo].[T_PACIENTE]
    ([codPersona]);
GO

-- Creating foreign key on [id_paciente] in table 'T_RESERVA_SERVICIO_SALUD'
ALTER TABLE [dbo].[T_RESERVA_SERVICIO_SALUD]
ADD CONSTRAINT [FK__T_RESERVA__id_pa__5DCAEF64]
    FOREIGN KEY ([id_paciente])
    REFERENCES [dbo].[T_PACIENTE]
        ([id_paciente])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__T_RESERVA__id_pa__5DCAEF64'
CREATE INDEX [IX_FK__T_RESERVA__id_pa__5DCAEF64]
ON [dbo].[T_RESERVA_SERVICIO_SALUD]
    ([id_paciente]);
GO

-- Creating foreign key on [id_paciente] in table 'T_PLAN_PACIENTE'
ALTER TABLE [dbo].[T_PLAN_PACIENTE]
ADD CONSTRAINT [FK_T_PLAN_PACIENTE_T_PACIENTE]
    FOREIGN KEY ([id_paciente])
    REFERENCES [dbo].[T_PACIENTE]
        ([id_paciente])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_T_PLAN_PACIENTE_T_PACIENTE'
CREATE INDEX [IX_FK_T_PLAN_PACIENTE_T_PACIENTE]
ON [dbo].[T_PLAN_PACIENTE]
    ([id_paciente]);
GO

-- Creating foreign key on [id_plan_salud] in table 'T_PLAN_BASE_FINANCIERA'
ALTER TABLE [dbo].[T_PLAN_BASE_FINANCIERA]
ADD CONSTRAINT [FK_T_PLAN_DE_SALUD]
    FOREIGN KEY ([id_plan_salud])
    REFERENCES [dbo].[T_PLAN_DE_SALUD]
        ([id_plan_salud])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_T_PLAN_DE_SALUD'
CREATE INDEX [IX_FK_T_PLAN_DE_SALUD]
ON [dbo].[T_PLAN_BASE_FINANCIERA]
    ([id_plan_salud]);
GO

-- Creating foreign key on [id_plan_salud] in table 'T_PLAN_BASE_LEGAL'
ALTER TABLE [dbo].[T_PLAN_BASE_LEGAL]
ADD CONSTRAINT [FK_T_PLAN]
    FOREIGN KEY ([id_plan_salud])
    REFERENCES [dbo].[T_PLAN_DE_SALUD]
        ([id_plan_salud])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_T_PLAN'
CREATE INDEX [IX_FK_T_PLAN]
ON [dbo].[T_PLAN_BASE_LEGAL]
    ([id_plan_salud]);
GO

-- Creating foreign key on [id_plan_salud] in table 'T_PLAN_ESTRATEGIA_COMERCIAL'
ALTER TABLE [dbo].[T_PLAN_ESTRATEGIA_COMERCIAL]
ADD CONSTRAINT [FK_T_PLAN_COMERCIAL]
    FOREIGN KEY ([id_plan_salud])
    REFERENCES [dbo].[T_PLAN_DE_SALUD]
        ([id_plan_salud])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_T_PLAN_COMERCIAL'
CREATE INDEX [IX_FK_T_PLAN_COMERCIAL]
ON [dbo].[T_PLAN_ESTRATEGIA_COMERCIAL]
    ([id_plan_salud]);
GO

-- Creating foreign key on [id_plan_salud] in table 'T_PLAN_PACIENTE'
ALTER TABLE [dbo].[T_PLAN_PACIENTE]
ADD CONSTRAINT [FK_T_PLAN_PACIENTE_T_PLAN_DE_SALUD]
    FOREIGN KEY ([id_plan_salud])
    REFERENCES [dbo].[T_PLAN_DE_SALUD]
        ([id_plan_salud])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_T_PLAN_PACIENTE_T_PLAN_DE_SALUD'
CREATE INDEX [IX_FK_T_PLAN_PACIENTE_T_PLAN_DE_SALUD]
ON [dbo].[T_PLAN_PACIENTE]
    ([id_plan_salud]);
GO

-- Creating foreign key on [idTecnicoMant] in table 'T_PLAN_MANTENIMIENTO'
ALTER TABLE [dbo].[T_PLAN_MANTENIMIENTO]
ADD CONSTRAINT [FK__T_PLAN_MA__idTec__5EBF139D]
    FOREIGN KEY ([idTecnicoMant])
    REFERENCES [dbo].[T_TECNICO_MANTENIMIENTO]
        ([idTecnicoMant])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__T_PLAN_MA__idTec__5EBF139D'
CREATE INDEX [IX_FK__T_PLAN_MA__idTec__5EBF139D]
ON [dbo].[T_PLAN_MANTENIMIENTO]
    ([idTecnicoMant]);
GO

-- Creating foreign key on [id_servicio] in table 'T_RESERVA_SERVICIO_SALUD'
ALTER TABLE [dbo].[T_RESERVA_SERVICIO_SALUD]
ADD CONSTRAINT [FK__T_RESERVA__id_se__5EBF139D]
    FOREIGN KEY ([id_servicio])
    REFERENCES [dbo].[T_SERVICIO_SALUD]
        ([id_servicio])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__T_RESERVA__id_se__5EBF139D'
CREATE INDEX [IX_FK__T_RESERVA__id_se__5EBF139D]
ON [dbo].[T_RESERVA_SERVICIO_SALUD]
    ([id_servicio]);
GO

-- Creating foreign key on [idTecnicoMant] in table 'T_SOLICITUD_MANTENIMIENTO'
ALTER TABLE [dbo].[T_SOLICITUD_MANTENIMIENTO]
ADD CONSTRAINT [FK__T_SOLICIT__idTec__6A30C649]
    FOREIGN KEY ([idTecnicoMant])
    REFERENCES [dbo].[T_TECNICO_MANTENIMIENTO]
        ([idTecnicoMant])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__T_SOLICIT__idTec__6A30C649'
CREATE INDEX [IX_FK__T_SOLICIT__idTec__6A30C649]
ON [dbo].[T_SOLICITUD_MANTENIMIENTO]
    ([idTecnicoMant]);
GO

-- Creating foreign key on [codPersona] in table 'T_PERSONA_PLANSALUD'
ALTER TABLE [dbo].[T_PERSONA_PLANSALUD]
ADD CONSTRAINT [FK_T_PERSONAT_PERSONA_PLANSALUD]
    FOREIGN KEY ([codPersona])
    REFERENCES [dbo].[T_PERSONA]
        ([codPersona])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_T_PERSONAT_PERSONA_PLANSALUD'
CREATE INDEX [IX_FK_T_PERSONAT_PERSONA_PLANSALUD]
ON [dbo].[T_PERSONA_PLANSALUD]
    ([codPersona]);
GO

-- Creating foreign key on [id_plan_salud] in table 'T_PERSONA_PLANSALUD'
ALTER TABLE [dbo].[T_PERSONA_PLANSALUD]
ADD CONSTRAINT [FK_T_PERSONA_PLANSALUDT_PLAN_DE_SALUD]
    FOREIGN KEY ([id_plan_salud])
    REFERENCES [dbo].[T_PLAN_DE_SALUD]
        ([id_plan_salud])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_T_PERSONA_PLANSALUDT_PLAN_DE_SALUD'
CREATE INDEX [IX_FK_T_PERSONA_PLANSALUDT_PLAN_DE_SALUD]
ON [dbo].[T_PERSONA_PLANSALUD]
    ([id_plan_salud]);
GO

-- Creating foreign key on [codPersona] in table 'T_PROGRAMACION_MEDICA'
ALTER TABLE [dbo].[T_PROGRAMACION_MEDICA]
ADD CONSTRAINT [FK_T_PROGRAMACION_MEDICAT_PERSONA]
    FOREIGN KEY ([codPersona])
    REFERENCES [dbo].[T_PERSONA]
        ([codPersona])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_T_PROGRAMACION_MEDICAT_PERSONA'
CREATE INDEX [IX_FK_T_PROGRAMACION_MEDICAT_PERSONA]
ON [dbo].[T_PROGRAMACION_MEDICA]
    ([codPersona]);
GO

-- Creating foreign key on [id_plan_salud] in table 'T_PLAN_SERVICIO'
ALTER TABLE [dbo].[T_PLAN_SERVICIO]
ADD CONSTRAINT [FK_T_PLAN_SERVICIOT_PLAN_DE_SALUD]
    FOREIGN KEY ([id_plan_salud])
    REFERENCES [dbo].[T_PLAN_DE_SALUD]
        ([id_plan_salud])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_T_PLAN_SERVICIOT_PLAN_DE_SALUD'
CREATE INDEX [IX_FK_T_PLAN_SERVICIOT_PLAN_DE_SALUD]
ON [dbo].[T_PLAN_SERVICIO]
    ([id_plan_salud]);
GO

-- Creating foreign key on [idEspecialidad] in table 'T_ESPECIALIDAD_SERVICIO'
ALTER TABLE [dbo].[T_ESPECIALIDAD_SERVICIO]
ADD CONSTRAINT [FK_T_ESPECIALIDAD_SERVICIOT_ESPECIALIDAD_MEDICA]
    FOREIGN KEY ([idEspecialidad])
    REFERENCES [dbo].[T_ESPECIALIDAD_MEDICA]
        ([idEspecialidad])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_T_ESPECIALIDAD_SERVICIOT_ESPECIALIDAD_MEDICA'
CREATE INDEX [IX_FK_T_ESPECIALIDAD_SERVICIOT_ESPECIALIDAD_MEDICA]
ON [dbo].[T_ESPECIALIDAD_SERVICIO]
    ([idEspecialidad]);
GO

-- Creating foreign key on [id_servicio], [idEspecialidad] in table 'T_PLAN_SERVICIO'
ALTER TABLE [dbo].[T_PLAN_SERVICIO]
ADD CONSTRAINT [FK_T_PLAN_SERVICIOT_ESPECIALIDAD_SERVICIO]
    FOREIGN KEY ([id_servicio], [idEspecialidad])
    REFERENCES [dbo].[T_ESPECIALIDAD_SERVICIO]
        ([id_servicio], [idEspecialidad])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_T_PLAN_SERVICIOT_ESPECIALIDAD_SERVICIO'
CREATE INDEX [IX_FK_T_PLAN_SERVICIOT_ESPECIALIDAD_SERVICIO]
ON [dbo].[T_PLAN_SERVICIO]
    ([id_servicio], [idEspecialidad]);
GO

-- Creating foreign key on [id_servicio], [idEspecialidad] in table 'T_PROGRAMACION_MEDICA'
ALTER TABLE [dbo].[T_PROGRAMACION_MEDICA]
ADD CONSTRAINT [FK_T_PROGRAMACION_MEDICAT_ESPECIALIDAD_SERVICIO]
    FOREIGN KEY ([id_servicio], [idEspecialidad])
    REFERENCES [dbo].[T_ESPECIALIDAD_SERVICIO]
        ([id_servicio], [idEspecialidad])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_T_PROGRAMACION_MEDICAT_ESPECIALIDAD_SERVICIO'
CREATE INDEX [IX_FK_T_PROGRAMACION_MEDICAT_ESPECIALIDAD_SERVICIO]
ON [dbo].[T_PROGRAMACION_MEDICA]
    ([id_servicio], [idEspecialidad]);
GO

-- Creating foreign key on [id_plan_salud] in table 'T_ESTRATEGIA_COMERCIAL'
ALTER TABLE [dbo].[T_ESTRATEGIA_COMERCIAL]
ADD CONSTRAINT [FK_T_ESTRATEGIA_COMERCIALT_PLAN_DE_SALUD]
    FOREIGN KEY ([id_plan_salud])
    REFERENCES [dbo].[T_PLAN_DE_SALUD]
        ([id_plan_salud])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_T_ESTRATEGIA_COMERCIALT_PLAN_DE_SALUD'
CREATE INDEX [IX_FK_T_ESTRATEGIA_COMERCIALT_PLAN_DE_SALUD]
ON [dbo].[T_ESTRATEGIA_COMERCIAL]
    ([id_plan_salud]);
GO

-- Creating foreign key on [id_estrategia_comercial] in table 'T_ESTRATEGIA_COMERCIAL_DETALLE'
ALTER TABLE [dbo].[T_ESTRATEGIA_COMERCIAL_DETALLE]
ADD CONSTRAINT [FK_T_ESTRATEGIA_COMERCIAL_DETALLET_ESTRATEGIA_COMERCIAL]
    FOREIGN KEY ([id_estrategia_comercial])
    REFERENCES [dbo].[T_ESTRATEGIA_COMERCIAL]
        ([id_estrategia_comercial])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_T_ESTRATEGIA_COMERCIAL_DETALLET_ESTRATEGIA_COMERCIAL'
CREATE INDEX [IX_FK_T_ESTRATEGIA_COMERCIAL_DETALLET_ESTRATEGIA_COMERCIAL]
ON [dbo].[T_ESTRATEGIA_COMERCIAL_DETALLE]
    ([id_estrategia_comercial]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------