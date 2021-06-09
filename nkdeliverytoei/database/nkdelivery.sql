-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 09, 2021 at 10:50 AM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.4.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `nkdelivery`
--

-- --------------------------------------------------------

--
-- Table structure for table `address`
--

CREATE TABLE `address` (
  `addressID` int(11) NOT NULL,
  `longitude` int(50) NOT NULL,
  `latitude` int(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `categoryID` int(11) NOT NULL,
  `Category_name` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `customerID` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(250) NOT NULL,
  `customer_name` varchar(250) NOT NULL,
  `address_cus` varchar(250) NOT NULL,
  `phone_cus` varchar(10) NOT NULL,
  `lat` varchar(50) NOT NULL,
  `lng` varchar(50) NOT NULL,
  `token` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`customerID`, `username`, `password`, `customer_name`, `address_cus`, `phone_cus`, `lat`, `lng`, `token`) VALUES
(8, 'nanny1', '123456789', 'ธิดารัตน์ ดานะพันธ์', '112 หมู่ 7 ถนนมิตรภาพ ตำบลหนองกอมเกาะ อำเภอเมืองหนองคาย จังหวัดหนองคาย 43000', '0999785888', '17.8032646', '102.7481745', 'ebaHjHMlS5-k5YVuZG2UTc:APA91bGb1_86x456Iqo25vBysFYPbqziBNZ7JJK2-WuZBFtntgno0Jt81E8GHx9B2QjmovQYOAhz7C8m99grz0VXAEg5HKYPTvy457Bn9PKu5YnwpZ16ZRRrrayGPlHEzJcFCpFOy0Jw'),
(9, 'toei', '123456', 'toei', '112 หมู่ 7 ถนนมิตรภาพ ตำบลหนองกอมเกาะ อำเภอเมืองหนองคาย จังหวัดหนองคาย 43000', '0987654321', '17.8032468', '102.7481455', 'd86xw3d4R2W7xvq-oeURYJ:APA91bFx-IyjTGW5GpiIHDalod_0xtSrIBVcf3WIeVWyn3ZP4zjn5Mnm_eXBYYFKRH5z_Y2m1GKoTfuy0gX7LSrmtSiomWEsZUAJugwAn1xn_7xJv4MeFuSwCgnSPUUuGV1GtjEZYZVM'),
(10, 'kung', '123456', 'sasithon phimmatha', '112 หมู่ 7 ถนนมิตรภาพ ตำบลหนองกอมเกาะ อำเภอเมืองหนองคาย จังหวัดหนองคาย 43001', '0986543213', '17.7992553', '102.7479348', 'ernBhjoWRbORtxfRrEZ6Xh:APA91bF_5B1p7PxD4vexaJnXqYgkw3-lTpDeZyegBWLIW-BFIVFWT6Mc-RyoMlGWZ2ViF1tLhFH9yspeGpGgWKcYEKG5c0vv5BWmSH4MfoQ9EBtjf95BL9HQ1omEoTPr0ahPEECRMf1V'),
(42, 'tommy', '123456', 'tom my', '81/1', '0123456789', '17.7992471', '102.747916', 'ernBhjoWRbORtxfRrEZ6Xh:APA91bF_5B1p7PxD4vexaJnXqYgkw3-lTpDeZyegBWLIW-BFIVFWT6Mc-RyoMlGWZ2ViF1tLhFH9yspeGpGgWKcYEKG5c0vv5BWmSH4MfoQ9EBtjf95BL9HQ1omEoTPr0ahPEECRMf1V'),
(43, 'supharat_n', '123', 'supharat noppharat', '112', '0963258741', '17.799302', '102.7478831', '999999'),
(44, 'sasithon', '123', 'sasithon Pim', '112 fgjgfhl', '0987654321', 'null', 'null', '55555555'),
(45, 'watsana', '123', 'watsana Pim', '1233cvbm', '0987654321', '17.8031408', '102.7478996', 'd86xw3d4R2W7xvq-oeURYJ:APA91bFx-IyjTGW5GpiIHDalod_0xtSrIBVcf3WIeVWyn3ZP4zjn5Mnm_eXBYYFKRH5z_Y2m1GKoTfuy0gX7LSrmtSiomWEsZUAJugwAn1xn_7xJv4MeFuSwCgnSPUUuGV1GtjEZYZVM'),
(46, 'kungky', '08022560', 'sasithon Pimmatha', '112', '0983265571', '17.8030602', '102.7479854', 'd86xw3d4R2W7xvq-oeURYJ:APA91bFx-IyjTGW5GpiIHDalod_0xtSrIBVcf3WIeVWyn3ZP4zjn5Mnm_eXBYYFKRH5z_Y2m1GKoTfuy0gX7LSrmtSiomWEsZUAJugwAn1xn_7xJv4MeFuSwCgnSPUUuGV1GtjEZYZVM');

-- --------------------------------------------------------

--
-- Table structure for table `delivery`
--

CREATE TABLE `delivery` (
  `deliveryID` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(250) NOT NULL,
  `name_delivery` varchar(250) NOT NULL,
  `address_delivery` varchar(250) NOT NULL,
  `phone_delivery` varchar(10) NOT NULL,
  `type_id` int(11) NOT NULL,
  `number_driver` varchar(250) NOT NULL,
  `number_car` varchar(50) NOT NULL,
  `token` text NOT NULL,
  `lat` text NOT NULL,
  `lng` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `delivery`
--

INSERT INTO `delivery` (`deliveryID`, `username`, `password`, `name_delivery`, `address_delivery`, `phone_delivery`, `type_id`, `number_driver`, `number_car`, `token`, `lat`, `lng`) VALUES
(4, 'root', '123456', 'sasi12', 'nongkhai12', '9876543210', 2, '666666666612', '659912', 'fwcc0seZS5Olhv3udstGtU:APA91bEeySNRBlHYJ__SsTGXPKoEma_UJcFRoIz-6d5VMMojEFQz9UGOrnI_II1PSIj_wB30jNeiUxmECLVUORK-nx6ql5qA6WRtYfjGaMZk1BRWYBIWLW4vrVs4WXc_XEjG10diERqc', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `orderlist`
--

CREATE TABLE `orderlist` (
  `orderlistID` int(11) NOT NULL,
  `datetime` text NOT NULL,
  `customerID` text NOT NULL,
  `customer_name` text NOT NULL,
  `address_cus` text NOT NULL,
  `phone_cus` text NOT NULL,
  `lat` text NOT NULL,
  `lng` text NOT NULL,
  `storeID` text NOT NULL,
  `store_name` text NOT NULL,
  `address_store` text NOT NULL,
  `latitude` text NOT NULL,
  `longitude` text NOT NULL,
  `distance` text NOT NULL,
  `transport` text NOT NULL,
  `productID` text NOT NULL,
  `productname` text NOT NULL,
  `price` text NOT NULL,
  `amount` text NOT NULL,
  `sum` text NOT NULL,
  `total` text NOT NULL,
  `totalprice` text NOT NULL,
  `deliveryID` text NOT NULL,
  `status` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `orderlist`
--

INSERT INTO `orderlist` (`orderlistID`, `datetime`, `customerID`, `customer_name`, `address_cus`, `phone_cus`, `lat`, `lng`, `storeID`, `store_name`, `address_store`, `latitude`, `longitude`, `distance`, `transport`, `productID`, `productname`, `price`, `amount`, `sum`, `total`, `totalprice`, `deliveryID`, `status`) VALUES
(31, '2021-02-12 12:54', '8', 'ธิดารัตน์ ดานะพันธ์1', '112 หมู่ 7 ถนนมิตรภาพ ตำบลหนองกอมเกาะ อำเภอเมืองหนองคาย จังหวัดหนองคาย 43000', '0999785888', '17.8032646', '102.7481745', '25', 'Just Follow the Goat at Bualinn Resort ', 'หมู่ 2 ตำบล หนองกอมเกาะ อำเภอเมืองหนองคาย หนองคาย 43000', '17.8497938', '102.7246554', '6.13', '12', '[20, 22, 23]', '[ข้าวหมูทอดกระเทียม , ลาเต้ , เอสเปรสโซ ]', '[55, 75, 65]', '[1, 1, 1]', '[55, 75, 65]', '195', '207', '8', 'RiderOrder'),
(34, '2021-02-12 02:46', '9', 'toei', '112 หมู่ 7 ถนนมิตรภาพ ตำบลหนองกอมเกาะ อำเภอเมืองหนองคาย จังหวัดหนองคาย 43000', '0987654321', '17.8032468', '102.7481455', '24', 'ร้านลาบหนองเดิ่น', 'หมู่ 7 ตำบล หนองกอมเกาะ อำเภอเมืองหนองคาย หนองคาย 43000', '17.8282563', '102.7392002', '3.35', '6', '[4, 6, 8]', '[ซอยจุ๊, ต้มแซ่บ, ตำมั่ว]', '[60, 60, 50]', '[1, 1, 1]', '[60, 60, 50]', '170', '176', '', 'UserOrder'),
(35, '2021-02-15 03:49', '10', 'sasithon pimmatha', '112 หมู่ 7 ถนนมิตรภาพ ตำบลหนองกอมเกาะ อำเภอเมืองหนองคาย จังหวัดหนองคาย 43000', '1234567890', '17.7992471', '102.747916', '24', 'ร้านลาบหนองเดิ่น', 'หมู่ 7 ตำบล หนองกอมเกาะ อำเภอเมืองหนองคาย หนองคาย 43000', '17.8282563', '102.7392002', '3.35', '6', '[3, 6, 7]', '[ตับหวาน, ต้มแซ่บ, ต้มเนื้อ]', '[50, 60, 50]', '[1, 1, 1]', '[50, 60, 50]', '160', '166', 'none', 'UserOrder'),
(36, '2021-02-15 03:49', '10', 'sasithon pimmatha', '112 หมู่ 7 ถนนมิตรภาพ ตำบลหนองกอมเกาะ อำเภอเมืองหนองคาย จังหวัดหนองคาย 43000', '1234567890', '17.7992471', '102.747916', '25', 'Just Follow the Goat at Bualinn Resort ', 'หมู่ 2 ตำบล หนองกอมเกาะ อำเภอเมืองหนองคาย หนองคาย 43000', '17.8497938', '102.7246554', '6.13', '12', '[20, 22]', '[ข้าวหมูทอดกระเทียม , ลาเต้ ]', '[55, 75]', '[1, 1]', '[55, 75]', '130', '142', 'none', 'UserOrder'),
(37, '2021-02-15 03:56', '43', 'supharat noppharat', '112', '0963258741', '17.799302', '102.7478831', '26', 'ข้าวขาหมูกอมอ.๑', '1259 วรรณอุทิศ ตำบลในเมือง อำเภอเมืองหนองคาย หนองคาย 43000', '17.8789344', '102.747896', '8.85', '18', '[13, 14, 15]', '[ขาหมูเปล่า, ข้าวเปล่า, ไข่พะโล้ ]', '[70, 10, 10]', '[1, 1, 1]', '[70, 10, 10]', '90', '108', 'none', 'UserOrder'),
(38, '2021-02-18 11:15', '8', 'ธิดารัตน์ ดานะพันธ์', '112 หมู่ 7 ถนนมิตรภาพ ตำบลหนองกอมเกาะ อำเภอเมืองหนองคาย จังหวัดหนองคาย 43000', '0999785888', '17.8032646', '102.7481745', '24', 'ร้านลาบหนองเดิ่น', 'หมู่ 7 ตำบล หนองกอมเกาะ อำเภอเมืองหนองคาย หนองคาย 43000', '17.8282563', '102.7392002', '3.35', '6', '[5]', '[ก้อยเนื้อ]', '[60]', '[1]', '[60]', '60', '66', 'none', 'UserOrder'),
(39, '2021-02-19 12:59', '8', 'ธิดารัตน์ ดานะพันธ์', '112 หมู่ 7 ถนนมิตรภาพ ตำบลหนองกอมเกาะ อำเภอเมืองหนองคาย จังหวัดหนองคาย 43000', '0999785888', '17.8032646', '102.7481745', '25', 'Just Follow the Goat at Bualinn Resort ', 'หมู่ 2 ตำบล หนองกอมเกาะ อำเภอเมืองหนองคาย หนองคาย 43000', '17.8497938', '102.7246554', '6.14', '12', '[20, 21]', '[ข้าวหมูทอดกระเทียม , อเมริกาโน ]', '[55, 65]', '[2, 1]', '[110, 65]', '175', '187', 'none', 'Success'),
(40, '2021-02-22 01:10', '8', 'ธิดารัตน์ ดานะพันธ์', '112 หมู่ 7 ถนนมิตรภาพ ตำบลหนองกอมเกาะ อำเภอเมืองหนองคาย จังหวัดหนองคาย 43000', '0999785888', '17.8032646', '102.7481745', '26', 'ข้าวขาหมูกอมอ.๑', '1259 วรรณอุทิศ ตำบลในเมือง อำเภอเมืองหนองคาย หนองคาย 43000', '17.8789344', '102.747896', '8.85', '18', '[13, 16, 17]', '[ขาหมูเปล่า, ขาหมูยกขา, น้ำเปล่า]', '[70, 350, 10]', '[1, 1, 1]', '[70, 350, 10]', '430', '448', 'none', 'UserOrder'),
(41, '2021-02-22 01:53', '8', 'ธิดารัตน์ ดานะพันธ์', '112 หมู่ 7 ถนนมิตรภาพ ตำบลหนองกอมเกาะ อำเภอเมืองหนองคาย จังหวัดหนองคาย 43000', '0999785888', '17.8032646', '102.7481745', '24', 'ร้านลาบหนองเดิ่น', 'หมู่ 7 ตำบล หนองกอมเกาะ อำเภอเมืองหนองคาย หนองคาย 43000', '17.8282563', '102.7392002', '2.95', '6', '[3]', '[ตับหวาน]', '[50]', '[2]', '[100]', '100', '106', 'none', 'UserOrder'),
(42, '2021-02-22 02:27', '8', 'ธิดารัตน์ ดานะพันธ์', '112 หมู่ 7 ถนนมิตรภาพ ตำบลหนองกอมเกาะ อำเภอเมืองหนองคาย จังหวัดหนองคาย 43000', '0999785888', '17.8032646', '102.7481745', '25', 'Just Follow the Goat at Bualinn Resort ', 'หมู่ 2 ตำบล หนองกอมเกาะ อำเภอเมืองหนองคาย หนองคาย 43000', '17.8497938', '102.7246554', '5.75', '12', '[21]', '[อเมริกาโน ]', '[65]', '[1]', '[65]', '65', '77', 'none', 'UserOrder'),
(43, '2021-02-22 02:38', '8', 'ธิดารัตน์ ดานะพันธ์', '112 หมู่ 7 ถนนมิตรภาพ ตำบลหนองกอมเกาะ อำเภอเมืองหนองคาย จังหวัดหนองคาย 43000', '0999785888', '17.8032646', '102.7481745', '25', 'Just Follow the Goat at Bualinn Resort ', 'หมู่ 2 ตำบล หนองกอมเกาะ อำเภอเมืองหนองคาย หนองคาย 43000', '17.8497938', '102.7246554', '5.75', '12', '[19]', '[ข้าวผัด   ]', '[55]', '[1]', '[55]', '55', '67', 'none', 'UserOrder'),
(44, '2021-02-22 03:17', '8', 'ธิดารัตน์ ดานะพันธ์', '112 หมู่ 7 ถนนมิตรภาพ ตำบลหนองกอมเกาะ อำเภอเมืองหนองคาย จังหวัดหนองคาย 43000', '0999785888', '17.8032646', '102.7481745', '25', 'Just Follow the Goat at Bualinn Resort ', 'หมู่ 2 ตำบล หนองกอมเกาะ อำเภอเมืองหนองคาย หนองคาย 43000', '17.8497938', '102.7246554', '5.75', '12', '[18]', '[ข้าวคลุกกะปิ ]', '[60]', '[1]', '[60]', '60', '72', 'none', 'UserOrder'),
(45, '2021-02-23 12:15', '10', 'sasithon phimmatha', '112 หมู่ 7 ถนนมิตรภาพ ตำบลหนองกอมเกาะ อำเภอเมืองหนองคาย จังหวัดหนองคาย 43001', '0986543213', '17.7992553', '102.7479348', '25', 'Just Follow the Goat at Bualinn Resort ', 'หมู่ 2 ตำบล หนองกอมเกาะ อำเภอเมืองหนองคาย หนองคาย 43000', '17.8497938', '102.7246554', '5.75', '12', '[19, 22]', '[ข้าวผัด   , ลาเต้ ]', '[55, 75]', '[1, 1]', '[55, 75]', '130', '142', 'none', 'StoreOrder'),
(46, '2021-02-23 01:50', '10', 'sasithon phimmatha', '112 หมู่ 7 ถนนมิตรภาพ ตำบลหนองกอมเกาะ อำเภอเมืองหนองคาย จังหวัดหนองคาย 43001', '0986543213', '17.7992553', '102.7479348', '27', 'SASI Restaurant หนองคาย', '102/3 บ้านหนองเดิ่น ตำบลหนองกอมเกาะ อำเภอเมืองหนองคาย จังหวัดหนองคาย 43000', '17.819072', '102.740801', '1.93', '4', '[25]', '[ยำมาม่าทะเล]', '[50]', '[1]', '[50]', '50', '54', 'none', 'Success'),
(47, '2021-02-24 12:46', '10', 'sasithon phimmatha', '112 หมู่ 7 ถนนมิตรภาพ ตำบลหนองกอมเกาะ อำเภอเมืองหนองคาย จังหวัดหนองคาย 43001', '0986543213', '17.7992553', '102.7479348', '27', 'SASI Restaurant หนองคาย', '102/3 บ้านหนองเดิ่น ตำบลหนองกอมเกาะ อำเภอเมืองหนองคาย จังหวัดหนองคาย 43000', '17.819072', '102.740801', '1.94', '4', '[25, 24]', '[ยำมาม่าทะเล, ข้าวผัดกุ้ง]', '[50, 50]', '[1, 2]', '[50, 100]', '150', '154', 'none', 'StoreOrder'),
(48, '2021-02-24 12:46', '10', 'sasithon phimmatha', '112 หมู่ 7 ถนนมิตรภาพ ตำบลหนองกอมเกาะ อำเภอเมืองหนองคาย จังหวัดหนองคาย 43001', '0986543213', '17.7992553', '102.7479348', '27', 'SASI Restaurant หนองคาย', '102/3 บ้านหนองเดิ่น ตำบลหนองกอมเกาะ อำเภอเมืองหนองคาย จังหวัดหนองคาย 43000', '17.819072', '102.740801', '1.94', '4', '[26, 24, 25]', '[ข้าวยำไก่ย่าง, ข้าวผัดกุ้ง, ยำมาม่าทะเล]', '[40, 50, 50]', '[3, 1, 1]', '[120, 50, 50]', '220', '224', 'none', 'CancelOrder'),
(49, '2021-02-24 12:51', '10', 'sasithon phimmatha', '112 หมู่ 7 ถนนมิตรภาพ ตำบลหนองกอมเกาะ อำเภอเมืองหนองคาย จังหวัดหนองคาย 43001', '0986543213', '17.7992553', '102.7479348', '26', 'ข้าวขาหมูกอมอ.๑', '1259 วรรณอุทิศ ตำบลในเมือง อำเภอเมืองหนองคาย หนองคาย 43000', '17.8789344', '102.747896', '8.43', '16', '[11, 15, 16]', '[ข้าวขาหมูผสมมันไก่, ไข่พะโล้ , ขาหมูยกขา]', '[60, 10, 350]', '[1, 1, 1]', '[60, 10, 350]', '420', '436', '4', 'UserOrder'),
(50, '2021-02-24 03:25', '45', 'watsana P', '1233', '0987654321', '17.8036307', '102.7471938', '27', 'SASI Restaurant หนองคาย', '102/3 บ้านหนองเดิ่น ตำบลหนองกอมเกาะ อำเภอเมืองหนองคาย จังหวัดหนองคาย 43000', '17.819072', '102.740801', '1.92', '4', '[25, 24]', '[ยำมาม่าทะเล, ข้าวผัดกุ้ง]', '[50, 50]', '[1, 1]', '[50, 50]', '100', '104', '4', 'RiderOrder'),
(51, '2021-02-24 03:32', '45', 'watsana P', '1233', '0987654321', '17.8036307', '102.7471938', '27', 'SASI Restaurant หนองคาย', '102/3 บ้านหนองเดิ่น ตำบลหนองกอมเกาะ อำเภอเมืองหนองคาย จังหวัดหนองคาย 43000', '17.819072', '102.740801', '1.92', '4', '[26]', '[ข้าวยำไก่ย่าง]', '[40]', '[1]', '[40]', '40', '44', 'none', 'Success'),
(52, '2021-02-25 02:02', '46', 'sasithon Pimmatha', '112', '0983265571', '17.8030602', '102.7479854', '24', 'ร้านลาบหนองเดิ่น', 'หมู่ 7 ตำบล หนองกอมเกาะ อำเภอเมืองหนองคาย หนองคาย 43000', '17.8282563', '102.7392002', '2.95', '9', '[5, 4, 3]', '[ก้อยเนื้อ, ซอยจุ๊, ตับหวาน]', '[60, 60, 50]', '[1, 1, 1]', '[60, 60, 50]', '170', '179', '', 'UserOrder');

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `productID` int(11) NOT NULL,
  `productname` text NOT NULL,
  `detail` text NOT NULL,
  `price` text NOT NULL,
  `photo` text NOT NULL,
  `storeID` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`productID`, `productname`, `detail`, `price`, `photo`, `storeID`) VALUES
(4, 'iKONIC', 'ไม่มี', '20', '/nkdeliverytoei/ImageFood/editfood748661.jpg', '29'),
(5, 'My Type', 'ไม่มี', '59', '/nkdeliverytoei/ImageFood/editfood445676.jpg', '29'),
(6, 'ลาบเนื้อ', 'เนื้อ วัวติดมันสับหยาบ ผงปรุงรลาบ หอมแขกหรือหอมแดงซอย ผักชีใบเลื่อยซอย ต้นหอมซอย พริกป่นคั่ว ข้าวคั่ว ใบสะระแหน่\r\n \r\n', '50', '/nkdeliverytoei/ImageFood/food633155.jpg', '24'),
(7, 'ลาบหมู', 'เนื้อหมูบด ', '50', '/nkdeliverytoei/ImageFood/food633152.jpg', '24'),
(8, 'ตับหวาน', 'ตับหมู', '50', '/nkdeliverytoei/ImageFood/food633153.jpg', '24'),
(9, 'ซอยจุ๊', 'เนื้อวัวสด', '60', '/nkdeliverytoei/ImageFood/food633154.jpg', '24'),
(10, 'ก้อยเนื้อ', 'เนื้อวัว', '60', '/nkdeliverytoei/ImageFood/food633151.jpg', '24'),
(11, 'ต้มแซ่บ', 'เนื้อวัว', '60', '/nkdeliverytoei/ImageFood/food633157.jpg', '24'),
(12, 'ต้มเนื้อ', 'เนื้อวัว', '50', '/nkdeliverytoei/ImageFood/food633158.jpg', '24'),
(13, 'ตำมั่ว', '-', '40', '/nkdeliverytoei/ImageFood/food633159.jpg', '24'),
(14, 'ตำถั่ว', '-', '40', '/nkdeliverytoei/ImageFood/food633160.jpg', '24'),
(15, 'ข้าวขาหมู', '-', '50', '/nkdeliverytoei/ImageFood/food123101.jpg', '26'),
(16, 'ข้าวขอหมูผสมไก่', '-', '60', '/nkdeliverytoei/ImageFood/food123100.jpg', '26'),
(17, 'ข้าวคากิ', '-', '50', '/nkdeliverytoei/ImageFood/food123696.jpg', '26'),
(18, 'ขาหมู', 'กับข้าว', '70', '/nkdeliverytoei/ImageFood/food123695.jpg', '26'),
(19, 'ข้าวสวย', '-', '10', '/nkdeliverytoei/ImageFood/food123697.jpg', '26'),
(20, 'ไข่พะโล้', 'กับข้าว', '30', '/nkdeliverytoei/ImageFood/food123699.jpg', '26'),
(21, 'ขาหมูยกขา', '-', '350', '/nkdeliverytoei/ImageFood/food123102.jpg', '26'),
(22, 'น้ำเปล่า', 'ขวดเล็ก', '10', '/nkdeliverytoei/ImageFood/food123698.jpg', '26'),
(23, 'ข้าวคุกกะปิ', '-', '60', '/nkdeliverytoei/ImageFood/food123111.jpg', '25'),
(24, 'ข้าวผัด', '-', '55', '/nkdeliverytoei/ImageFood/food123112.jpg', '25'),
(25, 'ข้าวหมูทอดกระเทียม', '-', '55', '/nkdeliverytoei/ImageFood/food123113.jpg', '25'),
(26, 'อเมริกาาโน่', '-', '65', '/nkdeliverytoei/ImageFood/food123114.jpg', '25'),
(27, 'เอสเพรสโซ่', '-', '65', '/nkdeliverytoei/ImageFood/food40358.jpg', '25'),
(28, 'ยำมาม่าทะเล', '-', '50', '/nkdeliverytoei/ImageFood/food123122.jpg', '27'),
(29, 'ข้าวยำไก่ย่าง', '-', '50', '/nkdeliverytoei/ImageFood/food123123.jpg', '27'),
(30, 'ข้าวผัดกุ้ง', '-', '50', '/nkdeliverytoei/ImageFood/food123121.jpg', '27'),
(33, 'Rhythm Ta', 'ไม่มี', '15', '/nkdeliverytoei/ImageFood/editfood88718.jpg', '29');

-- --------------------------------------------------------

--
-- Table structure for table `store`
--

CREATE TABLE `store` (
  `storeID` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(250) NOT NULL,
  `store_name` varchar(100) NOT NULL,
  `commercial_number` varchar(13) NOT NULL,
  `name_operator` varchar(250) NOT NULL,
  `address_store` varchar(250) NOT NULL,
  `longitude` text DEFAULT NULL,
  `latitude` text DEFAULT NULL,
  `address_operator` varchar(250) NOT NULL,
  `phone_store` varchar(10) NOT NULL,
  `p_img` text NOT NULL,
  `status` varchar(20) NOT NULL,
  `token` text NOT NULL,
  `timeopen` text DEFAULT NULL,
  `timeclose` text DEFAULT NULL,
  `dayopen` text NOT NULL,
  `dayclose` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `store`
--

INSERT INTO `store` (`storeID`, `username`, `password`, `store_name`, `commercial_number`, `name_operator`, `address_store`, `longitude`, `latitude`, `address_operator`, `phone_store`, `p_img`, `status`, `token`, `timeopen`, `timeclose`, `dayopen`, `dayclose`) VALUES
(24, 'root', '12345', 'ร้านลาบหนองเดิ่น', '1234565555', 'seyherh', 'หมู่ 7 ตำบล หนองกอมเกาะ อำเภอเมืองหนองคาย หนองคาย 43000', '102.7481321', '17.8028664', 'reujrty', '0879224397', '/nkdeliverytoei/ImageShop/editShop81672.jpg', 'open', 'eDLU66KXQZiqnsOd7AmSA-:APA91bG7LT0I0lTuGQuS-TrrKzzrFbv_y8aoapxr54-s7FmOfWyMD4z-iIhYXqlM7VGh4wR8lAMgNVolVG6iTsY5U8RyE7tx5-BiiIV7AxLyQSE4YThwq-NzG3Yo17vYbkuhqM-Pr3db', '07.00', '21.00', 'jun', 'tu'),
(25, 'dxhf', '12345', 'Just Follow the Goat at Bualinn Resort ', '546786', 'ui222', 'หมู่ 2 ตำบล หนองกอมเกาะ อำเภอเมืองหนองคาย หนองคาย 43000', '102.7246554', '17.8497938', 'ut ', '0909978929', '/nkdeliverytoei/ImageShop/shop633143.jpg', '', 'cK6UWuXKSzyw__JkMDLyL8:APA91bExCBphM7n7rKR2NnShR3lzzD_bHwbHPJZCn9C3-XhojZi7j5Ou6Rpxqou78y_LArJ7Y5pkwvjNKtOkJHKxEWiVsfR53SWp6ZkVZzBoH74ZpY6eIz-OGOJrMSDCne4kAsWdeOPN', '', '', '', ''),
(26, 'kormor', '123456789', 'ข้าวขาหมูกอมอ.๑', 'fcjgm', 'cgmhgm', '1259 วรรณอุทิศ ตำบลในเมือง อำเภอเมืองหนองคาย หนองคาย 43000', '102.747896', '17.8789344', 'zhfjgf', '0955627798', '/nkdeliverytoei/ImageShop/shop633142.jpg', '', 'cK6UWuXKSzyw__JkMDLyL8:APA91bExCBphM7n7rKR2NnShR3lzzD_bHwbHPJZCn9C3-XhojZi7j5Ou6Rpxqou78y_LArJ7Y5pkwvjNKtOkJHKxEWiVsfR53SWp6ZkVZzBoH74ZpY6eIz-OGOJrMSDCne4kAsWdeOPN', '', '', '', ''),
(27, 'sasi', '123456', 'SASI Restaurant หนองคาย', '987654321', 'Tanupat Sittiwong', '102/3 บ้านหนองเดิ่น ตำบลหนองกอมเกาะ อำเภอเมืองหนองคาย จังหวัดหนองคาย 43000', '102.7481321', '17.8028664', '102/3 บ้านหนองเดิ่น ตำบลหนองกอมเกาะ อำเภอเมืองหนองคาย จังหวัดหนองคาย 43000', '0987654321', '/nkdeliverytoei/ImageShop/shop633141.jpg', '', 'cK6UWuXKSzyw__JkMDLyL8:APA91bExCBphM7n7rKR2NnShR3lzzD_bHwbHPJZCn9C3-XhojZi7j5Ou6Rpxqou78y_LArJ7Y5pkwvjNKtOkJHKxEWiVsfR53SWp6ZkVZzBoH74ZpY6eIz-OGOJrMSDCne4kAsWdeOPN', '1222', '5464', 'iiii', 'ffff'),
(29, 'supharat', '123456789', 'อร่อยดี', '123456789', 'ศุภรัตน์ นพวัติ', '112', '102.7494628', '17.7981655', '112', '0987654321', '/nkdeliverytoei/ImageShop/editShop49373.jpg', '', 'eDLU66KXQZiqnsOd7AmSA-:APA91bG7LT0I0lTuGQuS-TrrKzzrFbv_y8aoapxr54-s7FmOfWyMD4z-iIhYXqlM7VGh4wR8lAMgNVolVG6iTsY5U8RyE7tx5-BiiIV7AxLyQSE4YThwq-NzG3Yo17vYbkuhqM-Pr3db', '08.00', '16.00', 'จันทร์', 'ศุกร์');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_admin`
--

CREATE TABLE `tbl_admin` (
  `admin_id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_admin`
--

INSERT INTO `tbl_admin` (`admin_id`, `username`, `password`) VALUES
(1, 'sasithon_p', '123456789');

-- --------------------------------------------------------

--
-- Table structure for table `type_car`
--

CREATE TABLE `type_car` (
  `type_id` int(11) NOT NULL,
  `type_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `type_car`
--

INSERT INTO `type_car` (`type_id`, `type_name`) VALUES
(2, 'รถยนต์'),
(3, 'รถจักรยานยนต์');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `address`
--
ALTER TABLE `address`
  ADD PRIMARY KEY (`addressID`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`categoryID`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`customerID`);

--
-- Indexes for table `delivery`
--
ALTER TABLE `delivery`
  ADD PRIMARY KEY (`deliveryID`);

--
-- Indexes for table `orderlist`
--
ALTER TABLE `orderlist`
  ADD PRIMARY KEY (`orderlistID`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`productID`);

--
-- Indexes for table `store`
--
ALTER TABLE `store`
  ADD PRIMARY KEY (`storeID`);

--
-- Indexes for table `tbl_admin`
--
ALTER TABLE `tbl_admin`
  ADD PRIMARY KEY (`admin_id`);

--
-- Indexes for table `type_car`
--
ALTER TABLE `type_car`
  ADD PRIMARY KEY (`type_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `customerID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT for table `delivery`
--
ALTER TABLE `delivery`
  MODIFY `deliveryID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `orderlist`
--
ALTER TABLE `orderlist`
  MODIFY `orderlistID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `productID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `store`
--
ALTER TABLE `store`
  MODIFY `storeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `tbl_admin`
--
ALTER TABLE `tbl_admin`
  MODIFY `admin_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `type_car`
--
ALTER TABLE `type_car`
  MODIFY `type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
