-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 21, 2025 at 02:24 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `logistics_shipping_system`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetShipmentWeight` (IN `shipmentId` INT)   BEGIN
    DECLARE totalWeight DECIMAL(10,2);

    SELECT 
        SUM(CAST(REPLACE(i.weight, 'kg', '') AS DECIMAL(10))) 
    INTO totalWeight
    FROM item_copy ic
    INNER JOIN item i ON ic.original_item_id = i.id
    WHERE ic.shipment_id = shipmentId;

    SELECT shipmentId AS Shipment_ID, 
           IFNULL(totalWeight, 0) AS Total_Weight_KG;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `arrived_orders`
--

CREATE TABLE `arrived_orders` (
  `id` int(11) NOT NULL,
  `shipment_id` int(11) DEFAULT NULL,
  `arrived_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `client`
--

CREATE TABLE `client` (
  `id` int(11) NOT NULL,
  `fullname` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `contact_number` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `client`
--

INSERT INTO `client` (`id`, `fullname`, `email`, `contact_number`) VALUES
(1, 'Asma Warren', 'ASH@gmail.com', '+27 856750890'),
(2, 'John doe', 'john@gmail.com', '+1 3052377089'),
(3, 'Arun Banks', 'Banks@gmail.com', '+1 8269531256'),
(4, 'Rodney Mccall', 'RM@gmail.com', '+54 92346541922'),
(5, 'Leanne Buchanan', 'Leanne@gmail.com', '+592 5108807');

-- --------------------------------------------------------

--
-- Table structure for table `customs_officers`
--

CREATE TABLE `customs_officers` (
  `id` int(11) NOT NULL,
  `fullname` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customs_officers`
--

INSERT INTO `customs_officers` (`id`, `fullname`, `email`) VALUES
(1, 'Mark Zuckerduck', 'zuckerdodo@amazad.net'),
(2, 'Joe Mahamas', 'yoma@jokes.you'),
(3, 'John Pork', 'johnpork@gmail.clam');

-- --------------------------------------------------------

--
-- Table structure for table `delays`
--

CREATE TABLE `delays` (
  `id` int(11) NOT NULL,
  `reason` varchar(100) DEFAULT NULL,
  `delay_log_time` datetime DEFAULT NULL,
  `new_expected_date` datetime DEFAULT NULL,
  `transport_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `item`
--

CREATE TABLE `item` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `weight` varchar(10) DEFAULT NULL,
  `dimensions` varchar(100) DEFAULT NULL,
  `customs_category` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `item`
--

INSERT INTO `item` (`id`, `name`, `weight`, `dimensions`, `customs_category`) VALUES
(1, 'R&M Mugs', '50kg', '5000mmX15000mm', 'cutlery'),
(2, 'APEX Knife', '1kg', '500mmX1000mm', 'cutlery'),
(3, 'Smith table', '20kg', '15000mmX15000mm', 'furniture'),
(4, 'ASUS gaming pc', '10kg', '5000mmX15000mm', 'tech'),
(5, 'PnA note books', '50kg', '50000mmX15000mm', 'stationery');

-- --------------------------------------------------------

--
-- Table structure for table `item_copy`
--

CREATE TABLE `item_copy` (
  `id` int(11) NOT NULL,
  `client_id` int(11) DEFAULT NULL,
  `shipment_id` int(11) DEFAULT NULL,
  `original_item_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `item_copy`
--

INSERT INTO `item_copy` (`id`, `client_id`, `shipment_id`, `original_item_id`) VALUES
(22, 1, 30, 1),
(23, 1, 30, 4),
(24, 2, 31, 2),
(25, 2, 32, 5),
(26, 4, 33, 4),
(27, 3, 33, 2),
(28, 5, 32, 3);

-- --------------------------------------------------------

--
-- Table structure for table `location`
--

CREATE TABLE `location` (
  `id` int(11) NOT NULL,
  `country` varchar(50) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `address` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `location`
--

INSERT INTO `location` (`id`, `country`, `city`, `address`) VALUES
(1, 'America', 'Newyork', '75 3rd Ave, New York, NY 10003, USA'),
(2, 'America', 'Newyork', 'East 14th Street, New York, NY 10003, United States'),
(3, 'France', 'Paris', '125 Bd Jean Jaurès, 92110 Clichy, France'),
(4, 'Spain', 'Barcelona', 'Carrer de Melcior de Palau, 157, Sants-Montjuïc, 08014 Barcelona, Spain'),
(5, 'Russia', 'Moscow', 'Ulitsa Kolmogorova, 1, Moscow, Russia, 119991'),
(6, 'India', 'Mumbai', '40, Rd Number 24, near Sies College Of Arts, Sciene & Commerce, Sion West, Sion, Mumbai, Maharashtra 400022, India'),
(7, 'China', 'Hong-Kong', '13 Electric Rd, Causeway Bay, Hong Kong'),
(8, 'Brazil', 'Rio de Janeiro', 'R. Leopoldo, 280 - Andaraí, Rio de Janeiro - RJ, 280 - Andaraí, Rio de Janeiro - RJ, 20541-170, Brazil'),
(9, 'South Africa', 'Johannesburg', '163 Civic Blvd, Braamfontein, Johannesburg, 2001'),
(10, 'Japan', 'Tokyo', '1 Chome-1-1 Uchisaiwaicho, Chiyoda City, Tokyo 100-8558, Japan');

-- --------------------------------------------------------

--
-- Table structure for table `shipment`
--

CREATE TABLE `shipment` (
  `id` int(11) NOT NULL,
  `departure_datetime` datetime DEFAULT NULL,
  `expected_date` date DEFAULT NULL,
  `clearance_state` varchar(20) DEFAULT 'unclear',
  `expected_location_id` int(11) DEFAULT NULL,
  `officer_id` int(11) DEFAULT NULL,
  `transport_id` int(11) DEFAULT NULL,
  `arrival_datetime` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `shipment`
--

INSERT INTO `shipment` (`id`, `departure_datetime`, `expected_date`, `clearance_state`, `expected_location_id`, `officer_id`, `transport_id`, `arrival_datetime`) VALUES
(30, '2025-08-20 14:30:00', '2025-09-15', 'unclear', 3, 1, 1, NULL),
(31, '2025-08-19 15:30:30', '2025-09-11', 'clear', 4, 1, 1, NULL),
(32, '2025-07-21 14:30:00', '2025-11-21', 'unclear', 1, 2, 2, NULL),
(33, '2025-06-11 14:30:00', '2025-10-01', 'clear', 2, 3, 3, NULL);

--
-- Triggers `shipment`
--
DELIMITER $$
CREATE TRIGGER `past_due_date` AFTER INSERT ON `shipment` FOR EACH ROW BEGIN

    IF NEW.expected_date < CURDATE() THEN
        INSERT INTO delays (reason, delay_log_time, new_expected_date, transport_id)
        VALUES ('Past due date', NOW(), NULL, NEW.transport_id);
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `transport_log`
--

CREATE TABLE `transport_log` (
  `id` int(11) NOT NULL,
  `check_in_time` datetime DEFAULT NULL,
  `checkpoint_location_id` int(11) DEFAULT NULL,
  `transport_id` int(11) DEFAULT NULL,
  `shipment_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transport_log`
--

INSERT INTO `transport_log` (`id`, `check_in_time`, `checkpoint_location_id`, `transport_id`, `shipment_id`) VALUES
(1, '2025-08-23 12:40:00', 1, 1, 33),
(2, '2025-08-22 12:40:00', 2, 1, 31),
(3, '2025-08-21 12:40:00', 1, 2, 30),
(4, NULL, 2, 2, 31),
(5, '2025-08-27 12:40:00', 4, 2, 30),
(6, '2025-08-26 12:40:00', 5, 2, 30),
(7, '2025-08-23 12:40:00', 5, 3, 32),
(8, NULL, 6, 3, 30),
(9, '2025-08-20 12:40:00', 7, 3, 31),
(10, '2025-08-20 12:40:00', 8, 3, 30),
(11, '2025-07-20 12:40:00', 10, 4, 32),
(12, NULL, 9, 4, 32),
(13, '2025-10-22 12:40:00', 6, 4, 30),
(14, '2025-07-20 12:40:00', 5, 4, 33);

--
-- Triggers `transport_log`
--
DELIMITER $$
CREATE TRIGGER `trg_shipment_arrived` AFTER UPDATE ON `transport_log` FOR EACH ROW BEGIN
    IF NEW.check_in_time IS NOT NULL 
       AND OLD.check_in_time IS NULL THEN
       
       UPDATE shipment
       SET arrival_datetime = NEW.check_in_time,
           clearance_state = 'arrived'
       WHERE shipment.id = NEW.shipment_id
         AND shipment.expected_location_id = NEW.checkpoint_location_id;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `transport_mode`
--

CREATE TABLE `transport_mode` (
  `id` int(11) NOT NULL,
  `vehicle_type` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transport_mode`
--

INSERT INTO `transport_mode` (`id`, `vehicle_type`) VALUES
(1, 'truck'),
(2, 'ship'),
(3, 'airplane'),
(4, 'van');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `arrived_orders`
--
ALTER TABLE `arrived_orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `shipment_id` (`shipment_id`);

--
-- Indexes for table `client`
--
ALTER TABLE `client`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customs_officers`
--
ALTER TABLE `customs_officers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `delays`
--
ALTER TABLE `delays`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transport_id` (`transport_id`);

--
-- Indexes for table `item`
--
ALTER TABLE `item`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `item_copy`
--
ALTER TABLE `item_copy`
  ADD PRIMARY KEY (`id`),
  ADD KEY `client_id` (`client_id`),
  ADD KEY `shipment_id` (`shipment_id`),
  ADD KEY `fk_original_item` (`original_item_id`);

--
-- Indexes for table `location`
--
ALTER TABLE `location`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `shipment`
--
ALTER TABLE `shipment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `expected_location_id` (`expected_location_id`),
  ADD KEY `officer_id` (`officer_id`),
  ADD KEY `transport_id` (`transport_id`);

--
-- Indexes for table `transport_log`
--
ALTER TABLE `transport_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `checkpoint_location_id` (`checkpoint_location_id`),
  ADD KEY `transport_id` (`transport_id`),
  ADD KEY `shipment_id` (`shipment_id`);

--
-- Indexes for table `transport_mode`
--
ALTER TABLE `transport_mode`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `arrived_orders`
--
ALTER TABLE `arrived_orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `client`
--
ALTER TABLE `client`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `customs_officers`
--
ALTER TABLE `customs_officers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `delays`
--
ALTER TABLE `delays`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `item`
--
ALTER TABLE `item`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `item_copy`
--
ALTER TABLE `item_copy`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `location`
--
ALTER TABLE `location`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `shipment`
--
ALTER TABLE `shipment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `transport_log`
--
ALTER TABLE `transport_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `transport_mode`
--
ALTER TABLE `transport_mode`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `arrived_orders`
--
ALTER TABLE `arrived_orders`
  ADD CONSTRAINT `arrived_orders_ibfk_1` FOREIGN KEY (`shipment_id`) REFERENCES `shipment` (`id`);

--
-- Constraints for table `item_copy`
--
ALTER TABLE `item_copy`
  ADD CONSTRAINT `fk_original_item` FOREIGN KEY (`original_item_id`) REFERENCES `item` (`id`),
  ADD CONSTRAINT `item_copy_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `client` (`id`),
  ADD CONSTRAINT `item_copy_ibfk_2` FOREIGN KEY (`shipment_id`) REFERENCES `shipment` (`id`);

--
-- Constraints for table `shipment`
--
ALTER TABLE `shipment`
  ADD CONSTRAINT `shipment_ibfk_1` FOREIGN KEY (`expected_location_id`) REFERENCES `location` (`id`),
  ADD CONSTRAINT `shipment_ibfk_2` FOREIGN KEY (`officer_id`) REFERENCES `customs_officers` (`id`),
  ADD CONSTRAINT `shipment_ibfk_3` FOREIGN KEY (`transport_id`) REFERENCES `transport_mode` (`id`);

--
-- Constraints for table `transport_log`
--
ALTER TABLE `transport_log`
  ADD CONSTRAINT `transport_log_ibfk_1` FOREIGN KEY (`checkpoint_location_id`) REFERENCES `location` (`id`),
  ADD CONSTRAINT `transport_log_ibfk_2` FOREIGN KEY (`transport_id`) REFERENCES `transport_mode` (`id`),
  ADD CONSTRAINT `transport_log_ibfk_3` FOREIGN KEY (`shipment_id`) REFERENCES `shipment` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
