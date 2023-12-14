-- phpMyAdmin SQL Dump
-- version 4.9.11
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Dec 14, 2023 at 09:57 AM
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
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
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
(1, 1, '2023-12-15 18:30:00', '2023-12-17 18:30:00', 'Liburan natal', 'Medan', 'pending', '2023-12-14 02:31:41', '2023-12-14 02:31:41'),
(2, 1, '2023-12-15 17:36:00', '2023-12-20 16:36:00', 'Belajar di rumah', 'Medan', 'pending', '2023-12-14 02:40:53', '2023-12-14 02:40:53'),
(3, 1, '2023-12-22 17:30:00', '2024-01-11 19:00:00', 'Liburan Paskah', 'Medan', 'pending', '2023-12-14 02:49:30', '2023-12-14 02:49:30'),
(4, 1, '2023-12-22 17:05:00', '2024-01-12 19:46:00', 'Liburan semester', 'Medan', 'pending', '2023-12-14 02:51:05', '2023-12-14 02:51:05');

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
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `google_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `mahasiswas`
--

INSERT INTO `mahasiswas` (`id`, `nim`, `name`, `username`, `email`, `email_verified_at`, `no_ktp`, `password`, `no_telp`, `remember_token`, `created_at`, `updated_at`, `google_id`) VALUES
(1, '11322014', 'Niel Siahaan', 'niel.shn', 'niel@gmail.com', NULL, '1207261108030001', '$2y$12$ooRWxiX1O1UgFtkEfaDireDXZOFjokKnIWGdGz0cbPbrUSitB7n5a', '081262179432', NULL, '2023-12-13 20:25:32', '2023-12-13 20:25:32', NULL);

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
(19, '2014_10_12_000000_create_users_table', 1),
(20, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(21, '2019_08_19_000000_create_failed_jobs_table', 1),
(22, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(23, '2022_12_08_015439_create_mahasiswas_table', 1),
(24, '2022_12_08_033445_add_google_id_column', 1),
(25, '2023_12_04_011205_create_feeds_table', 1),
(26, '2023_12_04_013921_create_likes_table', 1),
(27, '2023_12_04_023800_create_comments_table', 1),
(28, '2023_12_08_031619_create_rooms_table', 1),
(29, '2023_12_10_024511_create_bookings_table', 1),
(30, '2023_12_10_024540_create_surat_requests_table', 1),
(31, '2023_12_11_075352_create_request_i_k_s_table', 1),
(32, '2023_12_11_092256_create_admins_table', 1),
(33, '2023_12_12_014243_create_i_b_requests_table', 1),
(34, '2023_12_10_075352_create_request_i_k_s_table', 2);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
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
(1, 'App\\Models\\Mahasiswa', 1, 'auth_token', 'e157e4bf6ea5c65bb6fd5237544bd9055f0eca3ed069e7755dfb72053159a902', '[\"*\"]', NULL, NULL, '2023-12-13 20:25:32', '2023-12-13 20:25:32'),
(2, 'App\\Models\\Mahasiswa', 1, 'auth_token', 'da695c3cf8dac4e00ccd2c7a27f0e59ba06e7c49c3fbb16a4a88c15d85c8965f', '[\"*\"]', '2023-12-13 20:46:56', NULL, '2023-12-13 20:25:39', '2023-12-13 20:46:56'),
(3, 'App\\Models\\Mahasiswa', 1, 'auth_token', '5f592efd69f557c14ef79da804a1abb788462bc77a1bd874f7a8b582d34267a1', '[\"*\"]', '2023-12-13 21:09:30', NULL, '2023-12-13 21:07:30', '2023-12-13 21:09:30'),
(4, 'App\\Models\\Mahasiswa', 1, 'auth_token', 'a87ea8fa91866120dc0451705886eb4d44e6d7af31e363649d6852f834e3b8ed', '[\"*\"]', '2023-12-13 21:15:37', NULL, '2023-12-13 21:13:46', '2023-12-13 21:15:37'),
(5, 'App\\Models\\Mahasiswa', 1, 'auth_token', '1bac8a1476cb159236a0f7e6a2b4d9e76aec75ea6a2deb6590463c674b4627d3', '[\"*\"]', '2023-12-13 21:36:12', NULL, '2023-12-13 21:23:44', '2023-12-13 21:36:12'),
(6, 'App\\Models\\Mahasiswa', 1, 'auth_token', '9921255d0243308860d8afc0ecf0cda6697078d5021a3b8f923179eaa481333d', '[\"*\"]', '2023-12-14 02:51:14', NULL, '2023-12-13 23:51:20', '2023-12-14 02:51:14'),
(7, 'App\\Models\\Mahasiswa', 1, 'auth_token', 'ba4b7a5487140bea54a1e985d6e3e324f6c7fcc53c99a120a3968f690ea158da', '[\"*\"]', '2023-12-14 02:49:30', NULL, '2023-12-14 02:28:56', '2023-12-14 02:49:30');

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
(1, 1, '2023-12-13 08:00:00', '2023-12-13 10:00:00', 'pangkas rambut', 'approved', '2023-12-13 20:29:31', '2023-12-13 20:59:22'),
(2, 1, '2023-12-14 12:00:00', '2023-12-14 13:07:00', 'Healing dulu', 'rejected', '2023-12-13 21:09:30', '2023-12-13 21:23:04'),
(3, 1, '2023-12-14 14:10:00', '2023-12-14 15:03:00', 'Wawancara project', 'approved', '2023-12-14 00:04:11', '2023-12-14 00:09:30'),
(4, 1, '2023-12-14 16:40:00', '2023-12-14 18:37:00', 'You\'re the mighty God', 'pending', '2023-12-14 01:39:09', '2023-12-14 01:39:09');

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
(1, 'GD511', '2023-12-13 20:23:57', '2023-12-13 20:23:57'),
(2, 'GD512', '2023-12-13 20:24:02', '2023-12-13 20:24:02'),
(3, 'GD513', '2023-12-13 20:24:09', '2023-12-13 20:24:09'),
(4, 'GD514', '2023-12-13 20:24:20', '2023-12-13 20:24:20');

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
(1, 1, 'Surat Magang Bersertifikat', 'Nama: Daniel Siahaan\nProdi: Teknologi Informasi 22', '2023-12-16', 'rejected', '2023-12-14 00:20:35', '2023-12-14 00:36:59');

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
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Admin', 'admin@gmail.com', NULL, '$2y$12$bn8s1BcYOV9FyqSzHwOAheNXT0nZibrUT2isZykDfh2VPCwqwhwhe', NULL, '2023-12-13 20:23:20', '2023-12-13 20:23:20');

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
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

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
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `likes`
--
ALTER TABLE `likes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mahasiswas`
--
ALTER TABLE `mahasiswas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `request_i_k_s`
--
ALTER TABLE `request_i_k_s`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `rooms`
--
ALTER TABLE `rooms`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `surat_requests`
--
ALTER TABLE `surat_requests`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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
