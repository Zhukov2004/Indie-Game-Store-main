-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th12 02, 2025 lúc 06:36 AM
-- Phiên bản máy phục vụ: 10.4.32-MariaDB
-- Phiên bản PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `zzz_shop`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `order_date` date DEFAULT curdate(),
  `total_money` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `orders`
--

INSERT INTO `orders` (`order_id`, `user_id`, `order_date`, `total_money`) VALUES
(1, 2, '2025-11-26', 90.00),
(2, 3, '2025-11-28', 230.00),
(3, 3, '2025-11-28', 240.00),
(4, 3, '2025-11-28', 40.00),
(5, 3, '2025-11-28', 230.00),
(6, 2, '2025-11-28', 90.00),
(7, 2, '2025-12-01', 50.00);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `order_details`
--

CREATE TABLE `order_details` (
  `oid` int(11) NOT NULL,
  `pid` int(11) NOT NULL,
  `quantity` int(11) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `order_details`
--

INSERT INTO `order_details` (`oid`, `pid`, `quantity`, `price`) VALUES
(1, 2, 1, 50.00),
(1, 3, 1, 40.00),
(2, 1, 1, 180.00),
(2, 2, 1, 50.00),
(3, 6, 1, 180.00),
(3, 7, 1, 60.00),
(4, 3, 1, 40.00),
(5, 1, 1, 180.00),
(5, 2, 1, 50.00),
(6, 2, 1, 50.00),
(6, 3, 1, 40.00),
(7, 2, 1, 50.00);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `type` varchar(100) DEFAULT NULL,
  `rarity` varchar(20) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `video_id` varchar(50) DEFAULT 'f7lQWp1f0kQ',
  `w_engine_name` varchar(100) DEFAULT 'Unknown Engine',
  `w_engine_image` varchar(255) DEFAULT 'w_default.png',
  `teammate_1` varchar(255) DEFAULT 'no-image.png',
  `teammate_2` varchar(255) DEFAULT 'no-image.png',
  `is_upcoming` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `products`
--

INSERT INTO `products` (`id`, `name`, `type`, `rarity`, `price`, `image`, `description`, `video_id`, `w_engine_name`, `w_engine_image`, `teammate_1`, `teammate_2`, `is_upcoming`) VALUES
(1, 'Nekomata', 'Physical | Attack', 'S-Rank', 180.00, 'nekomata.png', 'Thành viên CUNNING HARES. Một cô mèo tinh nghịch với tốc độ đáng kinh ngạc.', 'Q2jboOEMt9I', 'Steel Cushion', 'w_steelcushion.png', 'anby.png', 'nicole.png', 0),
(2, 'Anby Demara', 'Electric | Stun', 'A-Rank', 50.00, 'anby.png', 'Thành viên trầm tính của CUNNING HARES. Thích xem phim và ăn burger.', 'Y2HTc9JZvwc', 'Demara Battery Mark II', 'w_demara.png', 'nekomata.png', 'nicole.png', 0),
(3, 'Billy Kid', 'Physical | Attack', 'A-Rank', 40.00, 'billy.png', 'Cyborg vui tính của CUNNING HARES. Fan cuồng của Starlight Knight.', 'WaPLKuWWahg', 'Starlight Engine Replica', 'w_starlight.png', 'nicole.png', 'anby.png', 0),
(4, 'Nicole Demara', 'Ether | Support', 'A-Rank', 40.00, 'nicole.png', 'Trưởng nhóm CUNNING HARES. Thông minh nhưng luôn gặp rắc rối về tiền bạc.', 'BA5eUSejUiQ', 'The Vault', 'w_vault.png', 'zhu_yuan.png', 'anby.png', 0),
(5, 'Grace Howard', 'Electric | Anomaly', 'S-Rank', 180.00, 'grace.png', 'Kỹ sư thiên tài của BELOBOG INDUSTRIES. Coi máy móc như con đẻ.', 'tpHEWFnS1jQ', 'Fusion Compiler', 'w_fusion.png', 'anton.png', 'rina.png', 0),
(6, 'Koleda Belobog', 'Fire | Stun', 'S-Rank', 180.00, 'koleda.png', 'Chủ tịch nhỏ tuổi của BELOBOG INDUSTRIES. Nhỏ nhưng có võ.', '1_s4XjX1pM4', 'Hellfire Gears', 'w_hellfire.png', 'ben.png', 'lucy.png', 0),
(7, 'Anton Ivanov', 'Electric | Attack', 'A-Rank', 60.00, 'anton.png', 'Đội trưởng nhiệt huyết của BELOBOG INDUSTRIES. Luôn tràn đầy năng lượng.', '1_s4XjX1pM4', 'Drill Rig - Red Axis', 'w_drill.png', 'grace.png', 'rina.png', 0),
(8, 'Ben Bigger', 'Fire | Defense', 'A-Rank', 60.00, 'ben.png', 'Kế toán gấu của BELOBOG INDUSTRIES. To lớn nhưng hiền lành và giỏi tính toán.', '1_s4XjX1pM4', 'Big Cylinder', 'w_bigcylinder.png', 'koleda.png', 'soldier11.png', 0),
(9, 'Rina', 'Electric | Support', 'S-Rank', 180.00, 'rina.png', 'Hầu gái trưởng của VICTORIA HOUSEKEEPING. Luôn đi kèm với những con rối ma quái.', 'vUEUNAzts-0', 'Weeping Cradle', 'w_weeping.png', 'grace.png', 'anton.png', 0),
(10, 'Ellen Joe', 'Ice | Attack', 'S-Rank', 180.00, 'ellen.png', 'Hầu gái cá mập của VICTORIA HOUSEKEEPING. Lạnh lùng và cắt tỉa kẻ thù nhanh gọn.', 'iOW8XhUce38', 'Deep Sea Visitor', 'w_deepsea.png', 'lycaon.png', 'soukaku.png', 0),
(11, 'Lycaon', 'Ice | Stun', 'S-Rank', 180.00, 'lycaon.png', 'Quản gia người sói của VICTORIA HOUSEKEEPING. Thanh lịch và trung thành tuyệt đối.', '8OqyvAXbgiQ', 'The Restrained', 'w_restrained.png', 'ellen.png', 'soukaku.png', 0),
(12, 'Corin Wickes', 'Physical | Attack', 'A-Rank', 50.00, 'corin.png', 'Hầu gái nhút nhát của VICTORIA HOUSEKEEPING. Sử dụng cưa máy để dọn dẹp.', 'f7lQWp1f0kQ', 'Housekeeper', 'w_housekeeper.png', 'lycaon.png', 'rina.png', 0),
(13, 'Soldier 11', 'Fire | Attack', 'S-Rank', 180.00, 'soldier11.png', 'Người lính hoàn hảo của OBOL SQUAD. Trung thành với mệnh lệnh.', 'cdjl01vqjEQ', 'The Brimstone', 'w_brimstone.png', 'koleda.png', 'lucy.png', 0),
(14, 'Trigger', 'Physical | Attack', 'A-Rank', 80.00, 'trigger.png', 'Xạ thủ thiện xạ của OBOL SQUAD. (Dữ liệu chưa chính thức).', 'q-Y0AqzOxQI', 'Unknown Engine', 'w_default.png', 'no-image.png', 'no-image.png', 0),
(15, 'Seed', 'Ice | Defense', 'A-Rank', 70.00, 'seed.png', 'Thành viên phòng vệ của OBOL SQUAD. (Dữ liệu chưa chính thức).', 'yVudzVUiBBQ', 'Unknown Engine', 'w_default.png', 'orphie.png', 'trigger.png', 0),
(16, 'Orphie & Magus', 'Ether | Support', 'A-Rank', 90.00, 'orphie.png', 'Cặp đôi bí ẩn của OBOL SQUAD. (Dữ liệu chưa chính thức).', 'jaxcn1kja9Y', 'Unknown Engine', 'w_default.png', 'no-image.png', 'no-image.png', 0),
(17, 'Zhu Yuan', 'Ether | Attack', 'S-Rank', 180.00, 'zhuyuan.png', 'Đội trưởng gương mẫu của N.E.P.S. Nguyên tắc và hiệu quả.', '0JmdwCmuA0I', 'Riot Suppressor Mark VI', 'w_riot.png', 'qingyi.png', 'nicole.png', 0),
(18, 'Qingyi', 'Electric | Stun', 'S-Rank', 180.00, 'qingyi.png', 'Cộng sự người máy của Zhu Yuan tại N.E.P.S. Thích uống nước sôi và nghe kinh kịch.', 'AO-QnJ-NvKA', 'Ice-Jade Teapot', 'w_teapot.png', 'zhu_yuan.png', 'nicole.png', 0),
(19, 'Jane Doe', 'Physical | Anomaly', 'S-Rank', 180.00, 'jane.png', 'Chuyên gia tâm lý tội phạm của N.E.P.S. Bí ẩn và nguy hiểm.', '5WCl2mtL4eE', 'Sharpened Stinger', 'w_stinger.png', 'seth.png', 'grace.png', 0),
(20, 'Seth Lowell', 'Electric | Defense', 'A-Rank', 60.00, 'seth.png', 'Sĩ quan tân binh của N.E.P.S. Nhiệt huyết bảo vệ công lý.', 'Q0t_qX8X9mU', 'Peacekeeper - Specialized', 'w_peacekeeper.png', 'jane.png', 'grace.png', 0),
(21, 'Caesar King', 'Physical | Defense', 'S-Rank', 180.00, 'caesar.png', 'Thủ lĩnh của SONS OF CALYDON. Mạnh mẽ và đầy uy quyền.', 'd17pewXhrI8', 'Tusks of Fury', 'w_tusks.png', 'lucy.png', 'piper.png', 0),
(22, 'Burnice White', 'Fire | Anomaly', 'S-Rank', 180.00, 'burnice.png', 'Chuyên gia pha chế của SONS OF CALYDON. Luôn rực lửa và sôi động.', '0NQPMTJ9rh0', 'Flamemaker Shaker', 'w_flamemaker.png', 'caesar.png', 'lucy.png', 0),
(23, 'Lighter', 'Fire | Stun', 'S-Rank', 180.00, 'lighter.png', 'Nhà vô địch bất bại của SONS OF CALYDON. Tự tin và hào sảng.', 'wKByj5l5HKQ', 'Blazing Piston', 'w_default.png', 'caesar.png', 'burnice.png', 0),
(24, 'Lucy', 'Fire | Support', 'A-Rank', 70.00, 'lucy.png', 'Tiểu thư nổi loạn gia nhập SONS OF CALYDON. Dùng gậy bóng chày và lợn con.', 'PDQ_0aE-1k0', 'Kaboom the Cannon', 'w_kaboom.png', 'soldier11.png', 'piper.png', 0),
(25, 'Piper Wheel', 'Physical | Anomaly', 'A-Rank', 60.00, 'piper.png', 'Tài xế xe tải của SONS OF CALYDON. Nhỏ nhắn nhưng lái xe cực lụa.', 'PDQ_0aE-1k0', 'Roaring Ride', 'w_roaring.png', 'nekomata.png', 'lucy.png', 0),
(26, 'Pulchra', 'Physical | Attack', 'A-Rank', 80.00, 'pulchra.png', 'Thành viên bí ẩn của SONS OF CALYDON. (Dữ liệu chưa chính thức).', 'f7lQWp1f0kQ', 'Hidden Dagger', 'w_default.png', 'caesar.png', 'lucy.png', 0),
(28, 'Harumasa', 'Electric | Attack', 'S-Rank', 180.00, 'harumasa.png', 'Thợ săn Hollow tài năng của SECTION 6. (Dữ liệu chưa chính thức).', '_3rq5fpGt0o', 'Unknown Engine', 'w_default.png', 'no-image.png', 'no-image.png', 0),
(29, 'Miyabi', 'Ice | Anomaly', 'S-Rank', 200.00, 'miyabi.png', 'Người đứng đầu SECTION 6. Kiếm sĩ huyền thoại được mong chờ nhất.', 'vw63hN_9scA', 'Ice-Bound Teapot', 'w_miyabi.png', 'soukaku.png', 'harumasa.png', 0),
(31, 'Astra Yao', 'Physical | Support', 'S-Rank', 150.00, 'astra.png', 'Thần tượng nổi tiếng thuộc STARS OF LYRA. Giọng hát chữa lành.', 'Tmd0cDFN-I4', 'Unknown Engine', 'w_default.png', 'no-image.png', 'no-image.png', 0),
(32, 'Evelyn', 'Ether | Support', 'A-Rank', 100.00, 'evelyn.png', 'Thành viên của STARS OF LYRA. Vẻ đẹp thanh khiết.', '9FQ3sTp3fdU', 'Unknown Engine', 'w_default.png', 'no-image.png', 'no-image.png', 0),
(37, 'Ju Fufu', 'Physical | Support', 'A-Rank', 90.00, 'jufufu.png', 'Thầy thuốc nhỏ tuổi từ YUNKUI SUMMIT.', 'DDl9QwUtLGg', 'Unknown Engine', 'w_default.png', 'no-image.png', 'no-image.png', 0),
(40, 'Alice', 'Ice | Support', 'A-Rank', 80.00, 'alice.png', 'Nhân viên của SPOOK SHACK. Dễ thương và nhẹ nhàng.', 'Fp7tFxXMoRM', 'Unknown Engine', 'w_default.png', 'no-image.png', 'no-image.png', 0),
(43, 'Manato', 'Ether | Attack', 'A-Rank', 80.00, 'manato.png', 'Thành viên nam hiếm hoi của SPOOK SHACK.', 'f7lQWp1f0kQ', 'Unknown Engine', 'w_default.png', 'no-image.png', 'no-image.png', 0),
(45, 'Yanagi', 'Electric | Anomaly', 'S-Rank', 180.00, 'yanagi.png', 'Phó phòng của SECTION 6. Nghiêm túc và sắc sảo.', 'UcjFp9_0flo', 'Thunder Spark', 'w_yanagi.png', 'harumasa.png', 'soukaku.png', 0),
(48, 'Soukaku', 'Ice | Support', 'A-Rank', 40.00, 'soukaku.png', 'Thành viên phàm ăn của SECTION 6. Sử dụng vũ khí khổng lồ.', 'm1n2_3sWwLpw', 'Bashful Demon', 'w_bashful.png', 'ellen.png', 'lycaon.png', 0),
(51, 'Soldier 0', 'Electric | Attack', 'S-Rank', 200.00, 'soldier0.png', 'Huyền thoại của DEFENSE FORCE. Phiên bản quá khứ của Anby?', 'IyK2g9DFlls', 'Unknown Engine', 'w_default.png', 'no-image.png', 'no-image.png', 0),
(52, 'Vivian', 'Ether | Anomaly', 'A-Rank', 120.00, 'vivian.png', 'Thành viên nhóm MOCKINGBIRD. Phong cách quý phái.', 'Mr2Uuba41nI', 'Unknown Engine', 'w_default.png', 'no-image.png', 'no-image.png', 0),
(53, 'Hugo', 'Physical | Defense', 'A-Rank', 110.00, 'hugo.png', 'Thành viên nhóm MOCKINGBIRD. Vẻ ngoài lãng tử.', 'yWbFXxzHxk8', 'Unknown Engine', 'w_default.png', 'no-image.png', 'no-image.png', 0),
(54, 'Yixuan', 'Ice | Attack', 'S-Rank', 180.00, 'yixuan.png', 'Đạo sĩ trừ tà từ YUNKUI SUMMIT.', 'ffubdFPFlS8', 'Unknown Engine', 'w_default.png', 'no-image.png', 'no-image.png', 0),
(56, 'Pan Yinhu', 'Fire | Defense', 'A-Rank', 90.00, 'panyinhu.png', 'Vệ sĩ gấu trúc từ YUNKUI SUMMIT.', 'f7lQWp1f0kQ', 'Unknown Engine', 'w_default.png', 'no-image.png', 'no-image.png', 0),
(57, 'Yuzuha', 'Fire | Attack', 'A-Rank', 80.00, 'yuzuha.png', 'Nhân viên của SPOOK SHACK. Năng động và rực rỡ.', 'yV8loyeDX_M', 'Unknown Engine', 'w_default.png', 'no-image.png', 'no-image.png', 0),
(59, 'Lucia', 'Electric | Stun', 'A-Rank', 80.00, 'lucia.png', 'Nhân viên của SPOOK SHACK. Tóc xanh cá tính.', 'rT6FVNzD02E', 'Unknown Engine', 'w_default.png', 'no-image.png', 'no-image.png', 0),
(60, 'Yidhari', 'Physical | Defense', 'A-Rank', 80.00, 'yidhari.png', 'Thành viên SPOOK SHACK.', '_Zo_zbHmOpI', 'Unknown Engine', 'w_default.png', 'no-image.png', 'no-image.png', 0),
(62, 'Ye Shunguang', 'Electric | Attack', 'S-Rank', 180.00, 'yeshunguang.png', 'Thành viên cốt cán của YUNKUI SUMMIT (Vân Khuy Sơn). Kiếm sĩ tài ba với khả năng điều khiển sấm sét.', 'r1n2_3sWwLpw', 'Unknown Engine', 'w_default.png', 'no-image.png', 'no-image.png', 1),
(63, 'Zhao', 'Fire | Defense', 'A-Rank', 80.00, 'zhao.png', 'Thành viên thuộc nhóm Quy Chuẩn Krampus. Chuyên gia phòng thủ vững chắc.', 'r1n2_3sWwLpw', 'Unknown Engine', 'w_default.png', 'no-image.png', 'no-image.png', 1),
(64, 'Banyue', 'Ice | Anomaly', 'S-Rank', 180.00, 'banyue.png', 'Thành viên bí ẩn của Quy Chuẩn Krampus. Sở hữu sức mạnh băng giá kỳ lạ.', 'r1n2_3sWwLpw', 'Unknown Engine', 'w_default.png', 'no-image.png', 'no-image.png', 1),
(65, 'Dialyn', 'Ether | Support', 'A-Rank', 80.00, 'dialyn.png', 'Hỗ trợ viên của Quy Chuẩn Krampus. Khả năng kết nối Ether vượt trội.', 'e0LoXFGJjSU', 'Unknown Engine', 'w_default.png', 'no-image.png', 'no-image.png', 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `transactions`
--

CREATE TABLE `transactions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL,
  `status` varchar(20) DEFAULT 'PENDING',
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `transactions`
--

INSERT INTO `transactions` (`id`, `user_id`, `amount`, `status`, `created_at`) VALUES
(1, 2, 500.00, 'APPROVED', '2025-11-28 13:04:44'),
(2, 2, 1000.00, 'APPROVED', '2025-11-28 13:04:44'),
(3, 2, 60.00, 'APPROVED', '2025-11-28 13:08:49'),
(4, 2, 300.00, 'REJECTED', '2025-11-28 13:10:32'),
(5, 3, 60.00, 'REJECTED', '2025-11-28 13:20:52'),
(6, 3, 60.00, 'REJECTED', '2025-11-28 13:22:59'),
(7, 3, 60.00, 'APPROVED', '2025-11-28 16:26:41');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `updates`
--

CREATE TABLE `updates` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `type` varchar(50) DEFAULT NULL,
  `version` varchar(20) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `content` text DEFAULT NULL,
  `official_link` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `updates`
--

INSERT INTO `updates` (`id`, `title`, `type`, `version`, `date`, `content`, `official_link`) VALUES
(1, 'Phiên bản 1.1: \"Gián Điệp R&B\" Chính Thức Ra Mắt', 'VERSION', 'v1.1', '2024-08-14', 'Trải nghiệm cốt truyện đặc biệt về Jane Doe, Seth và đội N.E.P.S. Mở khóa khu vực Gang Street.', 'https://zenless.hoyoverse.com/en-us/news/125132'),
(2, 'Sự kiện giới hạn: \"Tuần Tra An Ninh\"', 'EVENT', 'v1.1', '2024-08-16', 'Hoàn thành ủy thác từ Thanh Tra Qingyi để nhận Polychrome và Boopon miễn phí.', 'https://zenless.hoyoverse.com/en-us/news/125132'),
(3, 'Phiên bản 1.2: \"Tour de Inferno\" - Tiến về Outer Ring', 'VERSION', 'v1.2', '2024-09-25', 'Khám phá vùng đất hoang dã. Ra mắt Caesar King và Burnice White thuộc phe Sons of Calydon.', 'https://zenless.hoyoverse.com/en-us/news/125893'),
(4, 'Sự kiện: \"Đại Tiệc Biker Overlord\"', 'EVENT', 'v1.2', '2024-10-01', 'Tham gia đường đua tử thần tại Outer Ring để nhận W-Engine giới hạn hạng A.', 'https://zenless.hoyoverse.com/en-us/news/125893'),
(5, 'Nhân vật mới: Lighter - Nhà Vô Địch Bất Bại', 'NEW AGENT', 'v1.2', '2024-10-15', 'Lighter (S-Rank Fire/Stun) đã được thêm vào kênh Signal Search.', 'https://zenless.hoyoverse.com/en-us/news/125893'),
(6, 'Phiên bản 1.3: \"Virtual Revenge\" - Bí Mật Section 6', 'VERSION', 'v1.3', '2024-11-06', 'Hé lộ câu chuyện về Phó phòng Yanagi và H.S.O.S Section 6. Chế độ Tháp Ảo Ảnh mới.', 'https://zenless.hoyoverse.com/en-us/news/126786'),
(7, 'Sự kiện đăng nhập: \"7 Ngày Tác Chiến\"', 'EVENT', 'v1.3', '2024-11-10', 'Đăng nhập đủ 7 ngày để nhận ngay 10 Encrypted Master Tape.', 'https://zenless.hoyoverse.com/en-us/news/126786'),
(8, 'Phiên bản 1.4: \"Bản Giao Hưởng Ánh Sao\"', 'VERSION', 'v1.4', '2024-12-18', 'Chào đón Giáng Sinh tại New Eridu cùng nhóm thần tượng Stars of Lyra. Ra mắt Astra Yao.', 'https://zenless.hoyoverse.com/en-us/news'),
(9, 'Sự kiện âm nhạc: \"Hollow Idol Festival\"', 'EVENT', 'v1.4', '2024-12-20', 'Tham gia minigame âm nhạc (Rhythm Game) để đổi trang phục giới hạn cho Evelyn.', 'https://zenless.hoyoverse.com/en-us/news'),
(10, 'Phiên bản 1.5: \"Bóng Ma Quá Khứ\"', 'VERSION', 'v1.5', '2025-01-29', 'Hé lộ quá khứ của Soldier 11 và đội Obol Squad. Cập nhật cốt truyện Chương 5.', 'https://zenless.hoyoverse.com/en-us/news'),
(11, 'Chế độ mới: \"Survival Hollow\"', 'UPDATE', 'v1.5', '2025-02-05', 'Chế độ sinh tồn vô tận roguelike. Càng đi sâu, phần thưởng càng lớn.', 'https://zenless.hoyoverse.com/en-us/news'),
(12, 'Phiên bản 2.0: \"Chúa Tể Hollow\" - Đại Cập Nhật', 'VERSION', 'v2.0', '2025-03-12', 'Mở rộng bản đồ New Eridu: Khu vực Trung tâm. Ra mắt Miyabi - Kiếm sĩ huyền thoại.', 'https://zenless.hoyoverse.com/en-us/news'),
(13, 'Sự kiện kỷ niệm: \"Kỷ Nguyên Mới\"', 'EVENT', 'v2.0', '2025-03-12', 'Tặng miễn phí 1 nhân vật S-Rank tự chọn cho tất cả Proxy đăng nhập.', 'https://zenless.hoyoverse.com/en-us/news'),
(14, 'Nhân vật mới: Hoshimi Miyabi', 'NEW AGENT', 'v2.0', '2025-03-15', 'Agent được mong chờ nhất: Miyabi (Ice/Anomaly) chính thức xuất hiện.', 'https://zenless.hoyoverse.com/en-us/news'),
(15, 'Phiên bản 2.1: \"Linh Hồn Quán Trọ\"', 'VERSION', 'v2.1', '2025-04-23', 'Câu chuyện rùng rợn tại Spook Shack. Ra mắt Yuzuha và Alice.', 'https://zenless.hoyoverse.com/en-us/news'),
(16, 'Phiên bản 2.2: \"Sấm Động Vân Khuy\"', 'VERSION', 'v2.2', '2025-06-04', 'Mở khóa khu vực núi Yunkui Summit. Ra mắt Ye Shunguang và Yixuan.', 'https://zenless.hoyoverse.com/en-us/news'),
(17, 'Phiên bản 2.3: \"Giao Thức Krampus\"', 'VERSION', 'v2.3', '2025-07-16', 'Đối đầu với nhóm hacker bí ẩn Krampus Nomads. Ra mắt Zhao và Banyue.', 'https://zenless.hoyoverse.com/en-us/news'),
(18, 'Thông báo hệ thống: Điều chỉnh cân bằng Agent', 'MAINTENANCE', 'v2.3', '2025-07-20', 'Cập nhật sức mạnh cho các nhân vật hệ Vật Lý và Ether.', 'https://zenless.hoyoverse.com/en-us/news');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `full_name` varchar(100) DEFAULT NULL,
  `role` int(11) DEFAULT 0,
  `balance` decimal(10,2) DEFAULT 0.00,
  `is_locked` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `users`
--

INSERT INTO `users` (`user_id`, `username`, `password`, `full_name`, `role`, `balance`, `is_locked`) VALUES
(1, 'admin', '123', 'Fairy System', 1, 999999.00, 0),
(2, 'proxy', '123', 'Proxy', 0, 5420.00, 0),
(3, 'Huy2004', '123', 'Nguyễn Huy', 0, 5130.00, 0);

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Chỉ mục cho bảng `order_details`
--
ALTER TABLE `order_details`
  ADD PRIMARY KEY (`oid`,`pid`),
  ADD KEY `pid` (`pid`);

--
-- Chỉ mục cho bảng `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Chỉ mục cho bảng `updates`
--
ALTER TABLE `updates`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT cho bảng `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=66;

--
-- AUTO_INCREMENT cho bảng `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT cho bảng `updates`
--
ALTER TABLE `updates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT cho bảng `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Các ràng buộc cho bảng `order_details`
--
ALTER TABLE `order_details`
  ADD CONSTRAINT `order_details_ibfk_1` FOREIGN KEY (`oid`) REFERENCES `orders` (`order_id`),
  ADD CONSTRAINT `order_details_ibfk_2` FOREIGN KEY (`pid`) REFERENCES `products` (`id`);

--
-- Các ràng buộc cho bảng `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
