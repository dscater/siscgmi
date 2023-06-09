-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 07-07-2023 a las 21:54:42
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
-- Estructura de tabla para la tabla `detalle_herramientas`
--

CREATE TABLE `detalle_herramientas` (
  `id` bigint UNSIGNED NOT NULL,
  `orden_generada_id` bigint UNSIGNED NOT NULL,
  `herramienta_id` bigint UNSIGNED NOT NULL,
  `cantidad_solicitada` double NOT NULL,
  `costo` decimal(24,2) NOT NULL,
  `total` decimal(24,2) NOT NULL,
  `chekado` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `detalle_herramientas`
--

INSERT INTO `detalle_herramientas` (`id`, `orden_generada_id`, `herramienta_id`, `cantidad_solicitada`, `costo`, `total`, `chekado`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 20, 1000.00, 20000.00, 1, '2023-06-19 21:16:26', '2023-06-22 16:52:01'),
(2, 2, 3, 10, 3000.00, 30000.00, 0, '2023-06-19 23:16:03', '2023-06-19 23:16:03'),
(3, 2, 1, 3, 1000.00, 3000.00, 0, '2023-07-05 14:47:56', '2023-07-05 14:47:56');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_pedidos`
--

CREATE TABLE `detalle_pedidos` (
  `id` bigint UNSIGNED NOT NULL,
  `pedido_repuesto_id` bigint UNSIGNED NOT NULL,
  `repuesto_id` bigint UNSIGNED NOT NULL,
  `cantidad_requerida` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `detalle_pedidos`
--

INSERT INTO `detalle_pedidos` (`id`, `pedido_repuesto_id`, `repuesto_id`, `cantidad_requerida`, `created_at`, `updated_at`) VALUES
(9, 3, 1, 5, '2023-06-20 17:43:48', '2023-06-20 17:43:48'),
(10, 3, 3, 3, '2023-06-20 17:43:48', '2023-06-20 17:50:05');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_personals`
--

CREATE TABLE `detalle_personals` (
  `id` bigint UNSIGNED NOT NULL,
  `orden_generada_id` bigint UNSIGNED NOT NULL,
  `personal_id` bigint UNSIGNED NOT NULL,
  `costo` decimal(24,2) NOT NULL,
  `chekado` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `detalle_personals`
--

INSERT INTO `detalle_personals` (`id`, `orden_generada_id`, `personal_id`, `costo`, `chekado`, `created_at`, `updated_at`) VALUES
(3, 1, 1, 50.00, 1, '2023-06-19 21:55:15', '2023-06-22 16:54:03'),
(4, 1, 3, 40.00, 1, '2023-06-19 21:55:15', '2023-06-22 16:54:04'),
(5, 2, 4, 60.00, 0, '2023-06-19 22:06:45', '2023-06-19 22:06:45');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_repuestos`
--

CREATE TABLE `detalle_repuestos` (
  `id` bigint UNSIGNED NOT NULL,
  `orden_generada_id` bigint UNSIGNED NOT NULL,
  `repuesto_id` bigint UNSIGNED NOT NULL,
  `cantidad_requerida` double NOT NULL,
  `costo` decimal(24,2) NOT NULL,
  `total` decimal(24,2) NOT NULL,
  `chekado` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `detalle_repuestos`
--

INSERT INTO `detalle_repuestos` (`id`, `orden_generada_id`, `repuesto_id`, `cantidad_requerida`, `costo`, `total`, `chekado`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 5, 560.00, 2800.00, 1, '2023-06-19 21:14:52', '2023-06-22 16:24:59'),
(2, 1, 3, 3, 900.00, 2700.00, 1, '2023-06-19 21:14:52', '2023-06-22 16:25:45'),
(3, 2, 1, 5, 560.00, 2800.00, 1, '2023-06-19 23:16:15', '2023-06-22 19:43:02');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_tiempos`
--

CREATE TABLE `detalle_tiempos` (
  `id` bigint UNSIGNED NOT NULL,
  `historial_tiempo_id` bigint UNSIGNED NOT NULL,
  `fecha` date NOT NULL,
  `tiempo` int NOT NULL,
  `comentario` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `detalle_tiempos`
--

INSERT INTO `detalle_tiempos` (`id`, `historial_tiempo_id`, `fecha`, `tiempo`, `comentario`, `created_at`, `updated_at`) VALUES
(1, 1, '2023-01-01', 390, '', '2023-06-28 15:38:08', '2023-06-28 15:38:08'),
(2, 1, '2023-01-02', 390, '', '2023-06-28 15:38:08', '2023-06-28 15:38:08'),
(3, 1, '2023-01-03', 390, '', '2023-06-28 15:38:08', '2023-06-28 15:38:08'),
(4, 1, '2023-01-04', 390, '', '2023-06-28 15:38:08', '2023-06-28 15:38:08'),
(5, 1, '2023-01-05', 390, '', '2023-06-28 15:38:08', '2023-06-28 15:38:08'),
(6, 1, '2023-01-06', 390, '', '2023-06-28 15:38:08', '2023-06-28 15:38:08'),
(7, 1, '2023-01-07', 390, '', '2023-06-28 15:38:08', '2023-06-28 15:38:08'),
(8, 1, '2023-01-08', 390, '', '2023-06-28 15:38:08', '2023-06-28 15:38:08'),
(9, 1, '2023-01-09', 390, '', '2023-06-28 15:38:08', '2023-06-28 15:38:08'),
(10, 1, '2023-01-10', 390, '', '2023-06-28 15:38:08', '2023-06-28 15:38:08'),
(11, 1, '2023-01-11', 390, '', '2023-06-28 15:38:08', '2023-06-28 15:38:08'),
(12, 1, '2023-01-12', 390, '', '2023-06-28 15:38:08', '2023-06-28 15:38:08'),
(13, 1, '2023-01-13', 390, '', '2023-06-28 15:38:08', '2023-06-28 15:38:08'),
(14, 1, '2023-01-14', 390, '', '2023-06-28 15:38:08', '2023-06-28 15:38:08'),
(15, 1, '2023-01-15', 390, '', '2023-06-28 15:38:08', '2023-06-28 15:38:08'),
(16, 1, '2023-01-16', 390, '', '2023-06-28 15:38:08', '2023-06-28 15:38:08'),
(17, 1, '2023-01-17', 390, '', '2023-06-28 15:38:08', '2023-06-28 15:38:08'),
(18, 1, '2023-01-18', 390, '', '2023-06-28 15:38:08', '2023-06-28 15:38:08'),
(19, 1, '2023-01-19', 390, '', '2023-06-28 15:38:08', '2023-06-28 15:38:08'),
(20, 1, '2023-01-20', 390, '', '2023-06-28 15:38:08', '2023-06-28 15:38:08'),
(21, 1, '2023-01-21', 390, '', '2023-06-28 15:38:08', '2023-06-28 15:38:08'),
(22, 1, '2023-01-22', 390, '', '2023-06-28 15:38:08', '2023-06-28 15:38:08'),
(23, 1, '2023-01-23', 390, '', '2023-06-28 15:38:08', '2023-06-28 15:38:08'),
(24, 1, '2023-01-24', 390, '', '2023-06-28 15:38:08', '2023-06-28 15:38:08'),
(25, 1, '2023-01-25', 390, '', '2023-06-28 15:38:08', '2023-06-28 15:38:08'),
(26, 1, '2023-01-26', 390, '', '2023-06-28 15:38:08', '2023-06-28 15:38:08'),
(27, 1, '2023-01-27', 390, '', '2023-06-28 15:38:08', '2023-06-28 15:38:08'),
(28, 1, '2023-01-28', 390, '', '2023-06-28 15:38:08', '2023-06-28 15:38:08'),
(29, 1, '2023-01-29', 390, '', '2023-06-28 15:38:08', '2023-06-28 15:38:08'),
(30, 1, '2023-01-30', 390, '', '2023-06-28 15:38:08', '2023-06-28 15:38:08'),
(31, 1, '2023-01-31', 390, '', '2023-06-28 15:38:08', '2023-06-28 15:38:08'),
(32, 2, '2023-04-01', 390, '', '2023-06-28 15:39:12', '2023-06-28 15:39:12'),
(33, 2, '2023-04-02', 390, '', '2023-06-28 15:39:12', '2023-06-28 15:39:12'),
(34, 2, '2023-04-03', 390, '', '2023-06-28 15:39:12', '2023-06-28 15:39:12'),
(35, 2, '2023-04-04', 390, '', '2023-06-28 15:39:12', '2023-06-28 15:39:12'),
(36, 2, '2023-04-05', 390, '', '2023-06-28 15:39:12', '2023-06-28 15:39:12'),
(37, 2, '2023-04-06', 390, '', '2023-06-28 15:39:12', '2023-06-28 15:39:12'),
(38, 2, '2023-04-07', 390, '', '2023-06-28 15:39:12', '2023-06-28 15:39:12'),
(39, 2, '2023-04-08', 390, '', '2023-06-28 15:39:12', '2023-06-28 15:39:12'),
(40, 2, '2023-04-09', 390, '', '2023-06-28 15:39:12', '2023-06-28 15:39:12'),
(41, 2, '2023-04-10', 390, '', '2023-06-28 15:39:12', '2023-06-28 15:39:12'),
(42, 2, '2023-04-11', 390, '', '2023-06-28 15:39:12', '2023-06-28 15:39:12'),
(43, 2, '2023-04-12', 390, '', '2023-06-28 15:39:12', '2023-06-28 15:39:12'),
(44, 2, '2023-04-13', 390, '', '2023-06-28 15:39:12', '2023-06-28 15:39:12'),
(45, 2, '2023-04-14', 390, '', '2023-06-28 15:39:12', '2023-06-28 15:39:12'),
(46, 2, '2023-04-15', 390, '', '2023-06-28 15:39:12', '2023-06-28 15:39:12'),
(47, 2, '2023-04-16', 390, '', '2023-06-28 15:39:12', '2023-06-28 15:39:12'),
(48, 2, '2023-04-17', 390, '', '2023-06-28 15:39:12', '2023-06-28 15:39:12'),
(49, 2, '2023-04-18', 390, '', '2023-06-28 15:39:12', '2023-06-28 15:39:12'),
(50, 2, '2023-04-19', 390, '', '2023-06-28 15:39:13', '2023-06-28 15:39:13'),
(51, 2, '2023-04-20', 390, '', '2023-06-28 15:39:13', '2023-06-28 15:39:13'),
(52, 2, '2023-04-21', 390, '', '2023-06-28 15:39:13', '2023-06-28 15:39:13'),
(53, 2, '2023-04-22', 390, '', '2023-06-28 15:39:13', '2023-06-28 15:39:13'),
(54, 2, '2023-04-23', 390, '', '2023-06-28 15:39:13', '2023-06-28 15:39:13'),
(55, 2, '2023-04-24', 390, '', '2023-06-28 15:39:13', '2023-06-28 15:39:13'),
(56, 2, '2023-04-25', 390, '', '2023-06-28 15:39:13', '2023-06-28 15:39:13'),
(57, 2, '2023-04-26', 390, '', '2023-06-28 15:39:13', '2023-06-28 15:39:13'),
(58, 2, '2023-04-27', 0, '', '2023-06-28 15:39:13', '2023-06-28 15:39:13'),
(59, 2, '2023-04-28', 390, '', '2023-06-28 15:39:13', '2023-06-28 15:39:13'),
(60, 2, '2023-04-29', 390, '', '2023-06-28 15:39:13', '2023-06-28 15:39:13'),
(61, 2, '2023-04-30', 0, '', '2023-06-28 15:39:13', '2023-06-28 15:39:13'),
(62, 3, '2023-08-01', 390, '', '2023-07-07 21:10:58', '2023-07-07 21:10:58'),
(63, 3, '2023-08-02', 390, '', '2023-07-07 21:10:58', '2023-07-07 21:10:58'),
(64, 3, '2023-08-03', 390, '', '2023-07-07 21:10:58', '2023-07-07 21:10:58'),
(65, 3, '2023-08-04', 390, '', '2023-07-07 21:10:58', '2023-07-07 21:10:58'),
(66, 3, '2023-08-05', 390, '', '2023-07-07 21:10:58', '2023-07-07 21:10:58'),
(67, 3, '2023-08-06', 390, '', '2023-07-07 21:10:58', '2023-07-07 21:10:58'),
(68, 3, '2023-08-07', 390, '', '2023-07-07 21:10:58', '2023-07-07 21:10:58'),
(69, 3, '2023-08-08', 390, '', '2023-07-07 21:10:58', '2023-07-07 21:10:58'),
(70, 3, '2023-08-09', 390, '', '2023-07-07 21:10:58', '2023-07-07 21:10:58'),
(71, 3, '2023-08-10', 390, '', '2023-07-07 21:10:58', '2023-07-07 21:10:58'),
(72, 3, '2023-08-11', 390, '', '2023-07-07 21:10:58', '2023-07-07 21:10:58'),
(73, 3, '2023-08-12', 390, '', '2023-07-07 21:10:58', '2023-07-07 21:10:58'),
(74, 3, '2023-08-13', 390, '', '2023-07-07 21:10:58', '2023-07-07 21:10:58'),
(75, 3, '2023-08-14', 390, '', '2023-07-07 21:10:58', '2023-07-07 21:10:58'),
(76, 3, '2023-08-15', 390, '', '2023-07-07 21:10:58', '2023-07-07 21:10:58'),
(77, 3, '2023-08-16', 390, '', '2023-07-07 21:10:58', '2023-07-07 21:10:58'),
(78, 3, '2023-08-17', 390, '', '2023-07-07 21:10:58', '2023-07-07 21:10:58'),
(79, 3, '2023-08-18', 390, '', '2023-07-07 21:10:58', '2023-07-07 21:10:58'),
(80, 3, '2023-08-19', 390, '', '2023-07-07 21:10:58', '2023-07-07 21:10:58'),
(81, 3, '2023-08-20', 390, '', '2023-07-07 21:10:58', '2023-07-07 21:10:58'),
(82, 3, '2023-08-21', 390, '', '2023-07-07 21:10:58', '2023-07-07 21:10:58'),
(83, 3, '2023-08-22', 390, '', '2023-07-07 21:10:58', '2023-07-07 21:10:58'),
(84, 3, '2023-08-23', 390, '', '2023-07-07 21:10:58', '2023-07-07 21:10:58'),
(85, 3, '2023-08-24', 390, '', '2023-07-07 21:10:58', '2023-07-07 21:10:58'),
(86, 3, '2023-08-25', 390, '', '2023-07-07 21:10:58', '2023-07-07 21:10:58'),
(87, 3, '2023-08-26', 390, '', '2023-07-07 21:10:58', '2023-07-07 21:10:58'),
(88, 3, '2023-08-27', 390, '', '2023-07-07 21:10:58', '2023-07-07 21:10:58'),
(89, 3, '2023-08-28', 390, '', '2023-07-07 21:10:58', '2023-07-07 21:10:58'),
(90, 3, '2023-08-29', 390, '', '2023-07-07 21:10:58', '2023-07-07 21:10:58'),
(91, 3, '2023-08-30', 390, '', '2023-07-07 21:10:58', '2023-07-07 21:10:58'),
(92, 3, '2023-08-31', 390, '', '2023-07-07 21:10:58', '2023-07-07 21:10:58');

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

--
-- Volcado de datos para la tabla `entrada_repuestos`
--

INSERT INTO `entrada_repuestos` (`id`, `factura`, `repuesto_id`, `cantidad`, `precio`, `total`, `fecha`, `created_at`, `updated_at`) VALUES
(4, '1000010', 1, 100, 560.00, 56000.00, '2023-06-19', '2023-06-19 18:08:05', '2023-07-05 15:38:42'),
(5, '20000022', 2, 100, 50.00, 5000.00, '2023-06-19', '2023-06-19 18:08:20', '2023-06-19 18:08:20'),
(6, '30003303', 3, 100, 50.00, 5000.00, '2023-06-19', '2023-06-19 18:08:36', '2023-06-19 18:08:36');

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
(2, 2, 2, 'E002', 'EQUIPO 2', '10', 'A2-S2-E002-10', '2023-06-01 19:57:48', '2023-06-01 19:58:06'),
(4, 1, 4, 'E003', 'EQUIPO #3', '33', 'A1-S3-E003-33', '2023-06-20 19:27:14', '2023-06-20 19:27:14'),
(5, 2, 5, 'E004', 'EQUIPO #4', '44', 'A2-S4-E004-44', '2023-06-20 19:27:28', '2023-06-20 19:27:28');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `familias`
--

CREATE TABLE `familias` (
  `id` bigint UNSIGNED NOT NULL,
  `codigo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `familias`
--

INSERT INTO `familias` (`id`, `codigo`, `nombre`, `created_at`, `updated_at`) VALUES
(1, 'F001', 'FAMILIA #1 MODIFICADO', '2023-06-13 15:14:35', '2023-06-13 15:15:06');

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
(1, 1, '7', '2023-06-06 15:15:51', '2023-06-14 20:51:45');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `gama_detalles`
--

CREATE TABLE `gama_detalles` (
  `id` bigint UNSIGNED NOT NULL,
  `gama_id` bigint UNSIGNED NOT NULL,
  `tarea` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tiempo` double NOT NULL,
  `chekado` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `gama_detalles`
--

INSERT INTO `gama_detalles` (`id`, `gama_id`, `tarea`, `tiempo`, `chekado`, `created_at`, `updated_at`) VALUES
(1, 2, 'TAREA 1', 7, 1, '2023-06-13 16:37:24', '2023-06-22 16:53:52'),
(3, 2, 'NUEVA TAREA 2', 10, 1, '2023-06-13 16:43:34', '2023-06-22 16:53:54'),
(4, 3, 'TAREA 1', 120, 0, '2023-06-23 16:49:17', '2023-06-23 16:49:17'),
(5, 3, 'TAREA 2', 120, 0, '2023-06-23 16:49:17', '2023-06-23 16:49:17'),
(6, 3, 'TAREA 3', 120, 0, '2023-06-23 16:49:17', '2023-06-23 16:49:17');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `gama_mantenimientos`
--

CREATE TABLE `gama_mantenimientos` (
  `id` bigint UNSIGNED NOT NULL,
  `codigo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `codificacion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subfamilia_id` bigint UNSIGNED NOT NULL,
  `equipo_id` bigint UNSIGNED NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `gama_mantenimientos`
--

INSERT INTO `gama_mantenimientos` (`id`, `codigo`, `codificacion`, `subfamilia_id`, `equipo_id`, `descripcion`, `created_at`, `updated_at`) VALUES
(2, 'GM001', 'GM001HH8', 1, 1, '', '2023-06-13 16:37:24', '2023-06-14 16:05:09'),
(3, 'GM002', 'MNH002JJ', 1, 4, 'GAMA #2', '2023-06-23 16:49:17', '2023-06-23 16:49:17');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `herramientas`
--

CREATE TABLE `herramientas` (
  `id` bigint UNSIGNED NOT NULL,
  `codigo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `codificacion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
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

INSERT INTO `herramientas` (`id`, `codigo`, `codificacion`, `nombre`, `descripcion`, `clasificacion`, `cod_clasificacion`, `marca`, `modelo`, `serie`, `costo`, `unidad_medida`, `proveedor`, `dir`, `fono`, `correo`, `almacen`, `fabricante`, `terciarios`, `nombre_contacto`, `num_fono`, `correo_fabricante`, `dir_fabricante`, `num_identificacion`, `e_tecnicas`, `foto`, `created_at`, `updated_at`) VALUES
(1, 'H001', 'CH001PPP', 'HERRAMIENTA #1', 'DESC, HERRAMIENTA #1', 'CLASIFICACION 1', 'CLASI1', 'MARCA 1', 'MODELO 1', 'SERIE 1', 1000.00, 'METROS', 'PERES S.A.', 'LOS OLIVOS', '222222', 'PERES@GMAIL.COM', 'ALMACEN 1', 'FABRICANTE 1', 'TERCIARIOS 1', 'JUAN PERES', '222222', 'FABRICANTE@GMAIL.COM', 'LOS PEDREGALES', '23323211111', 'ESPECIFICACIONES TECNIAS HERRAMIENTA #1', '11686068009.jpeg', '2023-06-06 16:05:22', '2023-06-14 15:29:08'),
(3, 'E001', 'CO002OOP', 'EQUIPO PROTECCIÓN #1', 'DESC EQUIPO # 1', 'CLASIFICACION EQUIPO', 'CODIGOCLAS', 'MARCA EQUIPOS', 'MODELO EQUIPO', 'SERIEEQUIPO', 3000.00, 'METROS', 'PROVEEDOR DEL EQUIPO', NULL, NULL, NULL, 'ALMACEN EQUIPOS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-06-06 21:08:23', '2023-07-05 14:47:13'),
(4, 'H002', 'CO003POO', 'HERRAMIENTA #2', 'DESC. HERRAMIENTA #2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PROVEEDOR #3', NULL, NULL, NULL, 'ALMACEN #1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-06-14 15:31:43', '2023-07-05 14:47:33');

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
(74, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UNA ENTRADA DE REPUESTOS/INSUMOS', 'cantidad: 50<br/>created_at: 2023-06-07 13:46:01<br/>factura: 1000001<br/>fecha: 2023-06-07<br/>id: 3<br/>precio: 50.00<br/>repuesto_id: 1<br/>total: 2500.00<br/>updated_at: 2023-06-07 13:47:00<br/>', NULL, 'ENTRADA DE REPUESTOS/INSUMOS', '2023-06-07', '13:48:57', '2023-06-07 17:48:57', '2023-06-07 17:48:57'),
(75, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN USUARIO', 'acceso: 1<br/>ci: 3333<br/>ci_exp: LP<br/>correo: <br/>created_at: 2023-06-12 16:31:19<br/>dir: LOS OLIVOS<br/>especialidad: ESPECIALIDAD<br/>fecha_registro: 2023-06-12<br/>fono: 77777<br/>foto: default.png<br/>id: 4<br/>materno: CONDORI<br/>nombre: AGUSTIN<br/>password: $2y$10$1597Bo.Ua1Erz4IpnwIwqOWr9okA.2QX9HAH8l6tHAwnjbanPmEu6<br/>paterno: CONDORI<br/>tipo: AUXILIAR DE MANTENIMIENTO<br/>updated_at: 2023-06-12 16:31:19<br/>usuario: ACONDORI<br/>', NULL, 'USUARIOS', '2023-06-12', '16:31:19', '2023-06-12 20:31:19', '2023-06-12 20:31:19'),
(76, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN USUARIO', 'acceso: 1<br/>ci: 3333<br/>ci_exp: LP<br/>correo: <br/>created_at: 2023-06-12 16:31:19<br/>dir: LOS OLIVOS<br/>especialidad: ESPECIALIDAD<br/>fecha_registro: 2023-06-12<br/>fono: 77777<br/>foto: default.png<br/>id: 4<br/>materno: CONDORI<br/>nombre: AGUSTIN<br/>password: $2y$10$1597Bo.Ua1Erz4IpnwIwqOWr9okA.2QX9HAH8l6tHAwnjbanPmEu6<br/>paterno: CONDORI<br/>tipo: AUXILIAR DE MANTENIMIENTO<br/>updated_at: 2023-06-12 16:31:19<br/>usuario: ACONDORI<br/>', 'acceso: 1<br/>ci: 3333<br/>ci_exp: LP<br/>correo: agustin@gmail.com<br/>created_at: 2023-06-12 16:31:19<br/>dir: LOS OLIVOS<br/>especialidad: ESPECIALIDAD<br/>fecha_registro: 2023-06-12<br/>fono: 77777<br/>foto: default.png<br/>id: 4<br/>materno: CONDORI<br/>nombre: AGUSTIN<br/>password: $2y$10$1597Bo.Ua1Erz4IpnwIwqOWr9okA.2QX9HAH8l6tHAwnjbanPmEu6<br/>paterno: CONDORI<br/>tipo: AUXILIAR DE MANTENIMIENTO<br/>updated_at: 2023-06-12 16:37:03<br/>usuario: ACONDORI<br/>', 'USUARIOS', '2023-06-12', '16:37:03', '2023-06-12 20:37:03', '2023-06-12 20:37:03'),
(77, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN USUARIO', 'acceso: 1<br/>ci: 3333<br/>ci_exp: LP<br/>correo: agustin@gmail.com<br/>created_at: 2023-06-12 16:31:19<br/>dir: LOS OLIVOS<br/>especialidad: ESPECIALIDAD<br/>fecha_registro: 2023-06-12<br/>fono: 77777<br/>foto: default.png<br/>id: 4<br/>materno: CONDORI<br/>nombre: AGUSTIN<br/>password: $2y$10$1597Bo.Ua1Erz4IpnwIwqOWr9okA.2QX9HAH8l6tHAwnjbanPmEu6<br/>paterno: CONDORI<br/>tipo: AUXILIAR DE MANTENIMIENTO<br/>updated_at: 2023-06-12 16:37:03<br/>usuario: ACONDORI<br/>', 'acceso: 1<br/>ci: 3333<br/>ci_exp: LP<br/>correo: agustin@gmail.com<br/>created_at: 2023-06-12 16:31:19<br/>dir: LOS OLIVOS<br/>especialidad: ESPECIALIDAD<br/>fecha_registro: 2023-06-12<br/>fono: 77777; 66666<br/>foto: default.png<br/>id: 4<br/>materno: CONDORI<br/>nombre: AGUSTIN<br/>password: $2y$10$1597Bo.Ua1Erz4IpnwIwqOWr9okA.2QX9HAH8l6tHAwnjbanPmEu6<br/>paterno: CONDORI<br/>tipo: AUXILIAR DE MANTENIMIENTO<br/>updated_at: 2023-06-12 16:37:16<br/>usuario: ACONDORI<br/>', 'USUARIOS', '2023-06-12', '16:37:16', '2023-06-12 20:37:16', '2023-06-12 20:37:16'),
(78, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PERSONAL', 'correo: AGUSTIN@GMAIL.COM<br/>created_at: 2023-06-12 16:38:44<br/>domicilio: LOS OLIVOS<br/>especialidad: ESPECIALIDAD<br/>id: 1<br/>nro_doc: 3333<br/>razon_social: RAZON S.A.<br/>telefono: 77777; 66666<br/>tipo_mo: USUARIOS<br/>updated_at: 2023-06-12 16:38:44<br/>user_id: 4<br/>', NULL, 'PERSONAL', '2023-06-12', '16:38:44', '2023-06-12 20:38:44', '2023-06-12 20:38:44'),
(79, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PERSONAL', 'correo: JDK@GMAIL.COM<br/>created_at: 2023-06-12 16:40:44<br/>domicilio: LOS OLIVOS<br/>especialidad: ESPECIALIDAD 2<br/>id: 2<br/>nro_doc: 4545<br/>razon_social: JDK S.A.<br/>telefono: 77777; 66666<br/>tipo_mo: SERVICIOS<br/>updated_at: 2023-06-12 16:40:44<br/>user_id: <br/>', NULL, 'PERSONAL', '2023-06-12', '16:40:44', '2023-06-12 20:40:44', '2023-06-12 20:40:44'),
(80, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN PERSONAL', 'correo: AGUSTIN@GMAIL.COM<br/>created_at: 2023-06-12 16:38:44<br/>domicilio: LOS OLIVOS<br/>especialidad: ESPECIALIDAD<br/>id: 1<br/>nro_doc: 3333<br/>razon_social: RAZON S.A.<br/>telefono: 77777; 66666<br/>tipo_mo: USUARIOS<br/>updated_at: 2023-06-12 16:38:44<br/>user_id: 4<br/>', 'correo: AGUSTIN@GMAIL.COM<br/>created_at: 2023-06-12 16:38:44<br/>domicilio: LOS OLIVOS<br/>especialidad: ESPECIALIDAD<br/>id: 1<br/>nro_doc: 3333<br/>razon_social: RAZON S.A. MODIFICADO<br/>telefono: 77777; 66666<br/>tipo_mo: USUARIOS<br/>updated_at: 2023-06-12 16:44:02<br/>user_id: 4<br/>', 'PERSONAL', '2023-06-12', '16:44:02', '2023-06-12 20:44:02', '2023-06-12 20:44:02'),
(81, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN PERSONAL', 'correo: AGUSTIN@GMAIL.COM<br/>created_at: 2023-06-12 16:38:44<br/>domicilio: LOS OLIVOS<br/>especialidad: ESPECIALIDAD<br/>id: 1<br/>nro_doc: 3333<br/>razon_social: RAZON S.A. MODIFICADO<br/>telefono: 77777; 66666<br/>tipo_mo: USUARIOS<br/>updated_at: 2023-06-12 16:44:02<br/>user_id: 4<br/>', 'correo: AGUSTIN@GMAIL.COM<br/>created_at: 2023-06-12 16:38:44<br/>domicilio: LOS OLIVOS<br/>especialidad: ESPECIALIDAD<br/>id: 1<br/>nro_doc: 3333<br/>razon_social: RAZON S.A. MODIFICADO<br/>telefono: 77777; 66666<br/>tipo_mo: USUARIOS<br/>updated_at: 2023-06-12 16:44:02<br/>user_id: 4<br/>', 'PERSONAL', '2023-06-12', '16:45:16', '2023-06-12 20:45:16', '2023-06-12 20:45:16'),
(82, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN PERSONAL', 'correo: JDK@GMAIL.COM<br/>created_at: 2023-06-12 16:40:44<br/>domicilio: LOS OLIVOS<br/>especialidad: ESPECIALIDAD 2<br/>id: 2<br/>nro_doc: 4545<br/>razon_social: JDK S.A.<br/>telefono: 77777; 66666<br/>tipo_mo: SERVICIOS<br/>updated_at: 2023-06-12 16:40:44<br/>user_id: <br/>', 'correo: JDK@GMAIL.COM<br/>created_at: 2023-06-12 16:40:44<br/>domicilio: LOS OLIVOS<br/>especialidad: ESPECIALIDAD 2<br/>id: 2<br/>nro_doc: 4545<br/>razon_social: JDK S.A.<br/>telefono: 656565<br/>tipo_mo: SERVICIOS<br/>updated_at: 2023-06-12 16:45:28<br/>user_id: <br/>', 'PERSONAL', '2023-06-12', '16:45:28', '2023-06-12 20:45:28', '2023-06-12 20:45:28'),
(83, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN PERSONAL', 'correo: JDK@GMAIL.COM<br/>created_at: 2023-06-12 16:40:44<br/>domicilio: LOS OLIVOS<br/>especialidad: ESPECIALIDAD 2<br/>id: 2<br/>nro_doc: 4545<br/>razon_social: JDK S.A.<br/>telefono: 656565<br/>tipo_mo: SERVICIOS<br/>updated_at: 2023-06-12 16:45:28<br/>user_id: <br/>', 'correo: JDK@GMAIL.COM<br/>created_at: 2023-06-12 16:40:44<br/>domicilio: LOS OLIVOS<br/>especialidad: ESPECIALIDAD 2<br/>id: 2<br/>nro_doc: 4545<br/>razon_social: JDK S.A.<br/>telefono: 656565<br/>tipo_mo: SERVICIOS<br/>updated_at: 2023-06-12 16:45:28<br/>user_id: <br/>', 'PERSONAL', '2023-06-12', '16:45:36', '2023-06-12 20:45:36', '2023-06-12 20:45:36'),
(84, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UN PERSONAL', 'correo: JDK@GMAIL.COM<br/>created_at: 2023-06-12 16:40:44<br/>domicilio: LOS OLIVOS<br/>especialidad: ESPECIALIDAD 2<br/>id: 2<br/>nro_doc: 4545<br/>razon_social: JDK S.A.<br/>telefono: 656565<br/>tipo_mo: SERVICIOS<br/>updated_at: 2023-06-12 16:45:28<br/>user_id: <br/>', NULL, 'PERSONAL', '2023-06-12', '16:45:40', '2023-06-12 20:45:40', '2023-06-12 20:45:40'),
(85, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA FAMILIA', 'id: 1<br/>codigo: F001<br/>nombre: FAMILIA #1<br/>created_at: 2023-06-13 11:14:35<br/>updated_at: 2023-06-13 11:14:35<br/>', NULL, 'FAMILIAS', '2023-06-13', '11:14:35', '2023-06-13 15:14:35', '2023-06-13 15:14:35'),
(86, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA FAMILIA', 'id: 1<br/>codigo: F001<br/>nombre: FAMILIA #1<br/>created_at: 2023-06-13 11:14:35<br/>updated_at: 2023-06-13 11:14:35<br/>', 'id: 1<br/>codigo: F001<br/>nombre: FAMILIA #1 MODIFICADO<br/>created_at: 2023-06-13 11:14:35<br/>updated_at: 2023-06-13 11:15:06<br/>', 'FAMILIAS', '2023-06-13', '11:15:06', '2023-06-13 15:15:06', '2023-06-13 15:15:06'),
(87, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA FAMILIA', 'id: 2<br/>codigo: F002<br/>nombre: FAMILIA #2<br/>created_at: 2023-06-13 11:15:15<br/>updated_at: 2023-06-13 11:15:15<br/>', NULL, 'FAMILIAS', '2023-06-13', '11:15:15', '2023-06-13 15:15:15', '2023-06-13 15:15:15'),
(88, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UNA FAMILIA', 'id: 2<br/>codigo: F002<br/>nombre: FAMILIA #2<br/>created_at: 2023-06-13 11:15:15<br/>updated_at: 2023-06-13 11:15:15<br/>', NULL, 'FAMILIAS', '2023-06-13', '11:15:38', '2023-06-13 15:15:38', '2023-06-13 15:15:38'),
(89, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA SUBFAMILIA', 'id: 1<br/>familia_id: 1<br/>nombre: SUBFAMILIA #1<br/>created_at: 2023-06-13 11:22:07<br/>updated_at: 2023-06-13 11:22:07<br/>', NULL, 'SISTEMAS', '2023-06-13', '11:22:07', '2023-06-13 15:22:07', '2023-06-13 15:22:07'),
(90, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA SUBFAMILIA', 'id: 1<br/>familia_id: 1<br/>nombre: SUBFAMILIA #1<br/>created_at: 2023-06-13 11:22:07<br/>updated_at: 2023-06-13 11:22:07<br/>', 'id: 1<br/>familia_id: 1<br/>nombre: SUBFAMILIA #1 MODIFICADO<br/>created_at: 2023-06-13 11:22:07<br/>updated_at: 2023-06-13 11:23:19<br/>', 'SUBFAMILIAS', '2023-06-13', '11:23:19', '2023-06-13 15:23:19', '2023-06-13 15:23:19'),
(91, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA SUBFAMILIA', 'id: 2<br/>familia_id: 1<br/>nombre: SUB #2<br/>created_at: 2023-06-13 11:23:29<br/>updated_at: 2023-06-13 11:23:29<br/>', NULL, 'SUBFAMILIAS', '2023-06-13', '11:23:29', '2023-06-13 15:23:29', '2023-06-13 15:23:29'),
(92, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UNA SUBFAMILIA', 'id: 2<br/>familia_id: 1<br/>nombre: SUB #2<br/>created_at: 2023-06-13 11:23:29<br/>updated_at: 2023-06-13 11:23:29<br/>', NULL, 'SUBFAMILIAS', '2023-06-13', '11:23:33', '2023-06-13 15:23:33', '2023-06-13 15:23:33'),
(93, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN REPUESTOS/INSUMO', 'id: 2<br/>codigo: GM001<br/>subfamilia_id: 1<br/>equipo_id: 1<br/>descripcion: <br/>created_at: 2023-06-13 12:37:24<br/>updated_at: 2023-06-13 12:37:24<br/>', NULL, 'REPUESTOS/INSUMOS', '2023-06-13', '12:37:24', '2023-06-13 16:37:24', '2023-06-13 16:37:24'),
(94, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN REPUESTOS/INSUMO', 'id: 2<br/>codigo: GM001<br/>subfamilia_id: 1<br/>equipo_id: 1<br/>descripcion: <br/>created_at: 2023-06-13 12:37:24<br/>updated_at: 2023-06-13 12:37:24<br/>', 'id: 2<br/>codigo: GM001<br/>subfamilia_id: 1<br/>equipo_id: 1<br/>descripcion: <br/>created_at: 2023-06-13 12:37:24<br/>updated_at: 2023-06-13 12:37:24<br/>', 'REPUESTOS/INSUMOS', '2023-06-13', '12:38:30', '2023-06-13 16:38:30', '2023-06-13 16:38:30'),
(95, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN REPUESTOS/INSUMO', 'id: 2<br/>codigo: GM001<br/>subfamilia_id: 1<br/>equipo_id: 1<br/>descripcion: <br/>created_at: 2023-06-13 12:37:24<br/>updated_at: 2023-06-13 12:37:24<br/>', 'id: 2<br/>codigo: GM001<br/>subfamilia_id: 1<br/>equipo_id: 1<br/>descripcion: <br/>created_at: 2023-06-13 12:37:24<br/>updated_at: 2023-06-13 12:37:24<br/>', 'REPUESTOS/INSUMOS', '2023-06-13', '12:42:43', '2023-06-13 16:42:43', '2023-06-13 16:42:43'),
(96, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN REPUESTOS/INSUMO', 'id: 2<br/>codigo: GM001<br/>subfamilia_id: 1<br/>equipo_id: 1<br/>descripcion: <br/>created_at: 2023-06-13 12:37:24<br/>updated_at: 2023-06-13 12:37:24<br/>', 'id: 2<br/>codigo: GM001<br/>subfamilia_id: 1<br/>equipo_id: 1<br/>descripcion: <br/>created_at: 2023-06-13 12:37:24<br/>updated_at: 2023-06-13 12:37:24<br/>', 'REPUESTOS/INSUMOS', '2023-06-13', '12:43:35', '2023-06-13 16:43:35', '2023-06-13 16:43:35'),
(97, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN REPUESTOS/INSUMO', 'id: 2<br/>codigo: GM001<br/>subfamilia_id: 1<br/>equipo_id: 1<br/>descripcion: <br/>created_at: 2023-06-13 12:37:24<br/>updated_at: 2023-06-13 12:37:24<br/>', 'id: 2<br/>codigo: GM001<br/>subfamilia_id: 1<br/>equipo_id: 1<br/>descripcion: <br/>created_at: 2023-06-13 12:37:24<br/>updated_at: 2023-06-13 12:37:24<br/>', 'REPUESTOS/INSUMOS', '2023-06-13', '12:44:39', '2023-06-13 16:44:39', '2023-06-13 16:44:39'),
(98, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN SISTEMA', 'altura: 2M<br/>ancho: 1M<br/>archivo: <br/>capacidad: 300KG<br/>codificacion: <br/>correo: PROVEEDOR@GMAIL.COM<br/>costo: 1000.00<br/>created_at: 2023-06-05 13:16:25<br/>descripcion: MAQUINARIA #1<br/>dir: LOS OLIVOS<br/>e_tecnicas: ESPEC. TECNICAS<br/>equipo_id: 1<br/>estado: ACTIVA<br/>fabricantes: FABRICANTE 1<br/>fecha_compra: 2023-01-01<br/>fecha_instalacion: 2023-06-05<br/>fecha_ultimo_mantenimiento: 0223-06-05<br/>fecha_utlimo_termino: 2023-08-08<br/>foto: <br/>garantia_meses: 24<br/>id: 1<br/>largo: 1M<br/>marca: MARCA 1<br/>modelo: MODELO 1<br/>nombre_contacto: JUAN PERES<br/>num_fono: 7777<br/>num_identificacion: 232332<br/>peso: 100 KG<br/>prioridad: P1-URGENTE<br/>proveedor: PROVEEDOR 1<br/>serie: SERIE 1<br/>terciarios: TERCIARIO 1<br/>tipo: REFRIGERACIÓN<br/>ubicacion: PRODUCCIÓN<br/>updated_at: 2023-06-05 13:16:25<br/>voltios: 140 VOLTIOS<br/>', 'altura: 2M<br/>ancho: 1M<br/>archivo: <br/>capacidad: 300KG<br/>codificacion: HVF001LP<br/>correo: PROVEEDOR@GMAIL.COM<br/>costo: 1000.00<br/>created_at: 2023-06-05 13:16:25<br/>descripcion: MAQUINARIA #1<br/>dir: LOS OLIVOS<br/>e_tecnicas: ESPEC. TECNICAS<br/>equipo_id: 1<br/>estado: ACTIVA<br/>fabricantes: FABRICANTE 1<br/>fecha_compra: 2023-01-01<br/>fecha_instalacion: 2023-06-05<br/>fecha_ultimo_mantenimiento: 0223-06-05<br/>fecha_utlimo_termino: 2023-08-08<br/>foto: <br/>garantia_meses: 24<br/>id: 1<br/>largo: 1M<br/>marca: MARCA 1<br/>modelo: MODELO 1<br/>nombre_contacto: JUAN PERES<br/>num_fono: 7777<br/>num_identificacion: 232332<br/>peso: 100 KG<br/>prioridad: P1-URGENTE<br/>proveedor: PROVEEDOR 1<br/>serie: SERIE 1<br/>terciarios: TERCIARIO 1<br/>tipo: REFRIGERACIÓN<br/>ubicacion: PRODUCCIÓN<br/>updated_at: 2023-06-14 11:23:19<br/>voltios: 140 VOLTIOS<br/>', 'SISTEMAS', '2023-06-14', '11:23:19', '2023-06-14 15:23:19', '2023-06-14 15:23:19'),
(99, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN SISTEMA', 'altura: 2M<br/>ancho: 1M<br/>archivo: 21686004196.pdf<br/>capacidad: 500KG<br/>codificacion: <br/>correo: PROVEEDOR@GMAIL.COM<br/>costo: 2500.00<br/>created_at: 2023-06-05 18:05:32<br/>descripcion: MAQUINARIA #2<br/>dir: LOS OLIVOS<br/>e_tecnicas: ESPEC. TECNICAS MAQUINA #2<br/>equipo_id: 2<br/>estado: INDISPUESTA<br/>fabricantes: FABRICANTE 2<br/>fecha_compra: 2023-01-03<br/>fecha_instalacion: 2023-06-04<br/>fecha_ultimo_mantenimiento: 0223-06-04<br/>fecha_utlimo_termino: 2023-06-06<br/>foto: 21686003889.png<br/>garantia_meses: 24<br/>id: 2<br/>largo: 1M<br/>marca: MARCA 2<br/>modelo: MODELO 2<br/>nombre_contacto: ALBERTO GONZALES<br/>num_fono: 6666666<br/>num_identificacion: 232332<br/>peso: 200KG<br/>prioridad: P2-ALTA<br/>proveedor: PROVEEDOR 2<br/>serie: SERIE 2<br/>terciarios: TERCIARIO 2<br/>tipo: COMPRESIÓN<br/>ubicacion: PATIO<br/>updated_at: 2023-06-05 18:29:56<br/>voltios: 120VOLTIOS<br/>', 'altura: 2M<br/>ancho: 1M<br/>archivo: 21686004196.pdf<br/>capacidad: 500KG<br/>codificacion: HP002LP<br/>correo: PROVEEDOR@GMAIL.COM<br/>costo: 2500.00<br/>created_at: 2023-06-05 18:05:32<br/>descripcion: MAQUINARIA #2<br/>dir: LOS OLIVOS<br/>e_tecnicas: ESPEC. TECNICAS MAQUINA #2<br/>equipo_id: 2<br/>estado: INDISPUESTA<br/>fabricantes: FABRICANTE 2<br/>fecha_compra: 2023-01-03<br/>fecha_instalacion: 2023-06-04<br/>fecha_ultimo_mantenimiento: 0223-06-04<br/>fecha_utlimo_termino: 2023-06-06<br/>foto: 21686003889.png<br/>garantia_meses: 24<br/>id: 2<br/>largo: 1M<br/>marca: MARCA 2<br/>modelo: MODELO 2<br/>nombre_contacto: ALBERTO GONZALES<br/>num_fono: 6666666<br/>num_identificacion: 232332<br/>peso: 200KG<br/>prioridad: P2-ALTA<br/>proveedor: PROVEEDOR 2<br/>serie: SERIE 2<br/>terciarios: TERCIARIO 2<br/>tipo: COMPRESIÓN<br/>ubicacion: PATIO<br/>updated_at: 2023-06-14 11:23:32<br/>voltios: 120VOLTIOS<br/>', 'SISTEMAS', '2023-06-14', '11:23:32', '2023-06-14 15:23:32', '2023-06-14 15:23:32'),
(100, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN HERRAMIENTAS/EQUIPOS DE PROTECCIÓN', 'almacen: ALMACEN 1<br/>clasificacion: CLASIFICACION 1<br/>cod_clasificacion: CLASI1<br/>codificacion: <br/>codigo: H001<br/>correo: PERES@GMAIL.COM<br/>correo_fabricante: FABRICANTE@GMAIL.COM<br/>costo: 1000.00<br/>created_at: 2023-06-06 12:05:22<br/>descripcion: DESC, HERRAMIENTA #1<br/>dir: LOS OLIVOS<br/>dir_fabricante: LOS PEDREGALES<br/>e_tecnicas: ESPECIFICACIONES TECNIAS HERRAMIENTA #1<br/>fabricante: FABRICANTE 1<br/>fono: 222222<br/>foto: 11686068009.jpeg<br/>id: 1<br/>marca: MARCA 1<br/>modelo: MODELO 1<br/>nombre: HERRAMIENTA #1<br/>nombre_contacto: JUAN PERES<br/>num_fono: 222222<br/>num_identificacion: 23323211111<br/>proveedor: PERES S.A.<br/>serie: SERIE 1<br/>terciarios: TERCIARIOS 1<br/>unidad_medida: METROS<br/>updated_at: 2023-06-06 12:13:29<br/>', 'almacen: ALMACEN 1<br/>clasificacion: CLASIFICACION 1<br/>cod_clasificacion: CLASI1<br/>codificacion: CH001PPP<br/>codigo: H001<br/>correo: PERES@GMAIL.COM<br/>correo_fabricante: FABRICANTE@GMAIL.COM<br/>costo: 1000.00<br/>created_at: 2023-06-06 12:05:22<br/>descripcion: DESC, HERRAMIENTA #1<br/>dir: LOS OLIVOS<br/>dir_fabricante: LOS PEDREGALES<br/>e_tecnicas: ESPECIFICACIONES TECNIAS HERRAMIENTA #1<br/>fabricante: FABRICANTE 1<br/>fono: 222222<br/>foto: 11686068009.jpeg<br/>id: 1<br/>marca: MARCA 1<br/>modelo: MODELO 1<br/>nombre: HERRAMIENTA #1<br/>nombre_contacto: JUAN PERES<br/>num_fono: 222222<br/>num_identificacion: 23323211111<br/>proveedor: PERES S.A.<br/>serie: SERIE 1<br/>terciarios: TERCIARIOS 1<br/>unidad_medida: METROS<br/>updated_at: 2023-06-14 11:29:08<br/>', 'HERRAMIENTAS/EQUIPOS DE PROTECCIÓN', '2023-06-14', '11:29:08', '2023-06-14 15:29:08', '2023-06-14 15:29:08'),
(101, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN HERRAMIENTAS/EQUIPOS DE PROTECCIÓN', 'almacen: ALMACEN EQUIPOS<br/>clasificacion: CLASIFICACION EQUIPO<br/>cod_clasificacion: CODIGOCLAS<br/>codificacion: <br/>codigo: E001<br/>correo: <br/>correo_fabricante: <br/>costo: 3000.00<br/>created_at: 2023-06-06 17:08:23<br/>descripcion: DESC EQUIPO # 1<br/>dir: <br/>dir_fabricante: <br/>e_tecnicas: <br/>fabricante: <br/>fono: <br/>foto: <br/>id: 3<br/>marca: MARCA EQUIPOS<br/>modelo: MODELO EQUIPO<br/>nombre: EQUIPO #1<br/>nombre_contacto: <br/>num_fono: <br/>num_identificacion: <br/>proveedor: PROVEEDOR DEL EQUIPO<br/>serie: SERIEEQUIPO<br/>terciarios: <br/>unidad_medida: METROS<br/>updated_at: 2023-06-06 17:08:23<br/>', 'almacen: ALMACEN EQUIPOS<br/>clasificacion: CLASIFICACION EQUIPO<br/>cod_clasificacion: CODIGOCLAS<br/>codificacion: CO002OOP<br/>codigo: E001<br/>correo: <br/>correo_fabricante: <br/>costo: 3000.00<br/>created_at: 2023-06-06 17:08:23<br/>descripcion: DESC EQUIPO # 1<br/>dir: <br/>dir_fabricante: <br/>e_tecnicas: <br/>fabricante: <br/>fono: <br/>foto: <br/>id: 3<br/>marca: MARCA EQUIPOS<br/>modelo: MODELO EQUIPO<br/>nombre: EQUIPO #1<br/>nombre_contacto: <br/>num_fono: <br/>num_identificacion: <br/>proveedor: PROVEEDOR DEL EQUIPO<br/>serie: SERIEEQUIPO<br/>terciarios: <br/>unidad_medida: METROS<br/>updated_at: 2023-06-14 11:31:00<br/>', 'HERRAMIENTAS/EQUIPOS DE PROTECCIÓN', '2023-06-14', '11:31:00', '2023-06-14 15:31:00', '2023-06-14 15:31:00'),
(102, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN HERRAMIENTAS/EQUIPOS DE PROTECCIÓN', 'almacen: ALMACEN #1<br/>clasificacion: <br/>cod_clasificacion: <br/>codificacion: CO003POO<br/>codigo: EQ003<br/>correo: <br/>correo_fabricante: <br/>costo: <br/>created_at: 2023-06-14 11:31:43<br/>descripcion: DESC. EQ. #3<br/>dir: <br/>dir_fabricante: <br/>e_tecnicas: <br/>fabricante: <br/>fono: <br/>foto: <br/>id: 4<br/>marca: <br/>modelo: <br/>nombre: EQUIPO #3<br/>nombre_contacto: <br/>num_fono: <br/>num_identificacion: <br/>proveedor: PROVEEDOR #3<br/>serie: <br/>terciarios: <br/>unidad_medida: <br/>updated_at: 2023-06-14 11:31:43<br/>', NULL, 'HERRAMIENTAS/EQUIPOS DE PROTECCIÓN', '2023-06-14', '11:31:43', '2023-06-14 15:31:43', '2023-06-14 15:31:43'),
(103, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN HERRAMIENTAS/EQUIPOS DE PROTECCIÓN', 'almacen: ALMACEN #1<br/>clasificacion: <br/>cod_clasificacion: <br/>codificacion: CO003POO<br/>codigo: EQ003<br/>correo: <br/>correo_fabricante: <br/>costo: <br/>created_at: 2023-06-14 11:31:43<br/>descripcion: DESC. EQ. #3<br/>dir: <br/>dir_fabricante: <br/>e_tecnicas: <br/>fabricante: <br/>fono: <br/>foto: <br/>id: 4<br/>marca: <br/>modelo: <br/>nombre: EQUIPO #3<br/>nombre_contacto: <br/>num_fono: <br/>num_identificacion: <br/>proveedor: PROVEEDOR #3<br/>serie: <br/>terciarios: <br/>unidad_medida: <br/>updated_at: 2023-06-14 11:31:43<br/>', 'almacen: ALMACEN #1<br/>clasificacion: <br/>cod_clasificacion: <br/>codificacion: CO003POO<br/>codigo: EQ003<br/>correo: <br/>correo_fabricante: <br/>costo: <br/>created_at: 2023-06-14 11:31:43<br/>descripcion: DESC. EQ. #3<br/>dir: <br/>dir_fabricante: <br/>e_tecnicas: <br/>fabricante: <br/>fono: <br/>foto: <br/>id: 4<br/>marca: <br/>modelo: <br/>nombre: EQUIPO #3<br/>nombre_contacto: <br/>num_fono: <br/>num_identificacion: <br/>proveedor: PROVEEDOR #3<br/>serie: <br/>terciarios: <br/>unidad_medida: <br/>updated_at: 2023-06-14 11:31:43<br/>', 'HERRAMIENTAS/EQUIPOS DE PROTECCIÓN', '2023-06-14', '11:31:54', '2023-06-14 15:31:54', '2023-06-14 15:31:54'),
(104, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SISTEMA', 'altura: <br/>ancho: <br/>archivo: <br/>capacidad: <br/>codificacion: COO003EET<br/>correo: <br/>costo: <br/>created_at: 2023-06-14 11:32:36<br/>descripcion: DESC. MAQUINARIA #3<br/>dir: <br/>e_tecnicas: <br/>equipo_id: 2<br/>estado: ACTIVA<br/>fabricantes: <br/>fecha_compra: <br/>fecha_instalacion: <br/>fecha_ultimo_mantenimiento: <br/>fecha_utlimo_termino: <br/>foto: <br/>garantia_meses: <br/>id: 4<br/>largo: <br/>marca: <br/>modelo: <br/>nombre_contacto: <br/>num_fono: <br/>num_identificacion: <br/>peso: <br/>prioridad: P3-MEDIA<br/>proveedor: <br/>serie: <br/>terciarios: <br/>tipo: REFRIGERACIÓN<br/>ubicacion: PATIO<br/>updated_at: 2023-06-14 11:32:36<br/>voltios: <br/>', NULL, 'SISTEMAS', '2023-06-14', '11:32:36', '2023-06-14 15:32:36', '2023-06-14 15:32:36'),
(105, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN SISTEMA', 'altura: <br/>ancho: <br/>archivo: <br/>capacidad: <br/>codificacion: COO003EET<br/>correo: <br/>costo: <br/>created_at: 2023-06-14 11:32:36<br/>descripcion: DESC. MAQUINARIA #3<br/>dir: <br/>e_tecnicas: <br/>equipo_id: 2<br/>estado: ACTIVA<br/>fabricantes: <br/>fecha_compra: <br/>fecha_instalacion: <br/>fecha_ultimo_mantenimiento: <br/>fecha_utlimo_termino: <br/>foto: <br/>garantia_meses: <br/>id: 4<br/>largo: <br/>marca: <br/>modelo: <br/>nombre_contacto: <br/>num_fono: <br/>num_identificacion: <br/>peso: <br/>prioridad: P3-MEDIA<br/>proveedor: <br/>serie: <br/>terciarios: <br/>tipo: REFRIGERACIÓN<br/>ubicacion: PATIO<br/>updated_at: 2023-06-14 11:32:36<br/>voltios: <br/>', 'altura: <br/>ancho: <br/>archivo: <br/>capacidad: <br/>codificacion: COO003EET<br/>correo: <br/>costo: <br/>created_at: 2023-06-14 11:32:36<br/>descripcion: DESC. MAQUINARIA #3<br/>dir: <br/>e_tecnicas: <br/>equipo_id: 2<br/>estado: ACTIVA<br/>fabricantes: <br/>fecha_compra: <br/>fecha_instalacion: <br/>fecha_ultimo_mantenimiento: <br/>fecha_utlimo_termino: <br/>foto: <br/>garantia_meses: <br/>id: 4<br/>largo: <br/>marca: <br/>modelo: <br/>nombre_contacto: <br/>num_fono: <br/>num_identificacion: <br/>peso: <br/>prioridad: P3-MEDIA<br/>proveedor: <br/>serie: <br/>terciarios: <br/>tipo: REFRIGERACIÓN<br/>ubicacion: PATIO<br/>updated_at: 2023-06-14 11:32:36<br/>voltios: <br/>', 'SISTEMAS', '2023-06-14', '11:34:52', '2023-06-14 15:34:52', '2023-06-14 15:34:52'),
(106, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA ENTRADA DE HERRAMIENTA/EQUIPO DE PROTECCIÓN', 'cantidad: 100<br/>created_at: 2023-06-07 13:15:13<br/>factura: 4343<br/>fecha: 2023-06-07<br/>herramienta_id: 3<br/>id: 3<br/>precio: 50.00<br/>total: 5000.00<br/>unidad_medida: UNIDADES<br/>updated_at: 2023-06-07 13:15:13<br/>', 'cantidad: 100<br/>created_at: 2023-06-07 13:15:13<br/>factura: 4343<br/>fecha: 2023-06-07<br/>herramienta_id: 3<br/>id: 3<br/>precio: 50.00<br/>total: 5000.00<br/>unidad_medida: UNIDADES<br/>updated_at: 2023-06-07 13:15:13<br/>', 'ENTRADA DE HERRAMIENTAS/EQUIPOS DE PROTECCIÓN', '2023-06-14', '11:37:36', '2023-06-14 15:37:36', '2023-06-14 15:37:36'),
(107, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN REPUESTOS/INSUMO', 'almacen: ALMACEN 1<br/>codificacion: <br/>codigo: R001<br/>correo: PROVEEDOR@GMAIL.COM<br/>correo_fabricante: FABRICANTE@GMAIL.COM<br/>created_at: 2023-06-07 13:01:13<br/>descripcion: DESC. REPUESTO #1 MODIFICADO<br/>dir: LOS OLIVOS<br/>dir_fabricante: LOS OLIVOS #2<br/>equipo_id: 1<br/>fabricante: FABRICANTE 1<br/>fono: 222222<br/>id: 1<br/>marca: MARCA 1<br/>modelo: MODELO 1<br/>nombre: REPUESTO #1<br/>nombre_contacto: JUAN PERES<br/>num_fono: 7777777<br/>num_identificacion: 433434<br/>precio: 560.00<br/>proveedor: PROVEEDOR 1<br/>serie: SERIE 1<br/>stock_actual: 0<br/>stock_max: 200<br/>stock_min: 10<br/>terciarios: TERCIARIO 1<br/>unidad_medida: UNIDADES<br/>updated_at: 2023-06-07 13:48:57<br/>', 'almacen: ALMACEN 1<br/>codificacion: RC001POPE<br/>codigo: R001<br/>correo: PROVEEDOR@GMAIL.COM<br/>correo_fabricante: FABRICANTE@GMAIL.COM<br/>created_at: 2023-06-07 13:01:13<br/>descripcion: DESC. REPUESTO #1 MODIFICADO<br/>dir: LOS OLIVOS<br/>dir_fabricante: LOS OLIVOS #2<br/>equipo_id: 1<br/>fabricante: FABRICANTE 1<br/>fono: 222222<br/>id: 1<br/>marca: MARCA 1<br/>modelo: MODELO 1<br/>nombre: REPUESTO #1<br/>nombre_contacto: JUAN PERES<br/>num_fono: 7777777<br/>num_identificacion: 433434<br/>precio: 560.00<br/>proveedor: PROVEEDOR 1<br/>serie: SERIE 1<br/>stock_actual: 0<br/>stock_max: 200<br/>stock_min: 10<br/>terciarios: TERCIARIO 1<br/>unidad_medida: UNIDADES<br/>updated_at: 2023-06-14 11:42:41<br/>', 'REPUESTOS/INSUMOS', '2023-06-14', '11:42:41', '2023-06-14 15:42:41', '2023-06-14 15:42:41'),
(108, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN REPUESTOS/INSUMO', 'almacen: ALMACEN 1<br/>codificacion: <br/>codigo: I001<br/>correo: <br/>correo_fabricante: <br/>created_at: 2023-06-07 13:05:13<br/>descripcion: DESC. INSUMO #1<br/>dir: <br/>dir_fabricante: <br/>equipo_id: 2<br/>fabricante: <br/>fono: <br/>id: 2<br/>marca: <br/>modelo: <br/>nombre: INSUMO #1<br/>nombre_contacto: <br/>num_fono: <br/>num_identificacion: <br/>precio: 300.00<br/>proveedor: <br/>serie: <br/>stock_actual: 0<br/>stock_max: 100<br/>stock_min: 5<br/>terciarios: <br/>unidad_medida: <br/>updated_at: 2023-06-07 13:05:13<br/>', 'almacen: ALMACEN 1<br/>codificacion: I00012EIO<br/>codigo: I001<br/>correo: <br/>correo_fabricante: <br/>created_at: 2023-06-07 13:05:13<br/>descripcion: DESC. INSUMO #1<br/>dir: <br/>dir_fabricante: <br/>equipo_id: 2<br/>fabricante: <br/>fono: <br/>id: 2<br/>marca: <br/>modelo: <br/>nombre: INSUMO #1<br/>nombre_contacto: <br/>num_fono: <br/>num_identificacion: <br/>precio: 300.00<br/>proveedor: <br/>serie: <br/>stock_actual: 0<br/>stock_max: 100<br/>stock_min: 5<br/>terciarios: <br/>unidad_medida: <br/>updated_at: 2023-06-14 11:44:44<br/>', 'REPUESTOS/INSUMOS', '2023-06-14', '11:44:44', '2023-06-14 15:44:44', '2023-06-14 15:44:44'),
(109, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN REPUESTOS/INSUMO', 'almacen: ALMACEN<br/>codificacion: I004IRR<br/>codigo: I003<br/>correo: <br/>correo_fabricante: <br/>created_at: 2023-06-14 11:45:31<br/>descripcion: DESC. REP. #2<br/>dir: <br/>dir_fabricante: <br/>equipo_id: 2<br/>fabricante: <br/>fono: <br/>id: 3<br/>marca: <br/>modelo: <br/>nombre: REPUESTO #2<br/>nombre_contacto: <br/>num_fono: <br/>num_identificacion: <br/>precio: 900<br/>proveedor: <br/>serie: <br/>stock_actual: 0<br/>stock_max: 20<br/>stock_min: 4<br/>terciarios: <br/>unidad_medida: <br/>updated_at: 2023-06-14 11:45:31<br/>', NULL, 'REPUESTOS/INSUMOS', '2023-06-14', '11:45:31', '2023-06-14 15:45:31', '2023-06-14 15:45:31'),
(110, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN REPUESTOS/INSUMO', 'codificacion: <br/>codigo: GM001<br/>created_at: 2023-06-13 12:37:24<br/>descripcion: <br/>equipo_id: 1<br/>id: 2<br/>subfamilia_id: 1<br/>updated_at: 2023-06-13 12:37:24<br/>', 'codificacion: <br/>codigo: GM001<br/>created_at: 2023-06-13 12:37:24<br/>descripcion: <br/>equipo_id: 1<br/>id: 2<br/>subfamilia_id: 1<br/>updated_at: 2023-06-13 12:37:24<br/>', 'REPUESTOS/INSUMOS', '2023-06-14', '12:03:51', '2023-06-14 16:03:51', '2023-06-14 16:03:51'),
(111, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN REPUESTOS/INSUMO', 'codificacion: <br/>codigo: GM001<br/>created_at: 2023-06-13 12:37:24<br/>descripcion: <br/>equipo_id: 1<br/>id: 2<br/>subfamilia_id: 1<br/>updated_at: 2023-06-13 12:37:24<br/>', 'codificacion: GM001HH8<br/>codigo: GM001<br/>created_at: 2023-06-13 12:37:24<br/>descripcion: <br/>equipo_id: 1<br/>id: 2<br/>subfamilia_id: 1<br/>updated_at: 2023-06-14 12:05:09<br/>', 'REPUESTOS/INSUMOS', '2023-06-14', '12:05:09', '2023-06-14 16:05:09', '2023-06-14 16:05:09'),
(112, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA VARIABLE DE CONTROL', 'id: 2<br/>nombre: VARIABLE #2<br/>unidad: KILÓMETROS<br/>created_at: 2023-06-06 11:05:33<br/>updated_at: 2023-06-06 11:05:33<br/>', NULL, 'VARIABLES DE CONTROL', '2023-06-14', '16:51:25', '2023-06-14 20:51:25', '2023-06-14 20:51:25'),
(113, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA VARIABLE DE CONTROL', 'id: 2<br/>nombre: VARIABLE #2<br/>unidad: HORA<br/>created_at: 2023-06-06 11:05:33<br/>updated_at: 2023-06-14 16:51:25<br/>', NULL, 'VARIABLES DE CONTROL', '2023-06-14', '16:51:31', '2023-06-14 20:51:31', '2023-06-14 20:51:31'),
(114, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA VARIABLE DE CONTROL', 'id: 1<br/>nombre: VARIABLE CONTROL #1<br/>unidad: HORA<br/>created_at: 2023-06-06 11:05:22<br/>updated_at: 2023-06-06 11:05:22<br/>', NULL, 'VARIABLES DE CONTROL', '2023-06-14', '16:51:36', '2023-06-14 20:51:36', '2023-06-14 20:51:36'),
(115, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA CATEGORIA', 'id: 1<br/>variable_id: 1<br/>frecuencia: 1<br/>created_at: 2023-06-06 11:15:51<br/>updated_at: 2023-06-06 11:16:28<br/>', 'id: 1<br/>variable_id: 1<br/>frecuencia: 7<br/>created_at: 2023-06-06 11:15:51<br/>updated_at: 2023-06-14 16:51:45<br/>', 'CATEGORIAS', '2023-06-14', '16:51:45', '2023-06-14 20:51:45', '2023-06-14 20:51:45'),
(116, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PLAN DE MANTENIMIENTO', 'id: 1<br/>codificacion: PM001HHH9<br/>subunidad_id: 1<br/>gama_id: 2<br/>pm: PM<br/>prioridad: URGENTE<br/>tiempo: 17<br/>dias: 5<br/>tipo_mantenimiento: PREVENTIVO<br/>ultima_fecha_programada: 2023-05-01<br/>ultima_fecha_terminada: 2023-05-04<br/>programacion: ÚLTIMA VEZ QUE SE PROGRAMÓ<br/>fecha_final: 2023-05-31<br/>variable_control_id: 1<br/>frecuencia_id: 1<br/>estado: PLANIFICADO<br/>created_at: 2023-06-14 17:21:55<br/>updated_at: 2023-06-14 17:21:55<br/>', NULL, 'PLAN DE MANTENIMIENTO', '2023-06-14', '17:21:55', '2023-06-14 21:21:55', '2023-06-14 21:21:55'),
(117, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN PLAN DE MANTENIMIENTO', 'id: 1<br/>codificacion: PM001HHH9<br/>subunidad_id: 1<br/>gama_id: 2<br/>pm: PM<br/>prioridad: URGENTE<br/>tiempo: 17<br/>dias: 5<br/>tipo_mantenimiento: PREVENTIVO<br/>ultima_fecha_programada: 2023-05-01<br/>ultima_fecha_terminada: 2023-05-04<br/>programacion: ÚLTIMA VEZ QUE SE PROGRAMÓ<br/>fecha_final: 2023-05-31<br/>variable_control_id: 1<br/>frecuencia_id: 1<br/>estado: PLANIFICADO<br/>created_at: 2023-06-14 17:21:55<br/>updated_at: 2023-06-14 17:21:55<br/>', 'id: 1<br/>codificacion: PM001HHH921<br/>subunidad_id: 1<br/>gama_id: 2<br/>pm: PM MODIFICADO<br/>prioridad: URGENTE<br/>tiempo: 17<br/>dias: 5<br/>tipo_mantenimiento: PREVENTIVO<br/>ultima_fecha_programada: 2023-05-01<br/>ultima_fecha_terminada: 2023-05-04<br/>programacion: ÚLTIMA VEZ QUE SE TERMINÓ<br/>fecha_final: 2023-05-31<br/>variable_control_id: 1<br/>frecuencia_id: 1<br/>estado: PLANIFICADO<br/>created_at: 2023-06-14 17:21:55<br/>updated_at: 2023-06-14 17:27:50<br/>', 'PLAN DE MANTENIMIENTO', '2023-06-14', '17:27:50', '2023-06-14 21:27:50', '2023-06-14 21:27:50'),
(118, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN PLAN DE MANTENIMIENTO', 'id: 1<br/>codificacion: PM001HHH921<br/>subunidad_id: 1<br/>gama_id: 2<br/>pm: PM MODIFICADO<br/>prioridad: URGENTE<br/>tiempo: 17<br/>dias: 5<br/>tipo_mantenimiento: PREVENTIVO<br/>ultima_fecha_programada: 2023-05-01<br/>ultima_fecha_terminada: 2023-05-04<br/>programacion: ÚLTIMA VEZ QUE SE TERMINÓ<br/>fecha_final: 2023-05-31<br/>variable_control_id: 1<br/>frecuencia_id: 1<br/>estado: PLANIFICADO<br/>created_at: 2023-06-14 17:21:55<br/>updated_at: 2023-06-14 17:27:50<br/>', 'id: 1<br/>codificacion: PM001HHH921<br/>subunidad_id: 1<br/>gama_id: 2<br/>pm: PM<br/>prioridad: URGENTE<br/>tiempo: 17<br/>dias: 5<br/>tipo_mantenimiento: PREVENTIVO<br/>ultima_fecha_programada: 2023-05-01<br/>ultima_fecha_terminada: 2023-05-04<br/>programacion: ÚLTIMA VEZ QUE SE TERMINÓ<br/>fecha_final: 2023-05-31<br/>variable_control_id: 1<br/>frecuencia_id: 1<br/>estado: PLANIFICADO<br/>created_at: 2023-06-14 17:21:55<br/>updated_at: 2023-06-14 17:28:10<br/>', 'PLAN DE MANTENIMIENTO', '2023-06-14', '17:28:10', '2023-06-14 21:28:10', '2023-06-14 21:28:10'),
(119, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UN PLAN DE MANTENIMIENTO', 'id: 1<br/>codificacion: PM001HHH921<br/>subunidad_id: 1<br/>gama_id: 2<br/>pm: PM<br/>prioridad: URGENTE<br/>tiempo: 17<br/>dias: 5<br/>tipo_mantenimiento: PREVENTIVO<br/>ultima_fecha_programada: 2023-05-01<br/>ultima_fecha_terminada: 2023-05-04<br/>programacion: ÚLTIMA VEZ QUE SE TERMINÓ<br/>fecha_final: 2023-05-31<br/>variable_control_id: 1<br/>frecuencia_id: 1<br/>estado: PLANIFICADO<br/>created_at: 2023-06-14 17:21:55<br/>updated_at: 2023-06-14 17:28:10<br/>', NULL, 'PLAN DE MANTENIMIENTO', '2023-06-14', '17:31:46', '2023-06-14 21:31:46', '2023-06-14 21:31:46'),
(120, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PLAN DE MANTENIMIENTO', 'id: 2<br/>codificacion: PM001HHH3<br/>subunidad_id: 1<br/>gama_id: 2<br/>pm: PM<br/>prioridad: URGENTE<br/>tiempo: 17<br/>dias: 10<br/>tipo_mantenimiento: PREVENTIVO<br/>ultima_fecha_programada: 2023-05-01<br/>ultima_fecha_terminada: 2023-05-05<br/>programacion: ÚLTIMA VEZ QUE SE PROGRAMÓ<br/>fecha_final: 2023-05-31<br/>variable_control_id: 1<br/>frecuencia_id: 1<br/>estado: PLANIFICADO<br/>created_at: 2023-06-14 17:32:31<br/>updated_at: 2023-06-14 17:32:31<br/>', NULL, 'PLAN DE MANTENIMIENTO', '2023-06-14', '17:32:31', '2023-06-14 21:32:31', '2023-06-14 21:32:31'),
(121, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA ORDEN DE TRABAJO', 'created_at: 2023-06-15 11:23:35<br/>dias: 5<br/>estado: PROGRAMADO<br/>fecha_programada: 2023-06-15<br/>gama_id: 2<br/>id: 1<br/>prioridad: URGENTE<br/>subunidad_id: 1<br/>tiempo: 17<br/>tipo_mantenimiento: PREVENTIVO<br/>updated_at: 2023-06-15 11:23:35<br/>', NULL, 'ORDENES DE TRABAJO', '2023-06-15', '11:23:35', '2023-06-15 15:23:35', '2023-06-15 15:23:35'),
(122, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA ORDEN DE TRABAJO', 'created_at: 2023-06-15 11:23:35<br/>dias: 5<br/>estado: PROGRAMADO<br/>fecha_programada: 2023-06-15<br/>gama_id: 2<br/>id: 1<br/>prioridad: URGENTE<br/>subunidad_id: 1<br/>tiempo: 17<br/>tipo_mantenimiento: PREVENTIVO<br/>updated_at: 2023-06-15 11:23:35<br/>', 'created_at: 2023-06-15 11:23:35<br/>dias: 7<br/>estado: PROGRAMADO<br/>fecha_programada: 2023-06-15<br/>gama_id: 2<br/>id: 1<br/>prioridad: MODERADA<br/>subunidad_id: 2<br/>tiempo: 17<br/>tipo_mantenimiento: PREVENTIVO<br/>updated_at: 2023-06-15 11:25:40<br/>', 'ORDENES DE TRABAJO', '2023-06-15', '11:25:40', '2023-06-15 15:25:40', '2023-06-15 15:25:40'),
(123, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UNA ORDEN DE TRABAJO', 'created_at: 2023-06-15 11:23:35<br/>dias: 7<br/>estado: PROGRAMADO<br/>fecha_programada: 2023-06-15<br/>gama_id: 2<br/>id: 1<br/>prioridad: MODERADA<br/>subunidad_id: 2<br/>tiempo: 17<br/>tipo_mantenimiento: PREVENTIVO<br/>updated_at: 2023-06-15 11:25:40<br/>', NULL, 'ORDENES DE TRABAJO', '2023-06-15', '11:26:40', '2023-06-15 15:26:40', '2023-06-15 15:26:40'),
(124, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA ORDEN DE TRABAJO', 'created_at: 2023-06-15 11:26:58<br/>dias: 7<br/>estado: PROGRAMADO<br/>fecha_programada: 2023-06-15<br/>gama_id: 2<br/>id: 2<br/>prioridad: URGENTE<br/>subunidad_id: 1<br/>tiempo: 17<br/>tipo_mantenimiento: PREDICTIVO<br/>updated_at: 2023-06-15 11:26:58<br/>', NULL, 'ORDENES DE TRABAJO', '2023-06-15', '11:26:58', '2023-06-15 15:26:58', '2023-06-15 15:26:58'),
(125, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN USUARIO', 'acceso: 1<br/>ci: 1111<br/>ci_exp: LP<br/>correo: <br/>created_at: 2023-06-01 11:39:49<br/>dir: <br/>especialidad: <br/>fecha_registro: 2023-06-01<br/>fono: <br/>foto: default.png<br/>id: 2<br/>materno: MAMANI<br/>nombre: JUAN<br/>password: $2y$10$t1vtRZ48507H2YKWgrU02Olg8W6bhN8yV8PduODfUJeMSIXEzqF/e<br/>paterno: PERES<br/>tipo: GERENTE<br/>updated_at: 2023-06-01 11:39:49<br/>usuario: JPERES<br/>', 'acceso: 1<br/>ci: 1111<br/>ci_exp: LP<br/>correo: <br/>created_at: 2023-06-01 11:39:49<br/>dir: <br/>especialidad: <br/>fecha_registro: 2023-06-01<br/>fono: <br/>foto: default.png<br/>id: 2<br/>materno: MAMANI<br/>nombre: JUAN<br/>password: $2y$10$t1vtRZ48507H2YKWgrU02Olg8W6bhN8yV8PduODfUJeMSIXEzqF/e<br/>paterno: PERES<br/>tipo: GERENTE<br/>updated_at: 2023-06-15 11:32:28<br/>usuario: JPERES<br/>', 'USUARIOS', '2023-06-15', '11:32:28', '2023-06-15 15:32:28', '2023-06-15 15:32:28'),
(126, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA ORDEN DE TRABAJO', 'created_at: 2023-06-19 11:58:35<br/>dias: 10<br/>estado: PROGRAMADO<br/>fecha_programada: 2023-06-19<br/>gama_id: 2<br/>id: 3<br/>prioridad: MODERADA<br/>subunidad_id: 2<br/>tiempo: 17<br/>tipo_mantenimiento: LUBRICACIÓN<br/>updated_at: 2023-06-19 11:58:35<br/>', NULL, 'ORDENES DE TRABAJO', '2023-06-19', '11:58:35', '2023-06-19 15:58:35', '2023-06-19 15:58:35'),
(127, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA ENTRADA DE REPUESTOS/INSUMOS', 'id: 4<br/>factura: 1000010<br/>repuesto_id: 1<br/>cantidad: 100<br/>precio: 35<br/>total: 3500.00<br/>fecha: 2023-06-19<br/>created_at: 2023-06-19 14:08:05<br/>updated_at: 2023-06-19 14:08:05<br/>', NULL, 'ENTRADA DE REPUESTOS/INSUMOS', '2023-06-19', '14:08:05', '2023-06-19 18:08:05', '2023-06-19 18:08:05'),
(128, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA ENTRADA DE REPUESTOS/INSUMOS', 'id: 5<br/>factura: 20000022<br/>repuesto_id: 2<br/>cantidad: 100<br/>precio: 50<br/>total: 5000.00<br/>fecha: 2023-06-19<br/>created_at: 2023-06-19 14:08:20<br/>updated_at: 2023-06-19 14:08:20<br/>', NULL, 'ENTRADA DE REPUESTOS/INSUMOS', '2023-06-19', '14:08:20', '2023-06-19 18:08:20', '2023-06-19 18:08:20'),
(129, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA ENTRADA DE REPUESTOS/INSUMOS', 'id: 6<br/>factura: 30003303<br/>repuesto_id: 3<br/>cantidad: 100<br/>precio: 50<br/>total: 5000.00<br/>fecha: 2023-06-19<br/>created_at: 2023-06-19 14:08:36<br/>updated_at: 2023-06-19 14:08:36<br/>', NULL, 'ENTRADA DE REPUESTOS/INSUMOS', '2023-06-19', '14:08:36', '2023-06-19 18:08:36', '2023-06-19 18:08:36'),
(130, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PERSONAL', 'id: 3<br/>tipo_mo: SERVICIOS<br/>user_id: <br/>razon_social: SERVICE LTDA.<br/>nro_doc: 90812<br/>especialidad: ESPECIALIDAD #2<br/>correo: SERV@GMAIL.COM<br/>telefono: 2222<br/>domicilio: <br/>created_at: 2023-06-19 16:45:41<br/>updated_at: 2023-06-19 16:45:41<br/>', NULL, 'PERSONAL', '2023-06-19', '16:45:42', '2023-06-19 20:45:42', '2023-06-19 20:45:42'),
(131, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PERSONAL', 'id: 4<br/>tipo_mo: TERCEROS<br/>user_id: <br/>razon_social: TERCEROS S.A.<br/>nro_doc: 89329<br/>especialidad: ESPC. #3<br/>correo: TERC@GMAIL.COM<br/>telefono: 66666<br/>domicilio: LOS OLIVOS<br/>created_at: 2023-06-19 16:46:07<br/>updated_at: 2023-06-19 16:46:07<br/>', NULL, 'PERSONAL', '2023-06-19', '16:46:07', '2023-06-19 20:46:07', '2023-06-19 20:46:07'),
(132, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN USUARIO', 'id: 5<br/>usuario: JMARTINEZ<br/>nombre: JAVIER<br/>paterno: MARTINEZ<br/>materno: CARVAJAL<br/>ci: 4444<br/>ci_exp: LP<br/>especialidad: ESPECIALIDAD #4<br/>dir: LOS OLIVOS<br/>correo: <br/>fono: <br/>tipo: JEFE DE MANTENIMIENTO<br/>foto: default.png<br/>password: $2y$10$7x/LueWPTLqj7O3rmGeui.CHkOn0QYuylolsX/PX1aO6UNbHVbxIe<br/>acceso: 1<br/>fecha_registro: 2023-06-19<br/>created_at: 2023-06-19 17:13:00<br/>updated_at: 2023-06-19 17:13:00<br/>', NULL, 'USUARIOS', '2023-06-19', '17:13:00', '2023-06-19 21:13:00', '2023-06-19 21:13:00'),
(133, 1, 'REGISTRO', 'EL USUARIO admin REGISTRO UN REPUESTO EN UNA GENERACIÓN DE OT', 'id: 1<br/>orden_generada_id: 1<br/>repuesto_id: 1<br/>cantidad_requerida: 5<br/>costo: 560.00<br/>total: 2800<br/>created_at: 2023-06-19 17:14:52<br/>updated_at: 2023-06-19 17:14:52<br/>', NULL, 'GENERACIÓN DE OT - REPUESTOS', '2023-06-19', '17:14:52', '2023-06-19 21:14:52', '2023-06-19 21:14:52'),
(134, 1, 'REGISTRO', 'EL USUARIO admin REGISTRO UN REPUESTO EN UNA GENERACIÓN DE OT', 'id: 2<br/>orden_generada_id: 1<br/>repuesto_id: 3<br/>cantidad_requerida: 3<br/>costo: 900.00<br/>total: 2700<br/>created_at: 2023-06-19 17:14:52<br/>updated_at: 2023-06-19 17:14:52<br/>', NULL, 'GENERACIÓN DE OT - REPUESTOS', '2023-06-19', '17:14:52', '2023-06-19 21:14:52', '2023-06-19 21:14:52'),
(135, 1, 'REGISTRO', 'EL USUARIO admin REGISTRO UN PERSONAL EN UNA GENERACIÓN DE OT', 'id: 1<br/>orden_generada_id: 1<br/>personal_id: 1<br/>costo: 40<br/>created_at: 2023-06-19 17:15:22<br/>updated_at: 2023-06-19 17:15:22<br/>', NULL, 'GENERACIÓN DE OT - PERSONAL', '2023-06-19', '17:15:22', '2023-06-19 21:15:22', '2023-06-19 21:15:22'),
(136, 1, 'REGISTRO', 'EL USUARIO admin REGISTRO UN PERSONAL EN UNA GENERACIÓN DE OT', 'id: 2<br/>orden_generada_id: 1<br/>personal_id: 3<br/>costo: 50<br/>created_at: 2023-06-19 17:15:22<br/>updated_at: 2023-06-19 17:15:22<br/>', NULL, 'GENERACIÓN DE OT - PERSONAL', '2023-06-19', '17:15:22', '2023-06-19 21:15:22', '2023-06-19 21:15:22'),
(137, 1, 'REGISTRO', 'EL USUARIO admin REGISTRO UNA HERRAMIENTA EN UNA GENERACIÓN DE OT', 'id: 1<br/>orden_generada_id: 1<br/>herramienta_id: 1<br/>cantidad_solicitada: 20<br/>costo: 1000.00<br/>total: 20000<br/>created_at: 2023-06-19 17:16:26<br/>updated_at: 2023-06-19 17:16:26<br/>', NULL, 'GENERACIÓN DE OT - HERRAMIENTAS', '2023-06-19', '17:16:26', '2023-06-19 21:16:26', '2023-06-19 21:16:26'),
(140, 1, 'REGISTRO', 'EL USUARIO admin REGISTRO UN PERSONAL EN UNA GENERACIÓN DE OT', 'id: 3<br/>orden_generada_id: 1<br/>personal_id: 1<br/>costo: 50<br/>created_at: 2023-06-19 17:55:15<br/>updated_at: 2023-06-19 17:55:15<br/>', NULL, 'GENERACIÓN DE OT - PERSONAL', '2023-06-19', '17:55:15', '2023-06-19 21:55:15', '2023-06-19 21:55:15'),
(141, 1, 'REGISTRO', 'EL USUARIO admin REGISTRO UN PERSONAL EN UNA GENERACIÓN DE OT', 'id: 4<br/>orden_generada_id: 1<br/>personal_id: 3<br/>costo: 40<br/>created_at: 2023-06-19 17:55:15<br/>updated_at: 2023-06-19 17:55:15<br/>', NULL, 'GENERACIÓN DE OT - PERSONAL', '2023-06-19', '17:55:15', '2023-06-19 21:55:15', '2023-06-19 21:55:15'),
(142, 1, 'REGISTRO', 'EL USUARIO admin REGISTRO UN PERSONAL EN UNA GENERACIÓN DE OT', 'id: 5<br/>orden_generada_id: 2<br/>personal_id: 4<br/>costo: 60<br/>created_at: 2023-06-19 18:06:45<br/>updated_at: 2023-06-19 18:06:45<br/>', NULL, 'GENERACIÓN DE OT - PERSONAL', '2023-06-19', '18:06:45', '2023-06-19 22:06:45', '2023-06-19 22:06:45'),
(143, 1, 'REGISTRO', 'EL USUARIO admin REGISTRO UNA HERRAMIENTA EN UNA GENERACIÓN DE OT', 'id: 2<br/>orden_generada_id: 2<br/>herramienta_id: 3<br/>cantidad_solicitada: 10<br/>costo: 3000.00<br/>total: 30000<br/>created_at: 2023-06-19 19:16:03<br/>updated_at: 2023-06-19 19:16:03<br/>', NULL, 'GENERACIÓN DE OT - HERRAMIENTAS', '2023-06-19', '19:16:03', '2023-06-19 23:16:03', '2023-06-19 23:16:03'),
(144, 1, 'REGISTRO', 'EL USUARIO admin REGISTRO UN REPUESTO EN UNA GENERACIÓN DE OT', 'id: 3<br/>orden_generada_id: 2<br/>repuesto_id: 1<br/>cantidad_requerida: 5<br/>costo: 560.00<br/>total: 2800<br/>created_at: 2023-06-19 19:16:15<br/>updated_at: 2023-06-19 19:16:15<br/>', NULL, 'GENERACIÓN DE OT - REPUESTOS', '2023-06-19', '19:16:15', '2023-06-19 23:16:15', '2023-06-19 23:16:15'),
(145, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA ORDEN DE TRABAJO', 'id: 2<br/>fecha_programada: 2023-06-15<br/>subunidad_id: 1<br/>gama_id: 2<br/>prioridad: URGENTE<br/>tiempo: 17<br/>dias: 7<br/>tipo_mantenimiento: PREDICTIVO<br/>estado: PROGRAMADO<br/>created_at: 2023-06-15 11:26:58<br/>updated_at: 2023-06-15 11:26:58<br/>', 'id: 2<br/>fecha_programada: 2023-06-15<br/>subunidad_id: 1<br/>gama_id: 2<br/>prioridad: URGENTE<br/>tiempo: 17<br/>dias: 7<br/>tipo_mantenimiento: PREDICTIVO<br/>estado: PROGRAMADO<br/>created_at: 2023-06-15 11:26:58<br/>updated_at: 2023-06-15 11:26:58<br/>', 'ORDENES DE TRABAJO', '2023-06-19', '19:20:51', '2023-06-19 23:20:51', '2023-06-19 23:20:51');
INSERT INTO `historial_accions` (`id`, `user_id`, `accion`, `descripcion`, `datos_original`, `datos_nuevo`, `modulo`, `fecha`, `hora`, `created_at`, `updated_at`) VALUES
(146, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN USUARIO', 'id: 6<br/>usuario: MMAMANI<br/>nombre: MARIA<br/>paterno: MAMANI<br/>materno: MAMANI<br/>ci: 5555<br/>ci_exp: LP<br/>especialidad: ESPECIALIDAD #5<br/>dir: <br/>correo: <br/>fono: <br/>tipo: SUPERVISOR DE COMPRAS<br/>foto: default.png<br/>password: $2y$10$ErNwHw25OFa0/Rc1kaIGUe40JW8Bge5tGYFoDNATrOHyrgmK2mXfq<br/>acceso: 1<br/>fecha_registro: 2023-06-20<br/>created_at: 2023-06-20 13:18:50<br/>updated_at: 2023-06-20 13:18:50<br/>', NULL, 'USUARIOS', '2023-06-20', '13:18:50', '2023-06-20 17:18:50', '2023-06-20 17:18:50'),
(149, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PEDIDO DE REPUESTO', 'id: 3<br/>orden_id: 2<br/>created_at: 2023-06-20 13:24:52<br/>updated_at: 2023-06-20 13:24:52<br/>', NULL, 'PEDIDO DE REPUESTOS', '2023-06-20', '13:24:52', '2023-06-20 17:24:52', '2023-06-20 17:24:52'),
(150, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN PEDIDO DE REPUESTO', 'id: 3<br/>orden_id: 2<br/>created_at: 2023-06-20 13:24:52<br/>updated_at: 2023-06-20 13:24:52<br/>', 'id: 3<br/>orden_id: 2<br/>created_at: 2023-06-20 13:24:52<br/>updated_at: 2023-06-20 13:24:52<br/>', 'PEDIDO DE REPUESTOS', '2023-06-20', '13:42:49', '2023-06-20 17:42:49', '2023-06-20 17:42:49'),
(151, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN PEDIDO DE REPUESTO', 'id: 3<br/>orden_id: 2<br/>created_at: 2023-06-20 13:24:52<br/>updated_at: 2023-06-20 13:24:52<br/>', 'id: 3<br/>orden_id: 2<br/>created_at: 2023-06-20 13:24:52<br/>updated_at: 2023-06-20 13:24:52<br/>', 'PEDIDO DE REPUESTOS', '2023-06-20', '13:43:17', '2023-06-20 17:43:17', '2023-06-20 17:43:17'),
(152, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN PEDIDO DE REPUESTO', 'id: 3<br/>orden_id: 2<br/>created_at: 2023-06-20 13:24:52<br/>updated_at: 2023-06-20 13:24:52<br/>', 'id: 3<br/>orden_id: 2<br/>created_at: 2023-06-20 13:24:52<br/>updated_at: 2023-06-20 13:24:52<br/>', 'PEDIDO DE REPUESTOS', '2023-06-20', '13:43:48', '2023-06-20 17:43:48', '2023-06-20 17:43:48'),
(154, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN PEDIDO DE REPUESTO', 'id: 3<br/>orden_id: 2<br/>created_at: 2023-06-20 13:24:52<br/>updated_at: 2023-06-20 13:24:52<br/>', 'id: 3<br/>orden_id: 2<br/>created_at: 2023-06-20 13:24:52<br/>updated_at: 2023-06-20 13:24:52<br/>', 'PEDIDO DE REPUESTOS', '2023-06-20', '13:49:56', '2023-06-20 17:49:56', '2023-06-20 17:49:56'),
(155, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN PEDIDO DE REPUESTO', 'id: 3<br/>orden_id: 2<br/>created_at: 2023-06-20 13:24:52<br/>updated_at: 2023-06-20 13:24:52<br/>', 'id: 3<br/>orden_id: 2<br/>created_at: 2023-06-20 13:24:52<br/>updated_at: 2023-06-20 13:24:52<br/>', 'PEDIDO DE REPUESTOS', '2023-06-20', '13:50:05', '2023-06-20 17:50:05', '2023-06-20 17:50:05'),
(156, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PEDIDO DE REPUESTO', 'id: 4<br/>orden_id: 3<br/>created_at: 2023-06-20 13:51:54<br/>updated_at: 2023-06-20 13:51:54<br/>', NULL, 'PEDIDO DE REPUESTOS', '2023-06-20', '13:51:54', '2023-06-20 17:51:54', '2023-06-20 17:51:54'),
(157, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN PEDIDO DE REPUESTO', 'id: 4<br/>orden_id: 3<br/>created_at: 2023-06-20 13:51:54<br/>updated_at: 2023-06-20 13:51:54<br/>', 'id: 4<br/>orden_id: 3<br/>created_at: 2023-06-20 13:51:54<br/>updated_at: 2023-06-20 13:51:54<br/>', 'PEDIDO DE REPUESTOS', '2023-06-20', '13:52:03', '2023-06-20 17:52:03', '2023-06-20 17:52:03'),
(158, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN PEDIDO DE REPUESTO', 'id: 4<br/>orden_id: 3<br/>created_at: 2023-06-20 13:51:54<br/>updated_at: 2023-06-20 13:51:54<br/>', 'id: 4<br/>orden_id: 3<br/>created_at: 2023-06-20 13:51:54<br/>updated_at: 2023-06-20 13:51:54<br/>', 'PEDIDO DE REPUESTOS', '2023-06-20', '13:52:08', '2023-06-20 17:52:08', '2023-06-20 17:52:08'),
(159, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UN PEDIDO DE REPUESTO', 'id: 4<br/>orden_id: 3<br/>created_at: 2023-06-20 13:51:54<br/>updated_at: 2023-06-20 13:51:54<br/>', NULL, 'PEDIDO DE REPUESTOS', '2023-06-20', '13:52:19', '2023-06-20 17:52:19', '2023-06-20 17:52:19'),
(160, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA SUBUNIDAD', 'area_id: 1<br/>codigo: S003<br/>codigo2: S003-12<br/>created_at: 2023-06-20 15:24:28<br/>equipo_id: 1<br/>id: 4<br/>nombre: SUBUNIDAD 3<br/>numero: 12<br/>sistema_id: 1<br/>updated_at: 2023-06-20 15:24:28<br/>', NULL, 'SUBUNIDADES', '2023-06-20', '15:24:28', '2023-06-20 19:24:28', '2023-06-20 19:24:28'),
(161, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SISTEMA', 'area_id: 1<br/>codigo: S3<br/>created_at: 2023-06-20 15:26:32<br/>id: 4<br/>nombre: SISTEMA #3<br/>updated_at: 2023-06-20 15:26:32<br/>', NULL, 'SISTEMAS', '2023-06-20', '15:26:32', '2023-06-20 19:26:32', '2023-06-20 19:26:32'),
(162, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SISTEMA', 'area_id: 2<br/>codigo: S4<br/>created_at: 2023-06-20 15:26:41<br/>id: 5<br/>nombre: SISTEMA 4<br/>updated_at: 2023-06-20 15:26:41<br/>', NULL, 'SISTEMAS', '2023-06-20', '15:26:41', '2023-06-20 19:26:41', '2023-06-20 19:26:41'),
(163, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SISTEMA', 'area_id: 1<br/>codigo: E003<br/>codigo2: A1-S3-E003-33<br/>created_at: 2023-06-20 15:27:14<br/>id: 4<br/>nombre: EQUIPO #3<br/>numero: 33<br/>sistema_id: 4<br/>updated_at: 2023-06-20 15:27:14<br/>', NULL, 'SISTEMAS', '2023-06-20', '15:27:14', '2023-06-20 19:27:14', '2023-06-20 19:27:14'),
(164, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SISTEMA', 'area_id: 2<br/>codigo: E004<br/>codigo2: A2-S4-E004-44<br/>created_at: 2023-06-20 15:27:28<br/>id: 5<br/>nombre: EQUIPO #4<br/>numero: 44<br/>sistema_id: 5<br/>updated_at: 2023-06-20 15:27:28<br/>', NULL, 'SISTEMAS', '2023-06-20', '15:27:28', '2023-06-20 19:27:28', '2023-06-20 19:27:28'),
(165, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA SUBUNIDAD', 'area_id: 1<br/>codigo: 1001<br/>codigo2: 1001-01<br/>created_at: 2023-06-20 15:28:17<br/>equipo_id: 5<br/>id: 5<br/>nombre: BOMBA<br/>numero: 01<br/>sistema_id: 5<br/>updated_at: 2023-06-20 15:28:17<br/>', NULL, 'SUBUNIDADES', '2023-06-20', '15:28:17', '2023-06-20 19:28:17', '2023-06-20 19:28:17'),
(166, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA SUBUNIDAD', 'area_id: 1<br/>codigo: 1002<br/>codigo2: 1002-01<br/>created_at: 2023-06-20 15:29:24<br/>equipo_id: 4<br/>id: 6<br/>nombre: PRUEBA 2<br/>numero: 01<br/>sistema_id: 4<br/>updated_at: 2023-06-20 15:29:24<br/>', NULL, 'SUBUNIDADES', '2023-06-20', '15:29:24', '2023-06-20 19:29:24', '2023-06-20 19:29:24'),
(167, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN REPUESTO DE UNA ORDEN GENERADA', 'id: 1<br/>orden_generada_id: 1<br/>repuesto_id: 1<br/>cantidad_requerida: 5<br/>costo: 560.00<br/>total: 2800.00<br/>chekado: 0<br/>created_at: 2023-06-19 17:14:52<br/>updated_at: 2023-06-19 17:14:52<br/>', 'id: 1<br/>orden_generada_id: 1<br/>repuesto_id: 1<br/>cantidad_requerida: 5<br/>costo: 560.00<br/>total: 2800.00<br/>chekado: 1<br/>created_at: 2023-06-19 17:14:52<br/>updated_at: 2023-06-22 12:22:00<br/>', 'ORDEN GENERADA', '2023-06-22', '12:22:00', '2023-06-22 16:22:00', '2023-06-22 16:22:00'),
(168, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN REPUESTO DE UNA ORDEN GENERADA', 'id: 1<br/>orden_generada_id: 1<br/>repuesto_id: 1<br/>cantidad_requerida: 5<br/>costo: 560.00<br/>total: 2800.00<br/>chekado: 0<br/>created_at: 2023-06-19 17:14:52<br/>updated_at: 2023-06-22 12:22:00<br/>', 'id: 1<br/>orden_generada_id: 1<br/>repuesto_id: 1<br/>cantidad_requerida: 5<br/>costo: 560.00<br/>total: 2800.00<br/>chekado: 1<br/>created_at: 2023-06-19 17:14:52<br/>updated_at: 2023-06-22 12:24:59<br/>', 'ORDEN GENERADA', '2023-06-22', '12:24:59', '2023-06-22 16:24:59', '2023-06-22 16:24:59'),
(169, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN REPUESTO DE UNA ORDEN GENERADA', 'id: 2<br/>orden_generada_id: 1<br/>repuesto_id: 3<br/>cantidad_requerida: 3<br/>costo: 900.00<br/>total: 2700.00<br/>chekado: 0<br/>created_at: 2023-06-19 17:14:52<br/>updated_at: 2023-06-19 17:14:52<br/>', 'id: 2<br/>orden_generada_id: 1<br/>repuesto_id: 3<br/>cantidad_requerida: 3<br/>costo: 900.00<br/>total: 2700.00<br/>chekado: 1<br/>created_at: 2023-06-19 17:14:52<br/>updated_at: 2023-06-22 12:25:45<br/>', 'ORDEN GENERADA', '2023-06-22', '12:25:45', '2023-06-22 16:25:45', '2023-06-22 16:25:45'),
(170, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA HERRAMIENTA DE UNA ORDEN GENERADA', 'id: 1<br/>orden_generada_id: 1<br/>herramienta_id: 1<br/>cantidad_solicitada: 20<br/>costo: 1000.00<br/>total: 20000.00<br/>chekado: 0<br/>created_at: 2023-06-19 17:16:26<br/>updated_at: 2023-06-19 17:16:26<br/>', 'id: 1<br/>orden_generada_id: 1<br/>herramienta_id: 1<br/>cantidad_solicitada: 20<br/>costo: 1000.00<br/>total: 20000.00<br/>chekado: 1<br/>created_at: 2023-06-19 17:16:26<br/>updated_at: 2023-06-22 12:29:27<br/>', 'ORDEN GENERADA', '2023-06-22', '12:29:27', '2023-06-22 16:29:27', '2023-06-22 16:29:27'),
(171, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA HERRAMIENTA DE UNA ORDEN GENERADA', 'id: 1<br/>orden_generada_id: 1<br/>herramienta_id: 1<br/>cantidad_solicitada: 20<br/>costo: 1000.00<br/>total: 20000.00<br/>chekado: 1<br/>created_at: 2023-06-19 17:16:26<br/>updated_at: 2023-06-22 12:29:27<br/>', 'id: 1<br/>orden_generada_id: 1<br/>herramienta_id: 1<br/>cantidad_solicitada: 20<br/>costo: 1000.00<br/>total: 20000.00<br/>chekado: 0<br/>created_at: 2023-06-19 17:16:26<br/>updated_at: 2023-06-22 12:29:54<br/>', 'ORDEN GENERADA', '2023-06-22', '12:29:54', '2023-06-22 16:29:54', '2023-06-22 16:29:54'),
(172, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA HERRAMIENTA DE UNA ORDEN GENERADA', 'id: 1<br/>orden_generada_id: 1<br/>herramienta_id: 1<br/>cantidad_solicitada: 20<br/>costo: 1000.00<br/>total: 20000.00<br/>chekado: 0<br/>created_at: 2023-06-19 17:16:26<br/>updated_at: 2023-06-22 12:29:54<br/>', 'id: 1<br/>orden_generada_id: 1<br/>herramienta_id: 1<br/>cantidad_solicitada: 20<br/>costo: 1000.00<br/>total: 20000.00<br/>chekado: 1<br/>created_at: 2023-06-19 17:16:26<br/>updated_at: 2023-06-22 12:31:16<br/>', 'ORDEN GENERADA', '2023-06-22', '12:31:16', '2023-06-22 16:31:16', '2023-06-22 16:31:16'),
(173, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA HERRAMIENTA DE UNA ORDEN GENERADA', 'id: 1<br/>orden_generada_id: 1<br/>herramienta_id: 1<br/>cantidad_solicitada: 20<br/>costo: 1000.00<br/>total: 20000.00<br/>chekado: 1<br/>created_at: 2023-06-19 17:16:26<br/>updated_at: 2023-06-22 12:31:16<br/>', 'id: 1<br/>orden_generada_id: 1<br/>herramienta_id: 1<br/>cantidad_solicitada: 20<br/>costo: 1000.00<br/>total: 20000.00<br/>chekado: 0<br/>created_at: 2023-06-19 17:16:26<br/>updated_at: 2023-06-22 12:31:58<br/>', 'ORDEN GENERADA', '2023-06-22', '12:31:58', '2023-06-22 16:31:58', '2023-06-22 16:31:58'),
(174, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA HERRAMIENTA DE UNA ORDEN GENERADA', 'id: 1<br/>orden_generada_id: 1<br/>herramienta_id: 1<br/>cantidad_solicitada: 20<br/>costo: 1000.00<br/>total: 20000.00<br/>chekado: 0<br/>created_at: 2023-06-19 17:16:26<br/>updated_at: 2023-06-22 12:31:58<br/>', 'id: 1<br/>orden_generada_id: 1<br/>herramienta_id: 1<br/>cantidad_solicitada: 20<br/>costo: 1000.00<br/>total: 20000.00<br/>chekado: 1<br/>created_at: 2023-06-19 17:16:26<br/>updated_at: 2023-06-22 12:33:07<br/>', 'ORDEN GENERADA', '2023-06-22', '12:33:07', '2023-06-22 16:33:07', '2023-06-22 16:33:07'),
(175, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA HERRAMIENTA DE UNA ORDEN GENERADA', 'id: 1<br/>orden_generada_id: 1<br/>herramienta_id: 1<br/>cantidad_solicitada: 20<br/>costo: 1000.00<br/>total: 20000.00<br/>chekado: 1<br/>created_at: 2023-06-19 17:16:26<br/>updated_at: 2023-06-22 12:33:07<br/>', 'id: 1<br/>orden_generada_id: 1<br/>herramienta_id: 1<br/>cantidad_solicitada: 20<br/>costo: 1000.00<br/>total: 20000.00<br/>chekado: 0<br/>created_at: 2023-06-19 17:16:26<br/>updated_at: 2023-06-22 12:41:40<br/>', 'ORDEN GENERADA', '2023-06-22', '12:41:40', '2023-06-22 16:41:40', '2023-06-22 16:41:40'),
(176, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA HERRAMIENTA DE UNA ORDEN GENERADA', 'id: 1<br/>orden_generada_id: 1<br/>herramienta_id: 1<br/>cantidad_solicitada: 20<br/>costo: 1000.00<br/>total: 20000.00<br/>chekado: 0<br/>created_at: 2023-06-19 17:16:26<br/>updated_at: 2023-06-22 12:41:40<br/>', 'id: 1<br/>orden_generada_id: 1<br/>herramienta_id: 1<br/>cantidad_solicitada: 20<br/>costo: 1000.00<br/>total: 20000.00<br/>chekado: 1<br/>created_at: 2023-06-19 17:16:26<br/>updated_at: 2023-06-22 12:44:20<br/>', 'ORDEN GENERADA', '2023-06-22', '12:44:20', '2023-06-22 16:44:20', '2023-06-22 16:44:20'),
(177, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA HERRAMIENTA DE UNA ORDEN GENERADA', 'id: 1<br/>orden_generada_id: 1<br/>herramienta_id: 1<br/>cantidad_solicitada: 20<br/>costo: 1000.00<br/>total: 20000.00<br/>chekado: 1<br/>created_at: 2023-06-19 17:16:26<br/>updated_at: 2023-06-22 12:44:20<br/>', 'id: 1<br/>orden_generada_id: 1<br/>herramienta_id: 1<br/>cantidad_solicitada: 20<br/>costo: 1000.00<br/>total: 20000.00<br/>chekado: 0<br/>created_at: 2023-06-19 17:16:26<br/>updated_at: 2023-06-22 12:45:04<br/>', 'ORDEN GENERADA', '2023-06-22', '12:45:04', '2023-06-22 16:45:04', '2023-06-22 16:45:04'),
(178, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA HERRAMIENTA DE UNA ORDEN GENERADA', 'id: 1<br/>orden_generada_id: 1<br/>herramienta_id: 1<br/>cantidad_solicitada: 20<br/>costo: 1000.00<br/>total: 20000.00<br/>chekado: 0<br/>created_at: 2023-06-19 17:16:26<br/>updated_at: 2023-06-22 12:45:04<br/>', 'id: 1<br/>orden_generada_id: 1<br/>herramienta_id: 1<br/>cantidad_solicitada: 20<br/>costo: 1000.00<br/>total: 20000.00<br/>chekado: 1<br/>created_at: 2023-06-19 17:16:26<br/>updated_at: 2023-06-22 12:45:16<br/>', 'ORDEN GENERADA', '2023-06-22', '12:45:16', '2023-06-22 16:45:16', '2023-06-22 16:45:16'),
(179, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA HERRAMIENTA DE UNA ORDEN GENERADA', 'id: 1<br/>orden_generada_id: 1<br/>herramienta_id: 1<br/>cantidad_solicitada: 20<br/>costo: 1000.00<br/>total: 20000.00<br/>chekado: 1<br/>created_at: 2023-06-19 17:16:26<br/>updated_at: 2023-06-22 12:45:16<br/>', 'id: 1<br/>orden_generada_id: 1<br/>herramienta_id: 1<br/>cantidad_solicitada: 20<br/>costo: 1000.00<br/>total: 20000.00<br/>chekado: 0<br/>created_at: 2023-06-19 17:16:26<br/>updated_at: 2023-06-22 12:45:34<br/>', 'ORDEN GENERADA', '2023-06-22', '12:45:34', '2023-06-22 16:45:34', '2023-06-22 16:45:34'),
(180, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA HERRAMIENTA DE UNA ORDEN GENERADA', 'id: 1<br/>orden_generada_id: 1<br/>herramienta_id: 1<br/>cantidad_solicitada: 20<br/>costo: 1000.00<br/>total: 20000.00<br/>chekado: 0<br/>created_at: 2023-06-19 17:16:26<br/>updated_at: 2023-06-22 12:45:34<br/>', 'id: 1<br/>orden_generada_id: 1<br/>herramienta_id: 1<br/>cantidad_solicitada: 20<br/>costo: 1000.00<br/>total: 20000.00<br/>chekado: 1<br/>created_at: 2023-06-19 17:16:26<br/>updated_at: 2023-06-22 12:46:07<br/>', 'ORDEN GENERADA', '2023-06-22', '12:46:07', '2023-06-22 16:46:07', '2023-06-22 16:46:07'),
(181, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA HERRAMIENTA DE UNA ORDEN GENERADA', 'id: 1<br/>orden_generada_id: 1<br/>herramienta_id: 1<br/>cantidad_solicitada: 20<br/>costo: 1000.00<br/>total: 20000.00<br/>chekado: 1<br/>created_at: 2023-06-19 17:16:26<br/>updated_at: 2023-06-22 12:46:07<br/>', 'id: 1<br/>orden_generada_id: 1<br/>herramienta_id: 1<br/>cantidad_solicitada: 20<br/>costo: 1000.00<br/>total: 20000.00<br/>chekado: 0<br/>created_at: 2023-06-19 17:16:26<br/>updated_at: 2023-06-22 12:48:26<br/>', 'ORDEN GENERADA', '2023-06-22', '12:48:26', '2023-06-22 16:48:26', '2023-06-22 16:48:26'),
(182, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA HERRAMIENTA DE UNA ORDEN GENERADA', 'id: 1<br/>orden_generada_id: 1<br/>herramienta_id: 1<br/>cantidad_solicitada: 20<br/>costo: 1000.00<br/>total: 20000.00<br/>chekado: 0<br/>created_at: 2023-06-19 17:16:26<br/>updated_at: 2023-06-22 12:48:26<br/>', 'id: 1<br/>orden_generada_id: 1<br/>herramienta_id: 1<br/>cantidad_solicitada: 20<br/>costo: 1000.00<br/>total: 20000.00<br/>chekado: 1<br/>created_at: 2023-06-19 17:16:26<br/>updated_at: 2023-06-22 12:49:26<br/>', 'ORDEN GENERADA', '2023-06-22', '12:49:26', '2023-06-22 16:49:26', '2023-06-22 16:49:26'),
(183, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA HERRAMIENTA DE UNA ORDEN GENERADA', 'id: 1<br/>orden_generada_id: 1<br/>herramienta_id: 1<br/>cantidad_solicitada: 20<br/>costo: 1000.00<br/>total: 20000.00<br/>chekado: 0<br/>created_at: 2023-06-19 17:16:26<br/>updated_at: 2023-06-22 12:50:37<br/>', 'id: 1<br/>orden_generada_id: 1<br/>herramienta_id: 1<br/>cantidad_solicitada: 20<br/>costo: 1000.00<br/>total: 20000.00<br/>chekado: 1<br/>created_at: 2023-06-19 17:16:26<br/>updated_at: 2023-06-22 12:52:01<br/>', 'ORDEN GENERADA', '2023-06-22', '12:52:01', '2023-06-22 16:52:01', '2023-06-22 16:52:01'),
(184, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA TAREA DE MANTENIMIENTO', 'id: 1<br/>gama_id: 2<br/>tarea: TAREA 1<br/>tiempo: 7<br/>chekado: 0<br/>created_at: 2023-06-13 12:37:24<br/>updated_at: 2023-06-13 12:42:43<br/>', 'id: 1<br/>gama_id: 2<br/>tarea: TAREA 1<br/>tiempo: 7<br/>chekado: 1<br/>created_at: 2023-06-13 12:37:24<br/>updated_at: 2023-06-22 12:53:52<br/>', 'GAMA DE MANTENIMIENTOS', '2023-06-22', '12:53:52', '2023-06-22 16:53:52', '2023-06-22 16:53:52'),
(185, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA TAREA DE MANTENIMIENTO', 'id: 3<br/>gama_id: 2<br/>tarea: NUEVA TAREA 2<br/>tiempo: 10<br/>chekado: 0<br/>created_at: 2023-06-13 12:43:34<br/>updated_at: 2023-06-13 12:43:34<br/>', 'id: 3<br/>gama_id: 2<br/>tarea: NUEVA TAREA 2<br/>tiempo: 10<br/>chekado: 1<br/>created_at: 2023-06-13 12:43:34<br/>updated_at: 2023-06-22 12:53:54<br/>', 'GAMA DE MANTENIMIENTOS', '2023-06-22', '12:53:54', '2023-06-22 16:53:54', '2023-06-22 16:53:54'),
(186, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN PERSONAL DE UNA ORDEN GENERADA', 'id: 3<br/>orden_generada_id: 1<br/>personal_id: 1<br/>costo: 50.00<br/>chekado: 0<br/>created_at: 2023-06-19 17:55:15<br/>updated_at: 2023-06-19 17:55:15<br/>', 'id: 3<br/>orden_generada_id: 1<br/>personal_id: 1<br/>costo: 50.00<br/>chekado: 1<br/>created_at: 2023-06-19 17:55:15<br/>updated_at: 2023-06-22 12:54:03<br/>', 'ORDEN GENERADA', '2023-06-22', '12:54:03', '2023-06-22 16:54:03', '2023-06-22 16:54:03'),
(187, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN PERSONAL DE UNA ORDEN GENERADA', 'id: 4<br/>orden_generada_id: 1<br/>personal_id: 3<br/>costo: 40.00<br/>chekado: 0<br/>created_at: 2023-06-19 17:55:15<br/>updated_at: 2023-06-19 17:55:15<br/>', 'id: 4<br/>orden_generada_id: 1<br/>personal_id: 3<br/>costo: 40.00<br/>chekado: 1<br/>created_at: 2023-06-19 17:55:15<br/>updated_at: 2023-06-22 12:54:04<br/>', 'ORDEN GENERADA', '2023-06-22', '12:54:04', '2023-06-22 16:54:04', '2023-06-22 16:54:04'),
(188, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN REPUESTO DE UNA ORDEN GENERADA', 'cantidad_requerida: 5<br/>chekado: 0<br/>costo: 560.00<br/>created_at: 2023-06-19 19:16:15<br/>id: 3<br/>orden_generada_id: 2<br/>repuesto_id: 1<br/>total: 2800.00<br/>updated_at: 2023-06-19 19:16:15<br/>', 'cantidad_requerida: 5<br/>chekado: 1<br/>costo: 560.00<br/>created_at: 2023-06-19 19:16:15<br/>id: 3<br/>orden_generada_id: 2<br/>repuesto_id: 1<br/>total: 2800.00<br/>updated_at: 2023-06-22 15:43:02<br/>', 'ORDEN GENERADA', '2023-06-22', '15:43:02', '2023-06-22 19:43:02', '2023-06-22 19:43:02'),
(189, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN PLAN DE MANTENIMIENTO', 'codificacion: PM001HHH3<br/>created_at: 2023-06-14 17:32:31<br/>dias: 10<br/>estado: PLANIFICADO<br/>fecha_final: 2023-05-31<br/>frecuencia_id: 1<br/>gama_id: 2<br/>id: 2<br/>pm: PM<br/>prioridad: URGENTE<br/>programacion: ÚLTIMA VEZ QUE SE PROGRAMÓ<br/>subunidad_id: 1<br/>tiempo: 17<br/>tipo_mantenimiento: PREVENTIVO<br/>ultima_fecha_programada: 2023-05-01<br/>ultima_fecha_terminada: 2023-05-05<br/>updated_at: 2023-06-14 17:32:31<br/>variable_control_id: 1<br/>', 'codificacion: PM001HHH3<br/>created_at: 2023-06-14 17:32:31<br/>dias: 10<br/>estado: PLANIFICADO<br/>fecha_final: 2023-07-31<br/>frecuencia_id: 1<br/>gama_id: 2<br/>id: 2<br/>pm: PM<br/>prioridad: URGENTE<br/>programacion: ÚLTIMA VEZ QUE SE PROGRAMÓ<br/>subunidad_id: 1<br/>tiempo: 17<br/>tipo_mantenimiento: PREVENTIVO<br/>ultima_fecha_programada: 2023-07-01<br/>ultima_fecha_terminada: 2023-07-31<br/>updated_at: 2023-06-22 16:36:33<br/>variable_control_id: 1<br/>', 'PLAN DE MANTENIMIENTO', '2023-06-22', '16:36:33', '2023-06-22 20:36:33', '2023-06-22 20:36:33'),
(190, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ EL ESTADO DE UNA ORDEN DE TRABAJO', 'comentario: <br/>created_at: 2023-06-15 11:26:58<br/>dias: 7<br/>estado: PROGRAMADO<br/>fecha_programada: 2023-06-15<br/>gama_id: 2<br/>id: 2<br/>prioridad: URGENTE<br/>razon: <br/>subunidad_id: 1<br/>tiempo: 17<br/>tipo_mantenimiento: PREDICTIVO<br/>updated_at: 2023-06-22 16:33:58<br/>', 'comentario: COMENTARIO<br/>created_at: 2023-06-15 11:26:58<br/>dias: 7<br/>estado: INICIADO<br/>fecha_programada: 2023-06-15<br/>gama_id: 2<br/>id: 2<br/>prioridad: URGENTE<br/>razon: PRUEBA RAZON CAMBIO DE ESTADO #1<br/>subunidad_id: 1<br/>tiempo: 17<br/>tipo_mantenimiento: PREDICTIVO<br/>updated_at: 2023-06-22 16:59:38<br/>', 'ORDENES DE TRABAJO', '2023-06-22', '16:59:38', '2023-06-22 20:59:38', '2023-06-22 20:59:38'),
(192, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ EL ESTADO DE UNA ORDEN DE TRABAJO', 'comentario: COMENTARIO<br/>created_at: 2023-06-15 11:26:58<br/>dias: 7<br/>estado: PROGRAMADO<br/>fecha_programada: 2023-06-15<br/>gama_id: 2<br/>id: 2<br/>prioridad: URGENTE<br/>razon: PRUEBA RAZON CAMBIO DE ESTADO #1<br/>subunidad_id: 1<br/>tiempo: 17<br/>tipo_mantenimiento: PREDICTIVO<br/>updated_at: 2023-06-22 16:59:38<br/>', 'comentario: COMENTARIO<br/>created_at: 2023-06-15 11:26:58<br/>dias: 7<br/>estado: INICIADO<br/>fecha_programada: 2023-06-15<br/>gama_id: 2<br/>id: 2<br/>prioridad: URGENTE<br/>razon: PRUEBA #2 CAMBIO DE ESTADO<br/>subunidad_id: 1<br/>tiempo: 17<br/>tipo_mantenimiento: PREDICTIVO<br/>updated_at: 2023-06-22 17:05:05<br/>', 'ORDENES DE TRABAJO', '2023-06-22', '17:05:05', '2023-06-22 21:05:05', '2023-06-22 21:05:05'),
(193, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ EL ESTADO DE UNA ORDEN DE TRABAJO', 'comentario: COMENTARIO<br/>created_at: 2023-06-15 11:26:58<br/>dias: 7<br/>estado: PROGRAMADO<br/>fecha_inicio: <br/>fecha_programada: 2023-06-15<br/>fecha_termino: <br/>gama_id: 2<br/>hora_inicio: <br/>hora_termino: <br/>id: 2<br/>parada_maquina: <br/>prioridad: URGENTE<br/>razon: PRUEBA #2 CAMBIO DE ESTADO<br/>subunidad_id: 1<br/>tiempo: 17<br/>tiempo_ejecucion: <br/>tipo_mantenimiento: PREDICTIVO<br/>updated_at: 2023-06-22 17:05:05<br/>', 'comentario: COMENTARIO<br/>created_at: 2023-06-15 11:26:58<br/>dias: 7<br/>estado: INICIADO<br/>fecha_inicio: 2023-06-22<br/>fecha_programada: 2023-06-15<br/>fecha_termino: <br/>gama_id: 2<br/>hora_inicio: 17:41<br/>hora_termino: <br/>id: 2<br/>parada_maquina: <br/>prioridad: URGENTE<br/>razon: PRUEBA INICIO #1<br/>subunidad_id: 1<br/>tiempo: 17<br/>tiempo_ejecucion: <br/>tipo_mantenimiento: PREDICTIVO<br/>updated_at: 2023-06-22 17:41:37<br/>', 'ORDENES DE TRABAJO', '2023-06-22', '17:41:37', '2023-06-22 21:41:37', '2023-06-22 21:41:37'),
(194, 1, 'MODIFICACIÓN', 'EL USUARIO admin TERMINÓ UNA ORDEN DE TRABAJO', 'comentario: COMENTARIO<br/>created_at: 2023-06-15 11:26:58<br/>dias: 7<br/>estado: INICIADO<br/>fecha_inicio: 2023-06-22<br/>fecha_programada: 2023-06-15<br/>fecha_termino: <br/>gama_id: 2<br/>hora_inicio: 17:41:00<br/>hora_termino: <br/>id: 2<br/>parada_maquina: <br/>prioridad: URGENTE<br/>razon: PRUEBA INICIO #1<br/>subunidad_id: 1<br/>tiempo: 17<br/>tiempo_ejecucion: <br/>tipo_mantenimiento: PREDICTIVO<br/>updated_at: 2023-06-22 17:41:37<br/>', 'comentario: COMENTARIO<br/>created_at: 2023-06-15 11:26:58<br/>dias: 7<br/>estado: TERMINADO<br/>fecha_inicio: 2023-06-22<br/>fecha_programada: 2023-06-15<br/>fecha_termino: 2023-06-23<br/>gama_id: 2<br/>hora_inicio: 17:41:00<br/>hora_termino: 12:28<br/>id: 2<br/>parada_maquina: SI<br/>prioridad: URGENTE<br/>razon: PRUEBA TERMINO OT<br/>subunidad_id: 1<br/>tiempo: 17<br/>tiempo_ejecucion: 18<br/>tipo_mantenimiento: PREDICTIVO<br/>updated_at: 2023-06-23 12:29:40<br/>', 'ORDENES DE TRABAJO', '2023-06-23', '12:29:40', '2023-06-23 16:29:40', '2023-06-23 16:29:40'),
(195, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN REPUESTOS/INSUMO', 'codificacion: MNH002JJ<br/>codigo: GM002<br/>created_at: 2023-06-23 12:49:17<br/>descripcion: GAMA #2<br/>equipo_id: 4<br/>id: 3<br/>subfamilia_id: 1<br/>updated_at: 2023-06-23 12:49:17<br/>', NULL, 'REPUESTOS/INSUMOS', '2023-06-23', '12:49:17', '2023-06-23 16:49:17', '2023-06-23 16:49:17'),
(196, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PLAN DE MANTENIMIENTO', 'codificacion: PM0002UU<br/>created_at: 2023-06-23 12:50:09<br/>dias: 3<br/>estado: PLANIFICADO<br/>fecha_final: 2023-07-31<br/>frecuencia_id: 1<br/>gama_id: 3<br/>id: 3<br/>pm: PM<br/>prioridad: MODERADO<br/>programacion: ÚLTIMA VEZ QUE SE TERMINÓ<br/>subunidad_id: 2<br/>tiempo: 360<br/>tipo_mantenimiento: PREVENTIVO<br/>ultima_fecha_programada: 2023-07-01<br/>ultima_fecha_terminada: 2023-07-05<br/>updated_at: 2023-06-23 12:50:09<br/>variable_control_id: 1<br/>', NULL, 'PLAN DE MANTENIMIENTO', '2023-06-23', '12:50:09', '2023-06-23 16:50:09', '2023-06-23 16:50:09'),
(197, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA ORDEN DE TRABAJO', 'comentario: <br/>created_at: 2023-06-23 12:50:32<br/>dias: 3<br/>estado: PROGRAMADO<br/>fecha_inicio: <br/>fecha_programada: 2023-06-23<br/>fecha_termino: <br/>gama_id: 3<br/>hora_inicio: <br/>hora_termino: <br/>id: 4<br/>parada_maquina: <br/>prioridad: MODERADA<br/>razon: <br/>subunidad_id: 4<br/>tiempo: 360<br/>tiempo_ejecucion: <br/>tipo_mantenimiento: PREVENTIVO<br/>updated_at: 2023-06-23 12:50:32<br/>', NULL, 'ORDENES DE TRABAJO', '2023-06-23', '12:50:32', '2023-06-23 16:50:32', '2023-06-23 16:50:32'),
(198, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ LA FECHA DE PROGRAMACIÓN DE UNA ORDEN DE TRABAJO', 'id: 4<br/>fecha_programada: 2023-06-23<br/>subunidad_id: 4<br/>gama_id: 3<br/>prioridad: MODERADA<br/>tiempo: 360<br/>dias: 3<br/>tipo_mantenimiento: PREVENTIVO<br/>fecha_inicio: <br/>hora_inicio: <br/>fecha_termino: <br/>hora_termino: <br/>tiempo_ejecucion: <br/>parada_maquina: <br/>estado: PROGRAMADO<br/>razon: <br/>comentario: <br/>created_at: 2023-06-23 12:50:32<br/>updated_at: 2023-06-23 12:50:32<br/>', 'id: 4<br/>fecha_programada: 2023-06-22<br/>subunidad_id: 4<br/>gama_id: 3<br/>prioridad: MODERADA<br/>tiempo: 360<br/>dias: 3<br/>tipo_mantenimiento: PREVENTIVO<br/>fecha_inicio: <br/>hora_inicio: <br/>fecha_termino: <br/>hora_termino: <br/>tiempo_ejecucion: <br/>parada_maquina: <br/>estado: PROGRAMADO<br/>razon: <br/>comentario: <br/>created_at: 2023-06-23 12:50:32<br/>updated_at: 2023-06-26 13:01:26<br/>', 'ORDENES DE TRABAJO', '2023-06-26', '13:01:26', '2023-06-26 17:01:26', '2023-06-26 17:01:26'),
(199, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ LA FECHA DE PROGRAMACIÓN DE UNA ORDEN DE TRABAJO', 'id: 4<br/>fecha_programada: 2023-06-22<br/>subunidad_id: 4<br/>gama_id: 3<br/>prioridad: MODERADA<br/>tiempo: 360<br/>dias: 3<br/>tipo_mantenimiento: PREVENTIVO<br/>fecha_inicio: <br/>hora_inicio: <br/>fecha_termino: <br/>hora_termino: <br/>tiempo_ejecucion: <br/>parada_maquina: <br/>estado: PROGRAMADO<br/>razon: <br/>comentario: <br/>created_at: 2023-06-23 12:50:32<br/>updated_at: 2023-06-26 13:01:26<br/>', 'id: 4<br/>fecha_programada: 2023-06-30<br/>subunidad_id: 4<br/>gama_id: 3<br/>prioridad: MODERADA<br/>tiempo: 360<br/>dias: 3<br/>tipo_mantenimiento: PREVENTIVO<br/>fecha_inicio: <br/>hora_inicio: <br/>fecha_termino: <br/>hora_termino: <br/>tiempo_ejecucion: <br/>parada_maquina: <br/>estado: PROGRAMADO<br/>razon: <br/>comentario: <br/>created_at: 2023-06-23 12:50:32<br/>updated_at: 2023-06-26 13:15:13<br/>', 'ORDENES DE TRABAJO', '2023-06-26', '13:15:13', '2023-06-26 17:15:13', '2023-06-26 17:15:13'),
(200, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PEDIDO DE REPUESTO', 'id: 5<br/>orden_id: 3<br/>created_at: 2023-06-27 11:32:47<br/>updated_at: 2023-06-27 11:32:47<br/>', NULL, 'PEDIDO DE REPUESTOS', '2023-06-27', '11:32:47', '2023-06-27 15:32:47', '2023-06-27 15:32:47'),
(201, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UN PEDIDO DE REPUESTO', 'id: 5<br/>orden_id: 3<br/>created_at: 2023-06-27 11:32:47<br/>updated_at: 2023-06-27 11:32:47<br/>', NULL, 'PEDIDO DE REPUESTOS', '2023-06-27', '11:32:54', '2023-06-27 15:32:54', '2023-06-27 15:32:54'),
(202, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN HISTORIAL DE TIEMPO', 'id: 1<br/>anio: 2023<br/>mes: 05<br/>equipo_id: 1<br/>codificacion: HT0001MM<br/>total_tiempo: 11348<br/>created_at: 2023-06-27 12:36:32<br/>updated_at: 2023-06-27 12:36:32<br/>', NULL, 'HISTORIAL DE TIEMPOS', '2023-06-27', '12:36:32', '2023-06-27 16:36:32', '2023-06-27 16:36:32'),
(203, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN HISTORIAL DE TIEMPO', 'id: 1<br/>anio: 2023<br/>mes: 05<br/>equipo_id: 1<br/>codificacion: HT0001MM<br/>total_tiempo: 11348<br/>created_at: 2023-06-27 12:36:32<br/>updated_at: 2023-06-27 12:36:32<br/>', 'id: 1<br/>anio: 2023<br/>mes: 05<br/>equipo_id: 1<br/>codificacion: HT0001MM<br/>total_tiempo: 11310<br/>created_at: 2023-06-27 12:36:32<br/>updated_at: 2023-06-27 12:42:00<br/>', 'HISTORIAL DE TIEMPOS', '2023-06-27', '12:42:00', '2023-06-27 16:42:00', '2023-06-27 16:42:00'),
(204, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN HISTORIAL DE TIEMPO', 'id: 1<br/>anio: 2023<br/>mes: 05<br/>equipo_id: 1<br/>codificacion: HT0001MM<br/>total_tiempo: 11310<br/>created_at: 2023-06-27 12:36:32<br/>updated_at: 2023-06-27 12:42:00<br/>', 'id: 1<br/>anio: 2023<br/>mes: 05<br/>equipo_id: 1<br/>codificacion: HT0001MM<br/>total_tiempo: 11310<br/>created_at: 2023-06-27 12:36:32<br/>updated_at: 2023-06-27 12:42:00<br/>', 'HISTORIAL DE TIEMPOS', '2023-06-27', '12:45:31', '2023-06-27 16:45:31', '2023-06-27 16:45:31'),
(205, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN HISTORIAL DE TIEMPO', 'id: 1<br/>anio: 2023<br/>mes: 05<br/>equipo_id: 1<br/>codificacion: HT0001MM<br/>total_tiempo: 11310<br/>created_at: 2023-06-27 12:36:32<br/>updated_at: 2023-06-27 12:42:00<br/>', 'id: 1<br/>anio: 2023<br/>mes: 05<br/>equipo_id: 1<br/>codificacion: HT0001MM<br/>total_tiempo: 11310<br/>created_at: 2023-06-27 12:36:32<br/>updated_at: 2023-06-27 12:42:00<br/>', 'HISTORIAL DE TIEMPOS', '2023-06-27', '12:48:13', '2023-06-27 16:48:13', '2023-06-27 16:48:13'),
(206, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN HISTORIAL DE TIEMPO', 'id: 1<br/>anio: 2023<br/>mes: 05<br/>equipo_id: 1<br/>codificacion: HT0001MM<br/>total_tiempo: 11310<br/>created_at: 2023-06-27 12:36:32<br/>updated_at: 2023-06-27 12:42:00<br/>', 'id: 1<br/>anio: 2023<br/>mes: 05<br/>equipo_id: 1<br/>codificacion: HT0001MM<br/>total_tiempo: 11310<br/>created_at: 2023-06-27 12:36:32<br/>updated_at: 2023-06-27 12:42:00<br/>', 'HISTORIAL DE TIEMPOS', '2023-06-27', '12:49:33', '2023-06-27 16:49:33', '2023-06-27 16:49:33'),
(207, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN HISTORIAL DE TIEMPO', 'id: 1<br/>anio: 2023<br/>mes: 05<br/>equipo_id: 1<br/>codificacion: HT0001MM<br/>total_tiempo: 11310<br/>created_at: 2023-06-27 12:36:32<br/>updated_at: 2023-06-27 12:42:00<br/>', 'id: 1<br/>anio: 2023<br/>mes: 05<br/>equipo_id: 1<br/>codificacion: HT0001MM<br/>total_tiempo: 11310<br/>created_at: 2023-06-27 12:36:32<br/>updated_at: 2023-06-27 12:42:00<br/>', 'HISTORIAL DE TIEMPOS', '2023-06-27', '12:49:37', '2023-06-27 16:49:37', '2023-06-27 16:49:37'),
(208, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN HISTORIAL DE TIEMPO', 'id: 1<br/>anio: 2023<br/>mes: 05<br/>equipo_id: 1<br/>codificacion: HT0001MM<br/>total_tiempo: 11310<br/>created_at: 2023-06-27 12:36:32<br/>updated_at: 2023-06-27 12:42:00<br/>', 'id: 1<br/>anio: 2023<br/>mes: 05<br/>equipo_id: 1<br/>codificacion: HT0001MM<br/>total_tiempo: 11310<br/>created_at: 2023-06-27 12:36:32<br/>updated_at: 2023-06-27 12:42:00<br/>', 'HISTORIAL DE TIEMPOS', '2023-06-27', '12:50:21', '2023-06-27 16:50:21', '2023-06-27 16:50:21'),
(209, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN HISTORIAL DE TIEMPO', 'id: 1<br/>anio: 2023<br/>mes: 05<br/>equipo_id: 1<br/>codificacion: HT0001MM<br/>total_tiempo: 11310<br/>created_at: 2023-06-27 12:36:32<br/>updated_at: 2023-06-27 12:42:00<br/>', 'id: 1<br/>anio: 2023<br/>mes: 05<br/>equipo_id: 1<br/>codificacion: HT0001MM<br/>total_tiempo: 11310<br/>created_at: 2023-06-27 12:36:32<br/>updated_at: 2023-06-27 12:42:00<br/>', 'HISTORIAL DE TIEMPOS', '2023-06-27', '12:51:32', '2023-06-27 16:51:32', '2023-06-27 16:51:32'),
(210, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN HISTORIAL DE TIEMPO', 'id: 1<br/>anio: 2023<br/>mes: 05<br/>equipo_id: 1<br/>codificacion: HT0001MM<br/>total_tiempo: 11310<br/>created_at: 2023-06-27 12:36:32<br/>updated_at: 2023-06-27 12:42:00<br/>', 'id: 1<br/>anio: 2023<br/>mes: 05<br/>equipo_id: 1<br/>codificacion: HT0001MM<br/>total_tiempo: 11310<br/>created_at: 2023-06-27 12:36:32<br/>updated_at: 2023-06-27 12:42:00<br/>', 'HISTORIAL DE TIEMPOS', '2023-06-27', '12:51:55', '2023-06-27 16:51:55', '2023-06-27 16:51:55'),
(211, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN HISTORIAL DE TIEMPO', 'id: 8<br/>anio: 2023<br/>mes: 05<br/>equipo_id: 2<br/>codificacion: HT0002MM<br/>total_tiempo: 12090<br/>created_at: 2023-06-27 12:57:33<br/>updated_at: 2023-06-27 12:57:33<br/>', NULL, 'HISTORIAL DE TIEMPOS', '2023-06-27', '12:57:33', '2023-06-27 16:57:33', '2023-06-27 16:57:33'),
(212, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN HISTORIAL DE TIEMPO', 'id: 1<br/>anio: 2023<br/>mes: 05<br/>equipo_id: 1<br/>codificacion: HT0001MM<br/>total_tiempo: 11310<br/>created_at: 2023-06-27 12:36:32<br/>updated_at: 2023-06-27 12:42:00<br/>', 'id: 1<br/>anio: 2023<br/>mes: 05<br/>equipo_id: 1<br/>codificacion: HT0001MM<br/>total_tiempo: 11310<br/>created_at: 2023-06-27 12:36:32<br/>updated_at: 2023-06-27 12:42:00<br/>', 'HISTORIAL DE TIEMPOS', '2023-06-27', '13:00:35', '2023-06-27 17:00:35', '2023-06-27 17:00:35'),
(213, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN HISTORIAL DE TIEMPO', 'id: 1<br/>anio: 2023<br/>mes: 05<br/>equipo_id: 1<br/>codificacion: HT0001MM<br/>total_tiempo: 11310<br/>created_at: 2023-06-27 12:36:32<br/>updated_at: 2023-06-27 12:42:00<br/>', 'id: 1<br/>anio: 2023<br/>mes: 05<br/>equipo_id: 1<br/>codificacion: HT0001MM<br/>total_tiempo: 11310<br/>created_at: 2023-06-27 12:36:32<br/>updated_at: 2023-06-27 12:42:00<br/>', 'HISTORIAL DE TIEMPOS', '2023-06-27', '13:01:34', '2023-06-27 17:01:34', '2023-06-27 17:01:34'),
(214, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN HISTORIAL DE TIEMPO', 'id: 1<br/>anio: 2023<br/>mes: 05<br/>equipo_id: 1<br/>codificacion: HT0001MM<br/>total_tiempo: 11310<br/>created_at: 2023-06-27 12:36:32<br/>updated_at: 2023-06-27 12:42:00<br/>', 'id: 1<br/>anio: 2023<br/>mes: 05<br/>equipo_id: 1<br/>codificacion: HT0001MM<br/>total_tiempo: 11310<br/>created_at: 2023-06-27 12:36:32<br/>updated_at: 2023-06-27 12:42:00<br/>', 'HISTORIAL DE TIEMPOS', '2023-06-27', '13:01:46', '2023-06-27 17:01:46', '2023-06-27 17:01:46'),
(215, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN HISTORIAL DE TIEMPO', 'anio: 2023<br/>codificacion: HD0001PP<br/>created_at: 2023-06-28 11:38:08<br/>equipo_id: 1<br/>id: 1<br/>mes: 1<br/>total_tiempo: 12090<br/>updated_at: 2023-06-28 11:38:08<br/>', NULL, 'HISTORIAL DE TIEMPOS', '2023-06-28', '11:38:08', '2023-06-28 15:38:08', '2023-06-28 15:38:08'),
(216, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN HISTORIAL DE TIEMPO', 'anio: 2023<br/>codificacion: TD00002<br/>created_at: 2023-06-28 11:39:12<br/>equipo_id: 1<br/>id: 2<br/>mes: 4<br/>total_tiempo: 23010<br/>updated_at: 2023-06-28 11:39:12<br/>', NULL, 'HISTORIAL DE TIEMPOS', '2023-06-28', '11:39:13', '2023-06-28 15:39:13', '2023-06-28 15:39:13'),
(217, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ LA FECHA DE PROGRAMACIÓN DE UNA ORDEN DE TRABAJO', 'id: 4<br/>fecha_programada: 2023-06-30<br/>hora_programada: 00:00:00<br/>subunidad_id: 4<br/>gama_id: 3<br/>prioridad: MODERADA<br/>tiempo: 360<br/>dias: 3<br/>tipo_mantenimiento: PREVENTIVO<br/>fecha_inicio: <br/>hora_inicio: <br/>fecha_termino: <br/>hora_termino: <br/>tiempo_ejecucion: <br/>parada_maquina: <br/>estado: PROGRAMADO<br/>razon: <br/>comentario: <br/>created_at: 2023-06-23 12:50:32<br/>updated_at: 2023-06-26 13:15:13<br/>', 'id: 4<br/>fecha_programada: 2023-07-03<br/>hora_programada: 08:00<br/>subunidad_id: 4<br/>gama_id: 3<br/>prioridad: MODERADA<br/>tiempo: 360<br/>dias: 3<br/>tipo_mantenimiento: PREVENTIVO<br/>fecha_inicio: <br/>hora_inicio: <br/>fecha_termino: <br/>hora_termino: <br/>tiempo_ejecucion: <br/>parada_maquina: <br/>estado: PROGRAMADO<br/>razon: <br/>comentario: <br/>created_at: 2023-06-23 12:50:32<br/>updated_at: 2023-06-29 15:41:57<br/>', 'ORDENES DE TRABAJO', '2023-06-29', '15:41:57', '2023-06-29 19:41:57', '2023-06-29 19:41:57'),
(218, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ LA FECHA DE PROGRAMACIÓN DE UNA ORDEN DE TRABAJO', 'id: 4<br/>fecha_programada: 2023-07-03<br/>hora_programada: 08:00:00<br/>subunidad_id: 4<br/>gama_id: 3<br/>prioridad: MODERADA<br/>tiempo: 360<br/>dias: 3<br/>tipo_mantenimiento: PREVENTIVO<br/>fecha_inicio: <br/>hora_inicio: <br/>fecha_termino: <br/>hora_termino: <br/>tiempo_ejecucion: <br/>parada_maquina: <br/>estado: PROGRAMADO<br/>razon: <br/>comentario: <br/>created_at: 2023-06-23 12:50:32<br/>updated_at: 2023-06-29 15:41:57<br/>', 'id: 4<br/>fecha_programada: 2023-07-04<br/>hora_programada: 10:00<br/>subunidad_id: 4<br/>gama_id: 3<br/>prioridad: MODERADA<br/>tiempo: 360<br/>dias: 3<br/>tipo_mantenimiento: PREVENTIVO<br/>fecha_inicio: <br/>hora_inicio: <br/>fecha_termino: <br/>hora_termino: <br/>tiempo_ejecucion: <br/>parada_maquina: <br/>estado: PROGRAMADO<br/>razon: <br/>comentario: <br/>created_at: 2023-06-23 12:50:32<br/>updated_at: 2023-06-29 15:43:44<br/>', 'ORDENES DE TRABAJO', '2023-06-29', '15:43:44', '2023-06-29 19:43:44', '2023-06-29 19:43:44'),
(219, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ LA FECHA DE PROGRAMACIÓN DE UNA ORDEN DE TRABAJO', 'id: 4<br/>fecha_programada: 2023-07-04<br/>hora_programada: 10:00:00<br/>subunidad_id: 4<br/>gama_id: 3<br/>prioridad: MODERADA<br/>tiempo: 360<br/>dias: 3<br/>tipo_mantenimiento: PREVENTIVO<br/>fecha_inicio: <br/>hora_inicio: <br/>fecha_termino: <br/>hora_termino: <br/>tiempo_ejecucion: <br/>parada_maquina: <br/>estado: PROGRAMADO<br/>razon: <br/>comentario: <br/>created_at: 2023-06-23 12:50:32<br/>updated_at: 2023-06-29 15:43:44<br/>', 'id: 4<br/>fecha_programada: 2023-07-04<br/>hora_programada: 09:00<br/>subunidad_id: 4<br/>gama_id: 3<br/>prioridad: MODERADA<br/>tiempo: 360<br/>dias: 3<br/>tipo_mantenimiento: PREVENTIVO<br/>fecha_inicio: <br/>hora_inicio: <br/>fecha_termino: <br/>hora_termino: <br/>tiempo_ejecucion: <br/>parada_maquina: <br/>estado: PROGRAMADO<br/>razon: <br/>comentario: <br/>created_at: 2023-06-23 12:50:32<br/>updated_at: 2023-06-29 15:51:51<br/>', 'ORDENES DE TRABAJO', '2023-06-29', '15:51:51', '2023-06-29 19:51:51', '2023-06-29 19:51:51'),
(220, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN MODELO DETERMINISTICO', 'area_ocupada: 20<br/>c_adqui: 8000.00<br/>c_alma_ext: 1000<br/>c_alqui: 500<br/>c_depreciacion: 17.50<br/>c_em: 400<br/>c_espa: 10000<br/>c_gi: 166.67<br/>c_impor: 1000<br/>c_ins: 300<br/>c_mantenimiento: 10490.04<br/>c_ordenar: 2066.67<br/>cantp_rep: 100.00<br/>codigo: MD001PP<br/>costo_capital: 5.87<br/>costop_rep: 5.87<br/>cpo: 166.67<br/>created_at: 2023-06-30 13:15:41<br/>ct_adqui: 1000<br/>ct_almacenamiento: 10005.87<br/>ct_ordenar: 1200<br/>descripcion: DESC. MODELO DET. #1<br/>fabricacion_productos: 30<br/>id: 1<br/>inspeccion_control: 30<br/>it: 60<br/>leadtime: 82<br/>nombre: MODELO DETERMINISTICO #1<br/>oc_adqui: 0<br/>oc_mantenimiento: 300<br/>precio_compra: 5000<br/>procesamiento_pedido: 48<br/>procesamiento_pedido_calculado: 2.00<br/>repuesto_id: 1<br/>sm: 6000<br/>tasa_ia: 400<br/>tasa_ia_calculado: 1.00<br/>tiempo_transito: 20<br/>unidad: 12<br/>updated_at: 2023-06-30 13:15:41<br/>vp_rep: 586.67<br/>', NULL, 'MODELOS DETERMINISTICOS', '2023-06-30', '13:15:41', '2023-06-30 17:15:41', '2023-06-30 17:15:41'),
(221, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN MODELO DETERMINISTICO', 'area_ocupada: 20<br/>c_adqui: 8000.00<br/>c_alma_ext: 1000.00<br/>c_alqui: 500.00<br/>c_depreciacion: 17.50<br/>c_em: 400.00<br/>c_espa: 10000.00<br/>c_gi: 166.67<br/>c_impor: 1000.00<br/>c_ins: 300.00<br/>c_mantenimiento: 10490.04<br/>c_ordenar: 2066.67<br/>cantp_rep: 100<br/>codigo: MD001PP<br/>costo_capital: 5.87<br/>costop_rep: 5.87<br/>cpo: 166.67<br/>created_at: 2023-06-30 13:15:41<br/>ct_adqui: 1000.00<br/>ct_almacenamiento: 10005.87<br/>ct_ordenar: 1200.00<br/>descripcion: DESC. MODELO DET. #1<br/>fabricacion_productos: 30<br/>id: 1<br/>inspeccion_control: 30<br/>it: 60.00<br/>leadtime: 82.00<br/>nombre: MODELO DETERMINISTICO #1<br/>oc_adqui: 0.00<br/>oc_mantenimiento: 300.00<br/>precio_compra: 5000.00<br/>procesamiento_pedido: 48<br/>procesamiento_pedido_calculado: 2.00<br/>repuesto_id: 1<br/>sm: 6000.00<br/>tasa_ia: 400.00<br/>tasa_ia_calculado: 1.00<br/>tiempo_transito: 20<br/>unidad: 12<br/>updated_at: 2023-06-30 13:15:41<br/>vp_rep: 586.67<br/>', 'area_ocupada: 20<br/>c_adqui: 8000.00<br/>c_alma_ext: 1000.00<br/>c_alqui: 500.00<br/>c_depreciacion: 17.50<br/>c_em: 400.00<br/>c_espa: 10000.00<br/>c_gi: 166.67<br/>c_impor: 1000.00<br/>c_ins: 300.00<br/>c_mantenimiento: 10490.04<br/>c_ordenar: 2066.67<br/>cantp_rep: 100<br/>codigo: MD001PP<br/>costo_capital: 5.87<br/>costop_rep: 5.87<br/>cpo: 166.67<br/>created_at: 2023-06-30 13:15:41<br/>ct_adqui: 1000.00<br/>ct_almacenamiento: 10005.87<br/>ct_ordenar: 1200.00<br/>descripcion: DESC. MODELO DET. #1<br/>fabricacion_productos: 30<br/>id: 1<br/>inspeccion_control: 30<br/>it: 60.00<br/>leadtime: 82.00<br/>nombre: MODELO DETERMINISTICO #1<br/>oc_adqui: 0.00<br/>oc_mantenimiento: 300.00<br/>precio_compra: 5000.00<br/>procesamiento_pedido: 48<br/>procesamiento_pedido_calculado: 2.00<br/>repuesto_id: 1<br/>sm: 6000.00<br/>tasa_ia: 400.00<br/>tasa_ia_calculado: 1.00<br/>tiempo_transito: 20<br/>unidad: 14<br/>updated_at: 2023-06-30 13:16:19<br/>vp_rep: 586.67<br/>', 'MODELOS DETERMINISTICOS', '2023-06-30', '13:16:19', '2023-06-30 17:16:19', '2023-06-30 17:16:19'),
(222, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN MODELO DETERMINISTICO', 'area_ocupada: 20<br/>c_adqui: 8000.00<br/>c_alma_ext: 1000.00<br/>c_alqui: 500.00<br/>c_depreciacion: 17.50<br/>c_em: 400.00<br/>c_espa: 10000.00<br/>c_gi: 166.67<br/>c_impor: 1000.00<br/>c_ins: 300.00<br/>c_mantenimiento: 10490.04<br/>c_ordenar: 2066.67<br/>cantp_rep: 100<br/>codigo: MD001PP<br/>costo_capital: 5.87<br/>costop_rep: 5.87<br/>cpo: 166.67<br/>created_at: 2023-06-30 13:15:41<br/>ct_adqui: 1000.00<br/>ct_almacenamiento: 10005.87<br/>ct_ordenar: 1200.00<br/>descripcion: DESC. MODELO DET. #1<br/>fabricacion_productos: 30<br/>id: 1<br/>inspeccion_control: 30<br/>it: 60.00<br/>leadtime: 82.00<br/>nombre: MODELO DETERMINISTICO #1<br/>oc_adqui: 0.00<br/>oc_mantenimiento: 300.00<br/>precio_compra: 5000.00<br/>procesamiento_pedido: 48<br/>procesamiento_pedido_calculado: 2.00<br/>repuesto_id: 1<br/>sm: 6000.00<br/>tasa_ia: 400.00<br/>tasa_ia_calculado: 1.00<br/>tiempo_transito: 20<br/>unidad: 14<br/>updated_at: 2023-06-30 13:16:19<br/>vp_rep: 586.67<br/>', 'area_ocupada: 20<br/>c_adqui: 8000.00<br/>c_alma_ext: 1000.00<br/>c_alqui: 500.00<br/>c_depreciacion: 17.50<br/>c_em: 400.00<br/>c_espa: 10000.00<br/>c_gi: 166.67<br/>c_impor: 1000.00<br/>c_ins: 300.00<br/>c_mantenimiento: 10490.04<br/>c_ordenar: 2066.67<br/>cantp_rep: 100.00<br/>codigo: MD001PP<br/>costo_capital: 5.87<br/>costop_rep: 5.87<br/>cpo: 166.67<br/>created_at: 2023-06-30 13:15:41<br/>ct_adqui: 1000.00<br/>ct_almacenamiento: 10005.87<br/>ct_ordenar: 1200.00<br/>descripcion: DESC. MODELO DET. #1<br/>fabricacion_productos: 30<br/>id: 1<br/>inspeccion_control: 30<br/>it: 60.00<br/>leadtime: 82.00<br/>nombre: MODELO DETERMINISTICO #1<br/>oc_adqui: 0.00<br/>oc_mantenimiento: 300.00<br/>precio_compra: 5000.00<br/>procesamiento_pedido: 48<br/>procesamiento_pedido_calculado: 2.00<br/>repuesto_id: 1<br/>sm: 6000.00<br/>tasa_ia: 400.00<br/>tasa_ia_calculado: 1.00<br/>tiempo_transito: 20<br/>unidad: 12<br/>updated_at: 2023-06-30 13:16:26<br/>vp_rep: 586.67<br/>', 'MODELOS DETERMINISTICOS', '2023-06-30', '13:16:26', '2023-06-30 17:16:26', '2023-06-30 17:16:26'),
(223, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN MODELO DETERMINISTICO', 'area_ocupada: 20<br/>c_adqui: 8000.00<br/>c_alma_ext: 1000.00<br/>c_alqui: 500.00<br/>c_depreciacion: 17.50<br/>c_em: 400.00<br/>c_espa: 10000.00<br/>c_gi: 166.67<br/>c_impor: 1000.00<br/>c_ins: 300.00<br/>c_mantenimiento: 10490.04<br/>c_ordenar: 2066.67<br/>cantp_rep: 100<br/>codigo: MD001PP<br/>costo_capital: 5.87<br/>costop_rep: 5.87<br/>cpo: 166.67<br/>created_at: 2023-06-30 13:15:41<br/>ct_adqui: 1000.00<br/>ct_almacenamiento: 10005.87<br/>ct_ordenar: 1200.00<br/>descripcion: DESC. MODELO DET. #1<br/>fabricacion_productos: 30<br/>id: 1<br/>inspeccion_control: 30<br/>it: 60.00<br/>leadtime: 82.00<br/>nombre: MODELO DETERMINISTICO #1<br/>oc_adqui: 0.00<br/>oc_mantenimiento: 300.00<br/>precio_compra: 5000.00<br/>procesamiento_pedido: 48<br/>procesamiento_pedido_calculado: 2.00<br/>repuesto_id: 1<br/>sm: 6000.00<br/>tasa_ia: 400.00<br/>tasa_ia_calculado: 1.00<br/>tiempo_transito: 20<br/>unidad: 12<br/>updated_at: 2023-06-30 13:16:26<br/>vp_rep: 586.67<br/>', 'area_ocupada: 20<br/>c_adqui: 8000.00<br/>c_alma_ext: 1000<br/>c_alqui: 500.00<br/>c_depreciacion: 156.25<br/>c_em: 400.00<br/>c_espa: 10000.00<br/>c_gi: 166.67<br/>c_impor: 1000.00<br/>c_ins: 300.00<br/>c_mantenimiento: 10628.79<br/>c_ordenar: 2066.67<br/>cantp_rep: 100<br/>codigo: MD001PP<br/>costo_capital: 5.87<br/>costop_rep: 5.87<br/>cpo: 166.67<br/>created_at: 2023-06-30 13:15:41<br/>ct_adqui: 1000.00<br/>ct_almacenamiento: 10005.87<br/>ct_ordenar: 1200.00<br/>descripcion: DESC. MODELO DET. #1<br/>fabricacion_productos: 30<br/>id: 1<br/>inspeccion_control: 30<br/>it: 60.00<br/>leadtime: 82.00<br/>nombre: MODELO DETERMINISTICO #1<br/>oc_adqui: 0.00<br/>oc_mantenimiento: 300.00<br/>precio_compra: 5000.00<br/>procesamiento_pedido: 48<br/>procesamiento_pedido_calculado: 2.00<br/>repuesto_id: 1<br/>sm: 6000.00<br/>tasa_ia: 400.00<br/>tasa_ia_calculado: 1.00<br/>tiempo_transito: 20<br/>unidad: 12<br/>updated_at: 2023-06-30 13:33:34<br/>vp_rep: 586.67<br/>', 'MODELOS DETERMINISTICOS', '2023-06-30', '13:33:34', '2023-06-30 17:33:34', '2023-06-30 17:33:34'),
(224, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN MODELO DETERMINISTICO', 'area_ocupada: 20<br/>c_adqui: 8000.00<br/>c_alma_ext: 1000.00<br/>c_alqui: 500.00<br/>c_depreciacion: 156.25<br/>c_em: 400.00<br/>c_espa: 10000.00<br/>c_gi: 166.67<br/>c_impor: 1000.00<br/>c_ins: 300.00<br/>c_mantenimiento: 10628.79<br/>c_ordenar: 2066.67<br/>cantp_rep: 100<br/>codigo: MD001PP<br/>costo_capital: 5.87<br/>costop_rep: 5.87<br/>cpo: 166.67<br/>created_at: 2023-06-30 13:15:41<br/>ct_adqui: 1000.00<br/>ct_almacenamiento: 10005.87<br/>ct_ordenar: 1200.00<br/>descripcion: DESC. MODELO DET. #1<br/>fabricacion_productos: 30<br/>id: 1<br/>inspeccion_control: 30<br/>it: 60.00<br/>leadtime: 82.00<br/>nombre: MODELO DETERMINISTICO #1<br/>oc_adqui: 0.00<br/>oc_mantenimiento: 300.00<br/>precio_compra: 5000.00<br/>procesamiento_pedido: 48<br/>procesamiento_pedido_calculado: 2.00<br/>repuesto_id: 1<br/>sm: 6000.00<br/>tasa_ia: 400.00<br/>tasa_ia_calculado: 1.00<br/>tiempo_transito: 20<br/>unidad: 12<br/>updated_at: 2023-06-30 13:33:34<br/>vp_rep: 586.67<br/>', 'area_ocupada: 20<br/>c_adqui: 8000.00<br/>c_alma_ext: 1000.00<br/>c_alqui: 500.00<br/>c_depreciacion: 156.25<br/>c_em: 400.00<br/>c_espa: 10000.00<br/>c_gi: 166.67<br/>c_impor: 1000.00<br/>c_ins: 300.00<br/>c_mantenimiento: 10628.79<br/>c_ordenar: 2066.67<br/>cantp_rep: 100.00<br/>codigo: MD001PP<br/>costo_capital: 5.87<br/>costop_rep: 5.87<br/>cpo: 166.67<br/>created_at: 2023-06-30 13:15:41<br/>ct_adqui: 1000.00<br/>ct_almacenamiento: 10005.87<br/>ct_ordenar: 1200.00<br/>descripcion: DESC. MODELO DET. #1<br/>fabricacion_productos: 30<br/>id: 1<br/>inspeccion_control: 30<br/>it: 60.00<br/>leadtime: 82.00<br/>nombre: MODELO DETERMINISTICO #1<br/>oc_adqui: 0.00<br/>oc_mantenimiento: 300.00<br/>precio_compra: 5000.00<br/>procesamiento_pedido: 48<br/>procesamiento_pedido_calculado: 2.00<br/>repuesto_id: 1<br/>sm: 6000.00<br/>tasa_ia: 400.00<br/>tasa_ia_calculado: 1.00<br/>tiempo_transito: 20<br/>unidad: 12<br/>updated_at: 2023-06-30 13:33:40<br/>vp_rep: 586.67<br/>', 'MODELOS DETERMINISTICOS', '2023-06-30', '13:33:40', '2023-06-30 17:33:40', '2023-06-30 17:33:40'),
(225, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN MODELO DETERMINISTICO', 'area_ocupada: <br/>c_adqui: <br/>c_alma_ext: <br/>c_alqui: <br/>c_depreciacion: <br/>c_em: <br/>c_espa: <br/>c_gi: <br/>c_impor: <br/>c_ins: <br/>c_mantenimiento: <br/>c_ordenar: <br/>cantp_rep: 100.00<br/>codigo: MD002<br/>costo_capital: <br/>costop_rep: 5.87<br/>cpo: <br/>created_at: 2023-06-30 13:36:26<br/>ct_adqui: <br/>ct_almacenamiento: <br/>ct_ordenar: <br/>descripcion: <br/>fabricacion_productos: <br/>id: 2<br/>inspeccion_control: <br/>it: <br/>leadtime: <br/>nombre: MODELO #2<br/>oc_adqui: <br/>oc_mantenimiento: <br/>precio_compra: <br/>procesamiento_pedido: <br/>procesamiento_pedido_calculado: <br/>repuesto_id: 2<br/>sm: <br/>tasa_ia: <br/>tasa_ia_calculado: <br/>tiempo_transito: <br/>unidad: 12<br/>updated_at: 2023-06-30 13:36:26<br/>vp_rep: 586.67<br/>', NULL, 'MODELOS DETERMINISTICOS', '2023-06-30', '13:36:26', '2023-06-30 17:36:26', '2023-06-30 17:36:26');
INSERT INTO `historial_accions` (`id`, `user_id`, `accion`, `descripcion`, `datos_original`, `datos_nuevo`, `modulo`, `fecha`, `hora`, `created_at`, `updated_at`) VALUES
(226, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UN MODELO DETERMINISTICO', 'area_ocupada: <br/>c_adqui: <br/>c_alma_ext: <br/>c_alqui: <br/>c_depreciacion: <br/>c_em: <br/>c_espa: <br/>c_gi: <br/>c_impor: <br/>c_ins: <br/>c_mantenimiento: <br/>c_ordenar: <br/>cantp_rep: 100<br/>codigo: MD002<br/>costo_capital: <br/>costop_rep: 5.87<br/>cpo: <br/>created_at: 2023-06-30 13:36:26<br/>ct_adqui: <br/>ct_almacenamiento: <br/>ct_ordenar: <br/>descripcion: <br/>fabricacion_productos: <br/>id: 2<br/>inspeccion_control: <br/>it: <br/>leadtime: <br/>nombre: MODELO #2<br/>oc_adqui: <br/>oc_mantenimiento: <br/>precio_compra: <br/>procesamiento_pedido: <br/>procesamiento_pedido_calculado: <br/>repuesto_id: 2<br/>sm: <br/>tasa_ia: <br/>tasa_ia_calculado: <br/>tiempo_transito: <br/>unidad: 12<br/>updated_at: 2023-06-30 13:36:26<br/>vp_rep: 586.67<br/>', NULL, 'MODELOS DETERMINISTICOS', '2023-06-30', '13:37:56', '2023-06-30 17:37:56', '2023-06-30 17:37:56'),
(227, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA ORDEN DE TRABAJO', 'comentario: COMENTARIO<br/>created_at: 2023-06-15 11:26:58<br/>dias: 7<br/>estado: TERMINADO<br/>fecha_inicio: 2023-06-22<br/>fecha_programada: 2023-06-15<br/>fecha_termino: 2023-06-23<br/>gama_id: 2<br/>hora_inicio: 17:41:00<br/>hora_programada: 08:00:00<br/>hora_termino: 12:28:00<br/>id: 2<br/>parada_maquina: SI<br/>prioridad: URGENTE<br/>razon: PRUEBA TERMINO OT<br/>subunidad_id: 1<br/>tiempo: 17<br/>tiempo_ejecucion: 18<br/>tipo_mantenimiento: PREDICTIVO<br/>updated_at: 2023-06-23 12:29:40<br/>', 'comentario: COMENTARIO<br/>created_at: 2023-06-15 11:26:58<br/>dias: 7<br/>estado: TERMINADO<br/>fecha_inicio: 2023-06-22<br/>fecha_programada: 2023-07-03<br/>fecha_termino: 2023-06-23<br/>gama_id: 2<br/>hora_inicio: 17:41:00<br/>hora_programada: 08:00:00<br/>hora_termino: 12:28:00<br/>id: 2<br/>parada_maquina: SI<br/>prioridad: URGENTE<br/>razon: PRUEBA TERMINO OT<br/>subunidad_id: 1<br/>tiempo: 17<br/>tiempo_ejecucion: 18<br/>tipo_mantenimiento: PREDICTIVO<br/>updated_at: 2023-07-03 10:21:21<br/>', 'ORDENES DE TRABAJO', '2023-07-03', '10:21:21', '2023-07-03 14:21:21', '2023-07-03 14:21:21'),
(228, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA ORDEN DE TRABAJO', 'comentario: <br/>created_at: 2023-06-19 11:58:35<br/>dias: 10<br/>estado: PROGRAMADO<br/>fecha_inicio: <br/>fecha_programada: 2023-06-19<br/>fecha_termino: <br/>gama_id: 2<br/>hora_inicio: <br/>hora_programada: 08:00:00<br/>hora_termino: <br/>id: 3<br/>parada_maquina: <br/>prioridad: MODERADA<br/>razon: <br/>subunidad_id: 2<br/>tiempo: 17<br/>tiempo_ejecucion: <br/>tipo_mantenimiento: LUBRICACIÓN<br/>updated_at: 2023-06-19 11:58:35<br/>', 'comentario: <br/>created_at: 2023-06-19 11:58:35<br/>dias: 10<br/>estado: PROGRAMADO<br/>fecha_inicio: <br/>fecha_programada: 2023-07-01<br/>fecha_termino: <br/>gama_id: 2<br/>hora_inicio: <br/>hora_programada: 08:00:00<br/>hora_termino: <br/>id: 3<br/>parada_maquina: <br/>prioridad: MODERADA<br/>razon: <br/>subunidad_id: 2<br/>tiempo: 17<br/>tiempo_ejecucion: <br/>tipo_mantenimiento: LUBRICACIÓN<br/>updated_at: 2023-07-03 10:21:40<br/>', 'ORDENES DE TRABAJO', '2023-07-03', '10:21:40', '2023-07-03 14:21:40', '2023-07-03 14:21:40'),
(229, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ EL ESTADO DE UNA ORDEN DE TRABAJO', 'comentario: COMENTARIO<br/>created_at: 2023-06-15 11:26:58<br/>dias: 7<br/>estado: PROGRAMADO<br/>fecha_inicio: 2023-06-22<br/>fecha_programada: 2023-07-03<br/>fecha_termino: 2023-06-23<br/>gama_id: 2<br/>hora_inicio: 17:41:00<br/>hora_programada: 08:00:00<br/>hora_termino: 12:28:00<br/>id: 2<br/>parada_maquina: SI<br/>prioridad: URGENTE<br/>razon: PRUEBA TERMINO OT<br/>subunidad_id: 1<br/>tiempo: 17<br/>tiempo_ejecucion: 18<br/>tipo_mantenimiento: PREDICTIVO<br/>updated_at: 2023-07-03 10:21:21<br/>', 'comentario: COMENTARIO<br/>created_at: 2023-06-15 11:26:58<br/>dias: 7<br/>estado: INICIADO<br/>fecha_inicio: 2023-07-03<br/>fecha_programada: 2023-07-03<br/>fecha_termino: 2023-06-23<br/>gama_id: 2<br/>hora_inicio: 10:22<br/>hora_programada: 08:00:00<br/>hora_termino: 12:28:00<br/>id: 2<br/>parada_maquina: SI<br/>prioridad: URGENTE<br/>razon: PRUEBA INICIO #1<br/>subunidad_id: 1<br/>tiempo: 17<br/>tiempo_ejecucion: 18<br/>tipo_mantenimiento: PREDICTIVO<br/>updated_at: 2023-07-03 10:22:55<br/>', 'ORDENES DE TRABAJO', '2023-07-03', '10:22:55', '2023-07-03 14:22:55', '2023-07-03 14:22:55'),
(230, 1, 'MODIFICACIÓN', 'EL USUARIO admin TERMINÓ UNA ORDEN DE TRABAJO', 'comentario: COMENTARIO<br/>created_at: 2023-06-15 11:26:58<br/>dias: 7<br/>estado: INICIADO<br/>fecha_inicio: 2023-07-03<br/>fecha_programada: 2023-07-03<br/>fecha_termino: 2023-06-23<br/>gama_id: 2<br/>hora_inicio: 08:22:00<br/>hora_programada: 08:00:00<br/>hora_termino: 12:28:00<br/>id: 2<br/>parada_maquina: SI<br/>prioridad: URGENTE<br/>razon: PRUEBA INICIO #1<br/>subunidad_id: 1<br/>tiempo: 17<br/>tiempo_ejecucion: 18<br/>tipo_mantenimiento: PREDICTIVO<br/>updated_at: 2023-07-03 10:22:55<br/>', 'comentario: COMENTARIO<br/>created_at: 2023-06-15 11:26:58<br/>dias: 7<br/>estado: TERMINADO<br/>fecha_inicio: 2023-07-03<br/>fecha_programada: 2023-07-03<br/>fecha_termino: 2023-07-03<br/>gama_id: 2<br/>hora_inicio: 08:22:00<br/>hora_programada: 08:00:00<br/>hora_termino: 10:44<br/>id: 2<br/>parada_maquina: SI<br/>prioridad: URGENTE<br/>razon: PRUEBA TERMINO DE OT + FALLA<br/>subunidad_id: 1<br/>tiempo: 17<br/>tiempo_ejecucion: 2<br/>tipo_mantenimiento: PREDICTIVO<br/>updated_at: 2023-07-03 10:46:06<br/>', 'ORDENES DE TRABAJO', '2023-07-03', '10:46:06', '2023-07-03 14:46:06', '2023-07-03 14:46:06'),
(231, 1, 'MODIFICACIÓN', 'EL USUARIO admin TERMINÓ UNA ORDEN DE TRABAJO', 'comentario: COMENTARIO<br/>created_at: 2023-06-15 11:26:58<br/>dias: 7<br/>estado: INICIADO<br/>fecha_inicio: 2023-07-03<br/>fecha_programada: 2023-07-03<br/>fecha_termino: 2023-07-03<br/>gama_id: 2<br/>hora_inicio: 08:22:00<br/>hora_programada: 08:00:00<br/>hora_termino: 10:44:00<br/>id: 2<br/>parada_maquina: SI<br/>prioridad: URGENTE<br/>razon: PRUEBA TERMINO DE OT + FALLA<br/>subunidad_id: 1<br/>tiempo: 17<br/>tiempo_ejecucion: 2<br/>tipo_mantenimiento: PREDICTIVO<br/>updated_at: 2023-07-03 10:46:06<br/>', 'comentario: COMENTARIO<br/>created_at: 2023-06-15 11:26:58<br/>dias: 7<br/>estado: TERMINADO<br/>fecha_inicio: 2023-07-03<br/>fecha_programada: 2023-07-03<br/>fecha_termino: 2023-07-03<br/>gama_id: 2<br/>hora_inicio: 08:22:00<br/>hora_programada: 08:00:00<br/>hora_termino: 10:47<br/>id: 2<br/>parada_maquina: SI<br/>prioridad: URGENTE<br/>razon: PRUEBA TERMINO DE OT + TIEMPO DE FALL<br/>subunidad_id: 1<br/>tiempo: 17<br/>tiempo_ejecucion: 2<br/>tipo_mantenimiento: PREDICTIVO<br/>updated_at: 2023-07-03 10:47:54<br/>', 'ORDENES DE TRABAJO', '2023-07-03', '10:47:54', '2023-07-03 14:47:54', '2023-07-03 14:47:54'),
(232, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN MODELO DETERMINISTICO', 'area_ocupada: 20<br/>c_adqui: 8000.00<br/>c_alma_ext: 1000.00<br/>c_alqui: 500.00<br/>c_depreciacion: 156.25<br/>c_em: 400.00<br/>c_espa: 10000.00<br/>c_gi: 166.67<br/>c_impor: 1000.00<br/>c_ins: 300.00<br/>c_mantenimiento: 10628.79<br/>c_ordenar: 2066.67<br/>cantp_rep: 100<br/>codigo: MD001PP<br/>costo_capital: 5.87<br/>costop_rep: 5.87<br/>cpo: 166.67<br/>created_at: 2023-06-30 13:15:41<br/>ct_adqui: 1000.00<br/>ct_almacenamiento: 10005.87<br/>ct_ordenar: 1200.00<br/>descripcion: DESC. MODELO DET. #1<br/>fabricacion_productos: 30<br/>id: 1<br/>inspeccion_control: 30<br/>it: 60.00<br/>leadtime: 82.00<br/>nombre: MODELO DETERMINISTICO #1<br/>oc_adqui: 0.00<br/>oc_mantenimiento: 300.00<br/>precio_compra: 5000.00<br/>procesamiento_pedido: 48<br/>procesamiento_pedido_calculado: 2.00<br/>repuesto_id: 1<br/>sm: 6000.00<br/>tasa_ia: 400.00<br/>tasa_ia_calculado: 1.00<br/>tiempo_transito: 20<br/>unidad: 12<br/>updated_at: 2023-06-30 13:33:40<br/>vp_rep: 586.67<br/>', 'area_ocupada: 20<br/>c_adqui: 8000.00<br/>c_alma_ext: 1000.00<br/>c_alqui: 500.00<br/>c_depreciacion: 156.25<br/>c_em: 400.00<br/>c_espa: 10000.00<br/>c_gi: 166.67<br/>c_impor: 1000.00<br/>c_ins: 300.00<br/>c_mantenimiento: 11042.92<br/>c_ordenar: 2066.67<br/>cantp_rep: 30.00<br/>codigo: MD001PP<br/>costo_capital: 420.00<br/>costop_rep: 560.00<br/>cpo: 166.67<br/>created_at: 2023-06-30 13:15:41<br/>ct_adqui: 1000.00<br/>ct_almacenamiento: 10420.00<br/>ct_ordenar: 1200.00<br/>descripcion: DESC. MODELO DET. #1<br/>fabricacion_productos: 30<br/>id: 1<br/>inspeccion_control: 30<br/>it: 60.00<br/>leadtime: 82.00<br/>nombre: MODELO DETERMINISTICO #1<br/>oc_adqui: 0.00<br/>oc_mantenimiento: 300.00<br/>precio_compra: 5000.00<br/>procesamiento_pedido: 48<br/>procesamiento_pedido_calculado: 2.00<br/>repuesto_id: 1<br/>sm: 6000.00<br/>tasa_ia: 300<br/>tasa_ia_calculado: 0.75<br/>tiempo_transito: 20<br/>unidad: 12<br/>updated_at: 2023-07-03 12:44:23<br/>vp_rep: 16800.00<br/>', 'MODELOS DETERMINISTICOS', '2023-07-03', '12:44:23', '2023-07-03 16:44:23', '2023-07-03 16:44:23'),
(233, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN HERRAMIENTAS/EQUIPOS DE PROTECCIÓN', 'almacen: ALMACEN EQUIPOS<br/>clasificacion: CLASIFICACION EQUIPO<br/>cod_clasificacion: CODIGOCLAS<br/>codificacion: CO002OOP<br/>codigo: E001<br/>correo: <br/>correo_fabricante: <br/>costo: 3000.00<br/>created_at: 2023-06-06 17:08:23<br/>descripcion: DESC EQUIPO # 1<br/>dir: <br/>dir_fabricante: <br/>e_tecnicas: <br/>fabricante: <br/>fono: <br/>foto: <br/>id: 3<br/>marca: MARCA EQUIPOS<br/>modelo: MODELO EQUIPO<br/>nombre: EQUIPO #1<br/>nombre_contacto: <br/>num_fono: <br/>num_identificacion: <br/>proveedor: PROVEEDOR DEL EQUIPO<br/>serie: SERIEEQUIPO<br/>terciarios: <br/>unidad_medida: METROS<br/>updated_at: 2023-06-14 11:31:00<br/>', 'almacen: ALMACEN EQUIPOS<br/>clasificacion: CLASIFICACION EQUIPO<br/>cod_clasificacion: CODIGOCLAS<br/>codificacion: CO002OOP<br/>codigo: E001<br/>correo: <br/>correo_fabricante: <br/>costo: 3000.00<br/>created_at: 2023-06-06 17:08:23<br/>descripcion: DESC EQUIPO # 1<br/>dir: <br/>dir_fabricante: <br/>e_tecnicas: <br/>fabricante: <br/>fono: <br/>foto: <br/>id: 3<br/>marca: MARCA EQUIPOS<br/>modelo: MODELO EQUIPO<br/>nombre: EQUIPO PROTECCIÓN #1<br/>nombre_contacto: <br/>num_fono: <br/>num_identificacion: <br/>proveedor: PROVEEDOR DEL EQUIPO<br/>serie: SERIEEQUIPO<br/>terciarios: <br/>unidad_medida: METROS<br/>updated_at: 2023-07-05 10:47:13<br/>', 'HERRAMIENTAS/EQUIPOS DE PROTECCIÓN', '2023-07-05', '10:47:13', '2023-07-05 14:47:13', '2023-07-05 14:47:13'),
(234, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN HERRAMIENTAS/EQUIPOS DE PROTECCIÓN', 'almacen: ALMACEN #1<br/>clasificacion: <br/>cod_clasificacion: <br/>codificacion: CO003POO<br/>codigo: EQ003<br/>correo: <br/>correo_fabricante: <br/>costo: <br/>created_at: 2023-06-14 11:31:43<br/>descripcion: DESC. EQ. #3<br/>dir: <br/>dir_fabricante: <br/>e_tecnicas: <br/>fabricante: <br/>fono: <br/>foto: <br/>id: 4<br/>marca: <br/>modelo: <br/>nombre: EQUIPO #3<br/>nombre_contacto: <br/>num_fono: <br/>num_identificacion: <br/>proveedor: PROVEEDOR #3<br/>serie: <br/>terciarios: <br/>unidad_medida: <br/>updated_at: 2023-06-14 11:31:43<br/>', 'almacen: ALMACEN #1<br/>clasificacion: <br/>cod_clasificacion: <br/>codificacion: CO003POO<br/>codigo: H002<br/>correo: <br/>correo_fabricante: <br/>costo: <br/>created_at: 2023-06-14 11:31:43<br/>descripcion: DESC. HERRAMIENTA #2<br/>dir: <br/>dir_fabricante: <br/>e_tecnicas: <br/>fabricante: <br/>fono: <br/>foto: <br/>id: 4<br/>marca: <br/>modelo: <br/>nombre: HERRAMIENTA #2<br/>nombre_contacto: <br/>num_fono: <br/>num_identificacion: <br/>proveedor: PROVEEDOR #3<br/>serie: <br/>terciarios: <br/>unidad_medida: <br/>updated_at: 2023-07-05 10:47:33<br/>', 'HERRAMIENTAS/EQUIPOS DE PROTECCIÓN', '2023-07-05', '10:47:33', '2023-07-05 14:47:33', '2023-07-05 14:47:33'),
(235, 1, 'REGISTRO', 'EL USUARIO admin REGISTRO UNA HERRAMIENTA EN UNA GENERACIÓN DE OT', 'cantidad_solicitada: 3<br/>chekado: <br/>costo: 1000.00<br/>created_at: 2023-07-05 10:47:56<br/>herramienta_id: 1<br/>id: 3<br/>orden_generada_id: 2<br/>total: 3000<br/>updated_at: 2023-07-05 10:47:56<br/>', NULL, 'GENERACIÓN DE OT - HERRAMIENTAS', '2023-07-05', '10:47:56', '2023-07-05 14:47:56', '2023-07-05 14:47:56'),
(236, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA ENTRADA DE REPUESTOS/INSUMOS', 'cantidad: 100<br/>created_at: 2023-06-19 14:08:05<br/>factura: 1000010<br/>fecha: 2023-06-19<br/>id: 4<br/>precio: 35.00<br/>repuesto_id: 1<br/>total: 3500.00<br/>updated_at: 2023-06-19 14:08:05<br/>', NULL, 'ENTRADA DE REPUESTOS/INSUMOS', '2023-07-05', '11:38:42', '2023-07-05 15:38:42', '2023-07-05 15:38:42'),
(237, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ EL ESTADO DE UNA ORDEN DE TRABAJO', 'comentario: <br/>created_at: 2023-06-23 12:50:32<br/>dias: 3<br/>estado: PROGRAMADO<br/>fecha_inicio: <br/>fecha_programada: 2023-07-04<br/>fecha_termino: <br/>gama_id: 3<br/>hora_inicio: <br/>hora_programada: 09:00:00<br/>hora_termino: <br/>id: 4<br/>parada_maquina: <br/>prioridad: MODERADA<br/>razon: <br/>subunidad_id: 4<br/>tiempo: 360<br/>tiempo_ejecucion: <br/>tipo_mantenimiento: PREVENTIVO<br/>updated_at: 2023-06-29 15:51:51<br/>', 'comentario: <br/>created_at: 2023-06-23 12:50:32<br/>dias: 3<br/>estado: INICIADO<br/>fecha_inicio: 2023-07-06<br/>fecha_programada: 2023-07-04<br/>fecha_termino: <br/>gama_id: 3<br/>hora_inicio: 12:45<br/>hora_programada: 09:00:00<br/>hora_termino: <br/>id: 4<br/>parada_maquina: <br/>prioridad: MODERADA<br/>razon: PRUEBA INICIO #2<br/>subunidad_id: 4<br/>tiempo: 360<br/>tiempo_ejecucion: <br/>tipo_mantenimiento: PREVENTIVO<br/>updated_at: 2023-07-06 12:45:46<br/>', 'ORDENES DE TRABAJO', '2023-07-06', '12:45:46', '2023-07-06 16:45:46', '2023-07-06 16:45:46'),
(238, 1, 'MODIFICACIÓN', 'EL USUARIO admin TERMINÓ UNA ORDEN DE TRABAJO', 'comentario: <br/>created_at: 2023-06-23 12:50:32<br/>dias: 3<br/>estado: INICIADO<br/>fecha_inicio: 2023-07-06<br/>fecha_programada: 2023-07-04<br/>fecha_termino: <br/>gama_id: 3<br/>hora_inicio: 08:45:00<br/>hora_programada: 09:00:00<br/>hora_termino: <br/>id: 4<br/>parada_maquina: <br/>prioridad: MODERADA<br/>razon: PRUEBA INICIO #2<br/>subunidad_id: 4<br/>tiempo: 360<br/>tiempo_ejecucion: <br/>tipo_mantenimiento: PREVENTIVO<br/>updated_at: 2023-07-06 12:45:46<br/>', 'comentario: <br/>created_at: 2023-06-23 12:50:32<br/>dias: 3<br/>estado: TERMINADO<br/>fecha_inicio: 2023-07-06<br/>fecha_programada: 2023-07-04<br/>fecha_termino: 2023-07-06<br/>gama_id: 3<br/>hora_inicio: 08:45:00<br/>hora_programada: 09:00:00<br/>hora_termino: 12:46<br/>id: 4<br/>parada_maquina: SI<br/>prioridad: MODERADA<br/>razon: PRUEBA TERMINO CON FALLA #2<br/>subunidad_id: 4<br/>tiempo: 360<br/>tiempo_ejecucion: 4<br/>tipo_mantenimiento: PREVENTIVO<br/>updated_at: 2023-07-06 12:46:41<br/>', 'ORDENES DE TRABAJO', '2023-07-06', '12:46:41', '2023-07-06 16:46:41', '2023-07-06 16:46:41'),
(239, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA VARIABLE DE CONTROL', 'id: 1<br/>nombre: VARIABLE CONTROL #1<br/>unidad: DÍAS<br/>created_at: 2023-06-06 11:05:22<br/>updated_at: 2023-06-14 16:51:36<br/>', NULL, 'VARIABLES DE CONTROL', '2023-07-07', '16:21:38', '2023-07-07 20:21:38', '2023-07-07 20:21:38'),
(240, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN HERRAMIENTAS/EQUIPOS DE PROTECCIÓN', 'id: 1<br/>codigo: H001<br/>codificacion: CH001PPP<br/>nombre: HERRAMIENTA #1<br/>descripcion: DESC, HERRAMIENTA #1<br/>clasificacion: CLASIFICACION 1<br/>cod_clasificacion: CLASI1<br/>marca: MARCA 1<br/>modelo: MODELO 1<br/>serie: SERIE 1<br/>costo: 1000.00<br/>unidad_medida: METROS<br/>proveedor: PERES S.A.<br/>dir: LOS OLIVOS<br/>fono: 222222<br/>correo: PERES@GMAIL.COM<br/>almacen: ALMACEN 1<br/>fabricante: FABRICANTE 1<br/>terciarios: TERCIARIOS 1<br/>nombre_contacto: JUAN PERES<br/>num_fono: 222222<br/>correo_fabricante: FABRICANTE@GMAIL.COM<br/>dir_fabricante: LOS PEDREGALES<br/>num_identificacion: 23323211111<br/>e_tecnicas: ESPECIFICACIONES TECNIAS HERRAMIENTA #1<br/>foto: 11686068009.jpeg<br/>created_at: 2023-06-06 12:05:22<br/>updated_at: 2023-06-14 11:29:08<br/>', 'id: 1<br/>codigo: H001<br/>codificacion: CH001PPP<br/>nombre: HERRAMIENTA #1<br/>descripcion: DESC, HERRAMIENTA #1<br/>clasificacion: CLASIFICACION 1<br/>cod_clasificacion: CLASI1<br/>marca: MARCA 1<br/>modelo: MODELO 1<br/>serie: SERIE 1<br/>costo: 1000.00<br/>unidad_medida: METROS<br/>proveedor: PERES S.A.<br/>dir: LOS OLIVOS<br/>fono: 222222<br/>correo: PERES@GMAIL.COM<br/>almacen: ALMACEN 1<br/>fabricante: FABRICANTE 1<br/>terciarios: TERCIARIOS 1<br/>nombre_contacto: JUAN PERES<br/>num_fono: 222222<br/>correo_fabricante: FABRICANTE@GMAIL.COM<br/>dir_fabricante: LOS PEDREGALES<br/>num_identificacion: 23323211111<br/>e_tecnicas: ESPECIFICACIONES TECNIAS HERRAMIENTA #1<br/>foto: 11686068009.jpeg<br/>created_at: 2023-06-06 12:05:22<br/>updated_at: 2023-06-14 11:29:08<br/>', 'HERRAMIENTAS/EQUIPOS DE PROTECCIÓN', '2023-07-07', '16:24:26', '2023-07-07 20:24:26', '2023-07-07 20:24:26'),
(241, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN HISTORIAL DE TIEMPO', 'id: 3<br/>anio: 2023<br/>mes: 8<br/>equipo_id: 1<br/>codificacion: D000E1<br/>total_tiempo: 47190<br/>created_at: 2023-07-07 17:10:58<br/>updated_at: 2023-07-07 17:10:58<br/>', NULL, 'HISTORIAL DE TIEMPOS', '2023-07-07', '17:10:58', '2023-07-07 21:10:58', '2023-07-07 21:10:58'),
(242, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN USUARIO', 'id: 7<br/>usuario: FPAREDES<br/>nombre: FERNANDO<br/>paterno: PAREDES<br/>materno: PAREDES<br/>ci: 6666<br/>ci_exp: LP<br/>especialidad: <br/>dir: LOS OLIVOS<br/>correo: <br/>fono: <br/>tipo: AUXILIAR DE ALMACÉN<br/>foto: default.png<br/>password: $2y$10$W5grEj2.hONh6dme/rXEDeFwPw3MW4ySuv3A6JT49ieCpSpqihyIK<br/>acceso: 1<br/>fecha_registro: 2023-07-07<br/>created_at: 2023-07-07 17:30:23<br/>updated_at: 2023-07-07 17:30:23<br/>', NULL, 'USUARIOS', '2023-07-07', '17:30:23', '2023-07-07 21:30:23', '2023-07-07 21:30:23');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_fallas`
--

CREATE TABLE `historial_fallas` (
  `id` bigint UNSIGNED NOT NULL,
  `orden_id` bigint UNSIGNED NOT NULL,
  `nro_codificacion` bigint NOT NULL,
  `codificacion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo_falla` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion_falla` text COLLATE utf8mb4_unicode_ci,
  `fecha_inicio` date NOT NULL,
  `hora_inicio` time NOT NULL,
  `fecha_termino` date NOT NULL,
  `hora_termino` time NOT NULL,
  `tiempo_ejecucion` double NOT NULL,
  `fecha_falla` date DEFAULT NULL,
  `hora_falla` time DEFAULT NULL,
  `tiempo_falla` double DEFAULT NULL,
  `equipo_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `historial_fallas`
--

INSERT INTO `historial_fallas` (`id`, `orden_id`, `nro_codificacion`, `codificacion`, `tipo_falla`, `descripcion_falla`, `fecha_inicio`, `hora_inicio`, `fecha_termino`, `hora_termino`, `tiempo_ejecucion`, `fecha_falla`, `hora_falla`, `tiempo_falla`, `equipo_id`, `created_at`, `updated_at`) VALUES
(2, 2, 2, 'DM-0002-HIS-FM', 'MECÁNICA', '', '2023-07-03', '08:22:00', '2023-07-03', '10:47:00', 2, '2023-07-03', '10:15:00', 32, 1, '2023-07-03 14:47:54', '2023-07-03 14:47:54'),
(3, 4, 3, 'DM-0003-HIS-FM', 'HIDRÁULICA', 'PRUEBA FALLA #2', '2023-07-06', '08:45:00', '2023-07-06', '12:46:00', 4, '2023-07-06', '11:00:00', 106, 4, '2023-07-06 16:46:41', '2023-07-06 16:46:41');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_tiempos`
--

CREATE TABLE `historial_tiempos` (
  `id` bigint UNSIGNED NOT NULL,
  `anio` int NOT NULL,
  `mes` int NOT NULL,
  `equipo_id` bigint UNSIGNED NOT NULL,
  `codificacion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_tiempo` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `historial_tiempos`
--

INSERT INTO `historial_tiempos` (`id`, `anio`, `mes`, `equipo_id`, `codificacion`, `total_tiempo`, `created_at`, `updated_at`) VALUES
(1, 2023, 1, 1, 'HD0001PP', 12090, '2023-06-28 15:38:08', '2023-06-28 15:38:08'),
(2, 2023, 4, 1, 'TD00002', 23010, '2023-06-28 15:39:12', '2023-06-28 15:39:12'),
(3, 2023, 8, 1, 'D000E1', 47190, '2023-07-07 21:10:58', '2023-07-07 21:10:58');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `indicadors`
--

CREATE TABLE `indicadors` (
  `id` bigint UNSIGNED NOT NULL,
  `nro` bigint NOT NULL,
  `tipo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `indicadors`
--

INSERT INTO `indicadors` (`id`, `nro`, `tipo`, `created_at`, `updated_at`) VALUES
(1, 2, 'MTBF', '2023-06-28 16:50:00', '2023-07-07 21:11:21');

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

--
-- Volcado de datos para la tabla `kardex_repuestos`
--

INSERT INTO `kardex_repuestos` (`id`, `tipo_registro`, `registro_id`, `repuesto_id`, `detalle`, `precio`, `tipo_is`, `cantidad_ingreso`, `cantidad_salida`, `cantidad_saldo`, `cu`, `monto_ingreso`, `monto_salida`, `monto_saldo`, `fecha`, `created_at`, `updated_at`) VALUES
(2, 'ENTRADA', 4, 1, 'VALOR INICIAL', 560.00, 'INGRESO', 100, NULL, 100, 560.00, 56000.00, NULL, 56000.00, '2023-06-19', '2023-06-19 18:08:05', '2023-07-05 15:38:42'),
(3, 'ENTRADA', 5, 2, 'VALOR INICIAL', 50.00, 'INGRESO', 100, NULL, 100, 300.00, 5000.00, NULL, 5000.00, '2023-06-19', '2023-06-19 18:08:20', '2023-06-19 18:08:20'),
(4, 'ENTRADA', 6, 3, 'VALOR INICIAL', 50.00, 'INGRESO', 100, NULL, 100, 900.00, 5000.00, NULL, 5000.00, '2023-06-19', '2023-06-19 18:08:36', '2023-06-19 18:08:36'),
(6, 'DETALLE REPUESTO', 1, 1, 'ASIGNACIÓN DE REPUESTO DESDE VISUALIZACIÓN DE OT', 560.00, 'EGRESO', NULL, 5, 95, 560.00, NULL, 2800.00, 53200.00, '2023-06-22', '2023-06-22 16:24:59', '2023-07-05 15:38:42'),
(7, 'DETALLE REPUESTO', 2, 3, 'ASIGNACIÓN DE REPUESTO DESDE VISUALIZACIÓN DE OT', 900.00, 'EGRESO', NULL, 3, 97, 900.00, NULL, 2700.00, 2300.00, '2023-06-22', '2023-06-22 16:25:45', '2023-06-22 16:25:45'),
(8, 'DETALLE REPUESTO', 3, 1, 'ASIGNACIÓN DE REPUESTO DESDE VISUALIZACIÓN DE OT', 560.00, 'EGRESO', NULL, 5, 90, 560.00, NULL, 2800.00, 50400.00, '2023-06-22', '2023-06-22 19:43:02', '2023-07-05 15:38:42');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `maquinarias`
--

CREATE TABLE `maquinarias` (
  `id` bigint UNSIGNED NOT NULL,
  `equipo_id` bigint UNSIGNED NOT NULL,
  `codificacion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
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

INSERT INTO `maquinarias` (`id`, `equipo_id`, `codificacion`, `descripcion`, `prioridad`, `ubicacion`, `tipo`, `marca`, `modelo`, `serie`, `costo`, `fecha_compra`, `fecha_instalacion`, `garantia_meses`, `peso`, `altura`, `ancho`, `largo`, `voltios`, `capacidad`, `e_tecnicas`, `fecha_ultimo_mantenimiento`, `fecha_utlimo_termino`, `estado`, `fabricantes`, `proveedor`, `terciarios`, `nombre_contacto`, `num_fono`, `correo`, `dir`, `num_identificacion`, `foto`, `archivo`, `created_at`, `updated_at`) VALUES
(1, 1, 'HVF001LP', 'MAQUINARIA #1', 'P1-URGENTE', 'PRODUCCIÓN', 'REFRIGERACIÓN', 'MARCA 1', 'MODELO 1', 'SERIE 1', 1000.00, '2023-01-01', '2023-06-05', 24, '100 KG', '2M', '1M', '1M', '140 VOLTIOS', '300KG', 'ESPEC. TECNICAS', '0223-06-05', '2023-08-08', 'ACTIVA', 'FABRICANTE 1', 'PROVEEDOR 1', 'TERCIARIO 1', 'JUAN PERES', '7777', 'PROVEEDOR@GMAIL.COM', 'LOS OLIVOS', '232332', NULL, '', '2023-06-05 17:16:25', '2023-06-14 15:23:19'),
(2, 2, 'HP002LP', 'MAQUINARIA #2', 'P2-ALTA', 'PATIO', 'COMPRESIÓN', 'MARCA 2', 'MODELO 2', 'SERIE 2', 2500.00, '2023-01-03', '2023-06-04', 24, '200KG', '2M', '1M', '1M', '120VOLTIOS', '500KG', 'ESPEC. TECNICAS MAQUINA #2', '0223-06-04', '2023-06-06', 'INDISPUESTA', 'FABRICANTE 2', 'PROVEEDOR 2', 'TERCIARIO 2', 'ALBERTO GONZALES', '6666666', 'PROVEEDOR@GMAIL.COM', 'LOS OLIVOS', '232332', '21686003889.png', '21686004196.pdf', '2023-06-05 22:05:32', '2023-06-14 15:23:32'),
(4, 2, 'COO003EET', 'DESC. MAQUINARIA #3', 'P3-MEDIA', 'PATIO', 'REFRIGERACIÓN', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ACTIVA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-06-14 15:32:36', '2023-06-14 15:32:36');

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
(17, '2023_06_07_130719_create_kardex_repuestos_table', 3),
(18, '2023_06_12_143249_create_personals_table', 4),
(19, '2023_06_12_143616_create_familias_table', 4),
(20, '2023_06_12_143627_create_sub_familias_table', 4),
(21, '2023_06_12_143640_create_gama_mantenimientos_table', 4),
(22, '2023_06_12_143713_create_plan_mantenimientos_table', 4),
(23, '2023_06_12_143811_create_orden_trabajos_table', 4),
(24, '2023_06_12_143900_create_orden_generadas_table', 4),
(25, '2023_06_12_143928_create_detalle_repuestos_table', 4),
(26, '2023_06_12_144025_create_detalle_herramientas_table', 4),
(27, '2023_06_12_144035_create_detalle_personals_table', 4),
(28, '2023_06_12_144111_create_pedido_repuestos_table', 4),
(29, '2023_06_12_144309_create_gama_detalles_table', 4),
(30, '2023_06_12_144656_create_notificacions_table', 4),
(31, '2023_06_12_144706_create_notificacion_users_table', 4),
(32, '2023_06_12_150032_create_programacions_table', 4),
(33, '2023_06_12_152430_create_detalle_pedidos_table', 4),
(34, '2023_06_22_172351_create_historial_fallas_table', 5),
(35, '2023_06_27_111215_create_historial_tiempos_table', 6),
(36, '2023_06_27_111349_create_detalle_tiempos_table', 7),
(37, '2023_06_28_114825_create_indicadors_table', 8),
(38, '2023_06_28_161015_create_modelo_deterministicos_table', 9),
(39, '2023_07_03_124648_create_modelo_repuestos_table', 10);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modelo_deterministicos`
--

CREATE TABLE `modelo_deterministicos` (
  `id` bigint UNSIGNED NOT NULL,
  `codigo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci,
  `repuesto_id` bigint UNSIGNED NOT NULL,
  `sm` decimal(24,2) DEFAULT NULL,
  `it` decimal(24,2) DEFAULT NULL,
  `cpo` decimal(24,2) DEFAULT NULL,
  `ct_ordenar` decimal(24,2) DEFAULT NULL,
  `c_ins` decimal(24,2) DEFAULT NULL,
  `c_em` decimal(24,2) DEFAULT NULL,
  `c_ordenar` decimal(24,2) DEFAULT NULL,
  `precio_compra` decimal(24,2) DEFAULT NULL,
  `ct_adqui` decimal(24,2) DEFAULT NULL,
  `c_impor` decimal(24,2) DEFAULT NULL,
  `c_alma_ext` decimal(24,2) DEFAULT NULL,
  `oc_adqui` decimal(24,2) DEFAULT NULL,
  `c_adqui` decimal(24,2) DEFAULT NULL,
  `c_alqui` decimal(24,2) DEFAULT NULL,
  `area_ocupada` double(24,2) DEFAULT NULL,
  `c_espa` decimal(24,2) DEFAULT NULL,
  `vp_rep` decimal(24,2) DEFAULT NULL,
  `cantp_rep` double(24,2) DEFAULT NULL,
  `costop_rep` decimal(24,2) DEFAULT NULL,
  `tasa_ia` decimal(24,2) DEFAULT NULL,
  `tasa_ia_calculado` decimal(24,2) DEFAULT NULL,
  `costo_capital` decimal(24,2) DEFAULT NULL,
  `ct_almacenamiento` decimal(24,2) DEFAULT NULL,
  `c_depreciacion` decimal(24,2) DEFAULT NULL,
  `c_gi` decimal(24,2) DEFAULT NULL,
  `oc_mantenimiento` decimal(24,2) DEFAULT NULL,
  `c_mantenimiento` decimal(24,2) DEFAULT NULL,
  `leadtime` decimal(24,2) DEFAULT NULL,
  `procesamiento_pedido` double(24,2) DEFAULT NULL,
  `procesamiento_pedido_calculado` decimal(24,2) DEFAULT NULL,
  `fabricacion_productos` double(24,2) DEFAULT NULL,
  `tiempo_transito` double(24,2) DEFAULT NULL,
  `inspeccion_control` double(24,2) DEFAULT NULL,
  `unidad` double(24,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `modelo_deterministicos`
--

INSERT INTO `modelo_deterministicos` (`id`, `codigo`, `nombre`, `descripcion`, `repuesto_id`, `sm`, `it`, `cpo`, `ct_ordenar`, `c_ins`, `c_em`, `c_ordenar`, `precio_compra`, `ct_adqui`, `c_impor`, `c_alma_ext`, `oc_adqui`, `c_adqui`, `c_alqui`, `area_ocupada`, `c_espa`, `vp_rep`, `cantp_rep`, `costop_rep`, `tasa_ia`, `tasa_ia_calculado`, `costo_capital`, `ct_almacenamiento`, `c_depreciacion`, `c_gi`, `oc_mantenimiento`, `c_mantenimiento`, `leadtime`, `procesamiento_pedido`, `procesamiento_pedido_calculado`, `fabricacion_productos`, `tiempo_transito`, `inspeccion_control`, `unidad`, `created_at`, `updated_at`) VALUES
(1, 'MD001PP', 'MODELO DETERMINISTICO #1', 'DESC. MODELO DET. #1', 1, 6000.00, 60.00, 166.67, 1200.00, 300.00, 400.00, 2066.67, 5000.00, 1000.00, 1000.00, 1000.00, 0.00, 8000.00, 500.00, 20.00, 10000.00, 16800.00, 30.00, 560.00, 300.00, 0.75, 420.00, 10420.00, 156.25, 166.67, 300.00, 11042.92, 82.00, 48.00, 2.00, 30.00, 20.00, 30.00, 12.00, '2023-06-30 17:15:41', '2023-07-03 16:44:23');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modelo_repuestos`
--

CREATE TABLE `modelo_repuestos` (
  `id` bigint UNSIGNED NOT NULL,
  `repuesto_id` bigint UNSIGNED NOT NULL,
  `anio_ini` int NOT NULL,
  `trimestre_ini` int NOT NULL,
  `anio_fin` int NOT NULL,
  `trimestre_fin` int NOT NULL,
  `demanda` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `modelo_repuestos`
--

INSERT INTO `modelo_repuestos` (`id`, `repuesto_id`, `anio_ini`, `trimestre_ini`, `anio_fin`, `trimestre_fin`, `demanda`, `created_at`, `updated_at`) VALUES
(1, 1, 2023, 1, 2023, 3, -246.94, '2023-07-03 17:40:14', '2023-07-07 21:17:25');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notificacions`
--

CREATE TABLE `notificacions` (
  `id` bigint UNSIGNED NOT NULL,
  `notificacion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `registro_id` bigint UNSIGNED NOT NULL,
  `tipo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `notificacions`
--

INSERT INTO `notificacions` (`id`, `notificacion`, `registro_id`, `tipo`, `created_at`, `updated_at`) VALUES
(3, 'ASIGNACIÓN DE ORDEN DE TRABAJO', 1, 'GENERACIÓN DE OT', '2023-06-19 21:55:15', '2023-06-19 21:55:15'),
(4, 'ASIGNACIÓN DE ORDEN DE TRABAJO', 2, 'GENERACIÓN DE OT', '2023-06-19 22:06:45', '2023-06-19 22:06:45'),
(5, 'ORDEN DE PEDIDO DE REPUESTO', 3, 'PEDIDO DE REPUESTO', '2023-06-20 17:24:52', '2023-06-20 17:24:52'),
(7, 'CAMBIO DE ESTADO OT: 2', 2, 'CAMBIO DE ESTADO OT', '2023-06-22 21:05:05', '2023-06-22 21:05:05'),
(8, 'CAMBIO DE ESTADO OT: 2', 2, 'CAMBIO DE ESTADO OT', '2023-06-22 21:41:37', '2023-06-22 21:41:37'),
(10, 'CAMBIO DE ESTADO OT: 2', 2, 'CAMBIO DE ESTADO OT', '2023-07-03 14:22:55', '2023-07-03 14:22:55'),
(11, 'CAMBIO DE ESTADO OT: 4', 4, 'CAMBIO DE ESTADO OT', '2023-07-06 16:45:46', '2023-07-06 16:45:46');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notificacion_users`
--

CREATE TABLE `notificacion_users` (
  `id` bigint UNSIGNED NOT NULL,
  `notificacion_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `visto` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `notificacion_users`
--

INSERT INTO `notificacion_users` (`id`, `notificacion_id`, `user_id`, `visto`, `created_at`, `updated_at`) VALUES
(1, 3, 4, 0, '2023-06-19 21:55:15', '2023-06-19 21:55:15'),
(2, 3, 5, 1, '2023-06-19 21:55:15', '2023-07-07 21:54:15'),
(3, 4, 5, 1, '2023-06-19 22:06:45', '2023-07-07 21:54:15'),
(4, 5, 6, 1, '2023-06-20 17:24:53', '2023-06-20 17:37:26'),
(6, 7, 5, 1, '2023-06-22 21:05:05', '2023-07-07 21:54:15'),
(7, 8, 5, 1, '2023-06-22 21:41:37', '2023-07-07 21:54:15'),
(9, 10, 5, 1, '2023-07-03 14:22:55', '2023-07-07 21:54:15'),
(10, 11, 5, 1, '2023-07-06 16:45:46', '2023-07-07 21:54:15');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `orden_generadas`
--

CREATE TABLE `orden_generadas` (
  `id` bigint UNSIGNED NOT NULL,
  `orden_id` bigint UNSIGNED NOT NULL,
  `archivo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `descripcion_documentacion` text COLLATE utf8mb4_unicode_ci,
  `comentario` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `orden_generadas`
--

INSERT INTO `orden_generadas` (`id`, `orden_id`, `archivo`, `descripcion_documentacion`, `comentario`, `created_at`, `updated_at`) VALUES
(1, 2, 'og_11687216595.pdf', 'DESC', 'COMENTARIO DE PRUEBA MODIFICADO', '2023-06-19 16:27:02', '2023-06-19 23:16:35'),
(2, 3, 'og_21687216587.pdf', NULL, NULL, '2023-06-19 16:29:30', '2023-06-19 23:16:27');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `orden_trabajos`
--

CREATE TABLE `orden_trabajos` (
  `id` bigint UNSIGNED NOT NULL,
  `fecha_programada` date NOT NULL,
  `hora_programada` time NOT NULL,
  `subunidad_id` bigint UNSIGNED NOT NULL,
  `gama_id` bigint UNSIGNED NOT NULL,
  `prioridad` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tiempo` double NOT NULL,
  `dias` double NOT NULL,
  `tipo_mantenimiento` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `hora_inicio` time DEFAULT NULL,
  `fecha_termino` date DEFAULT NULL,
  `hora_termino` time DEFAULT NULL,
  `tiempo_ejecucion` double DEFAULT NULL,
  `parada_maquina` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estado` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `razon` text COLLATE utf8mb4_unicode_ci,
  `comentario` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `orden_trabajos`
--

INSERT INTO `orden_trabajos` (`id`, `fecha_programada`, `hora_programada`, `subunidad_id`, `gama_id`, `prioridad`, `tiempo`, `dias`, `tipo_mantenimiento`, `fecha_inicio`, `hora_inicio`, `fecha_termino`, `hora_termino`, `tiempo_ejecucion`, `parada_maquina`, `estado`, `razon`, `comentario`, `created_at`, `updated_at`) VALUES
(2, '2023-07-03', '08:00:00', 1, 2, 'URGENTE', 17, 7, 'PREDICTIVO', '2023-07-03', '08:22:00', '2023-07-03', '10:47:00', 2, 'SI', 'TERMINADO', 'PRUEBA TERMINO DE OT + TIEMPO DE FALL', 'COMENTARIO', '2023-06-15 15:26:58', '2023-07-03 14:47:54'),
(3, '2023-07-01', '08:00:00', 2, 2, 'MODERADA', 17, 10, 'LUBRICACIÓN', NULL, NULL, NULL, NULL, NULL, NULL, 'PROGRAMADO', NULL, NULL, '2023-06-19 15:58:35', '2023-07-03 14:21:40'),
(4, '2023-07-04', '09:00:00', 4, 3, 'MODERADA', 360, 3, 'PREVENTIVO', '2023-07-06', '08:45:00', '2023-07-06', '12:46:00', 4, 'SI', 'TERMINADO', 'PRUEBA TERMINO CON FALLA #2', NULL, '2023-06-23 16:50:32', '2023-07-06 16:46:41');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedido_repuestos`
--

CREATE TABLE `pedido_repuestos` (
  `id` bigint UNSIGNED NOT NULL,
  `orden_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `pedido_repuestos`
--

INSERT INTO `pedido_repuestos` (`id`, `orden_id`, `created_at`, `updated_at`) VALUES
(3, 2, '2023-06-20 17:24:52', '2023-06-20 17:24:52');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personals`
--

CREATE TABLE `personals` (
  `id` bigint UNSIGNED NOT NULL,
  `tipo_mo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `razon_social` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nro_doc` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `especialidad` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `correo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telefono` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `domicilio` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `personals`
--

INSERT INTO `personals` (`id`, `tipo_mo`, `user_id`, `razon_social`, `nro_doc`, `especialidad`, `correo`, `telefono`, `domicilio`, `created_at`, `updated_at`) VALUES
(1, 'USUARIOS', 4, 'RAZON S.A. MODIFICADO', '3333', 'ESPECIALIDAD', 'AGUSTIN@GMAIL.COM', '77777; 66666', 'LOS OLIVOS', '2023-06-12 20:38:44', '2023-06-12 20:44:02'),
(3, 'SERVICIOS', NULL, 'SERVICE LTDA.', '90812', 'ESPECIALIDAD #2', 'SERV@GMAIL.COM', '2222', NULL, '2023-06-19 20:45:41', '2023-06-19 20:45:41'),
(4, 'TERCEROS', NULL, 'TERCEROS S.A.', '89329', 'ESPC. #3', 'TERC@GMAIL.COM', '66666', 'LOS OLIVOS', '2023-06-19 20:46:07', '2023-06-19 20:46:07');

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
-- Estructura de tabla para la tabla `plan_mantenimientos`
--

CREATE TABLE `plan_mantenimientos` (
  `id` bigint UNSIGNED NOT NULL,
  `codificacion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subunidad_id` bigint UNSIGNED NOT NULL,
  `gama_id` bigint UNSIGNED NOT NULL,
  `pm` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `prioridad` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tiempo` double NOT NULL,
  `dias` double DEFAULT NULL,
  `tipo_mantenimiento` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ultima_fecha_programada` date DEFAULT NULL,
  `ultima_fecha_terminada` date DEFAULT NULL,
  `programacion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_final` date DEFAULT NULL,
  `variable_control_id` bigint UNSIGNED NOT NULL,
  `frecuencia_id` bigint UNSIGNED NOT NULL,
  `estado` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `plan_mantenimientos`
--

INSERT INTO `plan_mantenimientos` (`id`, `codificacion`, `subunidad_id`, `gama_id`, `pm`, `prioridad`, `tiempo`, `dias`, `tipo_mantenimiento`, `ultima_fecha_programada`, `ultima_fecha_terminada`, `programacion`, `fecha_final`, `variable_control_id`, `frecuencia_id`, `estado`, `created_at`, `updated_at`) VALUES
(2, 'PM001HHH3', 1, 2, 'PM', 'URGENTE', 17, 10, 'PREVENTIVO', '2023-07-01', '2023-07-31', 'ÚLTIMA VEZ QUE SE PROGRAMÓ', '2023-07-31', 1, 1, 'PROGRAMADO', '2023-06-14 21:32:31', '2023-07-06 14:49:04'),
(3, 'PM0002UU', 2, 3, 'PM', 'MODERADO', 360, 3, 'PREVENTIVO', '2023-07-01', '2023-07-05', 'ÚLTIMA VEZ QUE SE TERMINÓ', '2023-07-31', 1, 1, 'PLANIFICADO', '2023-06-23 16:50:09', '2023-07-06 14:50:06');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `programacions`
--

CREATE TABLE `programacions` (
  `id` bigint UNSIGNED NOT NULL,
  `plan_mantenimiento_id` bigint UNSIGNED NOT NULL,
  `numero` int NOT NULL,
  `dias` double NOT NULL,
  `fecha` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `programacions`
--

INSERT INTO `programacions` (`id`, `plan_mantenimiento_id`, `numero`, `dias`, `fecha`, `created_at`, `updated_at`) VALUES
(17, 2, 1, 7, '2023-07-07', '2023-06-22 20:36:33', '2023-06-22 20:36:33'),
(18, 2, 2, 7, '2023-07-14', '2023-06-22 20:36:33', '2023-06-22 20:36:33'),
(19, 2, 3, 7, '2023-07-21', '2023-06-22 20:36:33', '2023-06-22 20:36:33'),
(20, 2, 4, 7, '2023-07-28', '2023-06-22 20:36:33', '2023-06-22 20:36:33'),
(21, 3, 1, 7, '2023-07-11', '2023-06-23 16:50:09', '2023-06-23 16:50:09'),
(22, 3, 2, 7, '2023-07-18', '2023-06-23 16:50:09', '2023-06-23 16:50:09'),
(23, 3, 3, 7, '2023-07-25', '2023-06-23 16:50:09', '2023-06-23 16:50:09');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `repuestos`
--

CREATE TABLE `repuestos` (
  `id` bigint UNSIGNED NOT NULL,
  `codigo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `codificacion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
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

INSERT INTO `repuestos` (`id`, `codigo`, `codificacion`, `nombre`, `descripcion`, `marca`, `modelo`, `serie`, `equipo_id`, `precio`, `stock_min`, `stock_max`, `stock_actual`, `unidad_medida`, `dir`, `fono`, `correo`, `almacen`, `fabricante`, `proveedor`, `terciarios`, `nombre_contacto`, `num_fono`, `correo_fabricante`, `dir_fabricante`, `num_identificacion`, `created_at`, `updated_at`) VALUES
(1, 'R001', 'RC001POPE', 'REPUESTO #1', 'DESC. REPUESTO #1 MODIFICADO', 'MARCA 1', 'MODELO 1', 'SERIE 1', 1, 560.00, 10, 200, 90, 'UNIDADES', 'LOS OLIVOS', '222222', 'PROVEEDOR@GMAIL.COM', 'ALMACEN 1', 'FABRICANTE 1', 'PROVEEDOR 1', 'TERCIARIO 1', 'JUAN PERES', '7777777', 'FABRICANTE@GMAIL.COM', 'LOS OLIVOS #2', '433434', '2023-06-07 17:01:13', '2023-07-05 15:38:42'),
(2, 'I001', 'I00012EIO', 'INSUMO #1', 'DESC. INSUMO #1', NULL, NULL, NULL, 2, 300.00, 5, 100, 100, NULL, NULL, NULL, NULL, 'ALMACEN 1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-06-07 17:05:13', '2023-06-19 18:08:20'),
(3, 'I003', 'I004IRR', 'REPUESTO #2', 'DESC. REP. #2', NULL, NULL, NULL, 2, 900.00, 4, 20, 97, NULL, NULL, NULL, NULL, 'ALMACEN', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-06-14 15:45:31', '2023-06-22 16:25:45');

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
(2, 2, 'S2', 'SISTEMA 2 MODIFICADO', '2023-06-01 17:16:37', '2023-06-01 17:16:45'),
(4, 1, 'S3', 'SISTEMA #3', '2023-06-20 19:26:32', '2023-06-20 19:26:32'),
(5, 2, 'S4', 'SISTEMA 4', '2023-06-20 19:26:41', '2023-06-20 19:26:41');

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
(2, 2, 2, 2, 'SUB2', 'SUBUNIDAD #2', '32', 'SUB2-32', '2023-06-01 20:13:37', '2023-06-01 20:13:46'),
(4, 1, 1, 1, 'S003', 'SUBUNIDAD 3', '12', 'S003-12', '2023-06-20 19:24:28', '2023-06-20 19:24:28'),
(5, 1, 5, 5, '1001', 'BOMBA', '01', '1001-01', '2023-06-20 19:28:17', '2023-06-20 19:28:17'),
(6, 1, 4, 4, '1002', 'PRUEBA 2', '01', '1002-01', '2023-06-20 19:29:24', '2023-06-20 19:29:24');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sub_familias`
--

CREATE TABLE `sub_familias` (
  `id` bigint UNSIGNED NOT NULL,
  `familia_id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `sub_familias`
--

INSERT INTO `sub_familias` (`id`, `familia_id`, `nombre`, `created_at`, `updated_at`) VALUES
(1, 1, 'SUBFAMILIA #1 MODIFICADO', '2023-06-13 15:22:07', '2023-06-13 15:23:19');

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
  `tipo` enum('ADMINISTRADOR','GERENTE','GERENTE DE PRODUCCIÓN','JEFE DE MANTENIMIENTO','SUPERVISOR DE COMPRAS','AUXILIAR DE MANTENIMIENTO','AUXILIAR DE ALMACÉN') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
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
(2, 'JPERES', 'JUAN', 'PERES', 'MAMANI', '1111', 'LP', '', '', '', '', 'GERENTE', 'default.png', '$2y$10$t1vtRZ48507H2YKWgrU02Olg8W6bhN8yV8PduODfUJeMSIXEzqF/e', 1, '2023-06-01', '2023-06-01 15:39:49', '2023-06-15 15:32:28'),
(3, 'JGONZALES', 'JOSE ALBERTO', 'GONZALES', 'CONDORI', '2222', 'CB', 'ESPECIALIDAD', 'LOS OLIVOS', 'jose@gmail.com', '222222; 777777', 'GERENTE DE PRODUCCIÓN', '1685634062_JGONZALES.jpg', '$2y$10$KHi883Cz5Us3yixbNjs7cuxIWYst68Dkp6xZpJprokMjSYVvQpQUK', 1, '2023-06-01', '2023-06-01 15:41:02', '2023-06-01 15:42:49'),
(4, 'ACONDORI', 'AGUSTIN', 'CONDORI', 'CONDORI', '3333', 'LP', 'ESPECIALIDAD', 'LOS OLIVOS', 'agustin@gmail.com', '77777; 66666', 'AUXILIAR DE MANTENIMIENTO', 'default.png', '$2y$10$1597Bo.Ua1Erz4IpnwIwqOWr9okA.2QX9HAH8l6tHAwnjbanPmEu6', 1, '2023-06-12', '2023-06-12 20:31:19', '2023-06-12 20:37:16'),
(5, 'JMARTINEZ', 'JAVIER', 'MARTINEZ', 'CARVAJAL', '4444', 'LP', 'ESPECIALIDAD #4', 'LOS OLIVOS', '', '', 'JEFE DE MANTENIMIENTO', 'default.png', '$2y$10$7x/LueWPTLqj7O3rmGeui.CHkOn0QYuylolsX/PX1aO6UNbHVbxIe', 1, '2023-06-19', '2023-06-19 21:13:00', '2023-06-19 21:13:00'),
(6, 'MMAMANI', 'MARIA', 'MAMANI', 'MAMANI', '5555', 'LP', 'ESPECIALIDAD #5', '', '', '', 'SUPERVISOR DE COMPRAS', 'default.png', '$2y$10$ErNwHw25OFa0/Rc1kaIGUe40JW8Bge5tGYFoDNATrOHyrgmK2mXfq', 1, '2023-06-20', '2023-06-20 17:18:50', '2023-06-20 17:18:50'),
(7, 'FPAREDES', 'FERNANDO', 'PAREDES', 'PAREDES', '6666', 'LP', '', 'LOS OLIVOS', '', '', 'AUXILIAR DE ALMACÉN', 'default.png', '$2y$10$W5grEj2.hONh6dme/rXEDeFwPw3MW4ySuv3A6JT49ieCpSpqihyIK', 1, '2023-07-07', '2023-07-07 21:30:23', '2023-07-07 21:30:23');

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
(1, 'VARIABLE CONTROL #1', 'DÍAS', '2023-06-06 15:05:22', '2023-06-14 20:51:36'),
(2, 'VARIABLE #2', 'DÍAS', '2023-06-06 15:05:33', '2023-06-14 20:51:31');

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
-- Indices de la tabla `detalle_herramientas`
--
ALTER TABLE `detalle_herramientas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `detalle_herramientas_orden_generada_id_foreign` (`orden_generada_id`),
  ADD KEY `detalle_herramientas_herramienta_id_foreign` (`herramienta_id`);

--
-- Indices de la tabla `detalle_pedidos`
--
ALTER TABLE `detalle_pedidos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `detalle_pedidos_pedido_repuesto_id_foreign` (`pedido_repuesto_id`),
  ADD KEY `detalle_pedidos_repuesto_id_foreign` (`repuesto_id`);

--
-- Indices de la tabla `detalle_personals`
--
ALTER TABLE `detalle_personals`
  ADD PRIMARY KEY (`id`),
  ADD KEY `detalle_personals_orden_generada_id_foreign` (`orden_generada_id`),
  ADD KEY `detalle_personals_personal_id_foreign` (`personal_id`);

--
-- Indices de la tabla `detalle_repuestos`
--
ALTER TABLE `detalle_repuestos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `detalle_repuestos_orden_generada_id_foreign` (`orden_generada_id`),
  ADD KEY `detalle_repuestos_repuesto_id_foreign` (`repuesto_id`);

--
-- Indices de la tabla `detalle_tiempos`
--
ALTER TABLE `detalle_tiempos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `detalle_tiempos_historial_tiempo_id_foreign` (`historial_tiempo_id`);

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
-- Indices de la tabla `familias`
--
ALTER TABLE `familias`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `familias_codigo_unique` (`codigo`);

--
-- Indices de la tabla `frecuencias`
--
ALTER TABLE `frecuencias`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `gama_detalles`
--
ALTER TABLE `gama_detalles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `gama_detalles_gama_id_foreign` (`gama_id`);

--
-- Indices de la tabla `gama_mantenimientos`
--
ALTER TABLE `gama_mantenimientos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `gama_mantenimientos_codigo_unique` (`codigo`),
  ADD KEY `gama_mantenimientos_equipo_id_foreign` (`equipo_id`);

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
-- Indices de la tabla `historial_fallas`
--
ALTER TABLE `historial_fallas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `historial_tiempos`
--
ALTER TABLE `historial_tiempos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `historial_tiempos_equipo_id_foreign` (`equipo_id`);

--
-- Indices de la tabla `indicadors`
--
ALTER TABLE `indicadors`
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
-- Indices de la tabla `modelo_deterministicos`
--
ALTER TABLE `modelo_deterministicos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `modelo_deterministicos_codigo_unique` (`codigo`);

--
-- Indices de la tabla `modelo_repuestos`
--
ALTER TABLE `modelo_repuestos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `notificacions`
--
ALTER TABLE `notificacions`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `notificacion_users`
--
ALTER TABLE `notificacion_users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notificacion_users_notificacion_id_foreign` (`notificacion_id`),
  ADD KEY `notificacion_users_user_id_foreign` (`user_id`);

--
-- Indices de la tabla `orden_generadas`
--
ALTER TABLE `orden_generadas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `orden_trabajos`
--
ALTER TABLE `orden_trabajos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `orden_trabajos_subunidad_id_foreign` (`subunidad_id`),
  ADD KEY `orden_trabajos_gama_id_foreign` (`gama_id`);

--
-- Indices de la tabla `pedido_repuestos`
--
ALTER TABLE `pedido_repuestos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `personals`
--
ALTER TABLE `personals`
  ADD PRIMARY KEY (`id`),
  ADD KEY `personals_user_id_foreign` (`user_id`);

--
-- Indices de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indices de la tabla `plan_mantenimientos`
--
ALTER TABLE `plan_mantenimientos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `programacions`
--
ALTER TABLE `programacions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `programacions_plan_mantenimiento_id_foreign` (`plan_mantenimiento_id`);

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
-- Indices de la tabla `sub_familias`
--
ALTER TABLE `sub_familias`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sub_familias_familia_id_foreign` (`familia_id`);

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
-- AUTO_INCREMENT de la tabla `detalle_herramientas`
--
ALTER TABLE `detalle_herramientas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `detalle_pedidos`
--
ALTER TABLE `detalle_pedidos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `detalle_personals`
--
ALTER TABLE `detalle_personals`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `detalle_repuestos`
--
ALTER TABLE `detalle_repuestos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `detalle_tiempos`
--
ALTER TABLE `detalle_tiempos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=93;

--
-- AUTO_INCREMENT de la tabla `entrada_herramientas`
--
ALTER TABLE `entrada_herramientas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `entrada_repuestos`
--
ALTER TABLE `entrada_repuestos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `equipos`
--
ALTER TABLE `equipos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `familias`
--
ALTER TABLE `familias`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `frecuencias`
--
ALTER TABLE `frecuencias`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `gama_detalles`
--
ALTER TABLE `gama_detalles`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `gama_mantenimientos`
--
ALTER TABLE `gama_mantenimientos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `herramientas`
--
ALTER TABLE `herramientas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `historial_accions`
--
ALTER TABLE `historial_accions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=243;

--
-- AUTO_INCREMENT de la tabla `historial_fallas`
--
ALTER TABLE `historial_fallas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `historial_tiempos`
--
ALTER TABLE `historial_tiempos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `indicadors`
--
ALTER TABLE `indicadors`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `kardex_repuestos`
--
ALTER TABLE `kardex_repuestos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `maquinarias`
--
ALTER TABLE `maquinarias`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT de la tabla `modelo_deterministicos`
--
ALTER TABLE `modelo_deterministicos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `modelo_repuestos`
--
ALTER TABLE `modelo_repuestos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `notificacions`
--
ALTER TABLE `notificacions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `notificacion_users`
--
ALTER TABLE `notificacion_users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `orden_generadas`
--
ALTER TABLE `orden_generadas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `orden_trabajos`
--
ALTER TABLE `orden_trabajos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `pedido_repuestos`
--
ALTER TABLE `pedido_repuestos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `personals`
--
ALTER TABLE `personals`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `plan_mantenimientos`
--
ALTER TABLE `plan_mantenimientos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `programacions`
--
ALTER TABLE `programacions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT de la tabla `repuestos`
--
ALTER TABLE `repuestos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `sistemas`
--
ALTER TABLE `sistemas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `subunidads`
--
ALTER TABLE `subunidads`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `sub_familias`
--
ALTER TABLE `sub_familias`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `variable_controls`
--
ALTER TABLE `variable_controls`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `detalle_herramientas`
--
ALTER TABLE `detalle_herramientas`
  ADD CONSTRAINT `detalle_herramientas_herramienta_id_foreign` FOREIGN KEY (`herramienta_id`) REFERENCES `herramientas` (`id`),
  ADD CONSTRAINT `detalle_herramientas_orden_generada_id_foreign` FOREIGN KEY (`orden_generada_id`) REFERENCES `orden_generadas` (`id`);

--
-- Filtros para la tabla `detalle_pedidos`
--
ALTER TABLE `detalle_pedidos`
  ADD CONSTRAINT `detalle_pedidos_pedido_repuesto_id_foreign` FOREIGN KEY (`pedido_repuesto_id`) REFERENCES `pedido_repuestos` (`id`),
  ADD CONSTRAINT `detalle_pedidos_repuesto_id_foreign` FOREIGN KEY (`repuesto_id`) REFERENCES `repuestos` (`id`);

--
-- Filtros para la tabla `detalle_personals`
--
ALTER TABLE `detalle_personals`
  ADD CONSTRAINT `detalle_personals_orden_generada_id_foreign` FOREIGN KEY (`orden_generada_id`) REFERENCES `orden_generadas` (`id`),
  ADD CONSTRAINT `detalle_personals_personal_id_foreign` FOREIGN KEY (`personal_id`) REFERENCES `personals` (`id`);

--
-- Filtros para la tabla `detalle_repuestos`
--
ALTER TABLE `detalle_repuestos`
  ADD CONSTRAINT `detalle_repuestos_orden_generada_id_foreign` FOREIGN KEY (`orden_generada_id`) REFERENCES `orden_generadas` (`id`),
  ADD CONSTRAINT `detalle_repuestos_repuesto_id_foreign` FOREIGN KEY (`repuesto_id`) REFERENCES `repuestos` (`id`);

--
-- Filtros para la tabla `detalle_tiempos`
--
ALTER TABLE `detalle_tiempos`
  ADD CONSTRAINT `detalle_tiempos_historial_tiempo_id_foreign` FOREIGN KEY (`historial_tiempo_id`) REFERENCES `historial_tiempos` (`id`);

--
-- Filtros para la tabla `equipos`
--
ALTER TABLE `equipos`
  ADD CONSTRAINT `equipos_area_id_foreign` FOREIGN KEY (`area_id`) REFERENCES `areas` (`id`),
  ADD CONSTRAINT `equipos_sistema_id_foreign` FOREIGN KEY (`sistema_id`) REFERENCES `sistemas` (`id`);

--
-- Filtros para la tabla `gama_detalles`
--
ALTER TABLE `gama_detalles`
  ADD CONSTRAINT `gama_detalles_gama_id_foreign` FOREIGN KEY (`gama_id`) REFERENCES `gama_mantenimientos` (`id`);

--
-- Filtros para la tabla `gama_mantenimientos`
--
ALTER TABLE `gama_mantenimientos`
  ADD CONSTRAINT `gama_mantenimientos_equipo_id_foreign` FOREIGN KEY (`equipo_id`) REFERENCES `equipos` (`id`);

--
-- Filtros para la tabla `historial_tiempos`
--
ALTER TABLE `historial_tiempos`
  ADD CONSTRAINT `historial_tiempos_equipo_id_foreign` FOREIGN KEY (`equipo_id`) REFERENCES `equipos` (`id`);

--
-- Filtros para la tabla `notificacion_users`
--
ALTER TABLE `notificacion_users`
  ADD CONSTRAINT `notificacion_users_notificacion_id_foreign` FOREIGN KEY (`notificacion_id`) REFERENCES `notificacions` (`id`),
  ADD CONSTRAINT `notificacion_users_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `orden_trabajos`
--
ALTER TABLE `orden_trabajos`
  ADD CONSTRAINT `orden_trabajos_gama_id_foreign` FOREIGN KEY (`gama_id`) REFERENCES `gama_mantenimientos` (`id`),
  ADD CONSTRAINT `orden_trabajos_subunidad_id_foreign` FOREIGN KEY (`subunidad_id`) REFERENCES `subunidads` (`id`);

--
-- Filtros para la tabla `personals`
--
ALTER TABLE `personals`
  ADD CONSTRAINT `personals_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `programacions`
--
ALTER TABLE `programacions`
  ADD CONSTRAINT `programacions_plan_mantenimiento_id_foreign` FOREIGN KEY (`plan_mantenimiento_id`) REFERENCES `plan_mantenimientos` (`id`);

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

--
-- Filtros para la tabla `sub_familias`
--
ALTER TABLE `sub_familias`
  ADD CONSTRAINT `sub_familias_familia_id_foreign` FOREIGN KEY (`familia_id`) REFERENCES `familias` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
