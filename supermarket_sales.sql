-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 22-05-2023 a las 21:08:30
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `supermarket_sales`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `dim_branch`
--

CREATE TABLE `dim_branch` (
  `id` int(10) UNSIGNED NOT NULL,
  `branch` char(1) NOT NULL,
  `city` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `dim_customer`
--

CREATE TABLE `dim_customer` (
  `id` int(10) UNSIGNED NOT NULL,
  `gender` varchar(32) NOT NULL,
  `type` varchar(32) NOT NULL,
  `payment_method` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `dim_datetime`
--

CREATE TABLE `dim_datetime` (
  `id` int(10) UNSIGNED NOT NULL,
  `year` tinyint(3) UNSIGNED NOT NULL,
  `month` tinyint(3) UNSIGNED NOT NULL,
  `day` tinyint(3) UNSIGNED NOT NULL,
  `hour` tinyint(3) UNSIGNED NOT NULL,
  `minute` tinyint(3) UNSIGNED NOT NULL,
  `datetime` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `dim_product`
--

CREATE TABLE `dim_product` (
  `id` int(10) UNSIGNED NOT NULL,
  `line` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `fact_sale`
--

CREATE TABLE `fact_sale` (
  `id` int(10) UNSIGNED NOT NULL,
  `branch_id` int(10) UNSIGNED NOT NULL,
  `customer_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `datetime_id` int(10) UNSIGNED NOT NULL,
  `unit_price` decimal(6,2) NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL,
  `five_percent_tax` decimal(8,4) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `cogs` decimal(6,2) NOT NULL,
  `gross_margin_percentage` decimal(12,10) NOT NULL,
  `gross_margin` decimal(8,4) NOT NULL,
  `rating` float(4,1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `dim_branch`
--
ALTER TABLE `dim_branch`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `dim_customer`
--
ALTER TABLE `dim_customer`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `dim_datetime`
--
ALTER TABLE `dim_datetime`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `dim_product`
--
ALTER TABLE `dim_product`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `fact_sale`
--
ALTER TABLE `fact_sale`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_sale_branch` (`branch_id`),
  ADD KEY `fk_sale_customer` (`customer_id`),
  ADD KEY `fk_sale_product` (`product_id`),
  ADD KEY `fk_sale_datetime` (`datetime_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `dim_branch`
--
ALTER TABLE `dim_branch`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `dim_customer`
--
ALTER TABLE `dim_customer`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `dim_datetime`
--
ALTER TABLE `dim_datetime`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `dim_product`
--
ALTER TABLE `dim_product`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `fact_sale`
--
ALTER TABLE `fact_sale`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `fact_sale`
--
ALTER TABLE `fact_sale`
  ADD CONSTRAINT `fk_sale_branch` FOREIGN KEY (`branch_id`) REFERENCES `dim_branch` (`id`),
  ADD CONSTRAINT `fk_sale_customer` FOREIGN KEY (`customer_id`) REFERENCES `dim_customer` (`id`),
  ADD CONSTRAINT `fk_sale_datetime` FOREIGN KEY (`datetime_id`) REFERENCES `dim_datetime` (`id`),
  ADD CONSTRAINT `fk_sale_product` FOREIGN KEY (`product_id`) REFERENCES `dim_product` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
