-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Aug 11, 2026 at 11:25 AM
-- Server version: 8.0.17
-- PHP Version: 7.3.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mobilefix`
--

-- --------------------------------------------------------

--
-- Table structure for table `inventory`
--

CREATE TABLE `inventory` (
  `id` int(10) UNSIGNED NOT NULL,
  `part_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quantity` int(11) NOT NULL DEFAULT '0',
  `unit_price` decimal(12,2) NOT NULL DEFAULT '0.00',
  `min_stock` int(11) NOT NULL DEFAULT '0',
  `status` enum('active','inactive') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `inventory`
--

INSERT INTO `inventory` (`id`, `part_name`, `category`, `quantity`, `unit_price`, `min_stock`, `status`, `created_at`) VALUES
(1, 'Samsung A15 Screen', 'Screen', 9, '25000.00', 2, 'active', '2026-08-11 11:07:50');

-- --------------------------------------------------------

--
-- Table structure for table `invoices`
--

CREATE TABLE `invoices` (
  `id` int(10) UNSIGNED NOT NULL,
  `invoice_no` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `repair_id` int(10) UNSIGNED NOT NULL,
  `customer_id` int(10) UNSIGNED NOT NULL,
  `service_cost` decimal(12,2) NOT NULL DEFAULT '0.00',
  `parts_cost` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total` decimal(12,2) NOT NULL DEFAULT '0.00',
  `payment_status` enum('Unpaid','Paid') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Unpaid',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `invoices`
--

INSERT INTO `invoices` (`id`, `invoice_no`, `repair_id`, `customer_id`, `service_cost`, `parts_cost`, `total`, `payment_status`, `created_at`) VALUES
(1, 'INV-2026-0001', 1, 6, '10000.00', '25000.00', '35000.00', 'Paid', '2026-08-11 11:07:52');

-- --------------------------------------------------------

--
-- Table structure for table `invoice_items`
--

CREATE TABLE `invoice_items` (
  `id` int(10) UNSIGNED NOT NULL,
  `invoice_id` int(10) UNSIGNED NOT NULL,
  `repair_id` int(10) UNSIGNED NOT NULL,
  `description` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT '1',
  `unit_price` decimal(12,2) NOT NULL DEFAULT '0.00',
  `amount` decimal(12,2) NOT NULL DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `invoice_items`
--

INSERT INTO `invoice_items` (`id`, `invoice_id`, `repair_id`, `description`, `quantity`, `unit_price`, `amount`) VALUES
(5, 1, 1, 'Repair service (labour)', 1, '10000.00', '10000.00'),
(6, 1, 1, 'Samsung A15 Screen', 1, '25000.00', '25000.00');

-- --------------------------------------------------------

--
-- Table structure for table `repair_parts`
--

CREATE TABLE `repair_parts` (
  `id` int(10) UNSIGNED NOT NULL,
  `repair_id` int(10) UNSIGNED NOT NULL,
  `inventory_id` int(10) UNSIGNED DEFAULT NULL,
  `part_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT '1',
  `unit_price` decimal(12,2) NOT NULL DEFAULT '0.00',
  `subtotal` decimal(12,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `repair_parts`
--

INSERT INTO `repair_parts` (`id`, `repair_id`, `inventory_id`, `part_name`, `quantity`, `unit_price`, `subtotal`, `created_at`) VALUES
(1, 1, 1, 'Samsung A15 Screen', 1, '25000.00', '25000.00', '2026-08-11 11:07:53');

-- --------------------------------------------------------

--
-- Table structure for table `repair_requests`
--

CREATE TABLE `repair_requests` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer_id` int(10) UNSIGNED NOT NULL,
  `technician_id` int(10) UNSIGNED DEFAULT NULL,
  `brand` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `problem_type` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `imei` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('Pending','Assigned','Diagnosing','Repairing','Completed','Collected','Cancelled') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Pending',
  `diagnosis` text COLLATE utf8mb4_unicode_ci,
  `repair_notes` text COLLATE utf8mb4_unicode_ci,
  `service_cost` decimal(12,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `completed_at` datetime DEFAULT NULL,
  `collected_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `repair_requests`
--

INSERT INTO `repair_requests` (`id`, `reference`, `customer_id`, `technician_id`, `brand`, `model`, `problem_type`, `description`, `imei`, `status`, `diagnosis`, `repair_notes`, `service_cost`, `created_at`, `completed_at`, `collected_at`) VALUES
(1, 'MR-2026-0001', 6, 5, 'Samsung', 'Galaxy A15', 'Broken Screen', 'Screen stopped working after the phone fell.', NULL, 'Collected', 'Broken display assembly.', '', '10000.00', '2026-08-11 11:07:51', '2026-08-11 12:07:54', '2026-08-11 12:07:55');

-- --------------------------------------------------------

--
-- Table structure for table `repair_status_history`
--

CREATE TABLE `repair_status_history` (
  `id` int(10) UNSIGNED NOT NULL,
  `repair_id` int(10) UNSIGNED NOT NULL,
  `status` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `note` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `repair_status_history`
--

INSERT INTO `repair_status_history` (`id`, `repair_id`, `status`, `note`, `created_by`, `created_at`) VALUES
(1, 1, 'Pending', 'Repair request submitted by customer.', 6, '2026-08-11 11:07:51'),
(2, 1, 'Assigned', 'Assigned to technician.', 1, '2026-08-11 11:07:52'),
(3, 1, 'Diagnosing', NULL, 5, '2026-08-11 11:07:52'),
(4, 1, 'Repairing', NULL, 5, '2026-08-11 11:07:53'),
(5, 1, 'Completed', NULL, 5, '2026-08-11 11:07:54'),
(6, 1, 'Collected', 'Device collected by customer.', 1, '2026-08-11 11:07:55');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `full_name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` enum('customer','technician','admin') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'customer',
  `specialization` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('active','inactive') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `full_name`, `phone`, `email`, `password`, `role`, `specialization`, `status`, `created_at`) VALUES
(1, 'System Administrator', '08000000000', 'admin@mobilefix.com', '$2y$10$/gAq0ceDPhZ95CJZbRw86uVgq9A.ra943XZ6R1/j7oREX2gcOz0/i', 'admin', 'General', 'active', '2026-08-11 11:07:44'),
(2, 'MobileFix Administrator', '08000000001', 'admin@mobilefix.test', '$2y$10$ry6UgCMo3YfX.wUrzxxzGOfQEB30ErRXLD1Ii2GANPy8qAspF/E4C', 'admin', 'General', 'active', '2026-08-11 11:07:45'),
(3, 'MobileFix Technician', '08000000002', 'technician@mobilefix.test', '$2y$10$6zKZ5UR9PpSBOQG9YTp8m.dcWAUTC0JyVcRltmqgvIHdbX4xAkkNa', 'technician', 'Screen & Battery', 'active', '2026-08-11 11:07:45'),
(4, 'Demo Customer', '08000000003', 'customer@mobilefix.test', '$2y$10$pIzzvJ067OXe1koR76fbSu0mbRS5i6e8YS213BF2xHozLOewpFag6', 'customer', NULL, 'active', '2026-08-11 11:07:45'),
(5, 'Musa Ibrahim', '08011111111', 'technician@example.com', '$2y$10$UdLXW03W1lq2nXJrSPQ27OT.t9TsVbPVKcNuqL3y.Cxaa9qHcIjmm', 'technician', 'Screen & Battery', 'active', '2026-08-11 11:07:50'),
(6, 'Ahmad Kabir', '08000000000', 'customer@example.com', '$2y$10$Eg4dI0denN7lJpVI6kQgyODzxx7oBbu4qydynpNqDSVUa8GIMvNIG', 'customer', NULL, 'active', '2026-08-11 11:07:51'),
(7, 'Hacker User', '08099999999', 'hacker@example.com', '$2y$10$QvcxEZs9hW6h2Ogc2S9LKeA1LE07gglH49s3UP9gwv8TvGOqYGJga', 'customer', NULL, 'active', '2026-08-11 11:07:56'),
(8, 'Second Tech', '08033333333', 'tech2@example.com', '$2y$10$fv4/3AnkfVqVvsRQO5YHleKdG5vu6GkxSmp/.aTfVEczwQmAbzSuK', 'technician', '', 'active', '2026-08-11 11:07:57');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_inventory_status` (`status`);

--
-- Indexes for table `invoices`
--
ALTER TABLE `invoices`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_invoice_no` (`invoice_no`),
  ADD UNIQUE KEY `uq_invoice_repair` (`repair_id`),
  ADD KEY `idx_invoice_customer` (`customer_id`);

--
-- Indexes for table `invoice_items`
--
ALTER TABLE `invoice_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_invoice_items_invoice` (`invoice_id`),
  ADD KEY `fk_invoice_items_repair` (`repair_id`);

--
-- Indexes for table `repair_parts`
--
ALTER TABLE `repair_parts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_repair_parts_repair` (`repair_id`),
  ADD KEY `fk_repair_parts_inventory` (`inventory_id`);

--
-- Indexes for table `repair_requests`
--
ALTER TABLE `repair_requests`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_repair_reference` (`reference`),
  ADD KEY `idx_repair_customer` (`customer_id`),
  ADD KEY `idx_repair_technician` (`technician_id`),
  ADD KEY `idx_repair_status` (`status`);

--
-- Indexes for table `repair_status_history`
--
ALTER TABLE `repair_status_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_history_repair` (`repair_id`),
  ADD KEY `fk_history_user` (`created_by`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_users_email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `inventory`
--
ALTER TABLE `inventory`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `invoices`
--
ALTER TABLE `invoices`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `invoice_items`
--
ALTER TABLE `invoice_items`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `repair_parts`
--
ALTER TABLE `repair_parts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `repair_requests`
--
ALTER TABLE `repair_requests`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `repair_status_history`
--
ALTER TABLE `repair_status_history`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `invoices`
--
ALTER TABLE `invoices`
  ADD CONSTRAINT `fk_invoice_customer` FOREIGN KEY (`customer_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_invoice_repair` FOREIGN KEY (`repair_id`) REFERENCES `repair_requests` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `invoice_items`
--
ALTER TABLE `invoice_items`
  ADD CONSTRAINT `fk_invoice_items_invoice` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_invoice_items_repair` FOREIGN KEY (`repair_id`) REFERENCES `repair_requests` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `repair_parts`
--
ALTER TABLE `repair_parts`
  ADD CONSTRAINT `fk_repair_parts_inventory` FOREIGN KEY (`inventory_id`) REFERENCES `inventory` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_repair_parts_repair` FOREIGN KEY (`repair_id`) REFERENCES `repair_requests` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `repair_requests`
--
ALTER TABLE `repair_requests`
  ADD CONSTRAINT `fk_repair_customer` FOREIGN KEY (`customer_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_repair_technician` FOREIGN KEY (`technician_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `repair_status_history`
--
ALTER TABLE `repair_status_history`
  ADD CONSTRAINT `fk_history_repair` FOREIGN KEY (`repair_id`) REFERENCES `repair_requests` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_history_user` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
