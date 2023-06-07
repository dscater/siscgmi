-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 07-06-2023 a las 17:50:22
-- Versión del servidor: 8.0.30
-- Versión de PHP: 7.4.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `siscgmi_db`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `areas`
--

CREATE TABLE `areas` (
  `id` bigint UNSIGNED NOT NULL,
  `codigo` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `areas`
--

INSERT INTO `areas` (`id`, `codigo`, `nombre`, `created_at`, `updated_at`) VALUES
(1, 'A1', 'AREA 1', '2023-06-01 16:54:17', '2023-06-01 16:54:17'),
(2, 'A2', 'AREA 2 MODIFICADO', '2023-06-01 16:54:34', '2023-06-01 16:54:51');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `configuracions`
--

CREATE TABLE `configuracions` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre_sistema` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alias` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `razon_social` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nit` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ciudad` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dir` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fono` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `web` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `actividad` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `correo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `configuracions`
--

INSERT INTO `configuracions` (`id`, `nombre_sistema`, `alias`, `razon_social`, `nit`, `ciudad`, `dir`, `fono`, `web`, `actividad`, `correo`, `logo`, `created_at`, `updated_at`) VALUES
(1, 'SISTEMA DE COMPUTARIZADO DE GESTIÓN DE MANTENIMIENTO E INVENTARIOS', 'SISCGMI', 'EMPRESA DE PRUEBA', '10000000000', 'LA PAZ', 'LA PAZ', '222222', '', 'ACTIVIDAD', '', '1685568966_logo.png', NULL, '2023-05-31 21:36:06');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `entrada_herramientas`
--

CREATE TABLE `entrada_herramientas` (
  `id` bigint UNSIGNED NOT NULL,
  `factura` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `herramienta_id` int UNSIGNED NOT NULL,
  `cantidad` double NOT NULL,
  `unidad_medida` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `precio` decimal(24,2) NOT NULL,
  `total` decimal(24,2) NOT NULL,
  `fecha` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `entrada_herramientas`
--

INSERT INTO `entrada_herramientas` (`id`, `factura`, `herramienta_id`, `cantidad`, `unidad_medida`, `precio`, `total`, `fecha`, `created_at`, `updated_at`) VALUES
(2, '121212', 3, 100, 'METROS', 50.00, 5000.00, '2023-06-05', '2023-06-06 21:26:35', '2023-06-06 21:27:12'),
(3, '4343', 3, 100, 'UNIDADES', 50.00, 5000.00, '2023-06-07', '2023-06-07 17:15:13', '2023-06-07 17:15:13');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `entrada_repuestos`
--

CREATE TABLE `entrada_repuestos` (
  `id` bigint UNSIGNED NOT NULL,
  `factura` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `repuesto_id` int UNSIGNED NOT NULL,
  `cantidad` double NOT NULL,
  `precio` decimal(24,2) NOT NULL,
  `total` decimal(24,2) NOT NULL,
  `fecha` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `equipos`
--

CREATE TABLE `equipos` (
  `id` bigint UNSIGNED NOT NULL,
  `area_id` bigint UNSIGNED NOT NULL,
  `sistema_id` bigint UNSIGNED NOT NULL,
  `codigo` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `numero` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `codigo2` varchar(155) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `equipos`
--

INSERT INTO `equipos` (`id`, `area_id`, `sistema_id`, `codigo`, `nombre`, `numero`, `codigo2`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'E001', 'EQUIPO 1', '10', 'A1-S1-E001-10', '2023-06-01 19:56:53', '2023-06-01 19:56:53'),
(2, 2, 2, 'E002', 'EQUIPO 2', '10', 'A2-S2-E002-10', '2023-06-01 19:57:48', '2023-06-01 19:58:06');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `frecuencias`
--

CREATE TABLE `frecuencias` (
  `id` bigint UNSIGNED NOT NULL,
  `variable_id` bigint UNSIGNED NOT NULL,
  `frecuencia` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `frecuencias`
--

INSERT INTO `frecuencias` (`id`, `variable_id`, `frecuencia`, `created_at`, `updated_at`) VALUES
(1, 1, '1', '2023-06-06 15:15:51', '2023-06-06 15:16:28');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `herramientas`
--

CREATE TABLE `herramientas` (
  `id` bigint UNSIGNED NOT NULL,
  `codigo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `clasificacion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cod_clasificacion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `marca` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modelo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `serie` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `costo` decimal(24,2) DEFAULT NULL,
  `unidad_medida` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `proveedor` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dir` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fono` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `correo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `almacen` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fabricante` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `terciarios` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nombre_contacto` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `num_fono` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `correo_fabricante` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dir_fabricante` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `num_identificacion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `e_tecnicas` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `foto` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `herramientas`
--

INSERT INTO `herramientas` (`id`, `codigo`, `nombre`, `descripcion`, `clasificacion`, `cod_clasificacion`, `marca`, `modelo`, `serie`, `costo`, `unidad_medida`, `proveedor`, `dir`, `fono`, `correo`, `almacen`, `fabricante`, `terciarios`, `nombre_contacto`, `num_fono`, `correo_fabricante`, `dir_fabricante`, `num_identificacion`, `e_tecnicas`, `foto`, `created_at`, `updated_at`) VALUES
(1, 'H001', 'HERRAMIENTA #1', 'DESC, HERRAMIENTA #1', 'CLASIFICACION 1', 'CLASI1', 'MARCA 1', 'MODELO 1', 'SERIE 1', 1000.00, 'METROS', 'PERES S.A.', 'LOS OLIVOS', '222222', 'PERES@GMAIL.COM', 'ALMACEN 1', 'FABRICANTE 1', 'TERCIARIOS 1', 'JUAN PERES', '222222', 'FABRICANTE@GMAIL.COM', 'LOS PEDREGALES', '23323211111', 'ESPECIFICACIONES TECNIAS HERRAMIENTA #1', '11686068009.jpeg', '2023-06-06 16:05:22', '2023-06-06 16:13:29'),
(3, 'E001', 'EQUIPO #1', 'DESC EQUIPO # 1', 'CLASIFICACION EQUIPO', 'CODIGOCLAS', 'MARCA EQUIPOS', 'MODELO EQUIPO', 'SERIEEQUIPO', 3000.00, 'METROS', 'PROVEEDOR DEL EQUIPO', NULL, NULL, NULL, 'ALMACEN EQUIPOS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-06-06 21:08:23', '2023-06-06 21:08:23');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_accions`
--

CREATE TABLE `historial_accions` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `accion` varchar(155) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `datos_original` text COLLATE utf8mb4_unicode_ci,
  `datos_nuevo` text COLLATE utf8mb4_unicode_ci,
  `modulo` varchar(155) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `historial_accions`
--

INSERT INTO `historial_accions` (`id`, `user_id`, `accion`, `descripcion`, `datos_original`, `datos_nuevo`, `modulo`, `fecha`, `hora`, `created_at`, `updated_at`) VALUES
(1, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ LA CONFIGURACIÓN DEL SISTEMA', 'id: 1<br/>nombre_sistema: SISTEMA DE INVENTARIO Y VENTAS<br/>alias: SISTEMABI<br/>razon_social: EMPRESA FARMACIA<br/>nit: 10000000000<br/>ciudad: LA PAZ<br/>dir: LA PAZ<br/>fono: 222222<br/>web: <br/>actividad: ACTIVIDAD<br/>correo: <br/>logo: 1682712649_logo.jpg<br/>created_at: <br/>updated_at: 2023-04-28 20:10:49<br/>', 'id: 1<br/>nombre_sistema: SISTEMA DE COMPUTARIZADO DE GESTIÓN DE MANTENIMIENTO E INVENTARIOS<br/>alias: SISCGMI<br/>razon_social: EMPRESA DE PRUEBA<br/>nit: 10000000000<br/>ciudad: LA PAZ<br/>dir: LA PAZ<br/>fono: 222222<br/>web: <br/>actividad: ACTIVIDAD<br/>correo: <br/>logo: 1682712649_logo.jpg<br/>created_at: <br/>updated_at: 2023-05-31 17:22:23<br/>', 'CONFIGURACIÓN', '2023-05-31', '17:22:23', '2023-05-31 21:22:23', '2023-05-31 21:22:23'),
(2, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ LA CONFIGURACIÓN DEL SISTEMA', 'id: 1<br/>nombre_sistema: SISTEMA DE COMPUTARIZADO DE GESTIÓN DE MANTENIMIENTO E INVENTARIOS<br/>alias: SISCGMI<br/>razon_social: EMPRESA DE PRUEBA<br/>nit: 10000000000<br/>ciudad: LA PAZ<br/>dir: LA PAZ<br/>fono: 222222<br/>web: <br/>actividad: ACTIVIDAD<br/>correo: <br/>logo: 1682712649_logo.jpg<br/>created_at: <br/>updated_at: 2023-05-31 17:22:23<br/>', 'id: 1<br/>nombre_sistema: SISTEMA DE COMPUTARIZADO DE GESTIÓN DE MANTENIMIENTO E INVENTARIOS<br/>alias: SISCGMI<br/>razon_social: EMPRESA DE PRUEBA<br/>nit: 10000000000<br/>ciudad: LA PAZ<br/>dir: LA PAZ<br/>fono: 222222<br/>web: <br/>actividad: ACTIVIDAD<br/>correo: <br/>logo: 1685568966_logo.png<br/>created_at: <br/>updated_at: 2023-05-31 17:36:06<br/>', 'CONFIGURACIÓN', '2023-05-31', '17:36:06', '2023-05-31 21:36:06', '2023-05-31 21:36:06'),
(3, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN USUARIO', 'acceso: 1<br/>ci: 1111<br/>ci_exp: LP<br/>correo: <br/>created_at: 2023-06-01 11:39:49<br/>dir: <br/>especialidad: <br/>fecha_registro: 2023-06-01<br/>fono: <br/>foto: default.png<br/>id: 2<br/>materno: MAMANI<br/>nombre: JUAN<br/>password: $2y$10$t1vtRZ48507H2YKWgrU02Olg8W6bhN8yV8PduODfUJeMSIXEzqF/e<br/>paterno: PERES<br/>tipo: GERENTE<br/>updated_at: 2023-06-01 11:39:49<br/>usuario: JPERES<br/>', NULL, 'USUARIOS', '2023-06-01', '11:39:49', '2023-06-01 15:39:49', '2023-06-01 15:39:49'),
(4, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN USUARIO', 'acceso: 1<br/>ci: 2222<br/>ci_exp: CB<br/>correo: jose@gmail.com<br/>created_at: 2023-06-01 11:41:02<br/>dir: LOS OLIVOS<br/>especialidad: <br/>fecha_registro: 2023-06-01<br/>fono: 222222; 777777<br/>foto: 1685634062_JGONZALES.jpg<br/>id: 3<br/>materno: CONDORI<br/>nombre: JOSE ALBERTO<br/>password: $2y$10$KHi883Cz5Us3yixbNjs7cuxIWYst68Dkp6xZpJprokMjSYVvQpQUK<br/>paterno: GONZALES<br/>tipo: GERENTE DE PRODUCCIÓN<br/>updated_at: 2023-06-01 11:41:02<br/>usuario: JGONZALES<br/>', NULL, 'USUARIOS', '2023-06-01', '11:41:02', '2023-06-01 15:41:02', '2023-06-01 15:41:02'),
(5, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN USUARIO', 'acceso: 1<br/>ci: 2222<br/>ci_exp: CB<br/>correo: jose@gmail.com<br/>created_at: 2023-06-01 11:41:02<br/>dir: LOS OLIVOS<br/>especialidad: <br/>fecha_registro: 2023-06-01<br/>fono: 222222; 777777<br/>foto: 1685634062_JGONZALES.jpg<br/>id: 3<br/>materno: CONDORI<br/>nombre: JOSE ALBERTO<br/>password: $2y$10$KHi883Cz5Us3yixbNjs7cuxIWYst68Dkp6xZpJprokMjSYVvQpQUK<br/>paterno: GONZALES<br/>tipo: GERENTE DE PRODUCCIÓN<br/>updated_at: 2023-06-01 11:41:02<br/>usuario: JGONZALES<br/>', 'acceso: 1<br/>ci: 2222<br/>ci_exp: CB<br/>correo: jose@gmail.com<br/>created_at: 2023-06-01 11:41:02<br/>dir: LOS OLIVOS<br/>especialidad: <br/>fecha_registro: 2023-06-01<br/>fono: 222222; 777777<br/>foto: 1685634062_JGONZALES.jpg<br/>id: 3<br/>materno: CONDORI<br/>nombre: JOSE ALBERTO<br/>password: $2y$10$KHi883Cz5Us3yixbNjs7cuxIWYst68Dkp6xZpJprokMjSYVvQpQUK<br/>paterno: GONZALES<br/>tipo: GERENTE DE PRODUCCIÓN<br/>updated_at: 2023-06-01 11:41:30<br/>usuario: JGONZALES<br/>', 'USUARIOS', '2023-06-01', '11:41:30', '2023-06-01 15:41:30', '2023-06-01 15:41:30'),
(6, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN USUARIO', 'acceso: 1<br/>ci: 2222<br/>ci_exp: CB<br/>correo: jose@gmail.com<br/>created_at: 2023-06-01 11:41:02<br/>dir: LOS OLIVOS<br/>especialidad: <br/>fecha_registro: 2023-06-01<br/>fono: 222222; 777777<br/>foto: 1685634062_JGONZALES.jpg<br/>id: 3<br/>materno: CONDORI<br/>nombre: JOSE ALBERTO<br/>password: $2y$10$KHi883Cz5Us3yixbNjs7cuxIWYst68Dkp6xZpJprokMjSYVvQpQUK<br/>paterno: GONZALES<br/>tipo: GERENTE DE PRODUCCIÓN<br/>updated_at: 2023-06-01 11:41:30<br/>usuario: JGONZALES<br/>', 'acceso: 1<br/>ci: 2222<br/>ci_exp: CB<br/>correo: jose@gmail.com<br/>created_at: 2023-06-01 11:41:02<br/>dir: LOS OLIVOS<br/>especialidad: ESPECIALIDAD<br/>fecha_registro: 2023-06-01<br/>fono: 222222; 777777<br/>foto: 1685634062_JGONZALES.jpg<br/>id: 3<br/>materno: CONDORI<br/>nombre: JOSE ALBERTO<br/>password: $2y$10$KHi883Cz5Us3yixbNjs7cuxIWYst68Dkp6xZpJprokMjSYVvQpQUK<br/>paterno: GONZALES<br/>tipo: GERENTE DE PRODUCCIÓN<br/>updated_at: 2023-06-01 11:42:49<br/>usuario: JGONZALES<br/>', 'USUARIOS', '2023-06-01', '11:42:49', '2023-06-01 15:42:49', '2023-06-01 15:42:49'),
(7, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN AREA', 'codigo: A1<br/>created_at: 2023-06-01 12:54:17<br/>id: 1<br/>nombre: AREA 1<br/>updated_at: 2023-06-01 12:54:17<br/>', NULL, 'AREAS', '2023-06-01', '12:54:17', '2023-06-01 16:54:17', '2023-06-01 16:54:17'),
(8, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN AREA', 'codigo: A2<br/>created_at: 2023-06-01 12:54:34<br/>id: 2<br/>nombre: AREA 2<br/>updated_at: 2023-06-01 12:54:34<br/>', NULL, 'AREAS', '2023-06-01', '12:54:34', '2023-06-01 16:54:34', '2023-06-01 16:54:34'),
(9, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN AREA', 'codigo: A2<br/>created_at: 2023-06-01 12:54:34<br/>id: 2<br/>nombre: AREA 2<br/>updated_at: 2023-06-01 12:54:34<br/>', 'codigo: A2<br/>created_at: 2023-06-01 12:54:34<br/>id: 2<br/>nombre: AREA 2<br/>updated_at: 2023-06-01 12:54:34<br/>', 'AREAS', '2023-06-01', '12:54:39', '2023-06-01 16:54:39', '2023-06-01 16:54:39'),
(10, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN AREA', 'codigo: A2<br/>created_at: 2023-06-01 12:54:34<br/>id: 2<br/>nombre: AREA 2<br/>updated_at: 2023-06-01 12:54:34<br/>', 'codigo: A2<br/>created_at: 2023-06-01 12:54:34<br/>id: 2<br/>nombre: AREA 2 MODIFICADO<br/>updated_at: 2023-06-01 12:54:51<br/>', 'AREAS', '2023-06-01', '12:54:51', '2023-06-01 16:54:51', '2023-06-01 16:54:51'),
(11, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN AREA', 'codigo: AS<br/>created_at: 2023-06-01 12:54:58<br/>id: 3<br/>nombre: ASD<br/>updated_at: 2023-06-01 12:54:58<br/>', NULL, 'AREAS', '2023-06-01', '12:54:58', '2023-06-01 16:54:58', '2023-06-01 16:54:58'),
(12, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UN AREA', 'codigo: AS<br/>created_at: 2023-06-01 12:54:58<br/>id: 3<br/>nombre: ASD<br/>updated_at: 2023-06-01 12:54:58<br/>', NULL, 'AREAS', '2023-06-01', '12:55:04', '2023-06-01 16:55:04', '2023-06-01 16:55:04'),
(13, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SISTEMA', 'area_id: 1<br/>codigo: S1<br/>created_at: 2023-06-01 13:16:26<br/>id: 1<br/>nombre: SISTEMA 1<br/>updated_at: 2023-06-01 13:16:26<br/>', NULL, 'SISTEMAS', '2023-06-01', '13:16:26', '2023-06-01 17:16:26', '2023-06-01 17:16:26'),
(14, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SISTEMA', 'area_id: 2<br/>codigo: S2<br/>created_at: 2023-06-01 13:16:37<br/>id: 2<br/>nombre: SISTEMA 2<br/>updated_at: 2023-06-01 13:16:37<br/>', NULL, 'SISTEMAS', '2023-06-01', '13:16:37', '2023-06-01 17:16:37', '2023-06-01 17:16:37'),
(15, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN SISTEMA', 'area_id: 2<br/>codigo: S2<br/>created_at: 2023-06-01 13:16:37<br/>id: 2<br/>nombre: SISTEMA 2<br/>updated_at: 2023-06-01 13:16:37<br/>', 'area_id: 2<br/>codigo: S2<br/>created_at: 2023-06-01 13:16:37<br/>id: 2<br/>nombre: SISTEMA 2 MODIFICADO<br/>updated_at: 2023-06-01 13:16:45<br/>', 'SISTEMAS', '2023-06-01', '13:16:45', '2023-06-01 17:16:45', '2023-06-01 17:16:45'),
(16, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN SISTEMA', 'area_id: 2<br/>codigo: S2<br/>created_at: 2023-06-01 13:16:37<br/>id: 2<br/>nombre: SISTEMA 2 MODIFICADO<br/>updated_at: 2023-06-01 13:16:45<br/>', 'area_id: 2<br/>codigo: S2<br/>created_at: 2023-06-01 13:16:37<br/>id: 2<br/>nombre: SISTEMA 2 MODIFICADO<br/>updated_at: 2023-06-01 13:16:45<br/>', 'SISTEMAS', '2023-06-01', '13:17:02', '2023-06-01 17:17:02', '2023-06-01 17:17:02'),
(17, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SISTEMA', 'area_id: 1<br/>codigo: S3<br/>created_at: 2023-06-01 13:17:15<br/>id: 3<br/>nombre: S3<br/>updated_at: 2023-06-01 13:17:15<br/>', NULL, 'SISTEMAS', '2023-06-01', '13:17:15', '2023-06-01 17:17:15', '2023-06-01 17:17:15'),
(18, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UN SISTEMA', 'area_id: 1<br/>codigo: S3<br/>created_at: 2023-06-01 13:17:15<br/>id: 3<br/>nombre: S3<br/>updated_at: 2023-06-01 13:17:15<br/>', NULL, 'SISTEMAS', '2023-06-01', '13:17:36', '2023-06-01 17:17:36', '2023-06-01 17:17:36'),
(19, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SISTEMA', 'id: 1<br/>area_id: 1<br/>sistema_id: 1<br/>codigo: E001<br/>nombre: EQUIPO 1<br/>numero: 10<br/>codigo2: A1-S1-E001-10<br/>created_at: 2023-06-01 15:56:53<br/>updated_at: 2023-06-01 15:56:53<br/>', NULL, 'SISTEMAS', '2023-06-01', '15:56:54', '2023-06-01 19:56:54', '2023-06-01 19:56:54'),
(20, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN SISTEMA', 'id: 1<br/>area_id: 1<br/>sistema_id: 1<br/>codigo: E001<br/>nombre: EQUIPO 1<br/>numero: 10<br/>codigo2: A1-S1-E001-10<br/>created_at: 2023-06-01 15:56:53<br/>updated_at: 2023-06-01 15:56:53<br/>', 'id: 1<br/>area_id: 1<br/>sistema_id: 1<br/>codigo: E001<br/>nombre: EQUIPO 1<br/>numero: 10<br/>codigo2: A1-S1-E001-10<br/>created_at: 2023-06-01 15:56:53<br/>updated_at: 2023-06-01 15:56:53<br/>', 'SISTEMAS', '2023-06-01', '15:57:21', '2023-06-01 19:57:21', '2023-06-01 19:57:21'),
(21, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SISTEMA', 'id: 2<br/>area_id: 1<br/>sistema_id: 1<br/>codigo: E002<br/>nombre: EQUIPO 2<br/>numero: 10<br/>codigo2: A1-S1-E002-10<br/>created_at: 2023-06-01 15:57:48<br/>updated_at: 2023-06-01 15:57:48<br/>', NULL, 'SISTEMAS', '2023-06-01', '15:57:48', '2023-06-01 19:57:48', '2023-06-01 19:57:48'),
(22, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN SISTEMA', 'id: 2<br/>area_id: 1<br/>sistema_id: 1<br/>codigo: E002<br/>nombre: EQUIPO 2<br/>numero: 10<br/>codigo2: A1-S1-E002-10<br/>created_at: 2023-06-01 15:57:48<br/>updated_at: 2023-06-01 15:57:48<br/>', 'id: 2<br/>area_id: 1<br/>sistema_id: 2<br/>codigo: E002<br/>nombre: EQUIPO 2<br/>numero: 10<br/>codigo2: A1-S2-E002-10<br/>created_at: 2023-06-01 15:57:48<br/>updated_at: 2023-06-01 15:57:57<br/>', 'SISTEMAS', '2023-06-01', '15:57:57', '2023-06-01 19:57:57', '2023-06-01 19:57:57'),
(23, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN SISTEMA', 'id: 2<br/>area_id: 1<br/>sistema_id: 2<br/>codigo: E002<br/>nombre: EQUIPO 2<br/>numero: 10<br/>codigo2: A1-S2-E002-10<br/>created_at: 2023-06-01 15:57:48<br/>updated_at: 2023-06-01 15:57:57<br/>', 'id: 2<br/>area_id: 2<br/>sistema_id: 2<br/>codigo: E002<br/>nombre: EQUIPO 2<br/>numero: 10<br/>codigo2: A2-S2-E002-10<br/>created_at: 2023-06-01 15:57:48<br/>updated_at: 2023-06-01 15:58:06<br/>', 'SISTEMAS', '2023-06-01', '15:58:06', '2023-06-01 19:58:06', '2023-06-01 19:58:06'),
(24, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SISTEMA', 'id: 3<br/>area_id: 1<br/>sistema_id: 2<br/>codigo: ASDA<br/>nombre: ASDASDASDAAS12<br/>numero: 12<br/>codigo2: A1-S2-ASDA-12<br/>created_at: 2023-06-01 15:58:25<br/>updated_at: 2023-06-01 15:58:25<br/>', NULL, 'SISTEMAS', '2023-06-01', '15:58:25', '2023-06-01 19:58:25', '2023-06-01 19:58:25'),
(25, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UN SISTEMA', 'id: 3<br/>area_id: 1<br/>sistema_id: 2<br/>codigo: ASDA<br/>nombre: ASDASDASDAAS12<br/>numero: 12<br/>codigo2: A1-S2-ASDA-12<br/>created_at: 2023-06-01 15:58:25<br/>updated_at: 2023-06-01 15:58:25<br/>', NULL, 'SISTEMAS', '2023-06-01', '15:58:49', '2023-06-01 19:58:49', '2023-06-01 19:58:49'),
(26, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SISTEMA', 'id: 1<br/>area_id: 1<br/>sistema_id: 1<br/>equipo_id: 1<br/>codigo: SUB1<br/>nombre: SUBUNIDAD 1<br/>numero: 12<br/>codigo2: SUB1-12<br/>created_at: 2023-06-01 16:13:20<br/>updated_at: 2023-06-01 16:13:20<br/>', NULL, 'SISTEMAS', '2023-06-01', '16:13:20', '2023-06-01 20:13:20', '2023-06-01 20:13:20'),
(27, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SISTEMA', 'id: 2<br/>area_id: 2<br/>sistema_id: 2<br/>equipo_id: 2<br/>codigo: SUB2<br/>nombre: SUBUNIDADDD2<br/>numero: 32<br/>codigo2: SUB2-32<br/>created_at: 2023-06-01 16:13:37<br/>updated_at: 2023-06-01 16:13:37<br/>', NULL, 'SISTEMAS', '2023-06-01', '16:13:37', '2023-06-01 20:13:37', '2023-06-01 20:13:37'),
(28, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN SISTEMA', 'id: 2<br/>area_id: 2<br/>sistema_id: 2<br/>equipo_id: 2<br/>codigo: SUB2<br/>nombre: SUBUNIDADDD2<br/>numero: 32<br/>codigo2: SUB2-32<br/>created_at: 2023-06-01 16:13:37<br/>updated_at: 2023-06-01 16:13:37<br/>', 'id: 2<br/>area_id: 2<br/>sistema_id: 2<br/>equipo_id: 2<br/>codigo: SUB2<br/>nombre: SUBUNIDAD #2<br/>numero: 32<br/>codigo2: SUB2-32<br/>created_at: 2023-06-01 16:13:37<br/>updated_at: 2023-06-01 16:13:46<br/>', 'SISTEMAS', '2023-06-01', '16:13:46', '2023-06-01 20:13:46', '2023-06-01 20:13:46'),
(29, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SISTEMA', 'id: 3<br/>area_id: 1<br/>sistema_id: 1<br/>equipo_id: 1<br/>codigo: ASDA<br/>nombre: ASDAD<br/>numero: 12<br/>codigo2: ASDA-12<br/>created_at: 2023-06-01 16:14:21<br/>updated_at: 2023-06-01 16:14:21<br/>', NULL, 'SISTEMAS', '2023-06-01', '16:14:21', '2023-06-01 20:14:21', '2023-06-01 20:14:21'),
(30, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN SISTEMA', 'id: 3<br/>area_id: 1<br/>sistema_id: 1<br/>equipo_id: 1<br/>codigo: ASDA<br/>nombre: ASDAD<br/>numero: 12<br/>codigo2: ASDA-12<br/>created_at: 2023-06-01 16:14:21<br/>updated_at: 2023-06-01 16:14:21<br/>', 'id: 3<br/>area_id: 1<br/>sistema_id: 1<br/>equipo_id: 1<br/>codigo: ASD3<br/>nombre: ASDAD<br/>numero: 12<br/>codigo2: ASD3-12<br/>created_at: 2023-06-01 16:14:21<br/>updated_at: 2023-06-01 16:14:49<br/>', 'SISTEMAS', '2023-06-01', '16:14:49', '2023-06-01 20:14:49', '2023-06-01 20:14:49'),
(31, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UN SISTEMA', 'id: 3<br/>area_id: 1<br/>sistema_id: 1<br/>equipo_id: 1<br/>codigo: ASD3<br/>nombre: ASDAD<br/>numero: 12<br/>codigo2: ASD3-12<br/>created_at: 2023-06-01 16:14:21<br/>updated_at: 2023-06-01 16:14:49<br/>', NULL, 'SISTEMAS', '2023-06-01', '16:14:53', '2023-06-01 20:14:53', '2023-06-01 20:14:53'),
(32, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SISTEMA', 'id: 1<br/>equipo_id: 1<br/>descripcion: MAQUINARIA #1<br/>prioridad: P1-URGENTE<br/>ubicacion: PRODUCCIÓN<br/>tipo: REFRIGERACIÓN<br/>marca: MARCA 1<br/>modelo: MODELO 1<br/>serie: SERIE 1<br/>costo: 1000<br/>fecha_compra: 2023-01-01<br/>fecha_instalacion: 2023-06-05<br/>garantia_meses: 24<br/>peso: 100 KG<br/>altura: 2M<br/>ancho: 1M<br/>largo: 1M<br/>voltios: 140 VOLTIOS<br/>capacidad: 300KG<br/>e_tecnicas: ESPEC. TECNICAS<br/>fecha_ultimo_mantenimiento: 0223-06-05<br/>fecha_utlimo_termino: 2023-08-08<br/>estado: ACTIVA<br/>fabricantes: FABRICANTE 1<br/>proveedor: PROVEEDOR 1<br/>terciarios: TERCIARIO 1<br/>nombre_contacto: JUAN PERES<br/>num_fono: 7777<br/>correo: PROVEEDOR@GMAIL.COM<br/>dir: LOS OLIVOS<br/>num_identificacion: 232332<br/>foto: <br/>archivo: <br/>created_at: 2023-06-05 13:16:25<br/>updated_at: 2023-06-05 13:16:25<br/>', NULL, 'SISTEMAS', '2023-06-05', '13:16:25', '2023-06-05 17:16:25', '2023-06-05 17:16:25'),
(33, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SISTEMA', 'altura: 2M<br/>ancho: 1M<br/>archivo: <br/>capacidad: 300KG<br/>correo: PROVEEDOR@GMAIL.COM<br/>costo: 1000.00<br/>created_at: 2023-06-05 18:05:32<br/>descripcion: MAQUINARIA #1<br/>dir: LOS OLIVOS<br/>e_tecnicas: ESPEC. TECNICAS<br/>equipo_id: 1<br/>estado: ACTIVA<br/>fabricantes: FABRICANTE 1<br/>fecha_compra: 2023-01-01<br/>fecha_instalacion: 2023-06-05<br/>fecha_ultimo_mantenimiento: 0223-06-05<br/>fecha_utlimo_termino: 2023-08-08<br/>foto: <br/>garantia_meses: 24<br/>id: 2<br/>largo: 1M<br/>marca: MARCA 1<br/>modelo: MODELO 1<br/>nombre_contacto: JUAN PERES<br/>num_fono: 7777<br/>num_identificacion: 232332<br/>peso: 100 KG<br/>prioridad: P1-URGENTE<br/>proveedor: PROVEEDOR 1<br/>serie: SERIE 1<br/>terciarios: TERCIARIO 1<br/>tipo: REFRIGERACIÓN<br/>ubicacion: PRODUCCIÓN<br/>updated_at: 2023-06-05 18:05:32<br/>voltios: 140 VOLTIOS<br/>', NULL, 'SISTEMAS', '2023-06-05', '18:05:32', '2023-06-05 22:05:32', '2023-06-05 22:05:32'),
(34, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN SISTEMA', 'altura: 2M<br/>ancho: 1M<br/>archivo: <br/>capacidad: 300KG<br/>correo: PROVEEDOR@GMAIL.COM<br/>costo: 1000.00<br/>created_at: 2023-06-05 18:05:32<br/>descripcion: MAQUINARIA #1<br/>dir: LOS OLIVOS<br/>e_tecnicas: ESPEC. TECNICAS<br/>equipo_id: 1<br/>estado: ACTIVA<br/>fabricantes: FABRICANTE 1<br/>fecha_compra: 2023-01-01<br/>fecha_instalacion: 2023-06-05<br/>fecha_ultimo_mantenimiento: 0223-06-05<br/>fecha_utlimo_termino: 2023-08-08<br/>foto: <br/>garantia_meses: 24<br/>id: 2<br/>largo: 1M<br/>marca: MARCA 1<br/>modelo: MODELO 1<br/>nombre_contacto: JUAN PERES<br/>num_fono: 7777<br/>num_identificacion: 232332<br/>peso: 100 KG<br/>prioridad: P1-URGENTE<br/>proveedor: PROVEEDOR 1<br/>serie: SERIE 1<br/>terciarios: TERCIARIO 1<br/>tipo: REFRIGERACIÓN<br/>ubicacion: PRODUCCIÓN<br/>updated_at: 2023-06-05 18:05:32<br/>voltios: 140 VOLTIOS<br/>', 'altura: 2M<br/>ancho: 1M<br/>archivo: <br/>capacidad: 500KG<br/>correo: PROVEEDOR@GMAIL.COM<br/>costo: 2500<br/>created_at: 2023-06-05 18:05:32<br/>descripcion: MAQUINARIA #2<br/>dir: LOS OLIVOS<br/>e_tecnicas: ESPEC. TECNICAS MAQUINA #2<br/>equipo_id: 2<br/>estado: INDISPUESTA<br/>fabricantes: FABRICANTE 2<br/>fecha_compra: 2023-01-03<br/>fecha_instalacion: 2023-06-04<br/>fecha_ultimo_mantenimiento: 0223-06-04<br/>fecha_utlimo_termino: 2023-06-06<br/>foto: <br/>garantia_meses: 24<br/>id: 2<br/>largo: 1M<br/>marca: MARCA 2<br/>modelo: MODELO 2<br/>nombre_contacto: ALBERTO GONZALES<br/>num_fono: 6666666<br/>num_identificacion: 232332<br/>peso: 200KG<br/>prioridad: P2-ALTA<br/>proveedor: PROVEEDOR 2<br/>serie: SERIE 2<br/>terciarios: TERCIARIO 2<br/>tipo: COMPRESIÓN<br/>ubicacion: PATIO<br/>updated_at: 2023-06-05 18:07:13<br/>voltios: 120VOLTIOS<br/>', 'SISTEMAS', '2023-06-05', '18:07:13', '2023-06-05 22:07:13', '2023-06-05 22:07:13'),
(35, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN SISTEMA', 'altura: 2M<br/>ancho: 1M<br/>archivo: <br/>capacidad: 500KG<br/>correo: PROVEEDOR@GMAIL.COM<br/>costo: 2500.00<br/>created_at: 2023-06-05 18:05:32<br/>descripcion: MAQUINARIA #2<br/>dir: LOS OLIVOS<br/>e_tecnicas: ESPEC. TECNICAS MAQUINA #2<br/>equipo_id: 2<br/>estado: INDISPUESTA<br/>fabricantes: FABRICANTE 2<br/>fecha_compra: 2023-01-03<br/>fecha_instalacion: 2023-06-04<br/>fecha_ultimo_mantenimiento: 0223-06-04<br/>fecha_utlimo_termino: 2023-06-06<br/>foto: <br/>garantia_meses: 24<br/>id: 2<br/>largo: 1M<br/>marca: MARCA 2<br/>modelo: MODELO 2<br/>nombre_contacto: ALBERTO GONZALES<br/>num_fono: 6666666<br/>num_identificacion: 232332<br/>peso: 200KG<br/>prioridad: P2-ALTA<br/>proveedor: PROVEEDOR 2<br/>serie: SERIE 2<br/>terciarios: TERCIARIO 2<br/>tipo: COMPRESIÓN<br/>ubicacion: PATIO<br/>updated_at: 2023-06-05 18:07:13<br/>voltios: 120VOLTIOS<br/>', 'altura: 2M<br/>ancho: 1M<br/>archivo: <br/>capacidad: 500KG<br/>correo: PROVEEDOR@GMAIL.COM<br/>costo: 2500.00<br/>created_at: 2023-06-05 18:05:32<br/>descripcion: MAQUINARIA #2<br/>dir: LOS OLIVOS<br/>e_tecnicas: ESPEC. TECNICAS MAQUINA #2<br/>equipo_id: 2<br/>estado: INDISPUESTA<br/>fabricantes: FABRICANTE 2<br/>fecha_compra: 2023-01-03<br/>fecha_instalacion: 2023-06-04<br/>fecha_ultimo_mantenimiento: 0223-06-04<br/>fecha_utlimo_termino: 2023-06-06<br/>foto: <br/>garantia_meses: 24<br/>id: 2<br/>largo: 1M<br/>marca: MARCA 2<br/>modelo: MODELO 2<br/>nombre_contacto: ALBERTO GONZALES<br/>num_fono: 6666666<br/>num_identificacion: 232332<br/>peso: 200KG<br/>prioridad: P2-ALTA<br/>proveedor: PROVEEDOR 2<br/>serie: SERIE 2<br/>terciarios: TERCIARIO 2<br/>tipo: COMPRESIÓN<br/>ubicacion: PATIO<br/>updated_at: 2023-06-05 18:07:13<br/>voltios: 120VOLTIOS<br/>', 'SISTEMAS', '2023-06-05', '18:08:33', '2023-06-05 22:08:33', '2023-06-05 22:08:33'),
(36, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN SISTEMA', 'altura: 2M<br/>ancho: 1M<br/>archivo: <br/>capacidad: 500KG<br/>correo: PROVEEDOR@GMAIL.COM<br/>costo: 2500.00<br/>created_at: 2023-06-05 18:05:32<br/>descripcion: MAQUINARIA #2<br/>dir: LOS OLIVOS<br/>e_tecnicas: ESPEC. TECNICAS MAQUINA #2<br/>equipo_id: 2<br/>estado: INDISPUESTA<br/>fabricantes: FABRICANTE 2<br/>fecha_compra: 2023-01-03<br/>fecha_instalacion: 2023-06-04<br/>fecha_ultimo_mantenimiento: 0223-06-04<br/>fecha_utlimo_termino: 2023-06-06<br/>foto: <br/>garantia_meses: 24<br/>id: 2<br/>largo: 1M<br/>marca: MARCA 2<br/>modelo: MODELO 2<br/>nombre_contacto: ALBERTO GONZALES<br/>num_fono: 6666666<br/>num_identificacion: 232332<br/>peso: 200KG<br/>prioridad: P2-ALTA<br/>proveedor: PROVEEDOR 2<br/>serie: SERIE 2<br/>terciarios: TERCIARIO 2<br/>tipo: COMPRESIÓN<br/>ubicacion: PATIO<br/>updated_at: 2023-06-05 18:07:13<br/>voltios: 120VOLTIOS<br/>', 'altura: 2M<br/>ancho: 1M<br/>archivo: <br/>capacidad: 500KG<br/>correo: PROVEEDOR@GMAIL.COM<br/>costo: 2500.00<br/>created_at: 2023-06-05 18:05:32<br/>descripcion: MAQUINARIA #2<br/>dir: LOS OLIVOS<br/>e_tecnicas: ESPEC. TECNICAS MAQUINA #2<br/>equipo_id: 2<br/>estado: INDISPUESTA<br/>fabricantes: FABRICANTE 2<br/>fecha_compra: 2023-01-03<br/>fecha_instalacion: 2023-06-04<br/>fecha_ultimo_mantenimiento: 0223-06-04<br/>fecha_utlimo_termino: 2023-06-06<br/>foto: <br/>garantia_meses: 24<br/>id: 2<br/>largo: 1M<br/>marca: MARCA 2<br/>modelo: MODELO 2<br/>nombre_contacto: ALBERTO GONZALES<br/>num_fono: 6666666<br/>num_identificacion: 232332<br/>peso: 200KG<br/>prioridad: P2-ALTA<br/>proveedor: PROVEEDOR 2<br/>serie: SERIE 2<br/>terciarios: TERCIARIO 2<br/>tipo: COMPRESIÓN<br/>ubicacion: PATIO<br/>updated_at: 2023-06-05 18:07:13<br/>voltios: 120VOLTIOS<br/>', 'SISTEMAS', '2023-06-05', '18:08:45', '2023-06-05 22:08:45', '2023-06-05 22:08:45'),
(37, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN SISTEMA', 'altura: 2M<br/>ancho: 1M<br/>archivo: <br/>capacidad: 500KG<br/>correo: PROVEEDOR@GMAIL.COM<br/>costo: 2500.00<br/>created_at: 2023-06-05 18:05:32<br/>descripcion: MAQUINARIA #2<br/>dir: LOS OLIVOS<br/>e_tecnicas: ESPEC. TECNICAS MAQUINA #2<br/>equipo_id: 2<br/>estado: INDISPUESTA<br/>fabricantes: FABRICANTE 2<br/>fecha_compra: 2023-01-03<br/>fecha_instalacion: 2023-06-04<br/>fecha_ultimo_mantenimiento: 0223-06-04<br/>fecha_utlimo_termino: 2023-06-06<br/>foto: <br/>garantia_meses: 24<br/>id: 2<br/>largo: 1M<br/>marca: MARCA 2<br/>modelo: MODELO 2<br/>nombre_contacto: ALBERTO GONZALES<br/>num_fono: 6666666<br/>num_identificacion: 232332<br/>peso: 200KG<br/>prioridad: P2-ALTA<br/>proveedor: PROVEEDOR 2<br/>serie: SERIE 2<br/>terciarios: TERCIARIO 2<br/>tipo: COMPRESIÓN<br/>ubicacion: PATIO<br/>updated_at: 2023-06-05 18:07:13<br/>voltios: 120VOLTIOS<br/>', 'altura: 2M<br/>ancho: 1M<br/>archivo: <br/>capacidad: 500KG<br/>correo: PROVEEDOR@GMAIL.COM<br/>costo: 2500.00<br/>created_at: 2023-06-05 18:05:32<br/>descripcion: MAQUINARIA #2<br/>dir: LOS OLIVOS<br/>e_tecnicas: ESPEC. TECNICAS MAQUINA #2<br/>equipo_id: 2<br/>estado: INDISPUESTA<br/>fabricantes: FABRICANTE 2<br/>fecha_compra: 2023-01-03<br/>fecha_instalacion: 2023-06-04<br/>fecha_ultimo_mantenimiento: 0223-06-04<br/>fecha_utlimo_termino: 2023-06-06<br/>foto: <br/>garantia_meses: 24<br/>id: 2<br/>largo: 1M<br/>marca: MARCA 2<br/>modelo: MODELO 2<br/>nombre_contacto: ALBERTO GONZALES<br/>num_fono: 6666666<br/>num_identificacion: 232332<br/>peso: 200KG<br/>prioridad: P2-ALTA<br/>proveedor: PROVEEDOR 2<br/>serie: SERIE 2<br/>terciarios: TERCIARIO 2<br/>tipo: COMPRESIÓN<br/>ubicacion: PATIO<br/>updated_at: 2023-06-05 18:07:13<br/>voltios: 120VOLTIOS<br/>', 'SISTEMAS', '2023-06-05', '18:09:43', '2023-06-05 22:09:43', '2023-06-05 22:09:43'),
(38, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN SISTEMA', 'altura: 2M<br/>ancho: 1M<br/>archivo: <br/>capacidad: 500KG<br/>correo: PROVEEDOR@GMAIL.COM<br/>costo: 2500.00<br/>created_at: 2023-06-05 18:05:32<br/>descripcion: MAQUINARIA #2<br/>dir: LOS OLIVOS<br/>e_tecnicas: ESPEC. TECNICAS MAQUINA #2<br/>equipo_id: 2<br/>estado: INDISPUESTA<br/>fabricantes: FABRICANTE 2<br/>fecha_compra: 2023-01-03<br/>fecha_instalacion: 2023-06-04<br/>fecha_ultimo_mantenimiento: 0223-06-04<br/>fecha_utlimo_termino: 2023-06-06<br/>foto: <br/>garantia_meses: 24<br/>id: 2<br/>largo: 1M<br/>marca: MARCA 2<br/>modelo: MODELO 2<br/>nombre_contacto: ALBERTO GONZALES<br/>num_fono: 6666666<br/>num_identificacion: 232332<br/>peso: 200KG<br/>prioridad: P2-ALTA<br/>proveedor: PROVEEDOR 2<br/>serie: SERIE 2<br/>terciarios: TERCIARIO 2<br/>tipo: COMPRESIÓN<br/>ubicacion: PATIO<br/>updated_at: 2023-06-05 18:07:13<br/>voltios: 120VOLTIOS<br/>', 'altura: 2M<br/>ancho: 1M<br/>archivo: <br/>capacidad: 500KG<br/>correo: PROVEEDOR@GMAIL.COM<br/>costo: 2500.00<br/>created_at: 2023-06-05 18:05:32<br/>descripcion: MAQUINARIA #2<br/>dir: LOS OLIVOS<br/>e_tecnicas: ESPEC. TECNICAS MAQUINA #2<br/>equipo_id: 2<br/>estado: INDISPUESTA<br/>fabricantes: FABRICANTE 2<br/>fecha_compra: 2023-01-03<br/>fecha_instalacion: 2023-06-04<br/>fecha_ultimo_mantenimiento: 0223-06-04<br/>fecha_utlimo_termino: 2023-06-06<br/>foto: 21686003889.png<br/>garantia_meses: 24<br/>id: 2<br/>largo: 1M<br/>marca: MARCA 2<br/>modelo: MODELO 2<br/>nombre_contacto: ALBERTO GONZALES<br/>num_fono: 6666666<br/>num_identificacion: 232332<br/>peso: 200KG<br/>prioridad: P2-ALTA<br/>proveedor: PROVEEDOR 2<br/>serie: SERIE 2<br/>terciarios: TERCIARIO 2<br/>tipo: COMPRESIÓN<br/>ubicacion: PATIO<br/>updated_at: 2023-06-05 18:24:49<br/>voltios: 120VOLTIOS<br/>', 'SISTEMAS', '2023-06-05', '18:24:49', '2023-06-05 22:24:49', '2023-06-05 22:24:49'),
(39, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN SISTEMA', 'altura: 2M<br/>ancho: 1M<br/>archivo: <br/>capacidad: 500KG<br/>correo: PROVEEDOR@GMAIL.COM<br/>costo: 2500.00<br/>created_at: 2023-06-05 18:05:32<br/>descripcion: MAQUINARIA #2<br/>dir: LOS OLIVOS<br/>e_tecnicas: ESPEC. TECNICAS MAQUINA #2<br/>equipo_id: 2<br/>estado: INDISPUESTA<br/>fabricantes: FABRICANTE 2<br/>fecha_compra: 2023-01-03<br/>fecha_instalacion: 2023-06-04<br/>fecha_ultimo_mantenimiento: 0223-06-04<br/>fecha_utlimo_termino: 2023-06-06<br/>foto: 21686003889.png<br/>garantia_meses: 24<br/>id: 2<br/>largo: 1M<br/>marca: MARCA 2<br/>modelo: MODELO 2<br/>nombre_contacto: ALBERTO GONZALES<br/>num_fono: 6666666<br/>num_identificacion: 232332<br/>peso: 200KG<br/>prioridad: P2-ALTA<br/>proveedor: PROVEEDOR 2<br/>serie: SERIE 2<br/>terciarios: TERCIARIO 2<br/>tipo: COMPRESIÓN<br/>ubicacion: PATIO<br/>updated_at: 2023-06-05 18:24:49<br/>voltios: 120VOLTIOS<br/>', 'altura: 2M<br/>ancho: 1M<br/>archivo: 21686003915.pdf<br/>capacidad: 500KG<br/>correo: PROVEEDOR@GMAIL.COM<br/>costo: 2500.00<br/>created_at: 2023-06-05 18:05:32<br/>descripcion: MAQUINARIA #2<br/>dir: LOS OLIVOS<br/>e_tecnicas: ESPEC. TECNICAS MAQUINA #2<br/>equipo_id: 2<br/>estado: INDISPUESTA<br/>fabricantes: FABRICANTE 2<br/>fecha_compra: 2023-01-03<br/>fecha_instalacion: 2023-06-04<br/>fecha_ultimo_mantenimiento: 0223-06-04<br/>fecha_utlimo_termino: 2023-06-06<br/>foto: 21686003889.png<br/>garantia_meses: 24<br/>id: 2<br/>largo: 1M<br/>marca: MARCA 2<br/>modelo: MODELO 2<br/>nombre_contacto: ALBERTO GONZALES<br/>num_fono: 6666666<br/>num_identificacion: 232332<br/>peso: 200KG<br/>prioridad: P2-ALTA<br/>proveedor: PROVEEDOR 2<br/>serie: SERIE 2<br/>terciarios: TERCIARIO 2<br/>tipo: COMPRESIÓN<br/>ubicacion: PATIO<br/>updated_at: 2023-06-05 18:25:15<br/>voltios: 120VOLTIOS<br/>', 'SISTEMAS', '2023-06-05', '18:25:15', '2023-06-05 22:25:15', '2023-06-05 22:25:15'),
(40, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN SISTEMA', 'altura: 2M<br/>ancho: 1M<br/>archivo: <br/>capacidad: 300KG<br/>correo: PROVEEDOR@GMAIL.COM<br/>costo: 1000.00<br/>created_at: 2023-06-05 13:16:25<br/>descripcion: MAQUINARIA #1<br/>dir: LOS OLIVOS<br/>e_tecnicas: ESPEC. TECNICAS<br/>equipo_id: 1<br/>estado: ACTIVA<br/>fabricantes: FABRICANTE 1<br/>fecha_compra: 2023-01-01<br/>fecha_instalacion: 2023-06-05<br/>fecha_ultimo_mantenimiento: 0223-06-05<br/>fecha_utlimo_termino: 2023-08-08<br/>foto: <br/>garantia_meses: 24<br/>id: 1<br/>largo: 1M<br/>marca: MARCA 1<br/>modelo: MODELO 1<br/>nombre_contacto: JUAN PERES<br/>num_fono: 7777<br/>num_identificacion: 232332<br/>peso: 100 KG<br/>prioridad: P1-URGENTE<br/>proveedor: PROVEEDOR 1<br/>serie: SERIE 1<br/>terciarios: TERCIARIO 1<br/>tipo: REFRIGERACIÓN<br/>ubicacion: PRODUCCIÓN<br/>updated_at: 2023-06-05 13:16:25<br/>voltios: 140 VOLTIOS<br/>', 'altura: 2M<br/>ancho: 1M<br/>archivo: <br/>capacidad: 300KG<br/>correo: PROVEEDOR@GMAIL.COM<br/>costo: 1000.00<br/>created_at: 2023-06-05 13:16:25<br/>descripcion: MAQUINARIA #1<br/>dir: LOS OLIVOS<br/>e_tecnicas: ESPEC. TECNICAS<br/>equipo_id: 1<br/>estado: ACTIVA<br/>fabricantes: FABRICANTE 1<br/>fecha_compra: 2023-01-01<br/>fecha_instalacion: 2023-06-05<br/>fecha_ultimo_mantenimiento: 0223-06-05<br/>fecha_utlimo_termino: 2023-08-08<br/>foto: <br/>garantia_meses: 24<br/>id: 1<br/>largo: 1M<br/>marca: MARCA 1<br/>modelo: MODELO 1<br/>nombre_contacto: JUAN PERES<br/>num_fono: 7777<br/>num_identificacion: 232332<br/>peso: 100 KG<br/>prioridad: P1-URGENTE<br/>proveedor: PROVEEDOR 1<br/>serie: SERIE 1<br/>terciarios: TERCIARIO 1<br/>tipo: REFRIGERACIÓN<br/>ubicacion: PRODUCCIÓN<br/>updated_at: 2023-06-05 13:16:25<br/>voltios: 140 VOLTIOS<br/>', 'SISTEMAS', '2023-06-05', '18:28:18', '2023-06-05 22:28:18', '2023-06-05 22:28:18'),
(41, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN SISTEMA', 'altura: 2M<br/>ancho: 1M<br/>archivo: 21686003915.pdf<br/>capacidad: 500KG<br/>correo: PROVEEDOR@GMAIL.COM<br/>costo: 2500.00<br/>created_at: 2023-06-05 18:05:32<br/>descripcion: MAQUINARIA #2<br/>dir: LOS OLIVOS<br/>e_tecnicas: ESPEC. TECNICAS MAQUINA #2<br/>equipo_id: 2<br/>estado: INDISPUESTA<br/>fabricantes: FABRICANTE 2<br/>fecha_compra: 2023-01-03<br/>fecha_instalacion: 2023-06-04<br/>fecha_ultimo_mantenimiento: 0223-06-04<br/>fecha_utlimo_termino: 2023-06-06<br/>foto: 21686003889.png<br/>garantia_meses: 24<br/>id: 2<br/>largo: 1M<br/>marca: MARCA 2<br/>modelo: MODELO 2<br/>nombre_contacto: ALBERTO GONZALES<br/>num_fono: 6666666<br/>num_identificacion: 232332<br/>peso: 200KG<br/>prioridad: P2-ALTA<br/>proveedor: PROVEEDOR 2<br/>serie: SERIE 2<br/>terciarios: TERCIARIO 2<br/>tipo: COMPRESIÓN<br/>ubicacion: PATIO<br/>updated_at: 2023-06-05 18:25:15<br/>voltios: 120VOLTIOS<br/>', 'altura: 2M<br/>ancho: 1M<br/>archivo: 21686004115.pdf<br/>capacidad: 500KG<br/>correo: PROVEEDOR@GMAIL.COM<br/>costo: 2500.00<br/>created_at: 2023-06-05 18:05:32<br/>descripcion: MAQUINARIA #2<br/>dir: LOS OLIVOS<br/>e_tecnicas: ESPEC. TECNICAS MAQUINA #2<br/>equipo_id: 2<br/>estado: INDISPUESTA<br/>fabricantes: FABRICANTE 2<br/>fecha_compra: 2023-01-03<br/>fecha_instalacion: 2023-06-04<br/>fecha_ultimo_mantenimiento: 0223-06-04<br/>fecha_utlimo_termino: 2023-06-06<br/>foto: 21686003889.png<br/>garantia_meses: 24<br/>id: 2<br/>largo: 1M<br/>marca: MARCA 2<br/>modelo: MODELO 2<br/>nombre_contacto: ALBERTO GONZALES<br/>num_fono: 6666666<br/>num_identificacion: 232332<br/>peso: 200KG<br/>prioridad: P2-ALTA<br/>proveedor: PROVEEDOR 2<br/>serie: SERIE 2<br/>terciarios: TERCIARIO 2<br/>tipo: COMPRESIÓN<br/>ubicacion: PATIO<br/>updated_at: 2023-06-05 18:28:35<br/>voltios: 120VOLTIOS<br/>', 'SISTEMAS', '2023-06-05', '18:28:35', '2023-06-05 22:28:35', '2023-06-05 22:28:35'),
(42, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN SISTEMA', 'altura: 2M<br/>ancho: 1M<br/>archivo: 21686004115.pdf<br/>capacidad: 500KG<br/>correo: PROVEEDOR@GMAIL.COM<br/>costo: 2500.00<br/>created_at: 2023-06-05 18:05:32<br/>descripcion: MAQUINARIA #2<br/>dir: LOS OLIVOS<br/>e_tecnicas: ESPEC. TECNICAS MAQUINA #2<br/>equipo_id: 2<br/>estado: INDISPUESTA<br/>fabricantes: FABRICANTE 2<br/>fecha_compra: 2023-01-03<br/>fecha_instalacion: 2023-06-04<br/>fecha_ultimo_mantenimiento: 0223-06-04<br/>fecha_utlimo_termino: 2023-06-06<br/>foto: 21686003889.png<br/>garantia_meses: 24<br/>id: 2<br/>largo: 1M<br/>marca: MARCA 2<br/>modelo: MODELO 2<br/>nombre_contacto: ALBERTO GONZALES<br/>num_fono: 6666666<br/>num_identificacion: 232332<br/>peso: 200KG<br/>prioridad: P2-ALTA<br/>proveedor: PROVEEDOR 2<br/>serie: SERIE 2<br/>terciarios: TERCIARIO 2<br/>tipo: COMPRESIÓN<br/>ubicacion: PATIO<br/>updated_at: 2023-06-05 18:28:35<br/>voltios: 120VOLTIOS<br/>', 'altura: 2M<br/>ancho: 1M<br/>archivo: 21686004196.pdf<br/>capacidad: 500KG<br/>correo: PROVEEDOR@GMAIL.COM<br/>costo: 2500.00<br/>created_at: 2023-06-05 18:05:32<br/>descripcion: MAQUINARIA #2<br/>dir: LOS OLIVOS<br/>e_tecnicas: ESPEC. TECNICAS MAQUINA #2<br/>equipo_id: 2<br/>estado: INDISPUESTA<br/>fabricantes: FABRICANTE 2<br/>fecha_compra: 2023-01-03<br/>fecha_instalacion: 2023-06-04<br/>fecha_ultimo_mantenimiento: 0223-06-04<br/>fecha_utlimo_termino: 2023-06-06<br/>foto: 21686003889.png<br/>garantia_meses: 24<br/>id: 2<br/>largo: 1M<br/>marca: MARCA 2<br/>modelo: MODELO 2<br/>nombre_contacto: ALBERTO GONZALES<br/>num_fono: 6666666<br/>num_identificacion: 232332<br/>peso: 200KG<br/>prioridad: P2-ALTA<br/>proveedor: PROVEEDOR 2<br/>serie: SERIE 2<br/>terciarios: TERCIARIO 2<br/>tipo: COMPRESIÓN<br/>ubicacion: PATIO<br/>updated_at: 2023-06-05 18:29:56<br/>voltios: 120VOLTIOS<br/>', 'SISTEMAS', '2023-06-05', '18:29:56', '2023-06-05 22:29:56', '2023-06-05 22:29:56'),
(43, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SISTEMA', 'altura: <br/>ancho: <br/>archivo: 31686005473.pdf<br/>capacidad: <br/>correo: <br/>costo: <br/>created_at: 2023-06-05 18:51:13<br/>descripcion: MAQUINARIA #3<br/>dir: <br/>e_tecnicas: <br/>equipo_id: 2<br/>estado: ACTIVA<br/>fabricantes: <br/>fecha_compra: <br/>fecha_instalacion: <br/>fecha_ultimo_mantenimiento: <br/>fecha_utlimo_termino: <br/>foto: 31686005473.jpg<br/>garantia_meses: <br/>id: 3<br/>largo: <br/>marca: <br/>modelo: <br/>nombre_contacto: <br/>num_fono: <br/>num_identificacion: <br/>peso: <br/>prioridad: P5-MINIMA<br/>proveedor: <br/>serie: <br/>terciarios: <br/>tipo: OTROS<br/>ubicacion: CALDERAS<br/>updated_at: 2023-06-05 18:51:13<br/>voltios: <br/>', NULL, 'SISTEMAS', '2023-06-05', '18:51:13', '2023-06-05 22:51:13', '2023-06-05 22:51:13'),
(44, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UN SISTEMA', 'altura: <br/>ancho: <br/>archivo: 31686005473.pdf<br/>capacidad: <br/>correo: <br/>costo: <br/>created_at: 2023-06-05 18:51:13<br/>descripcion: MAQUINARIA #3<br/>dir: <br/>e_tecnicas: <br/>equipo_id: 2<br/>estado: ACTIVA<br/>fabricantes: <br/>fecha_compra: <br/>fecha_instalacion: <br/>fecha_ultimo_mantenimiento: <br/>fecha_utlimo_termino: <br/>foto: 31686005473.jpg<br/>garantia_meses: <br/>id: 3<br/>largo: <br/>marca: <br/>modelo: <br/>nombre_contacto: <br/>num_fono: <br/>num_identificacion: <br/>peso: <br/>prioridad: P5-MINIMA<br/>proveedor: <br/>serie: <br/>terciarios: <br/>tipo: OTROS<br/>ubicacion: CALDERAS<br/>updated_at: 2023-06-05 18:51:13<br/>voltios: <br/>', NULL, 'SISTEMAS', '2023-06-05', '19:01:27', '2023-06-05 23:01:27', '2023-06-05 23:01:27'),
(45, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA VARIABLE DE CONTROL', 'created_at: 2023-06-06 11:05:22<br/>id: 1<br/>nombre: VARIABLE CONTROL #1<br/>unidad: HORA<br/>updated_at: 2023-06-06 11:05:22<br/>', NULL, 'VARIABLES DE CONTROL', '2023-06-06', '11:05:22', '2023-06-06 15:05:22', '2023-06-06 15:05:22'),
(46, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA VARIABLE DE CONTROL', 'created_at: 2023-06-06 11:05:33<br/>id: 2<br/>nombre: VARIABLE #2<br/>unidad: KILÓMETROS<br/>updated_at: 2023-06-06 11:05:33<br/>', NULL, 'VARIABLES DE CONTROL', '2023-06-06', '11:05:33', '2023-06-06 15:05:33', '2023-06-06 15:05:33'),
(47, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA VARIABLE DE CONTROL', 'created_at: 2023-06-06 11:05:43<br/>id: 3<br/>nombre: VARIABLE #3<br/>unidad: MILLAS<br/>updated_at: 2023-06-06 11:05:43<br/>', NULL, 'VARIABLES DE CONTROL', '2023-06-06', '11:05:43', '2023-06-06 15:05:43', '2023-06-06 15:05:43'),
(48, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA VARIABLE DE CONTROL', 'created_at: 2023-06-06 11:05:43<br/>id: 3<br/>nombre: VARIABLE #3<br/>unidad: MILLAS<br/>updated_at: 2023-06-06 11:05:43<br/>', NULL, 'VARIABLES DE CONTROL', '2023-06-06', '11:05:56', '2023-06-06 15:05:56', '2023-06-06 15:05:56'),
(49, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UNA VARIABLE DE CONTROL', 'created_at: 2023-06-06 11:05:43<br/>id: 3<br/>nombre: VARIABLE #3 MOD<br/>unidad: LITROS<br/>updated_at: 2023-06-06 11:05:56<br/>', NULL, 'VARIABLES DE CONTROL', '2023-06-06', '11:06:26', '2023-06-06 15:06:26', '2023-06-06 15:06:26'),
(50, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA CATEGORIA', 'created_at: 2023-06-06 11:15:51<br/>frecuencia: 1<br/>id: 1<br/>updated_at: 2023-06-06 11:15:51<br/>variable_id: 1<br/>', NULL, 'CATEGORIAS', '2023-06-06', '11:15:51', '2023-06-06 15:15:51', '2023-06-06 15:15:51'),
(51, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA CATEGORIA', 'created_at: 2023-06-06 11:15:51<br/>frecuencia: 1<br/>id: 1<br/>updated_at: 2023-06-06 11:15:51<br/>variable_id: 1<br/>', 'created_at: 2023-06-06 11:15:51<br/>frecuencia: 2<br/>id: 1<br/>updated_at: 2023-06-06 11:16:16<br/>variable_id: 2<br/>', 'CATEGORIAS', '2023-06-06', '11:16:16', '2023-06-06 15:16:16', '2023-06-06 15:16:16'),
(52, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA CATEGORIA', 'created_at: 2023-06-06 11:15:51<br/>frecuencia: 2<br/>id: 1<br/>updated_at: 2023-06-06 11:16:16<br/>variable_id: 2<br/>', 'created_at: 2023-06-06 11:15:51<br/>frecuencia: 1<br/>id: 1<br/>updated_at: 2023-06-06 11:16:28<br/>variable_id: 1<br/>', 'CATEGORIAS', '2023-06-06', '11:16:28', '2023-06-06 15:16:28', '2023-06-06 15:16:28'),
(53, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA CATEGORIA', 'created_at: 2023-06-06 11:16:35<br/>frecuencia: 3<br/>id: 2<br/>updated_at: 2023-06-06 11:16:35<br/>variable_id: 2<br/>', NULL, 'CATEGORIAS', '2023-06-06', '11:16:35', '2023-06-06 15:16:35', '2023-06-06 15:16:35'),
(54, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UNA CATEGORIA', 'created_at: 2023-06-06 11:16:35<br/>frecuencia: 3<br/>id: 2<br/>updated_at: 2023-06-06 11:16:35<br/>variable_id: 2<br/>', NULL, 'CATEGORIAS', '2023-06-06', '11:17:33', '2023-06-06 15:17:33', '2023-06-06 15:17:33'),
(55, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SISTEMA', 'almacen: ALMACEN 1<br/>clasificacion: CLASIFICACION 1<br/>cod_clasificacion: CLASI1<br/>codigo: H001<br/>correo: PERES@GMAIL.COM<br/>correo_fabricante: FABRICANTE@GMAIL.COM<br/>costo: 1000<br/>created_at: 2023-06-06 12:05:22<br/>descripcion: DESC, HERRAMIENTA #1<br/>dir: LOS OLIVOS<br/>dir_fabricante: LOS PEDREGALES<br/>e_tecnicas: ESPECIFICACIONES TECNIAS HERRAMIENTA #1<br/>fabricante: FABRICANTE 1<br/>fono: 222222<br/>foto: 11686067522.jpg<br/>id: 1<br/>marca: MARCA 1<br/>modelo: MODELO 1<br/>nombre: HERRAMIENTA #1<br/>nombre_contacto: JUAN PERES<br/>num_fono: 222222<br/>num_identificacion: 2332323<br/>proveedor: PERES S.A.<br/>serie: SERIE 1<br/>terciarios: TERCIARIOS 1<br/>unidad_medida: METROS<br/>updated_at: 2023-06-06 12:05:22<br/>', NULL, 'SISTEMAS', '2023-06-06', '12:05:22', '2023-06-06 16:05:22', '2023-06-06 16:05:22'),
(56, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN SISTEMA', 'almacen: ALMACEN 1<br/>clasificacion: CLASIFICACION 1<br/>cod_clasificacion: CLASI1<br/>codigo: H001<br/>correo: PERES@GMAIL.COM<br/>correo_fabricante: FABRICANTE@GMAIL.COM<br/>costo: 1000.00<br/>created_at: 2023-06-06 12:05:22<br/>descripcion: DESC, HERRAMIENTA #1<br/>dir: LOS OLIVOS<br/>dir_fabricante: LOS PEDREGALES<br/>e_tecnicas: ESPECIFICACIONES TECNIAS HERRAMIENTA #1<br/>fabricante: FABRICANTE 1<br/>fono: 222222<br/>foto: 11686067522.jpg<br/>id: 1<br/>marca: MARCA 1<br/>modelo: MODELO 1<br/>nombre: HERRAMIENTA #1<br/>nombre_contacto: JUAN PERES<br/>num_fono: 222222<br/>num_identificacion: 2332323<br/>proveedor: PERES S.A.<br/>serie: SERIE 1<br/>terciarios: TERCIARIOS 1<br/>unidad_medida: METROS<br/>updated_at: 2023-06-06 12:05:22<br/>', 'almacen: ALMACEN 1<br/>clasificacion: CLASIFICACION 1<br/>cod_clasificacion: CLASI1<br/>codigo: H001<br/>correo: PERES@GMAIL.COM<br/>correo_fabricante: FABRICANTE@GMAIL.COM<br/>costo: 1000.00<br/>created_at: 2023-06-06 12:05:22<br/>descripcion: DESC, HERRAMIENTA #1<br/>dir: LOS OLIVOS<br/>dir_fabricante: LOS PEDREGALES<br/>e_tecnicas: ESPECIFICACIONES TECNIAS HERRAMIENTA #1<br/>fabricante: FABRICANTE 1<br/>fono: 222222<br/>foto: 11686067522.jpg<br/>id: 1<br/>marca: MARCA 1<br/>modelo: MODELO 1<br/>nombre: HERRAMIENTA #1<br/>nombre_contacto: JUAN PERES<br/>num_fono: 222222<br/>num_identificacion: 23323211111<br/>proveedor: PERES S.A.<br/>serie: SERIE 1<br/>terciarios: TERCIARIOS 1<br/>unidad_medida: METROS<br/>updated_at: 2023-06-06 12:13:18<br/>', 'SISTEMAS', '2023-06-06', '12:13:18', '2023-06-06 16:13:18', '2023-06-06 16:13:18'),
(57, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN SISTEMA', 'almacen: ALMACEN 1<br/>clasificacion: CLASIFICACION 1<br/>cod_clasificacion: CLASI1<br/>codigo: H001<br/>correo: PERES@GMAIL.COM<br/>correo_fabricante: FABRICANTE@GMAIL.COM<br/>costo: 1000.00<br/>created_at: 2023-06-06 12:05:22<br/>descripcion: DESC, HERRAMIENTA #1<br/>dir: LOS OLIVOS<br/>dir_fabricante: LOS PEDREGALES<br/>e_tecnicas: ESPECIFICACIONES TECNIAS HERRAMIENTA #1<br/>fabricante: FABRICANTE 1<br/>fono: 222222<br/>foto: 11686067522.jpg<br/>id: 1<br/>marca: MARCA 1<br/>modelo: MODELO 1<br/>nombre: HERRAMIENTA #1<br/>nombre_contacto: JUAN PERES<br/>num_fono: 222222<br/>num_identificacion: 23323211111<br/>proveedor: PERES S.A.<br/>serie: SERIE 1<br/>terciarios: TERCIARIOS 1<br/>unidad_medida: METROS<br/>updated_at: 2023-06-06 12:13:18<br/>', 'almacen: ALMACEN 1<br/>clasificacion: CLASIFICACION 1<br/>cod_clasificacion: CLASI1<br/>codigo: H001<br/>correo: PERES@GMAIL.COM<br/>correo_fabricante: FABRICANTE@GMAIL.COM<br/>costo: 1000.00<br/>created_at: 2023-06-06 12:05:22<br/>descripcion: DESC, HERRAMIENTA #1<br/>dir: LOS OLIVOS<br/>dir_fabricante: LOS PEDREGALES<br/>e_tecnicas: ESPECIFICACIONES TECNIAS HERRAMIENTA #1<br/>fabricante: FABRICANTE 1<br/>fono: 222222<br/>foto: 11686068009.jpeg<br/>id: 1<br/>marca: MARCA 1<br/>modelo: MODELO 1<br/>nombre: HERRAMIENTA #1<br/>nombre_contacto: JUAN PERES<br/>num_fono: 222222<br/>num_identificacion: 23323211111<br/>proveedor: PERES S.A.<br/>serie: SERIE 1<br/>terciarios: TERCIARIOS 1<br/>unidad_medida: METROS<br/>updated_at: 2023-06-06 12:13:29<br/>', 'SISTEMAS', '2023-06-06', '12:13:29', '2023-06-06 16:13:29', '2023-06-06 16:13:29'),
(58, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SISTEMA', 'almacen: ALMACEN 2<br/>clasificacion: <br/>cod_clasificacion: <br/>codigo: H002<br/>correo: <br/>correo_fabricante: <br/>costo: <br/>created_at: 2023-06-06 12:14:14<br/>descripcion: DESC #2<br/>dir: <br/>dir_fabricante: <br/>e_tecnicas: <br/>fabricante: <br/>fono: <br/>foto: <br/>id: 2<br/>marca: <br/>modelo: <br/>nombre: HERRAMIENTA #2<br/>nombre_contacto: <br/>num_fono: <br/>num_identificacion: <br/>proveedor: PROVEEDOR 1<br/>serie: <br/>terciarios: <br/>unidad_medida: <br/>updated_at: 2023-06-06 12:14:14<br/>', NULL, 'SISTEMAS', '2023-06-06', '12:14:14', '2023-06-06 16:14:14', '2023-06-06 16:14:14'),
(59, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UN SISTEMA', 'almacen: ALMACEN 2<br/>clasificacion: <br/>cod_clasificacion: <br/>codigo: H002<br/>correo: <br/>correo_fabricante: <br/>costo: <br/>created_at: 2023-06-06 12:14:14<br/>descripcion: DESC #2<br/>dir: <br/>dir_fabricante: <br/>e_tecnicas: <br/>fabricante: <br/>fono: <br/>foto: <br/>id: 2<br/>marca: <br/>modelo: <br/>nombre: HERRAMIENTA #2<br/>nombre_contacto: <br/>num_fono: <br/>num_identificacion: <br/>proveedor: PROVEEDOR 1<br/>serie: <br/>terciarios: <br/>unidad_medida: <br/>updated_at: 2023-06-06 12:14:14<br/>', NULL, 'SISTEMAS', '2023-06-06', '12:15:29', '2023-06-06 16:15:29', '2023-06-06 16:15:29'),
(60, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SISTEMA', 'id: 3<br/>codigo: E001<br/>nombre: EQUIPO #1<br/>descripcion: DESC EQUIPO # 1<br/>clasificacion: CLASIFICACION EQUIPO<br/>cod_clasificacion: CODIGOCLAS<br/>marca: MARCA EQUIPOS<br/>modelo: MODELO EQUIPO<br/>serie: SERIEEQUIPO<br/>costo: 3000<br/>unidad_medida: METROS<br/>proveedor: PROVEEDOR DEL EQUIPO<br/>dir: <br/>fono: <br/>correo: <br/>almacen: ALMACEN EQUIPOS<br/>fabricante: <br/>terciarios: <br/>nombre_contacto: <br/>num_fono: <br/>correo_fabricante: <br/>dir_fabricante: <br/>num_identificacion: <br/>e_tecnicas: <br/>foto: <br/>created_at: 2023-06-06 17:08:23<br/>updated_at: 2023-06-06 17:08:23<br/>', NULL, 'SISTEMAS', '2023-06-06', '17:08:24', '2023-06-06 21:08:24', '2023-06-06 21:08:24'),
(61, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA ENTRADA DE HERRAMIENTA/EQUIPO DE PROTECCIÓN', 'id: 1<br/>factura: <br/>herramienta_id: 1<br/>cantidad: 20<br/>unidad_medida: METROS<br/>precio: 50<br/>total: 1000.00<br/>fecha: 2023-06-06<br/>created_at: 2023-06-06 17:21:45<br/>updated_at: 2023-06-06 17:21:45<br/>', NULL, 'ENTRADA DE HERRAMIENTAS/EQUIPOS DE PROTECCIÓN', '2023-06-06', '17:21:45', '2023-06-06 21:21:45', '2023-06-06 21:21:45'),
(62, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UNA ENTRADA DE HERRAMIENTA/EQUIPO DE PROTECCIÓN', 'id: 1<br/>factura: <br/>herramienta_id: 1<br/>cantidad: 20<br/>unidad_medida: METROS<br/>precio: 50.00<br/>total: 1000.00<br/>fecha: 2023-06-06<br/>created_at: 2023-06-06 17:21:45<br/>updated_at: 2023-06-06 17:21:45<br/>', NULL, 'ENTRADA DE HERRAMIENTAS/EQUIPOS DE PROTECCIÓN', '2023-06-06', '17:26:12', '2023-06-06 21:26:12', '2023-06-06 21:26:12'),
(63, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA ENTRADA DE HERRAMIENTA/EQUIPO DE PROTECCIÓN', 'id: 2<br/>factura: 100000<br/>herramienta_id: 1<br/>cantidad: 50<br/>unidad_medida: METROS<br/>precio: 50<br/>total: 2500.00<br/>fecha: 2023-06-06<br/>created_at: 2023-06-06 17:26:35<br/>updated_at: 2023-06-06 17:26:35<br/>', NULL, 'ENTRADA DE HERRAMIENTAS/EQUIPOS DE PROTECCIÓN', '2023-06-06', '17:26:35', '2023-06-06 21:26:35', '2023-06-06 21:26:35'),
(64, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA ENTRADA DE HERRAMIENTA/EQUIPO DE PROTECCIÓN', 'id: 2<br/>factura: 100000<br/>herramienta_id: 1<br/>cantidad: 50<br/>unidad_medida: METROS<br/>precio: 50.00<br/>total: 2500.00<br/>fecha: 2023-06-06<br/>created_at: 2023-06-06 17:26:35<br/>updated_at: 2023-06-06 17:26:35<br/>', 'id: 2<br/>factura: 121212<br/>herramienta_id: 1<br/>cantidad: 100<br/>unidad_medida: METROS<br/>precio: 50.00<br/>total: 5000.00<br/>fecha: 2023-06-05<br/>created_at: 2023-06-06 17:26:35<br/>updated_at: 2023-06-06 17:26:49<br/>', 'ENTRADA DE HERRAMIENTAS/EQUIPOS DE PROTECCIÓN', '2023-06-06', '17:26:49', '2023-06-06 21:26:49', '2023-06-06 21:26:49'),
(65, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA ENTRADA DE HERRAMIENTA/EQUIPO DE PROTECCIÓN', 'id: 2<br/>factura: 121212<br/>herramienta_id: 1<br/>cantidad: 100<br/>unidad_medida: METROS<br/>precio: 50.00<br/>total: 5000.00<br/>fecha: 2023-06-05<br/>created_at: 2023-06-06 17:26:35<br/>updated_at: 2023-06-06 17:26:49<br/>', 'id: 2<br/>factura: 121212<br/>herramienta_id: 3<br/>cantidad: 200<br/>unidad_medida: METROS<br/>precio: 50.00<br/>total: 10000.00<br/>fecha: 2023-06-05<br/>created_at: 2023-06-06 17:26:35<br/>updated_at: 2023-06-06 17:27:04<br/>', 'ENTRADA DE HERRAMIENTAS/EQUIPOS DE PROTECCIÓN', '2023-06-06', '17:27:04', '2023-06-06 21:27:04', '2023-06-06 21:27:04'),
(66, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA ENTRADA DE HERRAMIENTA/EQUIPO DE PROTECCIÓN', 'id: 2<br/>factura: 121212<br/>herramienta_id: 3<br/>cantidad: 200<br/>unidad_medida: METROS<br/>precio: 50.00<br/>total: 10000.00<br/>fecha: 2023-06-05<br/>created_at: 2023-06-06 17:26:35<br/>updated_at: 2023-06-06 17:27:04<br/>', 'id: 2<br/>factura: 121212<br/>herramienta_id: 3<br/>cantidad: 100<br/>unidad_medida: METROS<br/>precio: 50.00<br/>total: 5000.00<br/>fecha: 2023-06-05<br/>created_at: 2023-06-06 17:26:35<br/>updated_at: 2023-06-06 17:27:12<br/>', 'ENTRADA DE HERRAMIENTAS/EQUIPOS DE PROTECCIÓN', '2023-06-06', '17:27:12', '2023-06-06 21:27:12', '2023-06-06 21:27:12'),
(67, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN REPUESTOS/INSUMO', 'almacen: ALMACEN 1<br/>codigo: R001<br/>correo: PROVEEDOR@GMAIL.COM<br/>correo_fabricante: FABRICANTE@GMAIL.COM<br/>created_at: 2023-06-07 13:01:13<br/>descripcion: DESC. REPUESTO #1<br/>dir: LOS OLIVOS<br/>dir_fabricante: LOS OLIVOS #2<br/>equipo_id: 1<br/>fabricante: FABRICANTE 1<br/>fono: 222222<br/>id: 1<br/>marca: MARCA 1<br/>modelo: MODELO 1<br/>nombre: REPUESTO #1<br/>nombre_contacto: JUAN PERES<br/>num_fono: 7777777<br/>num_identificacion: 433434<br/>precio: 560<br/>proveedor: PROVEEDOR 1<br/>serie: SERIE 1<br/>stock_max: 200<br/>stock_min: 10<br/>terciarios: TERCIARIO 1<br/>unidad_medida: UNIDADES<br/>updated_at: 2023-06-07 13:01:13<br/>', NULL, 'REPUESTOS/INSUMOS', '2023-06-07', '13:01:14', '2023-06-07 17:01:14', '2023-06-07 17:01:14');
INSERT INTO `historial_accions` (`id`, `user_id`, `accion`, `descripcion`, `datos_original`, `datos_nuevo`, `modulo`, `fecha`, `hora`, `created_at`, `updated_at`) VALUES
(68, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN REPUESTOS/INSUMO', 'almacen: ALMACEN 1<br/>codigo: R001<br/>correo: PROVEEDOR@GMAIL.COM<br/>correo_fabricante: FABRICANTE@GMAIL.COM<br/>created_at: 2023-06-07 13:01:13<br/>descripcion: DESC. REPUESTO #1<br/>dir: LOS OLIVOS<br/>dir_fabricante: LOS OLIVOS #2<br/>equipo_id: 1<br/>fabricante: FABRICANTE 1<br/>fono: 222222<br/>id: 1<br/>marca: MARCA 1<br/>modelo: MODELO 1<br/>nombre: REPUESTO #1<br/>nombre_contacto: JUAN PERES<br/>num_fono: 7777777<br/>num_identificacion: 433434<br/>precio: 560.00<br/>proveedor: PROVEEDOR 1<br/>serie: SERIE 1<br/>stock_max: 200<br/>stock_min: 10<br/>terciarios: TERCIARIO 1<br/>unidad_medida: UNIDADES<br/>updated_at: 2023-06-07 13:01:13<br/>', 'almacen: ALMACEN 1<br/>codigo: R001<br/>correo: PROVEEDOR@GMAIL.COM<br/>correo_fabricante: FABRICANTE@GMAIL.COM<br/>created_at: 2023-06-07 13:01:13<br/>descripcion: DESC. REPUESTO #1<br/>dir: LOS OLIVOS<br/>dir_fabricante: LOS OLIVOS #2<br/>equipo_id: 1<br/>fabricante: FABRICANTE 1<br/>fono: 222222<br/>id: 1<br/>marca: MARCA 1<br/>modelo: MODELO 1<br/>nombre: REPUESTO #1<br/>nombre_contacto: JUAN PERES<br/>num_fono: 7777777<br/>num_identificacion: 433434<br/>precio: 560.00<br/>proveedor: PROVEEDOR 1<br/>serie: SERIE 1<br/>stock_max: 200<br/>stock_min: 10<br/>terciarios: TERCIARIO 1<br/>unidad_medida: UNIDADES<br/>updated_at: 2023-06-07 13:01:13<br/>', 'REPUESTOS/INSUMOS', '2023-06-07', '13:03:41', '2023-06-07 17:03:41', '2023-06-07 17:03:41'),
(69, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN REPUESTOS/INSUMO', 'almacen: ALMACEN 1<br/>codigo: R001<br/>correo: PROVEEDOR@GMAIL.COM<br/>correo_fabricante: FABRICANTE@GMAIL.COM<br/>created_at: 2023-06-07 13:01:13<br/>descripcion: DESC. REPUESTO #1<br/>dir: LOS OLIVOS<br/>dir_fabricante: LOS OLIVOS #2<br/>equipo_id: 1<br/>fabricante: FABRICANTE 1<br/>fono: 222222<br/>id: 1<br/>marca: MARCA 1<br/>modelo: MODELO 1<br/>nombre: REPUESTO #1<br/>nombre_contacto: JUAN PERES<br/>num_fono: 7777777<br/>num_identificacion: 433434<br/>precio: 560.00<br/>proveedor: PROVEEDOR 1<br/>serie: SERIE 1<br/>stock_max: 200<br/>stock_min: 10<br/>terciarios: TERCIARIO 1<br/>unidad_medida: UNIDADES<br/>updated_at: 2023-06-07 13:01:13<br/>', 'almacen: ALMACEN 1<br/>codigo: R001<br/>correo: PROVEEDOR@GMAIL.COM<br/>correo_fabricante: FABRICANTE@GMAIL.COM<br/>created_at: 2023-06-07 13:01:13<br/>descripcion: DESC. REPUESTO #1 MODIFICADO<br/>dir: LOS OLIVOS<br/>dir_fabricante: LOS OLIVOS #2<br/>equipo_id: 1<br/>fabricante: FABRICANTE 1<br/>fono: 222222<br/>id: 1<br/>marca: MARCA 1<br/>modelo: MODELO 1<br/>nombre: REPUESTO #1<br/>nombre_contacto: JUAN PERES<br/>num_fono: 7777777<br/>num_identificacion: 433434<br/>precio: 560.00<br/>proveedor: PROVEEDOR 1<br/>serie: SERIE 1<br/>stock_max: 200<br/>stock_min: 10<br/>terciarios: TERCIARIO 1<br/>unidad_medida: UNIDADES<br/>updated_at: 2023-06-07 13:03:49<br/>', 'REPUESTOS/INSUMOS', '2023-06-07', '13:03:49', '2023-06-07 17:03:49', '2023-06-07 17:03:49'),
(70, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN REPUESTOS/INSUMO', 'almacen: ALMACEN 1<br/>codigo: I001<br/>correo: <br/>correo_fabricante: <br/>created_at: 2023-06-07 13:05:13<br/>descripcion: DESC. INSUMO #1<br/>dir: <br/>dir_fabricante: <br/>equipo_id: 2<br/>fabricante: <br/>fono: <br/>id: 2<br/>marca: <br/>modelo: <br/>nombre: INSUMO #1<br/>nombre_contacto: <br/>num_fono: <br/>num_identificacion: <br/>precio: 300<br/>proveedor: <br/>serie: <br/>stock_max: 100<br/>stock_min: 5<br/>terciarios: <br/>unidad_medida: <br/>updated_at: 2023-06-07 13:05:13<br/>', NULL, 'REPUESTOS/INSUMOS', '2023-06-07', '13:05:13', '2023-06-07 17:05:13', '2023-06-07 17:05:13'),
(71, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA ENTRADA DE HERRAMIENTA/EQUIPO DE PROTECCIÓN', 'cantidad: 100<br/>created_at: 2023-06-07 13:15:13<br/>factura: 4343<br/>fecha: 2023-06-07<br/>herramienta_id: 3<br/>id: 3<br/>precio: 50<br/>total: 5000.00<br/>unidad_medida: UNIDADES<br/>updated_at: 2023-06-07 13:15:13<br/>', NULL, 'ENTRADA DE HERRAMIENTAS/EQUIPOS DE PROTECCIÓN', '2023-06-07', '13:15:13', '2023-06-07 17:15:13', '2023-06-07 17:15:13'),
(72, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA ENTRADA DE REPUESTOS/INSUMOS', 'cantidad: 100<br/>created_at: 2023-06-07 13:46:01<br/>factura: 1000001<br/>fecha: 2023-06-07<br/>id: 3<br/>precio: 50<br/>repuesto_id: 1<br/>total: 5000.00<br/>updated_at: 2023-06-07 13:46:01<br/>', NULL, 'ENTRADA DE REPUESTOS/INSUMOS', '2023-06-07', '13:46:01', '2023-06-07 17:46:01', '2023-06-07 17:46:01'),
(73, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA ENTRADA DE REPUESTOS/INSUMOS', 'cantidad: 100<br/>created_at: 2023-06-07 13:46:01<br/>factura: 1000001<br/>fecha: 2023-06-07<br/>id: 3<br/>precio: 50.00<br/>repuesto_id: 1<br/>total: 5000.00<br/>updated_at: 2023-06-07 13:46:01<br/>', NULL, 'ENTRADA DE REPUESTOS/INSUMOS', '2023-06-07', '13:47:00', '2023-06-07 17:47:00', '2023-06-07 17:47:00'),
(74, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UNA ENTRADA DE REPUESTOS/INSUMOS', 'cantidad: 50<br/>created_at: 2023-06-07 13:46:01<br/>factura: 1000001<br/>fecha: 2023-06-07<br/>id: 3<br/>precio: 50.00<br/>repuesto_id: 1<br/>total: 2500.00<br/>updated_at: 2023-06-07 13:47:00<br/>', NULL, 'ENTRADA DE REPUESTOS/INSUMOS', '2023-06-07', '13:48:57', '2023-06-07 17:48:57', '2023-06-07 17:48:57');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `kardex_repuestos`
--

CREATE TABLE `kardex_repuestos` (
  `id` bigint UNSIGNED NOT NULL,
  `tipo_registro` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `registro_id` bigint UNSIGNED NOT NULL,
  `repuesto_id` bigint UNSIGNED NOT NULL,
  `detalle` text COLLATE utf8mb4_unicode_ci,
  `precio` decimal(24,2) NOT NULL,
  `tipo_is` varchar(24) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cantidad_ingreso` double DEFAULT NULL,
  `cantidad_salida` double DEFAULT NULL,
  `cantidad_saldo` double NOT NULL,
  `cu` decimal(24,2) NOT NULL,
  `monto_ingreso` decimal(24,2) DEFAULT NULL,
  `monto_salida` decimal(24,2) DEFAULT NULL,
  `monto_saldo` decimal(24,2) NOT NULL,
  `fecha` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `maquinarias`
--

CREATE TABLE `maquinarias` (
  `id` bigint UNSIGNED NOT NULL,
  `equipo_id` bigint UNSIGNED NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `prioridad` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ubicacion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `marca` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modelo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `serie` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `costo` decimal(24,2) DEFAULT NULL,
  `fecha_compra` date DEFAULT NULL,
  `fecha_instalacion` date DEFAULT NULL,
  `garantia_meses` double DEFAULT NULL,
  `peso` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `altura` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ancho` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `largo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `voltios` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `capacidad` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `e_tecnicas` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_ultimo_mantenimiento` date DEFAULT NULL,
  `fecha_utlimo_termino` date DEFAULT NULL,
  `estado` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fabricantes` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `proveedor` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `terciarios` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nombre_contacto` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `num_fono` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `correo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dir` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `num_identificacion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `foto` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `archivo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `maquinarias`
--

INSERT INTO `maquinarias` (`id`, `equipo_id`, `descripcion`, `prioridad`, `ubicacion`, `tipo`, `marca`, `modelo`, `serie`, `costo`, `fecha_compra`, `fecha_instalacion`, `garantia_meses`, `peso`, `altura`, `ancho`, `largo`, `voltios`, `capacidad`, `e_tecnicas`, `fecha_ultimo_mantenimiento`, `fecha_utlimo_termino`, `estado`, `fabricantes`, `proveedor`, `terciarios`, `nombre_contacto`, `num_fono`, `correo`, `dir`, `num_identificacion`, `foto`, `archivo`, `created_at`, `updated_at`) VALUES
(1, 1, 'MAQUINARIA #1', 'P1-URGENTE', 'PRODUCCIÓN', 'REFRIGERACIÓN', 'MARCA 1', 'MODELO 1', 'SERIE 1', 1000.00, '2023-01-01', '2023-06-05', 24, '100 KG', '2M', '1M', '1M', '140 VOLTIOS', '300KG', 'ESPEC. TECNICAS', '0223-06-05', '2023-08-08', 'ACTIVA', 'FABRICANTE 1', 'PROVEEDOR 1', 'TERCIARIO 1', 'JUAN PERES', '7777', 'PROVEEDOR@GMAIL.COM', 'LOS OLIVOS', '232332', NULL, '', '2023-06-05 17:16:25', '2023-06-05 17:16:25'),
(2, 2, 'MAQUINARIA #2', 'P2-ALTA', 'PATIO', 'COMPRESIÓN', 'MARCA 2', 'MODELO 2', 'SERIE 2', 2500.00, '2023-01-03', '2023-06-04', 24, '200KG', '2M', '1M', '1M', '120VOLTIOS', '500KG', 'ESPEC. TECNICAS MAQUINA #2', '0223-06-04', '2023-06-06', 'INDISPUESTA', 'FABRICANTE 2', 'PROVEEDOR 2', 'TERCIARIO 2', 'ALBERTO GONZALES', '6666666', 'PROVEEDOR@GMAIL.COM', 'LOS OLIVOS', '232332', '21686003889.png', '21686004196.pdf', '2023-06-05 22:05:32', '2023-06-05 22:29:56');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000002_create_users_table', 1),
(2, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(3, '2022_10_13_132625_create_configuracions_table', 1),
(4, '2023_05_31_163841_create_areas_table', 1),
(5, '2023_05_31_163852_create_sistemas_table', 1),
(6, '2023_05_31_163902_create_equipos_table', 1),
(7, '2023_05_31_163940_create_subunidads_table', 1),
(8, '2023_05_31_164218_create_maquinarias_table', 1),
(9, '2023_05_31_164339_create_variable_controls_table', 1),
(10, '2023_05_31_164455_create_frecuencias_table', 1),
(11, '2023_05_31_164512_create_herramientas_table', 1),
(12, '2023_05_31_164537_create_entrada_herramientas_table', 1),
(13, '2023_05_31_164618_create_repuestos_table', 1),
(14, '2023_05_31_164627_create_entrada_repuestos_table', 1),
(15, '2023_05_31_164656_create_kardex_herramientas_table', 1),
(16, '2023_01_26_144253_create_historial_accions_table', 2),
(17, '2023_06_07_130719_create_kardex_repuestos_table', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `repuestos`
--

CREATE TABLE `repuestos` (
  `id` bigint UNSIGNED NOT NULL,
  `codigo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `marca` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modelo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `serie` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `equipo_id` bigint UNSIGNED NOT NULL,
  `precio` decimal(24,2) NOT NULL,
  `stock_min` double NOT NULL,
  `stock_max` double NOT NULL,
  `stock_actual` double NOT NULL,
  `unidad_medida` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dir` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fono` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `correo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `almacen` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fabricante` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `proveedor` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `terciarios` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nombre_contacto` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `num_fono` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `correo_fabricante` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dir_fabricante` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `num_identificacion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `repuestos`
--

INSERT INTO `repuestos` (`id`, `codigo`, `nombre`, `descripcion`, `marca`, `modelo`, `serie`, `equipo_id`, `precio`, `stock_min`, `stock_max`, `stock_actual`, `unidad_medida`, `dir`, `fono`, `correo`, `almacen`, `fabricante`, `proveedor`, `terciarios`, `nombre_contacto`, `num_fono`, `correo_fabricante`, `dir_fabricante`, `num_identificacion`, `created_at`, `updated_at`) VALUES
(1, 'R001', 'REPUESTO #1', 'DESC. REPUESTO #1 MODIFICADO', 'MARCA 1', 'MODELO 1', 'SERIE 1', 1, 560.00, 10, 200, 0, 'UNIDADES', 'LOS OLIVOS', '222222', 'PROVEEDOR@GMAIL.COM', 'ALMACEN 1', 'FABRICANTE 1', 'PROVEEDOR 1', 'TERCIARIO 1', 'JUAN PERES', '7777777', 'FABRICANTE@GMAIL.COM', 'LOS OLIVOS #2', '433434', '2023-06-07 17:01:13', '2023-06-07 17:48:57'),
(2, 'I001', 'INSUMO #1', 'DESC. INSUMO #1', NULL, NULL, NULL, 2, 300.00, 5, 100, 0, NULL, NULL, NULL, NULL, 'ALMACEN 1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-06-07 17:05:13', '2023-06-07 17:05:13');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sistemas`
--

CREATE TABLE `sistemas` (
  `id` bigint UNSIGNED NOT NULL,
  `area_id` bigint UNSIGNED NOT NULL,
  `codigo` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `sistemas`
--

INSERT INTO `sistemas` (`id`, `area_id`, `codigo`, `nombre`, `created_at`, `updated_at`) VALUES
(1, 1, 'S1', 'SISTEMA 1', '2023-06-01 17:16:26', '2023-06-01 17:16:26'),
(2, 2, 'S2', 'SISTEMA 2 MODIFICADO', '2023-06-01 17:16:37', '2023-06-01 17:16:45');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `subunidads`
--

CREATE TABLE `subunidads` (
  `id` bigint UNSIGNED NOT NULL,
  `area_id` bigint UNSIGNED NOT NULL,
  `sistema_id` bigint UNSIGNED NOT NULL,
  `equipo_id` bigint UNSIGNED NOT NULL,
  `codigo` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `numero` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `codigo2` varchar(155) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `subunidads`
--

INSERT INTO `subunidads` (`id`, `area_id`, `sistema_id`, `equipo_id`, `codigo`, `nombre`, `numero`, `codigo2`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 'SUB1', 'SUBUNIDAD 1', '12', 'SUB1-12', '2023-06-01 20:13:20', '2023-06-01 20:13:20'),
(2, 2, 2, 2, 'SUB2', 'SUBUNIDAD #2', '32', 'SUB2-32', '2023-06-01 20:13:37', '2023-06-01 20:13:46');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `usuario` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `paterno` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `materno` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ci` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ci_exp` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `especialidad` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dir` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `correo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fono` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tipo` enum('ADMINISTRADOR','GERENTE','GERENTE DE PRODUCCIÓN','JEFE DE MANTENIMIENTO','SUPERVISOR DE COMPRAS','AUXILIAR DE MANTENIMIENTO','AUXILIAR DE ALMACÉN') COLLATE utf8mb4_unicode_ci NOT NULL,
  `foto` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `acceso` int NOT NULL,
  `fecha_registro` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `usuario`, `nombre`, `paterno`, `materno`, `ci`, `ci_exp`, `especialidad`, `dir`, `correo`, `fono`, `tipo`, `foto`, `password`, `acceso`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'admin', 'admin', NULL, '', '', NULL, '', NULL, '', 'ADMINISTRADOR', NULL, '$2y$10$RrCZZySOwPej2gMFWsrjMe6dLzfaL5Q88h4J75I1FesEBRNPwq1x.', 1, '2023-01-11', NULL, NULL),
(2, 'JPERES', 'JUAN', 'PERES', 'MAMANI', '1111', 'LP', NULL, '', '', '', 'GERENTE', 'default.png', '$2y$10$t1vtRZ48507H2YKWgrU02Olg8W6bhN8yV8PduODfUJeMSIXEzqF/e', 1, '2023-06-01', '2023-06-01 15:39:49', '2023-06-01 15:39:49'),
(3, 'JGONZALES', 'JOSE ALBERTO', 'GONZALES', 'CONDORI', '2222', 'CB', 'ESPECIALIDAD', 'LOS OLIVOS', 'jose@gmail.com', '222222; 777777', 'GERENTE DE PRODUCCIÓN', '1685634062_JGONZALES.jpg', '$2y$10$KHi883Cz5Us3yixbNjs7cuxIWYst68Dkp6xZpJprokMjSYVvQpQUK', 1, '2023-06-01', '2023-06-01 15:41:02', '2023-06-01 15:42:49');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `variable_controls`
--

CREATE TABLE `variable_controls` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `unidad` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `variable_controls`
--

INSERT INTO `variable_controls` (`id`, `nombre`, `unidad`, `created_at`, `updated_at`) VALUES
(1, 'VARIABLE CONTROL #1', 'HORA', '2023-06-06 15:05:22', '2023-06-06 15:05:22'),
(2, 'VARIABLE #2', 'KILÓMETROS', '2023-06-06 15:05:33', '2023-06-06 15:05:33');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `areas`
--
ALTER TABLE `areas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `areas_codigo_unique` (`codigo`);

--
-- Indices de la tabla `configuracions`
--
ALTER TABLE `configuracions`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `entrada_herramientas`
--
ALTER TABLE `entrada_herramientas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `entrada_repuestos`
--
ALTER TABLE `entrada_repuestos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `equipos`
--
ALTER TABLE `equipos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `equipos_codigo_unique` (`codigo`),
  ADD UNIQUE KEY `equipos_codigo2_unique` (`codigo2`),
  ADD KEY `equipos_area_id_foreign` (`area_id`),
  ADD KEY `equipos_sistema_id_foreign` (`sistema_id`);

--
-- Indices de la tabla `frecuencias`
--
ALTER TABLE `frecuencias`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `herramientas`
--
ALTER TABLE `herramientas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `herramientas_codigo_unique` (`codigo`);

--
-- Indices de la tabla `historial_accions`
--
ALTER TABLE `historial_accions`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `kardex_repuestos`
--
ALTER TABLE `kardex_repuestos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `maquinarias`
--
ALTER TABLE `maquinarias`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indices de la tabla `repuestos`
--
ALTER TABLE `repuestos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `repuestos_codigo_unique` (`codigo`);

--
-- Indices de la tabla `sistemas`
--
ALTER TABLE `sistemas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sistemas_codigo_unique` (`codigo`),
  ADD KEY `sistemas_area_id_foreign` (`area_id`);

--
-- Indices de la tabla `subunidads`
--
ALTER TABLE `subunidads`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `subunidads_codigo_unique` (`codigo`),
  ADD UNIQUE KEY `subunidads_codigo2_unique` (`codigo2`),
  ADD KEY `subunidads_area_id_foreign` (`area_id`),
  ADD KEY `subunidads_sistema_id_foreign` (`sistema_id`),
  ADD KEY `subunidads_equipo_id_foreign` (`equipo_id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_usuario_unique` (`usuario`);

--
-- Indices de la tabla `variable_controls`
--
ALTER TABLE `variable_controls`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `areas`
--
ALTER TABLE `areas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `configuracions`
--
ALTER TABLE `configuracions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `entrada_herramientas`
--
ALTER TABLE `entrada_herramientas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `entrada_repuestos`
--
ALTER TABLE `entrada_repuestos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `equipos`
--
ALTER TABLE `equipos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `frecuencias`
--
ALTER TABLE `frecuencias`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `herramientas`
--
ALTER TABLE `herramientas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `historial_accions`
--
ALTER TABLE `historial_accions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;

--
-- AUTO_INCREMENT de la tabla `kardex_repuestos`
--
ALTER TABLE `kardex_repuestos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `maquinarias`
--
ALTER TABLE `maquinarias`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `repuestos`
--
ALTER TABLE `repuestos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `sistemas`
--
ALTER TABLE `sistemas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `subunidads`
--
ALTER TABLE `subunidads`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `variable_controls`
--
ALTER TABLE `variable_controls`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `equipos`
--
ALTER TABLE `equipos`
  ADD CONSTRAINT `equipos_area_id_foreign` FOREIGN KEY (`area_id`) REFERENCES `areas` (`id`),
  ADD CONSTRAINT `equipos_sistema_id_foreign` FOREIGN KEY (`sistema_id`) REFERENCES `sistemas` (`id`);

--
-- Filtros para la tabla `sistemas`
--
ALTER TABLE `sistemas`
  ADD CONSTRAINT `sistemas_area_id_foreign` FOREIGN KEY (`area_id`) REFERENCES `areas` (`id`);

--
-- Filtros para la tabla `subunidads`
--
ALTER TABLE `subunidads`
  ADD CONSTRAINT `subunidads_area_id_foreign` FOREIGN KEY (`area_id`) REFERENCES `areas` (`id`),
  ADD CONSTRAINT `subunidads_equipo_id_foreign` FOREIGN KEY (`equipo_id`) REFERENCES `equipos` (`id`),
  ADD CONSTRAINT `subunidads_sistema_id_foreign` FOREIGN KEY (`sistema_id`) REFERENCES `sistemas` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
