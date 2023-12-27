-- phpMyAdmin SQL Dump
-- version 4.9.11
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Dec 27, 2023 at 03:34 AM
-- Server version: 8.0.30
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_pamproject`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` bigint UNSIGNED NOT NULL,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `id` bigint UNSIGNED NOT NULL,
  `mahasiswa_id` bigint UNSIGNED NOT NULL,
  `room_id` bigint UNSIGNED NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` date NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `keterangan` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`id`, `mahasiswa_id`, `room_id`, `start_time`, `end_time`, `status`, `keterangan`, `created_at`, `updated_at`) VALUES
(1, 2, 2, '2023-12-27 09:42:37', '2023-12-27', 'approved', 'Meeting room', '2023-12-26 19:43:08', '2023-12-26 19:43:34'),
(2, 2, 1, '2023-12-27 08:00:00', '2023-12-27', 'rejected', 'tutor himatif', '2023-12-26 20:27:57', '2023-12-26 20:28:58');

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `id` bigint UNSIGNED NOT NULL,
  `mahasiswa_id` bigint UNSIGNED NOT NULL,
  `feed_id` bigint UNSIGNED NOT NULL,
  `body` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `feeds`
--

CREATE TABLE `feeds` (
  `id` bigint UNSIGNED NOT NULL,
  `mahasiswa_id` bigint UNSIGNED NOT NULL,
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `i_b_requests`
--

CREATE TABLE `i_b_requests` (
  `id` bigint UNSIGNED NOT NULL,
  `mahasiswa_id` bigint UNSIGNED NOT NULL,
  `tanggal_berangkat` datetime NOT NULL,
  `tanggal_kembali` datetime NOT NULL,
  `deskripsi` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `tujuan` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `i_b_requests`
--

INSERT INTO `i_b_requests` (`id`, `mahasiswa_id`, `tanggal_berangkat`, `tanggal_kembali`, `deskripsi`, `tujuan`, `status`, `created_at`, `updated_at`) VALUES
(1, 2, '2023-12-29 17:05:00', '2024-01-11 09:25:00', 'Christmas holiday', 'Medan', 'approved', '2023-12-26 19:28:43', '2023-12-26 19:38:58'),
(2, 2, '2023-12-29 18:00:00', '2023-12-31 18:00:00', 'Ku sembah kudus kuduslah Tuhan', 'Medan', 'approved', '2023-12-26 19:40:55', '2023-12-26 19:43:59'),
(3, 2, '2023-12-22 17:30:00', '2024-01-11 19:00:00', 'Liburan Paskah', 'Medan', 'approved', '2023-12-26 20:26:53', '2023-12-26 20:29:09');

-- --------------------------------------------------------

--
-- Table structure for table `likes`
--

CREATE TABLE `likes` (
  `id` bigint UNSIGNED NOT NULL,
  `mahasiswa_id` bigint UNSIGNED NOT NULL,
  `feed_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mahasiswas`
--

CREATE TABLE `mahasiswas` (
  `id` bigint UNSIGNED NOT NULL,
  `nim` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `no_ktp` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `no_telp` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'mahasiswa',
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `google_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `mahasiswas`
--

INSERT INTO `mahasiswas` (`id`, `nim`, `name`, `username`, `email`, `email_verified_at`, `no_ktp`, `password`, `no_telp`, `role`, `remember_token`, `created_at`, `updated_at`, `google_id`) VALUES
(1, NULL, 'Admin', NULL, 'admin@gmail.com', NULL, NULL, '$2y$12$e2KF3V9G2q79laMmqEhpOu2gOu27of.FcinZFCqHv3Gv7VXdGpHhm', NULL, 'admin', NULL, '2023-12-26 19:17:51', '2023-12-26 19:17:51', NULL),
(2, '11322014', 'Niel Siahaan', 'niel.shn', 'niel@gmail.com', NULL, '1207261108030001', '$2y$12$e3ZGYRlQxCYCpat/Hp1yTerCGXGjzGEA1LssmgQzTKcT5l5CpPs/.', '081262179432', 'mahasiswa', NULL, '2023-12-26 19:18:46', '2023-12-26 19:18:46', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(31, '2023_12_11_075352_create_request_i_k_s_table', 1),
(63, '2023_12_11_092256_create_admins_table', 2),
(191, '2014_10_12_000000_create_users_table', 3),
(192, '2019_12_14_000001_create_personal_access_tokens_table', 3),
(193, '2022_12_08_015439_create_mahasiswas_table', 3),
(194, '2022_12_08_033445_add_google_id_column', 3),
(195, '2023_12_04_011205_create_feeds_table', 3),
(196, '2023_12_04_013921_create_likes_table', 3),
(197, '2023_12_04_023800_create_comments_table', 3),
(198, '2023_12_08_031619_create_rooms_table', 3),
(199, '2023_12_10_024511_create_bookings_table', 3),
(200, '2023_12_10_024540_create_surat_requests_table', 3),
(201, '2023_12_10_075352_create_request_i_k_s_table', 3),
(202, '2023_12_12_014243_create_i_b_requests_table', 3),
(203, '2023_12_23_001546_create_tshirts_table', 3),
(204, '2023_12_23_001639_create_orders_table', 3),
(205, '2023_12_23_001658_create_payments_table', 3);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` bigint UNSIGNED NOT NULL,
  `mahasiswa_id` bigint UNSIGNED NOT NULL,
  `tshirt_id` bigint UNSIGNED NOT NULL,
  `selected_size` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` int NOT NULL,
  `total_price` decimal(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` bigint UNSIGNED NOT NULL,
  `order_id` bigint UNSIGNED NOT NULL,
  `payment_amount` decimal(8,2) NOT NULL,
  `payment_method` enum('CreditCard','CashOnDelivery','Bank Transfer','DebitCard') COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_status` enum('Success','Failure') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Failure',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\Mahasiswa', 2, 'auth_token', '06064483b510be8f5fdf7aa858bd379f931f329f6abce82909589559952d54e6', '[\"*\"]', NULL, NULL, '2023-12-26 19:18:46', '2023-12-26 19:18:46'),
(2, 'App\\Models\\Mahasiswa', 2, 'auth_token', 'cee7f2cd5c0ec8cc149559bb42e40d40c77b72f5fa5efe5a5c52a7e47b349189', '[\"*\"]', '2023-12-26 19:19:55', NULL, '2023-12-26 19:19:19', '2023-12-26 19:19:55'),
(9, 'App\\Models\\Mahasiswa', 2, 'auth_token', '6309dcbf8dcdc59e7a69eb76ff39891809872fd9fb2380b7938f467e00cd3bff', '[\"*\"]', '2023-12-26 20:28:03', NULL, '2023-12-26 19:50:29', '2023-12-26 20:28:03'),
(11, 'App\\Models\\Mahasiswa', 1, 'auth_token', '60801e52c41ace3881da254e3cb2122a24393325549c1defb4112c980a768329', '[\"*\"]', '2023-12-26 20:29:35', NULL, '2023-12-26 19:52:42', '2023-12-26 20:29:35');

-- --------------------------------------------------------

--
-- Table structure for table `request_i_k_s`
--

CREATE TABLE `request_i_k_s` (
  `id` bigint UNSIGNED NOT NULL,
  `mahasiswa_id` bigint UNSIGNED NOT NULL,
  `tanggal_berangkat` datetime NOT NULL,
  `tanggal_kembali` datetime NOT NULL,
  `deskripsi` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `request_i_k_s`
--

INSERT INTO `request_i_k_s` (`id`, `mahasiswa_id`, `tanggal_berangkat`, `tanggal_kembali`, `deskripsi`, `status`, `created_at`, `updated_at`) VALUES
(1, 2, '2023-12-27 09:20:00', '2023-12-27 10:00:00', 'Terima kasih Tuhan', 'approved', '2023-12-26 19:19:47', '2023-12-26 19:34:02'),
(2, 2, '2023-12-27 09:40:00', '2023-12-27 12:39:00', 'Praise the Lord', 'approved', '2023-12-26 19:39:43', '2023-12-26 19:43:47');

-- --------------------------------------------------------

--
-- Table structure for table `rooms`
--

CREATE TABLE `rooms` (
  `id` bigint UNSIGNED NOT NULL,
  `roomName` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `rooms`
--

INSERT INTO `rooms` (`id`, `roomName`, `created_at`, `updated_at`) VALUES
(1, 'GD 511', '2023-12-26 19:32:46', '2023-12-26 19:32:46'),
(2, 'GD 512', '2023-12-26 19:32:52', '2023-12-26 19:32:52'),
(3, 'GD 513', '2023-12-26 19:33:01', '2023-12-26 19:33:01'),
(4, 'GD 514', '2023-12-26 19:33:06', '2023-12-26 19:33:06'),
(5, 'GD 515', '2023-12-26 19:33:14', '2023-12-26 19:33:14'),
(6, 'GD 516', '2023-12-26 19:33:25', '2023-12-26 19:33:25'),
(7, 'GD 517', '2023-12-26 19:33:32', '2023-12-26 19:33:32');

-- --------------------------------------------------------

--
-- Table structure for table `surat_requests`
--

CREATE TABLE `surat_requests` (
  `id` bigint UNSIGNED NOT NULL,
  `mahasiswa_id` bigint UNSIGNED NOT NULL,
  `kategori_surat` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tanggal_pengambilan` date NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `surat_requests`
--

INSERT INTO `surat_requests` (`id`, `mahasiswa_id`, `kategori_surat`, `content`, `tanggal_pengambilan`, `status`, `created_at`, `updated_at`) VALUES
(1, 2, 'Surat pengantar proyek', 'wawancara bersama klien\nKelompok 2 PA 2\nDaniel Siahaan', '2023-12-28', 'approved', '2023-12-26 19:31:27', '2023-12-26 19:34:26'),
(2, 2, 'Surat MBKM', 'Puji Tuhan, saya lulus program IISMA ke German', '2023-12-28', 'approved', '2023-12-26 19:41:46', '2023-12-26 19:44:12'),
(3, 2, 'surat MBKM yang diperbarui', 'keperluan magang yang diperbarui', '2023-12-14', 'approved', '2023-12-26 19:50:52', '2023-12-26 19:51:12'),
(4, 2, 'Surat Makrab', 'malam bersama tahun baru', '2023-12-28', 'rejected', '2023-12-26 19:52:26', '2023-12-26 19:53:01'),
(5, 2, 'Surat Studi Independen', 'program IISMA ke German', '2023-12-14', 'approved', '2023-12-26 19:55:17', '2023-12-26 19:55:42'),
(6, 2, 'Surat Studi Independen', 'program IISMA ke German', '2024-01-11', 'approved', '2023-12-26 20:07:37', '2023-12-26 20:07:55'),
(7, 2, 'Surat tunangan', 'Tuhan adalah Gembalaku', '2024-02-14', 'approved', '2023-12-26 20:19:04', '2023-12-26 20:19:20'),
(8, 2, 'Surat perjanjian', 'Tuhan adalah Gembalaku', '2024-02-14', 'approved', '2023-12-26 20:23:15', '2023-12-26 20:23:30');

-- --------------------------------------------------------

--
-- Table structure for table `tshirts`
--

CREATE TABLE `tshirts` (
  `id` bigint UNSIGNED NOT NULL,
  `size` enum('S','M','L','XL','XXL') COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` decimal(8,2) NOT NULL,
  `quantity` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tshirts`
--

INSERT INTO `tshirts` (`id`, `size`, `price`, `quantity`, `created_at`, `updated_at`) VALUES
(1, 'S', '70000.00', 20, '2023-12-26 19:35:03', '2023-12-26 19:35:03'),
(2, 'M', '80000.00', 40, '2023-12-26 19:35:22', '2023-12-26 19:35:22'),
(3, 'L', '90000.00', 70, '2023-12-26 19:35:52', '2023-12-26 19:35:52'),
(4, 'XL', '100000.00', 30, '2023-12-26 19:36:35', '2023-12-26 19:36:35'),
(5, 'XXL', '120000.00', 20, '2023-12-26 19:36:51', '2023-12-26 19:37:01');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `admins_email_unique` (`email`);

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bookings_mahasiswa_id_foreign` (`mahasiswa_id`),
  ADD KEY `bookings_room_id_foreign` (`room_id`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `comments_mahasiswa_id_foreign` (`mahasiswa_id`),
  ADD KEY `comments_feed_id_foreign` (`feed_id`);

--
-- Indexes for table `feeds`
--
ALTER TABLE `feeds`
  ADD PRIMARY KEY (`id`),
  ADD KEY `feeds_mahasiswa_id_foreign` (`mahasiswa_id`);

--
-- Indexes for table `i_b_requests`
--
ALTER TABLE `i_b_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `i_b_requests_mahasiswa_id_foreign` (`mahasiswa_id`);

--
-- Indexes for table `likes`
--
ALTER TABLE `likes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `likes_mahasiswa_id_foreign` (`mahasiswa_id`),
  ADD KEY `likes_feed_id_foreign` (`feed_id`);

--
-- Indexes for table `mahasiswas`
--
ALTER TABLE `mahasiswas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mahasiswas_email_unique` (`email`),
  ADD UNIQUE KEY `mahasiswas_username_unique` (`username`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `orders_mahasiswa_id_foreign` (`mahasiswa_id`),
  ADD KEY `orders_tshirt_id_foreign` (`tshirt_id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `payments_order_id_foreign` (`order_id`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `request_i_k_s`
--
ALTER TABLE `request_i_k_s`
  ADD PRIMARY KEY (`id`),
  ADD KEY `request_i_k_s_mahasiswa_id_foreign` (`mahasiswa_id`);

--
-- Indexes for table `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `rooms_roomname_unique` (`roomName`);

--
-- Indexes for table `surat_requests`
--
ALTER TABLE `surat_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `surat_requests_mahasiswa_id_foreign` (`mahasiswa_id`);

--
-- Indexes for table `tshirts`
--
ALTER TABLE `tshirts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `feeds`
--
ALTER TABLE `feeds`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `i_b_requests`
--
ALTER TABLE `i_b_requests`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `likes`
--
ALTER TABLE `likes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mahasiswas`
--
ALTER TABLE `mahasiswas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=206;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `request_i_k_s`
--
ALTER TABLE `request_i_k_s`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `rooms`
--
ALTER TABLE `rooms`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `surat_requests`
--
ALTER TABLE `surat_requests`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `tshirts`
--
ALTER TABLE `tshirts`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_mahasiswa_id_foreign` FOREIGN KEY (`mahasiswa_id`) REFERENCES `mahasiswas` (`id`),
  ADD CONSTRAINT `bookings_room_id_foreign` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_feed_id_foreign` FOREIGN KEY (`feed_id`) REFERENCES `feeds` (`id`),
  ADD CONSTRAINT `comments_mahasiswa_id_foreign` FOREIGN KEY (`mahasiswa_id`) REFERENCES `mahasiswas` (`id`);

--
-- Constraints for table `feeds`
--
ALTER TABLE `feeds`
  ADD CONSTRAINT `feeds_mahasiswa_id_foreign` FOREIGN KEY (`mahasiswa_id`) REFERENCES `mahasiswas` (`id`);

--
-- Constraints for table `i_b_requests`
--
ALTER TABLE `i_b_requests`
  ADD CONSTRAINT `i_b_requests_mahasiswa_id_foreign` FOREIGN KEY (`mahasiswa_id`) REFERENCES `mahasiswas` (`id`);

--
-- Constraints for table `likes`
--
ALTER TABLE `likes`
  ADD CONSTRAINT `likes_feed_id_foreign` FOREIGN KEY (`feed_id`) REFERENCES `feeds` (`id`),
  ADD CONSTRAINT `likes_mahasiswa_id_foreign` FOREIGN KEY (`mahasiswa_id`) REFERENCES `mahasiswas` (`id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_mahasiswa_id_foreign` FOREIGN KEY (`mahasiswa_id`) REFERENCES `mahasiswas` (`id`),
  ADD CONSTRAINT `orders_tshirt_id_foreign` FOREIGN KEY (`tshirt_id`) REFERENCES `tshirts` (`id`);

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`);

--
-- Constraints for table `request_i_k_s`
--
ALTER TABLE `request_i_k_s`
  ADD CONSTRAINT `request_i_k_s_mahasiswa_id_foreign` FOREIGN KEY (`mahasiswa_id`) REFERENCES `mahasiswas` (`id`);

--
-- Constraints for table `surat_requests`
--
ALTER TABLE `surat_requests`
  ADD CONSTRAINT `surat_requests_mahasiswa_id_foreign` FOREIGN KEY (`mahasiswa_id`) REFERENCES `mahasiswas` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
