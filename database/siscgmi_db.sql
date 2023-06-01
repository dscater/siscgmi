-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 01-06-2023 a las 21:16:07
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
(31, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UN SISTEMA', 'id: 3<br/>area_id: 1<br/>sistema_id: 1<br/>equipo_id: 1<br/>codigo: ASD3<br/>nombre: ASDAD<br/>numero: 12<br/>codigo2: ASD3-12<br/>created_at: 2023-06-01 16:14:21<br/>updated_at: 2023-06-01 16:14:49<br/>', NULL, 'SISTEMAS', '2023-06-01', '16:14:53', '2023-06-01 20:14:53', '2023-06-01 20:14:53');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `kardex_herramientas`
--

CREATE TABLE `kardex_herramientas` (
  `id` bigint UNSIGNED NOT NULL,
  `tipo_registro` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `registro_id` bigint UNSIGNED NOT NULL,
  `herramienta_id` bigint UNSIGNED NOT NULL,
  `detalle` text COLLATE utf8mb4_unicode_ci,
  `precio` decimal(24,2) NOT NULL,
  `tipo_is` varchar(24) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cantidad_ingreso` double NOT NULL,
  `cantidad_salida` double NOT NULL,
  `cantidad_saldo` double NOT NULL,
  `cu` decimal(24,2) NOT NULL,
  `monto_ingreso` decimal(24,2) NOT NULL,
  `monto_salida` decimal(24,2) NOT NULL,
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
(16, '2023_01_26_144253_create_historial_accions_table', 2);

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
  `unidad_medida` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dir` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fono` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `correo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `almacen` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fabricante` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `proveedor` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `terciarios` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nombre_contacto` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `num_fono` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `correo_fabricante` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dir_fabricante` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `num_identificacion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
-- Indices de la tabla `kardex_herramientas`
--
ALTER TABLE `kardex_herramientas`
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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `entrada_repuestos`
--
ALTER TABLE `entrada_repuestos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `equipos`
--
ALTER TABLE `equipos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `frecuencias`
--
ALTER TABLE `frecuencias`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `herramientas`
--
ALTER TABLE `herramientas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `historial_accions`
--
ALTER TABLE `historial_accions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT de la tabla `kardex_herramientas`
--
ALTER TABLE `kardex_herramientas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `maquinarias`
--
ALTER TABLE `maquinarias`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `repuestos`
--
ALTER TABLE `repuestos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

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
