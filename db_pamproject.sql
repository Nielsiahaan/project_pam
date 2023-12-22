-- phpMyAdmin SQL Dump
-- version 4.9.11
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Dec 22, 2023 at 09:58 AM
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
(1, 2, 2, '2023-12-20 08:00:00', '2023-12-20', 'pending', 'untuk keperluan tutor matdis', '2023-12-19 23:52:02', '2023-12-19 23:52:02');

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
(1, 2, '2023-12-22 17:30:00', '2024-01-11 19:00:00', 'Liburan Paskah', 'Medan', 'pending', '2023-12-19 23:48:10', '2023-12-19 23:48:10');

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
(1, NULL, 'Admin', NULL, 'admin@gmail.com', NULL, NULL, '$2y$12$tPb7Iza1Pmvja4QrtUKZLOnpXyp49GSoyf6SQTsMdMziJfeku8YgO', NULL, 'admin', NULL, '2023-12-19 23:38:31', '2023-12-19 23:38:31', NULL),
(2, '11322014', 'Niel Siahaan', 'niel.shn', 'niel@gmail.com', NULL, '1207261108030001', '$2y$12$XT6qLkQAT26Kd.HGJaXRieK8tJ56CydRzUqrubLKEgkIZB3WPuwE2', '081262179432', 'mahasiswa', NULL, '2023-12-19 23:44:56', '2023-12-19 23:44:56', NULL);

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
(50, '2014_10_12_000000_create_users_table', 2),
(51, '2014_10_12_100000_create_password_reset_tokens_table', 2),
(52, '2019_08_19_000000_create_failed_jobs_table', 2),
(53, '2019_12_14_000001_create_personal_access_tokens_table', 2),
(54, '2022_12_08_015439_create_mahasiswas_table', 2),
(55, '2022_12_08_033445_add_google_id_column', 2),
(56, '2023_12_04_011205_create_feeds_table', 2),
(57, '2023_12_04_013921_create_likes_table', 2),
(58, '2023_12_04_023800_create_comments_table', 2),
(59, '2023_12_08_031619_create_rooms_table', 2),
(60, '2023_12_10_024511_create_bookings_table', 2),
(61, '2023_12_10_024540_create_surat_requests_table', 2),
(62, '2023_12_10_075352_create_request_i_k_s_table', 2),
(63, '2023_12_11_092256_create_admins_table', 2),
(64, '2023_12_12_014243_create_i_b_requests_table', 2);

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
(1, 'App\\Models\\Mahasiswa', 2, 'auth_token', '9c8690d02454da96caf59fad4746ad78a0f45df9fa241693997acbf9a6ee9118', '[\"*\"]', NULL, NULL, '2023-12-19 23:44:56', '2023-12-19 23:44:56'),
(3, 'App\\Models\\Mahasiswa', 2, 'auth_token', 'df0358c1e29961fc13799042479d0e00873c2048a4161c0bf172819a2122ded3', '[\"*\"]', '2023-12-19 23:52:11', NULL, '2023-12-19 23:47:40', '2023-12-19 23:52:11'),
(4, 'App\\Models\\Mahasiswa', 1, 'auth_token', 'ad644aa78ed88e3458ab57d34baa08d079285050f1126e2b881ac446c42179e2', '[\"*\"]', NULL, NULL, '2023-12-20 00:12:51', '2023-12-20 00:12:51'),
(5, 'App\\Models\\Mahasiswa', 1, 'auth_token', 'ab9801bd99f4b6583125c386107d60b2a051293b4ac2cb7e58c91f081cd1fc4b', '[\"*\"]', NULL, NULL, '2023-12-20 00:12:54', '2023-12-20 00:12:54'),
(6, 'App\\Models\\Mahasiswa', 1, 'auth_token', '4788a410ab0ff190e95941cafa06a9394f22fc408439218953cbe0e8fbc2178b', '[\"*\"]', NULL, NULL, '2023-12-20 00:13:32', '2023-12-20 00:13:32'),
(7, 'App\\Models\\Mahasiswa', 1, 'auth_token', 'f3fd5d0976abc0bbc24857ed775bb8d24f91fb39add6b74cca6032f6bd5f4a97', '[\"*\"]', NULL, NULL, '2023-12-20 00:39:55', '2023-12-20 00:39:55'),
(8, 'App\\Models\\Mahasiswa', 1, 'auth_token', 'cd68b040ffe5e3d78fe179a995f995b4c55cea13dcd667c9507f1173848bf4dc', '[\"*\"]', '2023-12-20 02:05:56', NULL, '2023-12-20 01:48:16', '2023-12-20 02:05:56'),
(9, 'App\\Models\\Mahasiswa', 1, 'auth_token', '8fe7c3a9c7d691c4eb5e6149f16ccbafdffce7bec4675ca6468cff4fd5e5ef6f', '[\"*\"]', '2023-12-20 02:10:01', NULL, '2023-12-20 02:08:09', '2023-12-20 02:10:01'),
(10, 'App\\Models\\Mahasiswa', 1, 'auth_token', '37199c1a8b654293a8ba542dac3dc821f54b738adcec841f2113fa96a7f748a1', '[\"*\"]', '2023-12-20 19:03:42', NULL, '2023-12-20 18:50:47', '2023-12-20 19:03:42'),
(11, 'App\\Models\\Mahasiswa', 1, 'auth_token', '7ffe461e50938d54ba845f5cce7ab7dbda29c51c1b61262ef1beb44c68d3b01a', '[\"*\"]', '2023-12-20 20:44:38', NULL, '2023-12-20 19:54:17', '2023-12-20 20:44:38'),
(14, 'App\\Models\\Mahasiswa', 1, 'auth_token', '7379130ebb95f43daa00d7b1f59df6787b3a2ea7168792082be1da8672cf045c', '[\"*\"]', NULL, NULL, '2023-12-20 21:29:35', '2023-12-20 21:29:35'),
(17, 'App\\Models\\Mahasiswa', 1, 'auth_token', 'a8b8d35b87daa322cb0a024fae4baa6a082e0abbf067e9282a9a16e01c8adbaf', '[\"*\"]', '2023-12-20 22:58:17', NULL, '2023-12-20 22:57:34', '2023-12-20 22:58:17'),
(18, 'App\\Models\\Mahasiswa', 1, 'auth_token', '3f247d7ff9f65ebc99381fc895d626f2f24b54912369d0d9a5f7d573b8216f41', '[\"*\"]', '2023-12-22 02:55:34', NULL, '2023-12-22 02:25:52', '2023-12-22 02:55:34');

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
(1, 2, '2023-12-20 08:00:00', '2023-12-20 10:00:00', 'pangkas rambut', 'pending', '2023-12-19 23:48:46', '2023-12-19 23:48:46');

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
(1, 'GD511', '2023-12-19 23:50:06', '2023-12-19 23:50:06'),
(2, 'GD 517', '2023-12-19 23:50:15', '2023-12-20 02:10:01'),
(3, 'GD513', '2023-12-19 23:50:19', '2023-12-19 23:50:19'),
(4, 'GD514', '2023-12-19 23:50:23', '2023-12-19 23:50:23'),
(5, 'GD 515', '2023-12-20 02:04:18', '2023-12-20 02:04:18');

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
(1, 2, 'surat MBKM yang diperbarui', 'keperluan magang yang diperbarui', '2023-12-14', 'approved', '2023-12-19 23:49:14', '2023-12-20 21:36:40');

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `request_i_k_s`
--
ALTER TABLE `request_i_k_s`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `rooms`
--
ALTER TABLE `rooms`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `surat_requests`
--
ALTER TABLE `surat_requests`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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
