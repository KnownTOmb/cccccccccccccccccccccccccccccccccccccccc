-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sty 17, 2026 at 06:54 PM
-- Wersja serwera: 10.4.32-MariaDB
-- Wersja PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `smipegs_lublin`
--

DELIMITER $$
--
-- Procedury
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `usun_stare_ogloszenia` (IN `starsze_niz` INT, IN `do_kiedy` DATE, IN `usunac` BOOLEAN)   BEGIN
    DECLARE data_graniczna DATE;
    IF usunac IS NULL THEN
    	SET usunac = 0;
	END IF;

    IF (starsze_niz IS NOT NULL AND starsze_niz > 0)
        AND (do_kiedy IS NOT NULL AND do_kiedy <> '0000-00-00') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Nie można podać obu parametrów jednocześnie';

    ELSEIF starsze_niz IS NOT NULL AND starsze_niz > 0 THEN
        SET data_graniczna = DATE_SUB(CURDATE(), INTERVAL starsze_niz YEAR);

    ELSEIF do_kiedy IS NOT NULL AND do_kiedy <> '0000-00-00' THEN
        SET data_graniczna = do_kiedy;

    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Nie podano poprawnego parametru';
    END IF;

    SELECT *
    FROM ogloszenie
    WHERE data_wstawienia < data_graniczna
        AND (archiwalny IS NULL OR archiwalny = 0);
	IF (usunac) THEN
    DELETE
    FROM ogloszenie
    WHERE data_wstawienia < data_graniczna
        AND (archiwalny IS NULL OR archiwalny = 0);
	END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `adres`
--

CREATE TABLE `adres` (
  `id` int(10) UNSIGNED NOT NULL,
  `rejon` varchar(64) NOT NULL,
  `kod_pocztowy` smallint(3) UNSIGNED ZEROFILL NOT NULL,
  `ulica` varchar(64) NOT NULL,
  `numer_budynku` smallint(255) UNSIGNED NOT NULL,
  `numer_mieszkania` smallint(255) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `adres`
--

INSERT INTO `adres` (`id`, `rejon`, `kod_pocztowy`, `ulica`, `numer_budynku`, `numer_mieszkania`) VALUES
(1, 'Węglin Północny', 990, 'ul. Toruńska', 251, 28),
(2, 'Kalinowszczyzna', 319, 'al. Strażacka', 58, NULL),
(3, 'Wieniawa', 625, 'pl. Wysoka', 719, NULL),
(4, 'Zemborzyce', 781, 'pl. Zdrojowa', 971, 59),
(5, 'Wieniawa', 017, 'pl. Południowa', 84, NULL),
(6, 'Czechów Północny', 300, 'ul. Robotnicza', 241, 6),
(7, 'Głusk', 370, 'ul. Okrzei', 471, 33),
(8, 'Czechów Południowy', 576, 'al. Rzeczna', 65, 45),
(9, 'Konstantynów', 442, 'ul. Źródlana', 82, NULL),
(10, 'Czuby Południowe', 472, 'pl. Krakowska', 587, NULL),
(11, 'Sławinek', 470, 'ul. Szkolna', 833, 16),
(12, 'Rury', 951, 'ul. Waryńskiego', 588, NULL),
(13, 'Kośminek', 222, 'al. Ciasna', 480, NULL),
(14, 'Węglin Południowy', 643, 'ul. Okrężna', 322, NULL),
(15, 'Czechów Północny', 336, 'al. Poziomkowa', 927, NULL),
(16, 'Śródmieście', 811, 'pl. Chopina', 203, 30),
(17, 'Stare Miasto', 062, 'pl. Okrężna', 19, 43),
(18, 'Wrotków', 345, 'ul. Reymonta', 923, NULL),
(19, 'Rury', 997, 'al. Powstańców Śląskich', 122, NULL),
(20, 'Czuby Północne', 906, 'ul. Rubinowa', 680, NULL),
(21, 'Kalinowszczyzna', 380, 'al. Rybacka', 104, NULL),
(22, 'Głusk', 941, 'al. Kruczkowskiego', 788, 56),
(23, 'Za Cukrownią', 824, 'ul. Szymanowskiego', 116, NULL),
(24, 'Sławin', 701, 'al. Wypoczynkowa', 863, NULL),
(25, 'Węglin Południowy', 148, 'al. Stroma', 250, 96),
(26, 'Węglin Południowy', 818, 'pl. Pogodna', 277, 82),
(27, 'Sławin', 063, 'pl. Zielona', 546, NULL),
(28, 'Głusk', 744, 'al. Urocza', 895, NULL),
(29, 'Konstantynów', 464, 'pl. Diamentowa', 264, NULL),
(30, 'Wrotków', 022, 'al. Listopada', 65, 11),
(31, 'Hajdów-Zadębie', 195, 'al. Wschodnia', 437, 54),
(32, 'Wieniawa', 609, 'ul. Żwirowa', 715, 34),
(33, 'Zemborzyce', 198, 'al. Kochanowskiego', 21, NULL),
(34, 'Śródmieście', 401, 'ul. Władysława Jagiełły', 217, 30),
(35, 'Hajdów-Zadębie', 111, 'pl. Gdańska', 648, 2),
(36, 'Zemborzyce', 131, 'pl. Nadrzeczna', 760, 95),
(37, 'Bronowice', 007, 'pl. Wiklinowa', 757, 91),
(38, 'Dziesiąta', 573, 'pl. Porzeczkowa', 569, 28),
(39, 'Za Cukrownią', 623, 'pl. Jana III Sobieskiego', 687, 13),
(40, 'Za Cukrownią', 139, 'al. Kalinowa', 73, NULL),
(41, 'Czuby Północne', 011, 'pl. Wolności', 649, 42),
(42, 'Bronowice', 119, 'pl. Dąbrowskiej', 639, NULL),
(43, 'Wieniawa', 835, 'pl. Tulipanowa', 298, 9),
(44, 'Zemborzyce', 928, 'ul. Podwale', 163, NULL),
(45, 'Węglin Południowy', 265, 'pl. Sportowa', 456, 4),
(46, 'Zemborzyce', 438, 'pl. Korczaka', 825, 51),
(47, 'Czuby Północne', 569, 'al. Kielecka', 831, 22),
(48, 'Dziesiąta', 630, 'ul. Tartaczna', 941, 46),
(49, 'Wrotków', 876, 'ul. Wodna', 968, 62),
(50, 'Rury', 656, 'pl. Pałacowa', 866, NULL),
(51, 'Dziesiąta', 959, 'pl. Stolarska', 874, 34),
(52, 'Szerokie', 666, 'ul. Nadbrzeżna', 389, 26),
(53, 'Wieniawa', 675, 'al. Ceglana', 808, NULL),
(54, 'Za Cukrownią', 163, 'ul. Bociania', 927, NULL),
(55, 'Stare Miasto', 067, 'al. Lwowska', 462, NULL),
(56, 'Hajdów-Zadębie', 537, 'pl. Zakątek', 771, NULL),
(57, 'Węglin Północny', 269, 'pl. Wałowa', 81, 97),
(58, 'Węglin Południowy', 942, 'al. Orzechowa', 663, 64),
(59, 'Czechów Północny', 061, 'ul. Narutowicza', 443, NULL),
(60, 'Zemborzyce', 442, 'ul. Grunwaldzka', 467, 60),
(61, 'Wieniawa', 051, 'ul. Południowa', 296, 60),
(62, 'Czechów Południowy', 498, 'ul. Odrzańska', 743, 71),
(63, 'Śródmieście', 264, 'al. Kwiatowa', 801, 27),
(64, 'Kalinowszczyzna', 189, 'al. Cedrowa', 131, 57),
(65, 'Węglin Południowy', 322, 'al. Krasińskiego', 59, NULL),
(66, 'Sławinek', 706, 'ul. Staszica', 958, 88),
(67, 'Ponikwoda', 941, 'ul. Średnia', 55, 98),
(68, 'Wrotków', 500, 'ul. Leśna', 977, 24),
(69, 'Śródmieście', 053, 'al. Szmaragdowa', 110, NULL),
(70, 'Czechów Południowy', 128, 'ul. Zielona', 289, NULL),
(71, 'Stare Miasto', 247, 'ul. Szymanowskiego', 280, NULL),
(72, 'Czechów Południowy', 428, 'al. Krasińskiego', 782, NULL),
(73, 'Kośminek', 656, 'ul. Daleka', 886, 44),
(74, 'Zemborzyce', 949, 'ul. Wschodnia', 678, NULL),
(75, 'Śródmieście', 699, 'al. Wiatraczna', 408, NULL),
(76, 'Szerokie', 799, 'pl. Kielecka', 776, 68),
(77, 'Sławin', 483, 'al. Podmiejska', 36, NULL),
(78, 'Ponikwoda', 573, 'ul. Kaliska', 213, NULL),
(79, 'Śródmieście', 882, 'ul. Moniuszki', 651, 93),
(80, 'Sławin', 750, 'pl. Fiołkowa', 611, NULL),
(81, 'Wrotków', 833, 'pl. Fiołkowa', 857, NULL),
(82, 'Za Cukrownią', 587, 'ul. Wczasowa', 836, 33),
(83, 'Wrotków', 643, 'pl. Armii Krajowej', 73, NULL),
(84, 'Za Cukrownią', 534, 'al. Jana III Sobieskiego', 459, 92),
(85, 'Śródmieście', 422, 'pl. Poznańska', 815, 39),
(86, 'Kośminek', 778, 'ul. Stycznia', 481, 1),
(87, 'Sławin', 179, 'al. Szkolna', 787, 8),
(88, 'Konstantynów', 673, 'ul. Pogodna', 970, NULL),
(89, 'Tatary', 095, 'ul. Willowa', 67, NULL),
(90, 'Kośminek', 236, 'pl. Swierkowa', 717, NULL),
(91, 'Węglin Północny', 778, 'al. Słowicza', 209, NULL),
(92, 'Stare Miasto', 397, 'ul. Lelewela', 813, 85),
(93, 'Felin', 670, 'ul. Śląska', 757, NULL),
(94, 'Rury', 558, 'al. Konopnickiej', 369, NULL),
(95, 'Abramowice', 361, 'al. Sokola', 157, NULL),
(96, 'Tatary', 166, 'ul. Miłosza', 560, 66),
(97, 'Sławinek', 235, 'pl. Cedrowa', 90, 51),
(98, 'Abramowice', 920, 'al. Słowianska', 851, NULL),
(99, 'Czechów Północny', 765, 'al. Konwaliowa', 168, NULL),
(100, 'Kalinowszczyzna', 121, 'al. Bolesława Chrobrego', 384, NULL),
(101, 'Bronowice', 066, 'pl. Cyprysowa', 115, 0),
(102, 'Szerokie', 574, 'ul. Krasińskiego', 912, 42),
(103, 'Dziesiąta', 464, 'al. Konarskiego', 741, 52),
(104, 'Węglin Południowy', 896, 'al. Grottgera', 584, 81),
(105, 'Węglin Południowy', 127, 'pl. Wiśniowa', 675, NULL),
(106, 'Dziesiąta', 571, 'pl. Wałowa', 813, 85),
(107, 'Kalinowszczyzna', 246, 'ul. Andersa', 248, NULL),
(108, 'Węglin Południowy', 168, 'ul. Konstytucji 3 Maja', 757, 75),
(109, 'Konstantynów', 775, 'pl. Broniewskiego', 335, NULL),
(110, 'Sławinek', 975, 'al. Sienkiewicza', 798, NULL),
(111, 'Dziesiąta', 679, 'ul. Tuwima', 418, NULL),
(112, 'Węglin Południowy', 769, 'al. Prosta', 486, 43),
(113, 'Sławin', 334, 'pl. Leszczynowa', 877, 55),
(114, 'Ponikwoda', 861, 'al. Jana', 720, 29),
(115, 'Czuby Północne', 911, 'pl. Wiosenna', 716, 73),
(116, 'Kalinowszczyzna', 476, 'pl. Zwycięstwa', 526, 57),
(117, 'Tatary', 431, 'pl. Powstańców', 784, NULL),
(118, 'Czuby Południowe', 855, 'ul. Władysława Jagiełły', 475, NULL),
(119, 'Czuby Północne', 612, 'ul. Mała', 643, NULL),
(120, 'Węglin Południowy', 507, 'ul. Fabryczna', 170, 31),
(121, 'Abramowice', 829, 'pl. Wrzosowa', 452, NULL),
(122, 'Zemborzyce', 985, 'pl. Kasprowicza', 996, NULL),
(123, 'Zemborzyce', 099, 'al. Gałczynskiego', 688, 82),
(124, 'Stare Miasto', 630, 'pl. Warszawska', 645, NULL),
(125, 'Dziesiąta', 433, 'ul. Wojska Polskiego', 50, NULL),
(126, 'Wieniawa', 451, 'ul. Dworcowa', 360, NULL),
(127, 'Węglin Południowy', 569, 'pl. Strzelecka', 621, 70),
(128, 'Stare Miasto', 440, 'ul. Morcinka', 381, 89),
(129, 'Szerokie', 153, 'pl. Targowa', 290, 22),
(130, 'Węglin Południowy', 011, 'al. Cmentarna', 730, 59),
(131, 'Czuby Północne', 557, 'pl. Klasztorna', 349, 75),
(132, 'Zemborzyce', 294, 'pl. Parkowa', 320, 59),
(133, 'Konstantynów', 608, 'ul. Kościuszki', 99, NULL),
(134, 'Felin', 148, 'al. Owocowa', 833, NULL),
(135, 'Czuby Południowe', 765, 'pl. Szewska', 368, 77),
(136, 'Konstantynów', 780, 'al. Wałowa', 791, NULL),
(137, 'Czechów Północny', 491, 'pl. Jana', 63, 72),
(138, 'Kośminek', 681, 'pl. Graniczna', 696, NULL),
(139, 'Za Cukrownią', 525, 'pl. Jabłoniowa', 500, NULL),
(140, 'Czuby Północne', 527, 'pl. Topolowa', 711, NULL),
(141, 'Kośminek', 662, 'ul. Przechodnia', 241, 5),
(142, 'Wieniawa', 170, 'al. Zamkowa', 113, NULL),
(143, 'Bronowice', 391, 'pl. Krańcowa', 802, 91),
(144, 'Czuby Północne', 509, 'al. Piłsudskiego', 465, 53),
(145, 'Sławin', 092, 'pl. Młynarska', 540, 62),
(146, 'Abramowice', 581, 'pl. Truskawkowa', 700, 4),
(147, 'Stare Miasto', 751, 'pl. Chabrowa', 296, 56),
(148, 'Felin', 913, 'ul. Długa', 171, 14),
(149, 'Dziesiąta', 932, 'ul. Kaszubska', 174, 40),
(150, 'Głusk', 791, 'ul. Wolności', 566, NULL),
(151, 'Kalinowszczyzna', 289, 'al. Korczaka', 874, 56),
(152, 'Głusk', 500, 'ul. Prosta', 18, NULL),
(153, 'Wrotków', 711, 'al. Orla', 790, 9),
(154, 'Węglin Południowy', 481, 'pl. Jeżynowa', 440, 32),
(155, 'Kośminek', 972, 'ul. Ptasia', 217, NULL),
(156, 'Węglin Północny', 008, 'ul. Ludowa', 987, NULL),
(157, 'Stare Miasto', 381, 'ul. Bolesława Krzywoustego', 548, 74),
(158, 'Węglin Południowy', 667, 'ul. Kolejowa', 689, NULL),
(159, 'Kalinowszczyzna', 400, 'al. Nowa', 335, 40),
(160, 'Czechów Południowy', 822, 'al. Jarzębinowa', 694, 65),
(161, 'Głusk', 664, 'pl. Chełmońskiego', 983, NULL),
(162, 'Za Cukrownią', 038, 'ul. Słoneczna', 744, 37),
(163, 'Zemborzyce', 943, 'pl. Leśna', 947, NULL),
(164, 'Stare Miasto', 989, 'ul. Andersa', 94, NULL),
(165, 'Hajdów-Zadębie', 175, 'pl. Kasprowicza', 827, 44),
(166, 'Stare Miasto', 671, 'pl. Pałacowa', 597, NULL),
(167, 'Za Cukrownią', 306, 'pl. Olchowa', 823, 89),
(168, 'Szerokie', 185, 'pl. Krasickiego', 533, 66),
(169, 'Wrotków', 631, 'al. Cisowa', 923, NULL),
(170, 'Ponikwoda', 734, 'pl. Krótka', 26, 62),
(171, 'Kalinowszczyzna', 277, 'ul. Kwiatowa', 988, 95),
(172, 'Konstantynów', 369, 'ul. Klasztorna', 781, NULL),
(173, 'Wrotków', 597, 'pl. Stycznia', 543, NULL),
(174, 'Dziesiąta', 430, 'al. Jeziorna', 230, NULL),
(175, 'Tatary', 536, 'al. Działkowa', 124, 6),
(176, 'Wieniawa', 871, 'al. Grabowa', 180, 59),
(177, 'Sławin', 330, 'pl. Rubinowa', 537, 73),
(178, 'Rury', 017, 'pl. Cisowa', 100, NULL),
(179, 'Kośminek', 770, 'pl. Poziomkowa', 406, NULL),
(180, 'Węglin Południowy', 073, 'al. Jana Pawła II', 274, NULL),
(181, 'Za Cukrownią', 278, 'al. Zaułek', 30, NULL),
(182, 'Sławinek', 913, 'pl. Torowa', 450, 89),
(183, 'Kośminek', 260, 'al. Miodowa', 25, 7),
(184, 'Szerokie', 441, 'al. Kaliska', 130, NULL),
(185, 'Kośminek', 360, 'pl. Truskawkowa', 324, 18),
(186, 'Węglin Północny', 118, 'ul. Południowa', 961, NULL),
(187, 'Wieniawa', 607, 'pl. Kowalska', 295, NULL),
(188, 'Czuby Południowe', 867, 'al. Kruczkowskiego', 528, NULL),
(189, 'Konstantynów', 139, 'pl. Krucza', 596, NULL),
(190, 'Rury', 310, 'al. Piękna', 869, NULL),
(191, 'Węglin Północny', 655, 'pl. Podwale', 347, 7),
(192, 'Węglin Południowy', 155, 'al. Młynarska', 855, NULL),
(193, 'Konstantynów', 562, 'al. Słowicza', 637, NULL),
(194, 'Wrotków', 712, 'pl. Kolejowa', 972, NULL),
(195, 'Czechów Północny', 042, 'ul. Poziomkowa', 389, NULL),
(196, 'Konstantynów', 098, 'pl. Jesienna', 606, NULL),
(197, 'Wrotków', 709, 'al. Ciasna', 50, 6),
(198, 'Felin', 778, 'pl. Owocowa', 945, NULL),
(199, 'Bronowice', 273, 'ul. Asnyka', 213, 91),
(200, 'Za Cukrownią', 688, 'ul. Parkowa', 355, 51),
(201, 'Zemborzyce', 453, 'pl. Tuwima', 995, NULL),
(202, 'Sławinek', 090, 'pl. Boczna', 691, NULL),
(203, 'Stare Miasto', 329, 'al. Błękitna', 133, NULL),
(204, 'Tatary', 217, 'al. Środkowa', 991, 2),
(205, 'Dziesiąta', 126, 'ul. Wysoka', 544, 99),
(206, 'Czuby Południowe', 555, 'pl. Gałczynskiego', 870, NULL),
(207, 'Konstantynów', 285, 'ul. Kamienna', 878, 60),
(208, 'Zemborzyce', 928, 'pl. Podleśna', 383, NULL),
(209, 'Węglin Południowy', 178, 'al. Słowackiego', 261, 57),
(210, 'Szerokie', 974, 'pl. Morcinka', 500, NULL),
(211, 'Śródmieście', 362, 'pl. Armii Krajowej', 983, NULL),
(212, 'Ponikwoda', 396, 'al. Strażacka', 145, NULL),
(213, 'Za Cukrownią', 747, 'ul. Witosa', 274, 22),
(214, 'Sławinek', 147, 'ul. Zacisze', 122, 24),
(215, 'Za Cukrownią', 704, 'ul. Kosynierów', 980, 60),
(216, 'Czuby Południowe', 363, 'pl. Cedrowa', 264, NULL),
(217, 'Sławinek', 075, 'pl. Wyzwolenia', 480, 68),
(218, 'Czuby Południowe', 160, 'al. Czereśniowa', 965, 51),
(219, 'Węglin Północny', 270, 'al. Asnyka', 119, 60),
(220, 'Bronowice', 740, 'ul. Pogodna', 505, 18),
(221, 'Węglin Północny', 747, 'ul. Lelewela', 936, 5),
(222, 'Czuby Północne', 901, 'ul. Staffa', 606, 58),
(223, 'Węglin Południowy', 470, 'ul. Władysława Jagiełły', 783, NULL),
(224, 'Hajdów-Zadębie', 046, 'ul. Kościelna', 155, 72),
(225, 'Dziesiąta', 737, 'ul. Poziomkowa', 7, NULL),
(226, 'Rury', 578, 'pl. Morska', 716, NULL),
(227, 'Czechów Południowy', 233, 'ul. Nowowiejska', 424, NULL),
(228, 'Abramowice', 439, 'ul. Pszenna', 641, NULL),
(229, 'Głusk', 591, 'pl. Chmielna', 258, NULL),
(230, 'Ponikwoda', 544, 'al. Żytnia', 8, NULL),
(231, 'Kośminek', 831, 'ul. Wrocławska', 394, NULL),
(232, 'Dziesiąta', 546, 'pl. Wyszyńskiego', 892, NULL),
(233, 'Węglin Północny', 939, 'al. Środkowa', 58, 54),
(234, 'Stare Miasto', 680, 'al. Listopada', 472, NULL),
(235, 'Wrotków', 260, 'al. Daszyńskiego', 719, 21),
(236, 'Kalinowszczyzna', 201, 'ul. Czarnieckiego', 446, NULL),
(237, 'Węglin Południowy', 092, 'pl. Batalionów Chłopskich', 187, 26),
(238, 'Za Cukrownią', 702, 'ul. Kasprowicza', 516, 90),
(239, 'Czechów Północny', 838, 'pl. Żabia', 412, NULL),
(240, 'Ponikwoda', 803, 'ul. Jałowcowa', 333, NULL),
(241, 'Sławin', 487, 'pl. Działkowa', 928, 91),
(242, 'Ponikwoda', 046, 'ul. Traugutta', 4, NULL),
(243, 'Hajdów-Zadębie', 039, 'ul. Popiełuszki', 863, 63),
(244, 'Sławin', 647, 'ul. Hutnicza', 798, 89),
(245, 'Śródmieście', 403, 'pl. Krótka', 250, NULL),
(246, 'Dziesiąta', 882, 'pl. Lisia', 355, NULL),
(247, 'Szerokie', 975, 'pl. Jeziorna', 139, 37),
(248, 'Felin', 731, 'ul. Mokra', 126, NULL),
(249, 'Bronowice', 441, 'ul. Orzeszkowej', 689, 23),
(250, 'Wrotków', 523, 'al. Skargi', 318, 64),
(251, 'Czuby Północne', 294, 'pl. Podmiejska', 192, 90),
(252, 'Czuby Północne', 093, 'pl. Osiedlowa', 364, NULL),
(253, 'Wieniawa', 097, 'ul. Piekarska', 155, 76),
(254, 'Sławinek', 206, 'ul. Baczynskiego', 732, 9),
(255, 'Wieniawa', 920, 'pl. Niepodległości', 269, NULL),
(256, 'Czechów Północny', 123, 'ul. Dąbrowskiego', 566, 16),
(257, 'Kośminek', 735, 'al. Krokusowa', 148, NULL),
(258, 'Wieniawa', 159, 'pl. Armii Krajowej', 181, NULL),
(259, 'Ponikwoda', 983, 'al. Bolesława Chrobrego', 634, 55),
(260, 'Wieniawa', 210, 'pl. Chmielna', 782, 82),
(261, 'Czuby Południowe', 247, 'al. Bolesława Krzywoustego', 328, NULL),
(262, 'Rury', 671, 'pl. Broniewskiego', 752, NULL),
(263, 'Rury', 406, 'al. Żeromskiego', 550, NULL),
(264, 'Kalinowszczyzna', 176, 'pl. Powstańców', 778, 20),
(265, 'Felin', 977, 'al. Cicha', 362, NULL),
(266, 'Wieniawa', 762, 'ul. Grunwaldzka', 0, 88),
(267, 'Stare Miasto', 387, 'al. Zaułek', 460, 38),
(268, 'Za Cukrownią', 554, 'pl. Rumiankowa', 436, 94),
(269, 'Abramowice', 054, 'al. Maja', 861, 1),
(270, 'Sławinek', 766, 'ul. Waryńskiego', 786, 54),
(271, 'Wieniawa', 291, 'al. Żwirowa', 537, NULL),
(272, 'Czuby Południowe', 998, 'pl. Kasprowicza', 667, 84),
(273, 'Czuby Północne', 822, 'al. Rynek', 631, NULL),
(274, 'Węglin Południowy', 029, 'pl. Lipowa', 677, NULL),
(275, 'Czuby Południowe', 873, 'pl. Wiosenna', 973, NULL),
(276, 'Sławin', 028, 'al. Łączna', 416, 63),
(277, 'Czuby Północne', 488, 'ul. Gałczynskiego', 159, 57),
(278, 'Dziesiąta', 898, 'al. Wrocławska', 527, NULL),
(279, 'Sławinek', 061, 'ul. Szmaragdowa', 294, NULL),
(280, 'Konstantynów', 764, 'ul. Wróblewskiego', 981, 62),
(281, 'Czuby Północne', 893, 'pl. Rubinowa', 64, 45),
(282, 'Hajdów-Zadębie', 983, 'ul. Myśliwska', 20, 96),
(283, 'Rury', 019, 'pl. Lwowska', 844, 45),
(284, 'Sławinek', 378, 'pl. Dąbrowskiego', 929, NULL),
(285, 'Czechów Północny', 603, 'al. Szpitalna', 519, NULL),
(286, 'Szerokie', 355, 'pl. Krucza', 845, 98),
(287, 'Dziesiąta', 355, 'al. Kowalska', 817, 29),
(288, 'Dziesiąta', 159, 'ul. Jabłoniowa', 753, 75),
(289, 'Felin', 473, 'al. Srebrna', 698, 73),
(290, 'Dziesiąta', 404, 'ul. Przemysłowa', 998, 89),
(291, 'Felin', 301, 'ul. Północna', 345, NULL),
(292, 'Ponikwoda', 021, 'al. Krótka', 238, 83),
(293, 'Węglin Północny', 368, 'al. Miła', 761, NULL),
(294, 'Bronowice', 936, 'pl. Lazurowa', 361, 89),
(295, 'Wrotków', 276, 'pl. Majowa', 810, 7),
(296, 'Abramowice', 799, 'pl. Konstytucji 3 Maja', 694, 60),
(297, 'Kośminek', 957, 'al. Żwirowa', 210, NULL),
(298, 'Bronowice', 498, 'al. Lawendowa', 874, 74),
(299, 'Rury', 138, 'pl. Jasna', 194, NULL),
(300, 'Węglin Północny', 936, 'al. Kraszewskiego', 288, NULL);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `dane_uzytkownika`
--

CREATE TABLE `dane_uzytkownika` (
  `id` int(10) UNSIGNED NOT NULL,
  `imie` varchar(64) NOT NULL,
  `nazwisko` varchar(64) NOT NULL,
  `numer_telefonu` varchar(16) DEFAULT NULL,
  `data_urodzenia` date NOT NULL,
  `data_smierci` date DEFAULT NULL,
  `adres_id` int(10) UNSIGNED DEFAULT NULL,
  `uzytkownik_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `dane_uzytkownika`
--

INSERT INTO `dane_uzytkownika` (`id`, `imie`, `nazwisko`, `numer_telefonu`, `data_urodzenia`, `data_smierci`, `adres_id`, `uzytkownik_id`) VALUES
(1, 'Mikołaj', 'Wosiak', '601 989 318', '1916-06-21', NULL, 1, 2),
(2, 'Adam', 'Wiatrak', '699 188 451', '1910-05-28', '1973-01-28', 2, 3),
(3, 'Tola', 'Tomzik', '578 682 833', '1917-09-02', '1931-12-27', 3, 4),
(4, 'Stanisław', 'Wielądek', '513 928 731', '1983-01-10', '1988-04-22', 4, 5),
(5, 'Ignacy', 'Zacharek', '+48 510 468 905', '1980-09-03', NULL, 5, 6),
(6, 'Józef', 'Osipiuk', '+48 574 291 570', '1951-12-23', NULL, 6, 7),
(7, 'Jerzy', 'Brząkała', '+48 32 349 03 70', '1958-11-08', '1993-08-05', 7, 8),
(8, 'Kacper', 'Kluczek', '537 173 586', '1945-10-01', '2016-12-08', 8, 9),
(9, 'Nela', 'Kloska', '603 259 371', '1936-02-23', '1970-01-22', 9, 10),
(10, 'Daniel', 'Małyszek', '666 554 818', '1910-01-03', NULL, 10, 11),
(11, 'Tomasz', 'Oczkowicz', '783 746 387', '1905-11-28', NULL, 11, 12),
(12, 'Aleksander', 'Kubów', '576 403 008', '1934-02-27', NULL, 12, 13),
(13, 'Daniel', 'Czochara', '+48 787 225 630', '1916-08-19', '2014-11-01', 13, 14),
(14, 'Cyprian', 'Wszoła', '+48 665 141 583', '1927-01-14', '1995-06-15', 14, 15),
(15, 'Nikodem', 'Szczechowicz', '661 769 448', '1963-06-04', '2005-01-17', 15, 16),
(16, 'Leon', 'Moździerz', '+48 604 754 599', '1931-05-25', '2021-08-13', 16, 17),
(17, 'Tomasz', 'Mrozowicz', '+48 691 428 781', '1958-05-12', '2023-08-25', 17, 18),
(18, 'Bianka', 'Flasza', '726 373 011', '1916-08-07', NULL, 18, 19),
(19, 'Przemysław', 'Moneta', '+48 789 511 050', '1972-04-22', NULL, 19, 20),
(20, 'Maksymilian', 'Janowiak', '725 980 647', '1914-12-04', '2009-09-05', 20, 21),
(21, 'Ryszard', 'Sorbian', '+48 511 078 283', '1931-04-01', '2019-06-08', 21, 22),
(22, 'Ida', 'Kubisz', '798 163 280', '1968-11-05', '1978-07-30', 22, 23),
(23, 'Wiktor', 'Gosik', '883 955 759', '1905-01-22', NULL, 23, 24),
(24, 'Rafał', 'Miętus', '662 384 196', '1973-02-07', '1979-01-22', 24, 25),
(25, 'Tomasz', 'Makaruk', '+48 692 237 664', '1957-03-04', NULL, 25, 26),
(26, 'Leon', 'Potyrała', '+48 22 865 15 80', '1965-01-28', '1999-11-18', 26, 27),
(27, 'Jan', 'Lamch', '32 251 53 23', '1956-10-05', NULL, 27, 28),
(28, 'Olga', 'Ryszkiewicz', '22 655 65 56', '1961-05-14', '2002-05-10', 28, 29),
(29, 'Karina', 'Glonek', '+48 535 159 018', '1973-04-15', NULL, 29, 30),
(30, 'Anita', 'Szarejko', '+48 798 744 327', '1927-12-18', '2014-04-11', 30, 31),
(31, 'Eryk', 'Kościukiewicz', '32 017 50 19', '1982-12-05', NULL, 31, 32),
(32, 'Bartek', 'Sito', '790 288 729', '1952-02-06', NULL, 32, 33),
(33, 'Józef', 'Kolarz', '+48 508 761 898', '1905-02-05', NULL, 33, 34),
(34, 'Nataniel', 'Wypiór', '784 094 967', '1950-03-05', '2013-06-26', 34, 35),
(35, 'Aniela', 'Witoń', '+48 889 287 321', '1973-11-26', '1982-05-15', 35, 36),
(36, 'Adrian', 'Orpel', '+48 694 501 261', '1971-01-13', '1981-01-29', 36, 37),
(37, 'Krystian', 'Kwoka', '606 375 379', '1924-03-01', '1949-05-05', 37, 38),
(38, 'Radosław', 'Letkiewicz', '786 889 427', '1956-10-26', '1986-01-27', 38, 39),
(39, 'Michał', 'Solarek', '530 180 903', '1979-02-01', NULL, 39, 40),
(40, 'Rozalia', 'Kurnik', '509 696 299', '1928-05-31', NULL, 40, 41),
(41, 'Norbert', 'Podgórny', '+48 579 085 812', '1981-01-17', NULL, 41, 42),
(42, 'Natan', 'Witas', '+48 22 969 83 70', '1976-01-15', NULL, 42, 43),
(43, 'Piotr', 'Pokrzywa', '22 936 98 26', '1959-04-17', NULL, 43, 44),
(44, 'Leon', 'Bartela', '+48 513 189 107', '1938-08-06', NULL, 44, 45),
(45, 'Melania', 'Ciak', '32 531 99 48', '1916-02-26', '1996-12-01', 45, 46),
(46, 'Klara', 'Jargiło', '+48 530 523 462', '1963-07-14', NULL, 46, 47),
(47, 'Cezary', 'Półchłopek', '506 008 565', '1937-10-16', NULL, 47, 48),
(48, 'Tadeusz', 'Żołądź', '604 079 181', '1907-06-22', '1935-04-07', 48, 49),
(49, 'Dariusz', 'Maciejko', '739 941 460', '1925-01-31', '2019-08-19', 49, 50),
(50, 'Szymon', 'Drobik', '789 522 843', '1946-05-13', '1998-05-30', 50, 51),
(51, 'Paweł', 'Szczepaniuk', '609 946 225', '1946-11-10', '2022-11-16', 51, 52),
(52, 'Aleksander', 'Glaza', '881 288 770', '1965-09-23', '2022-09-08', 52, 53),
(53, 'Nicole', 'Drozda', '883 544 372', '1915-10-24', '1971-03-06', 53, 54),
(54, 'Oskar', 'Lula', '+48 721 578 477', '1939-09-22', NULL, 54, 55),
(55, 'Artur', 'Michniak', '579 983 680', '1920-06-12', '1942-07-20', 55, 56),
(56, 'Dawid', 'Romaniak', '799 108 855', '1907-10-06', NULL, 56, 57),
(57, 'Franciszek', 'Durma', '600 377 973', '1967-03-17', NULL, 57, 58),
(58, 'Witold', 'Forma', '730 342 436', '1923-02-19', NULL, 58, 59),
(59, 'Łukasz', 'Siwka', '+48 722 877 573', '1949-08-12', '1989-10-26', 59, 60),
(60, 'Artur', 'Drela', '+48 511 704 775', '1942-05-04', '1951-04-19', 60, 61),
(61, 'Kacper', 'Sztuczka', '887 954 405', '1970-02-17', '2025-12-28', 61, 62),
(62, 'Jerzy', 'Smorąg', '+48 724 251 849', '1938-02-07', NULL, 62, 63),
(63, 'Filip', 'Dzidek', '535 362 747', '1943-08-28', NULL, 63, 64),
(64, 'Janina', 'Stojak', '+48 734 691 874', '1972-02-28', NULL, 64, 65),
(65, 'Sebastian', 'Piaseczna', '727 567 320', '1929-07-31', NULL, 65, 66),
(66, 'Jerzy', 'Pacura', '+48 883 879 646', '1906-03-01', '1992-08-13', 66, 67),
(67, 'Błażej', 'Marosz', '+48 696 842 297', '1919-10-18', NULL, 67, 68),
(68, 'Apolonia', 'Zadworny', '+48 606 977 086', '1923-08-14', NULL, 68, 69),
(69, 'Nela', 'Kacperek', '+48 668 281 051', '1925-07-26', NULL, 69, 70),
(70, 'Kacper', 'Rubin', '576 202 761', '1932-03-01', NULL, 70, 71),
(71, 'Maksymilian', 'Furga', '+48 600 242 391', '1909-08-03', '1986-11-25', 71, 72),
(72, 'Borys', 'Szabla', '+48 887 239 696', '1951-07-11', NULL, 72, 73),
(73, 'Hubert', 'Plich', '+48 507 376 568', '1956-09-15', '1983-01-09', 73, 74),
(74, 'Adam', 'Delikat', '+48 736 412 074', '1985-07-10', '2017-01-24', 74, 75),
(75, 'Maciej', 'Towarek', '+48 888 242 811', '1909-11-22', '1937-09-28', 75, 76),
(76, 'Oliwier', 'Szajner', '737 021 045', '1941-12-08', NULL, 76, 77),
(77, 'Konrad', 'Polaszek', '+48 536 238 915', '1911-06-17', '1991-11-04', 77, 78),
(78, 'Elżbieta', 'Wojtczuk', '+48 796 879 918', '1976-04-08', '2003-08-11', 78, 79),
(79, 'Michał', 'Sierpień', '604 262 660', '1955-10-18', '2008-12-24', 79, 80),
(80, 'Radosław', 'Żołądź', '+48 32 155 77 92', '1926-02-27', NULL, 80, 81),
(81, 'Aurelia', 'Kazek', '578 865 151', '1981-04-27', NULL, 81, 82),
(82, 'Leon', 'Andrejczuk', '576 316 183', '1982-04-20', '2021-08-13', 82, 83),
(83, 'Stanisław', 'Uroda', '+48 571 356 143', '1975-06-28', '1981-07-02', 83, 84),
(84, 'Łukasz', 'Sobisz', '+48 530 356 921', '1948-06-07', NULL, 84, 85),
(85, 'Kacper', 'Warczak', '+48 796 955 444', '1952-11-23', '1990-12-29', 85, 86),
(86, 'Aleksander', 'Brygoła', '788 182 336', '1908-05-16', '1996-07-29', 86, 87),
(87, 'Maks', 'Zera', '504 780 410', '1952-02-24', '1959-10-29', 87, 88),
(88, 'Hubert', 'Wawszczak', '+48 736 947 903', '1943-12-06', '2014-04-02', 88, 89),
(89, 'Jan', 'Biesek', '22 650 14 59', '1985-02-07', NULL, 89, 90),
(90, 'Alex', 'Szalast', '885 659 383', '1942-05-08', NULL, 90, 91),
(91, 'Krystian', 'Szott', '578 294 012', '1947-12-01', NULL, 91, 92),
(92, 'Łukasz', 'Wojtunik', '788 010 235', '1948-10-04', NULL, 92, 93),
(93, 'Szymon', 'Bubel', '576 545 387', '1951-10-24', NULL, 93, 94),
(94, 'Ignacy', 'Gołofit', '738 923 440', '1916-08-29', NULL, 94, 95),
(95, 'Błażej', 'Weremczuk', '+48 665 038 925', '1915-12-22', NULL, 95, 96),
(96, 'Ewa', 'Baka', '+48 32 984 63 06', '1911-09-16', NULL, 96, 97),
(97, 'Gabriel', 'Zach', '608 334 213', '1970-03-10', NULL, 97, 98),
(98, 'Adam', 'Krauz', '+48 514 461 864', '1941-03-20', '1987-05-05', 98, 99),
(99, 'Sebastian', 'Kurc', '572 843 202', '1960-01-13', NULL, 99, 100),
(100, 'Aleksander', 'Jacak', '796 525 857', '1963-03-21', '1999-06-27', 100, 101),
(101, 'Przemysław', 'Duc', '885 320 782', '1942-11-21', '2007-05-21', 101, 102),
(102, 'Sandra', 'Obiała', '22 763 85 44', '1910-03-25', '2020-08-29', 102, 103),
(103, 'Roksana', 'Bodziony', '791 162 341', '1921-08-25', '2008-01-26', 103, 104),
(104, 'Ewelina', 'Ułanowicz', '+48 510 598 867', '1920-06-02', '2023-05-08', 104, 105),
(105, 'Oskar', 'Roszkiewicz', '578 228 365', '1940-07-21', '1986-06-03', 105, 106),
(106, 'Cyprian', 'Janic', '+48 693 255 807', '1931-02-28', NULL, 106, 107),
(107, 'Błażej', 'Łusiak', '605 475 835', '1945-09-07', '2013-12-31', 107, 108),
(108, 'Sonia', 'Małocha', '+48 729 208 467', '1947-11-14', '2011-03-13', 108, 109),
(109, 'Tomasz', 'Gierasimiuk', '720 932 932', '1958-09-27', '2003-10-12', 109, 110),
(110, 'Sebastian', 'Chylak', '+48 733 740 008', '1967-07-13', '2020-08-10', 110, 111),
(111, 'Mikołaj', 'Lizoń', '32 931 47 69', '1934-11-08', NULL, 111, 112),
(112, 'Konrad', 'Legutko', '32 473 12 72', '1964-07-07', '1967-06-08', 112, 113),
(113, 'Aurelia', 'Krzyszczak', '661 578 134', '1952-03-20', '1982-07-27', 113, 114),
(114, 'Kalina', 'Piechna', '22 697 01 43', '1947-04-18', '1992-08-22', 114, 115),
(115, 'Marcel', 'Broszkiewicz', '669 640 844', '1926-01-25', '1978-11-17', 115, 116),
(116, 'Olga', 'Porzucek', '+48 667 735 621', '1961-06-11', '1981-05-16', 116, 117),
(117, 'Alex', 'Świerszcz', '724 559 654', '1980-02-29', '2014-12-27', 117, 118),
(118, 'Jakub', 'Szczepaniec', '+48 574 050 813', '1907-11-20', '1942-06-14', 118, 119),
(119, 'Piotr', 'Gęgotek', '+48 604 491 016', '1935-03-23', '1961-06-17', 119, 120),
(120, 'Emil', 'Rajchel', '+48 787 917 027', '1966-01-25', NULL, 120, 121),
(121, 'Tomasz', 'Milka', '+48 32 503 06 72', '1947-09-30', NULL, 121, 122),
(122, 'Jędrzej', 'Sośniak', '508 810 287', '1937-12-10', NULL, 122, 123),
(123, 'Malwina', 'Jerzyk', '+48 799 627 147', '1940-08-24', '1997-05-02', 123, 124),
(124, 'Anita', 'Franków', '+48 788 324 809', '1943-05-25', '2007-05-12', 124, 125),
(125, 'Tomasz', 'Olesiejuk', '+48 603 411 781', '1931-05-05', NULL, 125, 126),
(126, 'Maksymilian', 'Niedbał', '32 052 71 12', '1927-02-08', NULL, 126, 127),
(127, 'Kacper', 'Dylak', '888 760 851', '1943-01-02', NULL, 127, 128),
(128, 'Radosław', 'Martyn', '+48 32 195 22 97', '1911-12-22', NULL, 128, 129),
(129, 'Cezary', 'Ogłaza', '+48 606 060 829', '1927-05-01', NULL, 129, 130),
(130, 'Miłosz', 'Oleksa', '600 901 208', '1984-07-24', NULL, 130, 131),
(131, 'Ernest', 'Leśko', '785 043 194', '1920-04-28', '1932-03-05', 131, 132),
(132, 'Alex', 'Szałata', '+48 32 644 70 30', '1940-08-25', '1945-05-21', 132, 133),
(133, 'Olgierd', 'Szymula', '728 916 802', '1973-02-21', '2008-06-15', 133, 134),
(134, 'Łukasz', 'Klekot', '+48 576 360 227', '1935-06-29', '1943-06-20', 134, 135),
(135, 'Gabriel', 'Łyś', '22 244 75 06', '1922-05-31', '1968-12-12', 135, 136),
(136, 'Mariusz', 'Długajczyk', '782 608 088', '1938-12-30', '1942-01-05', 136, 137),
(137, 'Alex', 'Witka', '514 689 233', '1957-09-19', NULL, 137, 138),
(138, 'Borys', 'Jonak', '727 918 334', '1979-06-29', NULL, 138, 139),
(139, 'Leonard', 'Zagrodnik', '+48 884 581 566', '1980-03-07', '2006-07-10', 139, 140),
(140, 'Urszula', 'Młyńczyk', '+48 575 293 302', '1945-08-03', NULL, 140, 141),
(141, 'Cezary', 'Protasiuk', '791 749 418', '1958-08-06', '1985-10-26', 141, 142),
(142, 'Adam', 'Guściora', '+48 505 895 557', '1936-08-12', '2011-08-09', 142, 143),
(143, 'Olaf', 'Niechciał', '+48 723 959 456', '1919-04-30', NULL, 143, 144),
(144, 'Przemysław', 'Bąbel', '666 919 032', '1977-06-26', NULL, 144, 145),
(145, 'Maksymilian', 'Malara', '+48 604 205 999', '1956-06-01', NULL, 145, 146),
(146, 'Anita', 'Miecznik', '+48 880 206 461', '1939-06-27', '2009-05-05', 146, 147),
(147, 'Filip', 'Jargiło', '534 896 958', '1913-04-08', '2025-03-17', 147, 148),
(148, 'Tomasz', 'Kuk', '579 614 235', '1961-05-08', '1968-11-09', 148, 149),
(149, 'Filip', 'Jamroz', '22 396 74 16', '1961-05-18', '1989-11-11', 149, 150),
(150, 'Gabriel', 'Szkatuła', '+48 693 060 997', '1908-07-01', NULL, 150, 151),
(151, 'Jędrzej', 'Grodek', '734 269 220', '1963-09-01', NULL, 151, 152),
(152, 'Oskar', 'Jakubiuk', '+48 725 678 000', '1939-06-27', '1962-08-05', 152, 153),
(153, 'Mikołaj', 'Osiadacz', '506 653 601', '1927-10-23', '1960-09-30', 153, 154),
(154, 'Kalina', 'Jarczak', '538 458 191', '1963-01-12', NULL, 154, 155),
(155, 'Karol', 'Szajner', '787 708 000', '1916-09-21', NULL, 155, 156),
(156, 'Tymon', 'Uliczka', '+48 518 590 032', '1924-07-12', NULL, 156, 157),
(157, 'Mateusz', 'Naumiuk', '+48 32 077 64 10', '1934-04-13', NULL, 157, 158),
(158, 'Borys', 'Jarmużek', '+48 515 243 863', '1975-02-12', NULL, 158, 159),
(159, 'Klara', 'Gradek', '+48 795 595 096', '1975-07-01', NULL, 159, 160),
(160, 'Julian', 'Uss', '661 555 155', '1971-12-02', '1976-08-04', 160, 161),
(161, 'Ewelina', 'Lisak', '32 058 95 96', '1910-11-13', NULL, 161, 162),
(162, 'Bartek', 'Olszowa', '+48 22 920 39 91', '1960-11-06', NULL, 162, 163),
(163, 'Mieszko', 'Smoter', '607 261 098', '1983-08-23', '2004-07-21', 163, 164),
(164, 'Marek', 'Olszowa', '+48 662 380 916', '1950-09-10', '1983-01-02', 164, 165),
(165, 'Iwo', 'Leszkiewicz', '22 484 74 56', '1985-04-19', '2015-02-02', 165, 166),
(166, 'Damian', 'Stawinoga', '+48 574 290 966', '1922-10-25', '2010-09-07', 166, 167),
(167, 'Stanisław', 'Małys', '+48 889 916 926', '1975-06-02', '1987-10-02', 167, 168),
(168, 'Mikołaj', 'Jamroży', '+48 571 388 814', '1919-12-15', NULL, 168, 169),
(169, 'Konstanty', 'Wiertelak', '22 129 91 41', '1938-08-05', '1982-07-07', 169, 170),
(170, 'Daniel', 'Lewko', '606 928 402', '1915-06-26', '1966-01-02', 170, 171),
(171, 'Dawid', 'Lulek', '+48 531 566 032', '1919-03-09', NULL, 171, 172),
(172, 'Jerzy', 'Pasiak', '22 637 72 45', '1919-01-31', NULL, 172, 173),
(173, 'Dawid', 'Capała', '+48 795 659 827', '1946-11-17', NULL, 173, 174),
(174, 'Kazimierz', 'Słupek', '+48 604 758 104', '1971-09-17', NULL, 174, 175),
(175, 'Ernest', 'Proć', '786 127 114', '1963-12-21', '2010-10-23', 175, 176),
(176, 'Olga', 'Koleśnik', '535 543 041', '1970-02-27', NULL, 176, 177),
(177, 'Agnieszka', 'Kamyk', '539 115 971', '1966-06-11', NULL, 177, 178),
(178, 'Jakub', 'Żołądkiewicz', '+48 22 971 67 52', '1925-08-25', '1997-06-07', 178, 179),
(179, 'Dariusz', 'Szulim', '+48 723 189 493', '1906-12-29', '2011-07-31', 179, 180),
(180, 'Miłosz', 'Jarmuż', '739 687 514', '1977-08-29', NULL, 180, 181),
(181, 'Julian', 'Słoka', '+48 668 840 928', '1926-08-25', NULL, 181, 182),
(182, 'Maciej', 'Fit', '+48 32 278 20 80', '1930-03-03', NULL, 182, 183),
(183, 'Ida', 'Matacz', '+48 667 001 615', '1984-04-14', NULL, 183, 184),
(184, 'Tymon', 'Jarmuła', '+48 884 117 834', '1910-04-23', '2024-05-02', 184, 185),
(185, 'Daniel', 'Woszczyna', '+48 697 438 654', '1960-08-29', '2000-10-28', 185, 186),
(186, 'Franciszek', 'Grab', '+48 794 363 884', '1914-06-24', NULL, 186, 187),
(187, 'Nikodem', 'Wysota', '+48 696 506 710', '1944-07-28', '1997-02-05', 187, 188),
(188, 'Ignacy', 'Praczyk', '662 872 251', '1912-06-14', NULL, 188, 189),
(189, 'Melania', 'Chaberek', '794 553 437', '1917-03-12', '1962-05-24', 189, 190),
(190, 'Konrad', 'Dywan', '663 023 296', '1973-11-25', '1996-02-11', 190, 191),
(191, 'Marek', 'Ciaś', '729 243 937', '1914-06-30', '1968-06-20', 191, 192),
(192, 'Tadeusz', 'Młotek', '+48 509 853 759', '1958-11-11', '2010-02-01', 192, 193),
(193, 'Patryk', 'Knysak', '+48 780 810 415', '1956-01-15', NULL, 193, 194),
(194, 'Artur', 'Bembenek', '+48 604 463 178', '1977-05-24', NULL, 194, 195),
(195, 'Krzysztof', 'Hanusiak', '+48 792 980 672', '1914-03-24', '1939-12-08', 195, 196),
(196, 'Ernest', 'Stebel', '790 807 816', '1935-03-15', NULL, 196, 197),
(197, 'Józef', 'Wojtarowicz', '+48 519 161 508', '1956-03-22', NULL, 197, 198),
(198, 'Mateusz', 'Widuch', '600 404 762', '1922-02-16', '1987-06-11', 198, 199),
(199, 'Szymon', 'Hermanowicz', '887 793 227', '1921-01-19', '2008-03-26', 199, 200),
(200, 'Stefan', 'Dorawa', '32 488 06 07', '1944-03-10', NULL, 200, 201),
(201, 'Natasza', 'Szwiec', '+48 727 751 184', '1972-02-28', '2022-09-26', 201, 202),
(202, 'Ryszard', 'Pitek', '571 156 738', '1932-12-12', '2014-03-07', 202, 203),
(203, 'Adrianna', 'Niewiara', '606 714 362', '1905-09-27', '1986-12-15', 203, 204),
(204, 'Daniel', 'Kuświk', '789 946 132', '1943-12-28', '1944-05-07', 204, 205),
(205, 'Justyna', 'Cyman', '+48 504 281 723', '1958-03-19', '1963-06-06', 205, 206),
(206, 'Fabian', 'Powałka', '+48 735 783 328', '1983-11-18', NULL, 206, 207),
(207, 'Maciej', 'Bazyluk', '695 126 663', '1975-08-03', '2021-10-10', 207, 208),
(208, 'Jeremi', 'Cherek', '+48 733 790 043', '1909-12-30', NULL, 208, 209),
(209, 'Eryk', 'Kuśmider', '+48 518 381 222', '1961-12-02', NULL, 209, 210),
(210, 'Ryszard', 'Ludwin', '+48 694 529 687', '1956-06-01', NULL, 210, 211),
(211, 'Nataniel', 'Gniewek', '+48 696 948 436', '1910-09-19', '1941-03-29', 211, 212),
(212, 'Ryszard', 'Kacperczyk', '+48 669 031 051', '1911-08-26', '1977-04-08', 212, 213),
(213, 'Kornel', 'Pachowicz', '728 658 328', '1983-08-04', NULL, 213, 214),
(214, 'Sylwia', 'Wołoszczuk', '32 765 46 07', '1944-12-30', NULL, 214, 215),
(215, 'Andrzej', 'Dudzicz', '+48 730 572 460', '1949-09-06', NULL, 215, 216),
(216, 'Gustaw', 'Rzeźniczek', '577 499 158', '1971-01-30', NULL, 216, 217),
(217, 'Mateusz', 'Czuj', '796 863 150', '1952-06-16', NULL, 217, 218),
(218, 'Filip', 'Korzekwa', '532 103 812', '1919-05-31', NULL, 218, 219),
(219, 'Leon', 'Drobny', '+48 696 623 380', '1958-01-01', '1989-12-11', 219, 220),
(220, 'Rozalia', 'Sobisz', '22 328 38 59', '1927-05-30', '1936-04-22', 220, 221),
(221, 'Maks', 'Mosiołek', '888 412 640', '1941-01-21', NULL, 221, 222),
(222, 'Tobiasz', 'Michniak', '32 070 50 63', '1966-05-02', '1980-11-10', 222, 223),
(223, 'Karol', 'Liedtke', '22 325 99 67', '1930-11-21', '1949-10-20', 223, 224),
(224, 'Szymon', 'Kościk', '+48 609 801 050', '1985-12-17', '1995-03-29', 224, 225),
(225, 'Grzegorz', 'Rysz', '+48 780 767 016', '1974-12-06', '2024-02-03', 225, 226),
(226, 'Robert', 'Słoboda', '535 146 605', '1907-02-06', NULL, 226, 227),
(227, 'Fryderyk', 'Cherek', '784 122 129', '1951-09-14', '2024-08-29', 227, 228),
(228, 'Artur', 'Uliasz', '+48 503 961 630', '1954-08-09', NULL, 228, 229),
(229, 'Tymoteusz', 'Krzyszczak', '693 446 781', '1985-06-14', NULL, 229, 230),
(230, 'Fabian', 'Waluk', '500 248 986', '1931-09-19', NULL, 230, 231),
(231, 'Krzysztof', 'Janduła', '504 610 682', '1925-01-12', '1945-03-12', 231, 232),
(232, 'Olgierd', 'Pyszny', '+48 516 188 864', '1954-04-17', '1973-09-19', 232, 233),
(233, 'Mieszko', 'Drobny', '511 552 275', '1949-03-22', '2005-02-12', 233, 234),
(234, 'Igor', 'Czopik', '+48 22 611 94 58', '1978-05-21', NULL, 234, 235),
(235, 'Paweł', 'Staniewicz', '666 790 441', '1932-11-11', NULL, 235, 236),
(236, 'Miłosz', 'Drewniok', '885 081 450', '1962-09-15', '1991-10-06', 236, 237),
(237, 'Antoni', 'Kozdra', '691 623 252', '1963-04-27', NULL, 237, 238),
(238, 'Oliwier', 'Misiurek', '577 401 148', '1942-06-26', '2016-05-18', 238, 239),
(239, 'Eryk', 'Janczarek', '+48 514 024 312', '1943-09-23', '1984-04-09', 239, 240),
(240, 'Mateusz', 'Kurc', '+48 696 340 077', '1921-01-23', '2003-12-22', 240, 241),
(241, 'Paweł', 'Misiurek', '32 894 12 10', '1948-04-08', '1968-09-10', 241, 242),
(242, 'Róża', 'Ciaś', '798 787 923', '1980-05-05', '1994-06-03', 242, 243),
(243, 'Natasza', 'Słupek', '535 272 669', '1924-11-10', NULL, 243, 244),
(244, 'Tymon', 'Pietraś', '22 654 72 54', '1944-06-16', '1968-10-15', 244, 245),
(245, 'Emil', 'Lula', '667 205 653', '1942-10-19', NULL, 245, 246),
(246, 'Kaja', 'Dyda', '+48 574 766 006', '1906-08-29', '1913-12-03', 246, 247),
(247, 'Jakub', 'Rut', '+48 509 151 882', '1917-10-26', NULL, 247, 248),
(248, 'Tobiasz', 'Pikula', '22 188 70 09', '1926-06-10', NULL, 248, 249),
(249, 'Agnieszka', 'Krekora', '796 715 357', '1953-08-07', '1963-09-22', 249, 250),
(250, 'Antoni', 'Duc', '571 991 890', '1948-04-09', NULL, 250, 251),
(251, 'Jerzy', 'Siejak', '881 642 576', '1906-09-18', NULL, 251, 252),
(252, 'Maurycy', 'Lorenz', '32 895 32 51', '1950-10-13', '1957-09-04', 252, 253),
(253, 'Cyprian', 'Droździel', '+48 730 081 928', '1911-03-13', '1990-03-12', 253, 254),
(254, 'Ernest', 'Pogorzelec', '+48 32 652 82 79', '1933-10-09', NULL, 254, 255),
(255, 'Apolonia', 'Grunt', '+48 539 560 790', '1919-09-14', NULL, 255, 256),
(256, 'Stefan', 'Zimmer', '+48 733 374 183', '1953-02-06', '1964-05-25', 256, 257),
(257, 'Jędrzej', 'Szałkiewicz', '537 809 386', '1970-08-07', '1987-04-03', 257, 258),
(258, 'Ksawery', 'Smutek', '694 196 670', '1984-04-12', '2014-06-15', 258, 259),
(259, 'Maurycy', 'Kuster', '+48 32 661 17 65', '1964-03-28', NULL, 259, 260),
(260, 'Stanisław', 'Wyderka', '781 242 273', '1905-06-30', NULL, 260, 261),
(261, 'Artur', 'Dyszkiewicz', '880 194 463', '1962-07-11', '1992-01-25', 261, 262),
(262, 'Jędrzej', 'Jędryczka', '+48 880 377 212', '1930-09-03', '1934-06-26', 262, 263),
(263, 'Stanisław', 'Kość', '731 207 376', '1982-05-25', '1985-10-14', 263, 264),
(264, 'Marika', 'Dąbal', '+48 735 062 529', '1921-01-24', NULL, 264, 265),
(265, 'Eryk', 'Lejman', '+48 663 106 436', '1983-03-04', NULL, 265, 266),
(266, 'Adam', 'Sajda', '737 903 394', '1952-12-21', NULL, 266, 267),
(267, 'Fryderyk', 'Roda', '+48 574 041 163', '1906-03-22', '1940-07-18', 267, 268),
(268, 'Nicole', 'Muskała', '+48 664 062 501', '1909-09-19', '1989-02-08', 268, 269),
(269, 'Tymoteusz', 'Działak', '22 844 34 25', '1975-11-05', NULL, 269, 270),
(270, 'Wojciech', 'Durma', '+48 536 110 721', '1984-08-30', '2009-05-21', 270, 271),
(271, 'Liwia', 'Duc', '+48 790 281 877', '1918-01-25', '2002-05-07', 271, 272),
(272, 'Rafał', 'Zajko', '691 572 688', '1966-07-09', '2012-08-12', 272, 273),
(273, 'Iwo', 'Feliksiak', '793 046 393', '1925-09-01', NULL, 273, 274),
(274, 'Gabriel', 'Szyma', '796 560 901', '1943-02-14', NULL, 274, 275),
(275, 'Hubert', 'Poczta', '32 462 92 34', '1974-10-11', NULL, 275, 276),
(276, 'Rozalia', 'Kobel', '+48 664 085 855', '1976-11-03', NULL, 276, 277),
(277, 'Jerzy', 'Maćczak', '22 926 05 39', '1938-09-29', '2025-06-28', 277, 278),
(278, 'Fabian', 'Oziębło', '+48 694 169 192', '1950-04-23', '1953-07-31', 278, 279),
(279, 'Witold', 'Kranc', '790 298 179', '1977-05-06', '2002-07-18', 279, 280),
(280, 'Tymoteusz', 'Nickel', '+48 789 207 827', '1947-01-12', NULL, 280, 281),
(281, 'Marcel', 'Anioła', '607 341 268', '1915-07-25', '2003-03-30', 281, 282),
(282, 'Natasza', 'Krzysztofek', '+48 739 079 936', '1980-12-18', '1991-11-26', 282, 283),
(283, 'Urszula', 'Wudarczyk', '+48 787 266 282', '1956-05-19', '1979-11-25', 283, 284),
(284, 'Aleks', 'Golisz', '+48 536 046 739', '1970-01-24', '1996-05-21', 284, 285),
(285, 'Iwo', 'Chalimoniuk', '+48 515 915 380', '1907-10-04', NULL, 285, 286),
(286, 'Emil', 'Świętoń', '728 810 518', '1957-04-29', NULL, 286, 287),
(287, 'Kamila', 'Kolka', '723 581 264', '1964-02-21', '2016-02-18', 287, 288),
(288, 'Maks', 'Wiese', '32 222 20 08', '1933-07-10', '1939-07-03', 288, 289),
(289, 'Tymoteusz', 'Gromala', '+48 720 306 322', '1905-10-02', '1982-09-21', 289, 290),
(290, 'Jan', 'Tlałka', '503 223 414', '1953-08-05', NULL, 290, 291),
(291, 'Grzegorz', 'Szymaniuk', '22 324 51 05', '1926-07-10', '1955-06-11', 291, 292),
(292, 'Eliza', 'Szpyt', '517 742 941', '1941-05-26', '1954-05-22', 292, 293),
(293, 'Ewelina', 'Tylman', '577 930 481', '1970-07-08', NULL, 293, 294),
(294, 'Natasza', 'Seta', '+48 739 607 035', '1956-05-28', '1989-10-31', 294, 295),
(295, 'Aleks', 'Siebert', '536 075 012', '1925-05-13', '1932-06-17', 295, 296),
(296, 'Bianka', 'Franas', '780 108 140', '1931-01-27', '1980-11-27', 296, 297),
(297, 'Olaf', 'Hornik', '606 655 197', '1941-03-14', NULL, 297, 298),
(298, 'Stanisław', 'Dziewior', '+48 665 744 284', '1950-04-27', NULL, 298, 299),
(299, 'Roksana', 'Witko', '+48 22 785 05 59', '1969-10-14', NULL, 299, 300);

--
-- Wyzwalacze `dane_uzytkownika`
--
DELIMITER $$
CREATE TRIGGER `po_usunieciu_danych_usun_adres` AFTER DELETE ON `dane_uzytkownika` FOR EACH ROW IF OLD.adres_id IS NOT NULL THEN
        IF NOT EXISTS (SELECT 1 FROM dane_uzytkownika WHERE adres_id = OLD.adres_id) THEN
            DELETE FROM adres WHERE id = OLD.adres_id;
        END IF;
    END IF
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `kod_pocztowy`
-- (See below for the actual view)
--
CREATE TABLE `kod_pocztowy` (
`id` int(10) unsigned
,`kod_pocztowy` varchar(6)
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `matuzal`
-- (See below for the actual view)
--
CREATE TABLE `matuzal` (
`id` int(10) unsigned
,`imie_pseudonim_nazwisko` varchar(196)
,`wiek` bigint(21)
);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `modlitwa`
--

CREATE TABLE `modlitwa` (
  `id` smallint(255) UNSIGNED NOT NULL,
  `nazwa` varchar(128) DEFAULT NULL,
  `tresc` varchar(2048) NOT NULL,
  `efekt` varchar(128) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `modlitwa`
--

INSERT INTO `modlitwa` (`id`, `nazwa`, `tresc`, `efekt`) VALUES
(1, 'Do św. Oskara', 'Bóg Azja rząd źródło lista powoli niebo.\nMinuskuła twarz dziadek nagły lub. Chodzić chodzić Ameryka muzyk świeca most jazda.\nSkładnik widoczny pacjent dany wygrać smutny ryba mieszkać.\nŁóżko mały narzędzie studiować. Wspólnota łuk bać się mecz.\nPan nos policzek zgodnie koło. Jabłko naj- jednak drewniany mebel.\nOgień sędzia często zwolennik.\nRzeka specjalista pokonać analiza. Zajmować pojemnik wąż Ukraina.\nKatolicki alfabet włożyć mieszkaniec.\nSprawa błoto osioł razem uznawać. Słowacja opisać popularny gdzieś.\nPlaża przejście składać się egzamin dzięki szybki wchodzić.\nW Końcu strata uciec 3 80 pożar lata. Jak gleba granica godny twój swój lecz.\nUdział telewizja samochód biec ofiara stan oglądać.\nChoć rzadki kawa – szczyt przyjąć ozdoba.\nBo ostry gaz. Rana spać rozpocząć oczekiwać siedzieć zima cel 8.\nTłuszcz zostać przestać zysk spokój srebro. Stacja figura te północ.\nMało republika łatwo kiedyś.\nBądź cisza krew spokój bohater dodatek akcja. Morze Śródziemne moment lot brudny zmęczony.\nKupić róża czterdzieści fabryka władca. Cebula szacunek chłopiec martwy.\nPole dzielnica sylaba 100 urodzenie lampa.', 'Ptak nastrój rada broń.'),
(2, 'Do św. Angeliki', 'Królestwo drużyna użycie łatwy pieniądz para przynieść USA.\nSzkoda azjatycki kupić płyn rozwiązanie. Prawy wypowiedź więcej młody tracić znów prezent.\nWywoływać r.\npogląd pełnić szanowny jednak miara. Średniowieczny linia łódź moralny nie ma klimat wierny.\nPająk każdy przedstawiać nowy związać gra zachowywać się działalność.\nPisanie też własny otrzymywać czas spać stary. Narzędzie pojazd kupić okno drogi.\nSkład powiedzieć żeby lud potem.\nDach praktyka piasek gęś. Narząd droga liczyć Słońce Warszawa.\nPić dokonywać zupełnie korona Słowacja dowód korzyść.\nJabłko dany wielkość. Po Prostu tłumaczyć zdjęcie zapach.\nChrześcijański zjawisko dane zazwyczaj czytać letni kwiecień.\nWoda kupować Słowacja. Wrzesień nie- kochać bar owad średniowieczny.\nPod obywatelka kobieta komórka chiński stado polityczny.\nSzwedzki bok wszyscy analiza wrócić. Klimat 3 strumień wtedy. Szukać sztuka szukać mądry Egipt obecnie.\nLiteratura specjalista napisać trzydzieści ozdobny pieniądze. Przyjmować drewno kraina czyjś 40.\nŁuk ogół okoliczność tajemnica typ gospodarczy.\nStanowić operacja prywatny uczucie umieszczać.', 'Słowo masa Grecja trwały.'),
(3, 'Do św. Adriana', 'Co świadczyć płyn 8 wioska. Próba małpa zwykle głównie.\nKolano jasny kiedy możliwy paliwo właśnie konstrukcja smutek.\nWojenny pióro odbywać się moc cztery skala pojedynczy. Fala delikatny oni zamek zbiornik.\nMasło projekt prasa centrum wierny.\nNasiono zadanie tor angielski. Kura oddawać drobny podział babcia narkotyk.\nRząd Bóg przyszły stać kaczka.\nOgon filmowy pieśń las. Pojęcie Australia dodatkowy ciekawy piętro. Bycie hałas tłuszcz sok mgła nic głównie.\nMalować banknot polski proszę.\nBrzeg ciąża studiować kupić.\nPotrawa oni trzy nad pies warunek jutro. Koniec delikatny 100 inny.\nBułgarski pracownik szlachetny szkoda imię. Spadać płacić stawiać brązowy otoczenie specjalista kierunek piętro.\nSygnał farba scena słuchać.\nLód napój Niemiec.\nRegion robić zdarzenie umowa dziesięć Ameryka źródło zupełnie. Proszę trwały być wojskowy zrozumieć nadawać grecki.\nPlac rysunek bogini każdy postępowanie wnętrze dany.\nSędzia wina las móc żelazo gołąb żaden. Mleko pytanie elektryczny zabawka zwolennik.\nWewnątrz głośny w rozmowa owoc żółty kochać.\nDorosły sól panować w.\nsiedemdziesiąt żyć szkoła umiejętność.', '30.'),
(4, 'Do św. Oskara', 'Jezioro rzadko hałas przeciwko.\nZysk królestwo oni władca. Podłoga policjant wśród modlitwa lato słodki zdjęcie.\nFabryka uważać śniadanie lustro umożliwiać pojęcie. Telewizja jabłko polityk państwo pełen ogromny.\nBycie zdolność rządzić jednostka morze matematyka koniec potrzebny. Telewizyjny mysz medycyna tam ubranie czterdzieści tłumaczyć. Włoski dodatkowy w kształcie państwo kiedyś.\nRosyjski profesor ci zostać droga Francja typ u.\nWpływ 80 pomidor brak tył za arabski.\nMożliwość zdrowy król mało. Cierpieć lekcja jaki rzadki program sygnał. Zawód rodzinny walczyć kolega prawy brać wysiłek odcień.\nInternetowy opisać wizyta nagle plaża.\nPomieszczenie jeździć mówić potrzebny własność. Majątek łączyć kobieta śmiać się więzienie granica syn.\nFrancja ze brązowy szklanka stawać się.\nDokument wspólnota czyn słońce. Substancja czysty lubić ?.\nPlama ostatni warstwa pieśń zaraz.\nZgromadzenie kierowca herb miód. 2 dolina powiedzieć rachunek sześćdziesiąt.\nMożliwość my większy związek podatek zawartość oglądać głowa.\nSłoń wspólnota obywatelka skłonność brat lampa inaczej budzić. Punkt teoria mgła.\nUlegać dla kolorowy służba.\nPismo składać się mapa rysunek funkcja księżyc wewnętrzny.', 'Lub sportowy łyżka biedny.'),
(5, 'Do św. Barteka', 'Siedziba banknot przyjmować czerwony przyjęcie narodowy. Dar niszczyć na zewnątrz.\nWesoły szklanka zmienić nazywać ksiądz jezioro zimno. Terytorium dziwny członek próba szczególnie powinien wszelki.\nBelgia spaść trudno Wielka Brytania pierwiastek chemiczny pomóc płacić.\nTurcja Afganistan przyjemność klucz moralny staw wieś. Zegar posiłek wreszcie ludzie motyl.\nBar wydawać obraz wschodni pustynia studiować tworzyć.\nDlatego rzucić stół polityka drogi.\nWywoływać pokarm szwedzki trochę. Powodować samochodowy zajmować brudny brudny.\nKaczka 0 r.\nw kształcie. Tutaj muzeum zabawa dany wiersz.\nZamiast pisarz przykład wschodni siebie.', 'Punkt korzeń pomóc strata Jezus. Bok pozycja siebie pojemnik. Jedynie temat rezultat.'),
(6, 'Do św. Aurelii', 'Szczyt ryzyko 40 pamiętać państwowy praktyka rodzaj sztuka.\nObwód pomóc kolorowy dodać przypominać zamiar. Reguła po odnosić się jednak zmienić. Zamknąć starać się rząd myśl.\nCel przyjść dyskusja przyjaciel rzucić wykonanie. Figura cierpienie uciec ogon.\nZąb powierzchnia nikt.\nBycie nazywać za obcy szczególnie łączyć parlament. Węgry koszula utrzymywać polityczny profesor zatoka.\nWilk w kształcie odnosić się nikt.\nWidoczny klucz byk. Nadmierny dziki miasto miejscowość okropny wstyd.\nWizyta jeździć hałas. Mapa składać się znowu.\nOsobisty dane wejście. Skończyć biały produkt chemiczny środkowy sędzia broda.\nPrzemysł graniczyć w czasie związek przygotować symbol znowu.\nWydać przeszkoda płacić flaga jednak siedziba. Swój roślina osiemdziesiąt kierunek pióro całkowicie. Górny ubranie roślina trawa wojsko.\nOfiara skrzydło nauczyciel królestwo mocny biedny.\nNiski cisza pierwszy analiza 0. Wewnętrzny 10 tam.\nZakon przemysł mieszkanie tworzyć mózg.', 'Nagle tor zwykły łóżko zgromadzenie. Plecy prędkość złożony wokół punkt.'),
(7, 'Do św. Mateusza', 'Dialekt srebrny słyszeć chłop tani jakość dawny.', '9 móc grać silny praca.'),
(8, 'Do św. Toli', 'Morze Śródziemne pies znaleźć wczesny.\nPłeć połączyć zwrot dialekt poczta.\nCzechy bitwa zwykle Egipt.', 'Większy Hiszpania powód gorączka podróżować 3 koszula wierzyć.'),
(9, 'Do św. Kariny', 'Strona skóra wystawa telefon szczyt.\nJajko rząd 5 tarcza szary.\nPoznać wrogi miód spotkanie. Szkoda dokument jeśli. Ślad kość tamten zdjęcie. Osoba pełnić chyba minuta obok telewizyjny idea.\nAle wszyscy toponim krzyż strona panna siedziba wieczorem.\nFilmowy rysunek fotografia słyszeć ruch. Potrzebny postępować cukier dany wczesny.\nZacząć rząd cesarz dzisiejszy około.\nObowiązek go Kraków rzecz język dziecięcy. Znaczyć oznaczać rzeka możliwość 5.\nZbiornik pływać północny. Wyraz telewizja święty kraina.\nZiemski otaczać wolność ludzki rachunek ser ściana.\nOdcień brzuch trawa wrzesień rodzinny tu. Dziki sportowy wspaniały całkiem.\nCzy burza żołnierz krowa.\nTrawa prąd sędzia obóz. Zamknąć toponim kwestia córka łuk.\nUzyskać stać budzić wyścig wiersz. Między ludność dobry dokładny jedzenie leżeć bądź. Czasem dom użytkownik gość.\nDeska wokół przypadek Hiszpania przemysł choroba.\nOsiągnąć pokonać pojedynczy sprawa jezioro wywodzić się zarówno.\nPrzepis powietrze towar łyżka. Dokonać potrzebować gruby rolnik tracić mapa drzewo.\nGardło daleki tekst rosnąć planeta broń.\nHałas broda bok wytwarzać pięćdziesiąt pustynia badanie wejście. Przebywać mózg wioska świecić silnik oficjalny kobieta.\nWychodzić Warszawa osoba sukces imię żywy zawartość mózg. Bezpośrednio koło zajęcie przy ocean tor angielski zdrowy.\nMądry mięso stworzyć także. Warszawa ósmy restauracja miejski.\nPod parlament wielkość czynić Izrael studia przyjmować.\nPomidor przybyć sposób dziedzina piłka. Zgadzać Się leżeć oddawać samolot twardy.\nBank zdrowy bądź artykuł. Wojskowy październik rządzić wyjście nos składać.\nZnajdować położenie bądź kontynent strój ciężar jezioro.\nCzwartek 70 muzyka drogi przeprowadzać użytkownik samiec majątek. Reguła wstyd sprzedaż usuwać efekt dolina.\nPrzeprowadzać wojskowy Słońce wrócić norma na figura dziki.\nDany pszczoła umrzeć nie- Słońce. Okropny strój złodziej fakt operacja Boże Narodzenie.\nTyp zasada to.\nZawierać stopień choć wada nasiono 0.', 'Nauczycielka tkanina kostka pisać mama wierny.'),
(10, 'Do św. Grzegorza', 'Wolno wola walczyć piętro sos mowa dzień.\nCiemny leżeć ludzki otwór cukier przy Europa.\nZamieszkiwać otoczenie królowa obcy. Zachowanie tradycja brązowy otaczać.', 'Jeśli liczba atomowa straszny wstyd poważny. Dostęp ! powiedzieć użyć wcześnie kłopot temat.'),
(11, 'Do św. Kornelii', 'Ogon tańczyć między jazda lot piosenka.\nJeżeli ciężki instrument biskup działanie.\nZnaleźć on firma właściwy. Narząd południe czysty wróg.\nGardło że przyjaciel.\nKościół wychodzić gniazdo działać chęć.\nDokładnie malować płyn. Usuwać wykonać rejon wydawać się oddawać każdy.\nNiebieski organizm Słowacja tu wieś zaraz suchy.\nLub pozbawić oznaczać. Ono oba wzór układ okresowy dziewięć itp..\nJabłko kosz pytać poza jeść gdzie.\nPrzeznaczyć wschód żart oba srebro często straszny. Jak pojęcie wyrażać szyja ciągle przejście.\nKontrola zimno płakać związek noga pływać turecki.\nPrzypadek wysiłek zadanie Egipt królowa efekt krok. Szef zachód wielkość kość 1.\nTeoria godność uśmiech leżeć koncert wewnętrzny. Azja skała ono niszczyć ogromny tańczyć. Wygląd sprawa chronić zarówno.\nSala położyć oddawać dać się stowarzyszenie.\nGdyby nic las nigdy typ sobą. Długość Dania usuwać jeżeli gleba koncert odcień trudno.\nTeraz jutro materiał herb pół.\nGraniczyć idea dokładnie wola mózg piłka.\nKomputerowy profesor czarny fizyczny brat gospodarka.', 'Rynek rak ciasto jeżeli. Ból kurs tłuszcz odzież moc.'),
(12, 'Do św. Maurycya', 'Miłość przestać pokryć.\nPrzebywać rzymski nieść igła dyskusja środkowy.\nWąski zajmować się 50 rodzic budynek pochodzenie. Turcja odcinek wrażenie ósmy bieg.\nRozpocząć pamięć postawa bawić się.\nToponim zdolność sportowy trzeci epoka poważny. Warunek stan złożony czasem ryzyko bank przyjęcie sklep.\nZiarno słyszeć babcia religia podstawowy przygotować. Zapalenie wyrok grób tekst przechodzić płaszcz.\nFala pokój średniowieczny umieć. Małpa szkoła wziąć umiejętność powolny żołądek koza.\nCiąża pan żółty chory możliwy kość wywołać sylaba. Studia złoty hotel daleki pociąg.\nUtrzymywać wpaść poziom Litwa m.in.\nhasło krowa mi. Jądro wykonywanie zazwyczaj że ból opieka.\nDziewięćdziesiąt we męski.\nSmutek praca wyrok talerz lina zanim trudny. Czekolada treść inny potrzebny dom określać.\nOwad dobrze dzień trzydzieści osiemdziesiąt dziać się ciepło herbata. Istota sprawa należy wytwarzać autobus Bóg mieszkanka.\nOko święty liść Włochy szkodliwy drobny.\nSpotkać miód Pan sprzęt centrum powód niebezpieczeństwo.', 'Ustawa rozwiązanie zacząć obrót. Pytać wybrać dziecko pamięć fałszywy sobota drapieżny.'),
(13, 'Do św. Melanii', 'Miasto hodować film muzyczny piątek.\nW.\ninteres człowiek zrozumieć tworzyć też Austria. Strój prawie zachowanie trzeba pomóc świadczyć.\nWzrost zarówno liść dom student pojazd. Brzeg zatoka wolny mecz bar wyraz.\nPieniądz korona zachowywać się.\nZwycięstwo dzisiejszy pan grzech zajmować się. Zamek określenie wzgórze pieniądze odpowiedź badanie. Pomarańczowy wrzesień łyżka dyrektor królestwo uchodzić. Surowy dobrze metal koszt szkodliwy uczyć.\nPozostać włosy samochód rządzić bogactwo.\nBroda uderzenie poziom wysiłek. Wewnątrz wniosek jedzenie księżyc samica.\nUmożliwiać żeby czwartek szklanka patrzeć. Kupować 5 podawać dopływ.\nOdwaga poznać panować — szczególnie.\nPlemię kierunek świecić zbyt palić wstyd Unia Europejska. Wyspa przynieść zabić mur.\nStarać Się rodzic Stany Zjednoczone na przykład nasz córka dokonać.\nMiędzynarodowy wąż słownik płyta Stany Zjednoczone. Wąski pustynia stosunek prędkość.\nKoszt wojskowy Żyd dwa ważny.\nDrobny ślub wzrost pies policjant ja liczny katolicki.', 'Pierś we.'),
(14, 'Do św. Tadeusza', 'Wieża spodnie lotnisko uczeń herb podróżować mecz przynieść.\nJak granica Warszawa dać. Jednostka daleki czuć ćwiczenie tani ludzie nastrój specjalny.\nStworzyć spaść chemiczny stanowić.\nProstytutka ciężki ojczyzna stacja wysiłek przyrząd. Sobą wybuch syn ludzie wybór wiek.\nCierpieć mebel tydzień składać się nazwa badanie mięso Piotr.\nCmentarz szef sygnał słodki przedsiębiorstwo róża łuk. Sprzęt przygotować urzędnik Szwecja wymagać gazeta mur.\nNiektóry być ziemski pełny gniew sprawa. Dalej intensywny dawać język wschodni oddać koszt.\nGłowa oczekiwać obcy klasztor cel las zawodowy.\nSkala większy królewski pusty dziób 100.\nDym o no umowa szereg. Ona szkoda brat żołnierz kwiat lipiec.\nDlatego komórka miękki położony bieg. Wyścig Litwa przedsiębiorstwo zwolennik ciekawy.\nStół ciemny żołądek rzymski lampa. Szkolny strój czterdzieści śmiech ogólny program niewolnik noc.\nOgród charakter zakończenie poeta maszyna. Zarówno zwłaszcza krótki słoneczny.\nLos bok bogactwo.\nWspólny zawsze ogromny stopień wczesny. Minister bilet biec polityczny kto produkt obserwować drewniany.\nKrok podstawa tyle rodowity. Francja lub koło niezwykły serce róża użycie.\nZłodziej podróż często brać jabłko. Uczyć który rower naród.\nCzasownik pisanie w zdrowy na. Umrzeć żeby brudny minister osiągnąć rano przygotować.\nWakacje żyć pomarańcza listopad 60 wyrażać złożyć.\nDziwny chociaż uczyć się północ. Wkrótce w celu wreszcie rzeka.\nJednocześnie różny umieszczać mieszkać.\nStraszny robotnik podnieść. Zostać włosy narkotyk.\nSzereg ilość szybko zysk cena autor.\nSuchy składać w ciągu zazwyczaj. Ryba powierzchnia burza warstwa własny.\nKończyć diabeł również bić.\nWalka funkcja owca oddech jajko pieśń. Szkło lata moralny rozwój.\nPoziom instrument zwrot oddech jechać. Przyszłość zdjęcie sztuka 60 kolor.\nDłoń działać byk wartość uderzyć.\nLitera miara zły dzielnica bank dokument. Kino opowiadać Ukraina koszt piękny przynosić.\nNasz sądowy mebel gniew.\nKoszt pora wszystko zaś mleko uczeń. Grzech środek mąka śnieg czyn.\nSyn hasło fizyczny tylko znajdować.', 'Ryba mało strona paliwo.'),
(15, 'Do św. Anastazji', 'Dziewczyna kierowca ryba palec dzięki odcień.\nPomieszczenie administracyjny obraz wróg. Ślub słońce produkować kobiecy czynność broda.\nKarta inny myśleć. Noc kostka lotniczy brudny członek głos działać.\nProfesor pod czynić międzynarodowy.\nŻyd – różowy bądź bądź metal. Typowy ona mieć na imię głupek.\nChoć azjatycki oraz ja obrona długość. Właśnie Rosja stać głównie piasek uderzenie.\nGrunt sportowy charakter brać uchodzić grzyb.\nRzucić cesarz kolejny źle grunt. Żeński hasło narodowość silny określony przeciw.\nSos kino palić dokonać okazja.\nProjekt lot narodowy armia na zewnątrz metal różowy. Ponieważ stały wtedy przestępstwo uderzenie przejść rezultat łóżko.\nZaś dom ślad.\nImpreza gwałtowny uderzyć pewny marka szczególny. Biblioteka nastrój suchy dokonać pokonać metalowy.\nKapelusz głowa tłumaczyć wymagać. Lotniczy wybrać wewnątrz brać.\nZupa mocz jednocześnie deszcz granica wąski zaś.\nTaniec (…) Egipt szary spadek odcinek. Słoneczny wrócić pałac tkanina instytucja.\nDziecięcy albo potrawa bogactwo.\nPoprzez ona białoruski pająk wspólnota trwać kara.\nTylko wioska południe uderzać leczenie. Obszar ofiara widzieć ciemność cztery o.\nGra władza czytać jednocześnie kwiat jak alfabet. Przyjaźń zimno wycieczka obraz jaki jedynie bajka. Trzydzieści marka pokonać ogromny razem tworzyć.\nNie- pojedynczy ogólny spotkać fabryka.\nDotyczyć samica ich ile zdrowy grudzień wykonanie.', 'Woda 60 Stany Zjednoczone gotować koza.'),
(16, 'Do św. Neli', 'Północ ciągle plac zamykać.\nWzór Francja późny.\nBajka lotniczy z sport paliwo blady powieść. Pomiędzy całość przypominać wpływ brązowy gardło trzy strój.\nTelewizyjny płacić i czysty. Mocno zmarły od mało słoneczny.\nWywodzić Się kolacja zbiornik ich lato trwać.\nDroga kość Szwajcaria poprzez kamień oś. Budowa ocean zapis ósmy umowa cel pamięć.\nMiara zupełnie powoli. Surowy bycie kość jeżeli Egipt doprowadzić duński.\nPo wysokość muzyk.\nHiszpania maj trzydziesty ksiądz Słowacja kij nóż. Postawa Polska spotkanie wejść zawartość sygnał ojciec metal.\nNapisać dawno kupować wyrób pająk futro święto. Lecieć para wstyd Belgia okolica wieś punkt ogon.\nPłaszcz - zwrot dziób samica. Imię urodzić bić go nauka ośrodek prawny.\nMy historia nagły seks. Odbywać Się restauracja skała.\nOdpowiadać aż osiągnąć.\nWaga anioł dzieło urzędnik sen. Sportowy długo owad dane przygotowywać.\nTysiąc naród budowa jakość jakby proszę.\n60 cały wysłać bajka uderzać ta. Cienki mózg wykonywanie włosy —.\nNiszczyć przybyć płaszcz zimno.\nŚwiat zakres rada wynosić istota. Ty sen łódź miejscowość.\nOpieka grupa nieszczęście jednocześnie widoczny osobisty włosy.\nPałac rozwój zachodni.', 'Pieniądze wstyd podnieść Izrael produkować. 50 ważny muzyka alfabet tekst zacząć.'),
(17, 'Do św. Julianny', 'Stopień budować świecić poruszać koszula.\nPoziom artykuł słońce zielony matka. Szkło cztery wieś swój.\nSpaść wykonanie lecz tablica szybko graniczyć.\nAutobus nosić suchy czwartek pierwiastek chemiczny ponownie wydać.\nGotować dziób struktura zazwyczaj kontakt widok poprzez. Od autor Ukraina ślub kupić firma charakterystyczny.\nPodróż utwór wyraz inaczej mebel Indie uderzać ogólny. Funkcja imię południe zajmować określać.\nSrebro muzeum niż chłopak.\nPolicja zacząć zdanie wytwarzać wypadek niech. Mieszkanie duży ocena nagły czekać siebie wieża chrześcijaństwo.\nJednostka trudny gospodarka materiał sprzedawać obrona suchy liczba atomowa.\nWedług dzisiaj matka żaba nocny paliwo. No ustawa polityczny zimno rzeka łączyć.\nŻydowski dziura bezpieczeństwo mi.\nHotel finansowy przyszły początek przyszłość długo styczeń. Kłopot pająk specjalista urzędnik przyszłość kawałek oficjalny.\nLubić prywatny kapelusz zacząć podstawowy łuk usta.', 'Gałąź dokładnie wrócić.'),
(18, 'Do św. Natana', 'Otworzyć transport określać 10 coś.\nKończyć dokonywać wódka królewski przeciw. Centrum przemysł w po. Ono obcy rachunek użyć Kraków czekolada pojawić się.\nWyjść ptak kwiat ulica.\nZmieniać urodzić stanowić. Jego dokładny urząd podróżować chrześcijaństwo kontakt nazywać.\nKrok gleba artykuł wy.\nProsty nigdy skończyć tańczyć. Nieść należeć to Białoruś pisarz kolej.\nKontakt Australia autor razem dowód bezpośrednio rzeczownik.\nWodny doprowadzić rezultat poruszać się pogląd herb właściwy. Głównie brzuch bezpośrednio żelazo ojczyzna kobieta.\nWiersz droga jechać bitwa restauracja zajmować się szybko.\nŁódź wiersz stawać się południe para. Motyl kaczka gorący bez dziewczynka szyja.\n1 ciągnąć grupa wesoły matka wszystko. Ocean społeczeństwo charakterystyczny koncert wolny.\nRóżowy zwyczaj sklep zachodni stopień Bóg bronić chcieć. Pochodzić i obok pisać.\nOtwarty jej telewizja organizm potrafić z jeździć. Dziób wschód biuro ważny niedźwiedź jedenaście światło.\nKlasa gdzieś starożytny zjeść gospodarczy jeść forma.\nSzczególny władca światło samiec węgiel bać się lipiec.', 'Przedstawiciel jajko określenie dowód.'),
(19, 'Do św. Ryszarda', 'Pragnąć lekcja mało.\nLina tytoń rok nie użyć nasienie kość. Przyjść tak pewny wino mnóstwo.\nJednostka pozbawić średni.\nObrona wybierać jednostka różowy wcześnie. Osiemdziesiąt długi przyjść igła.\n— odpowiadać inaczej. Naj- środek prezydent.\nDecyzja dzięki oddawać połączenie. Bogini ciekawy w formie późny ulica całkiem.\nObowiązywać chrześcijaństwo mężczyzna !. Rodzaj umieć ser jądro hasło.\nCzysty żołądek pisać herb wejść samolot klient.\nLinia biedny republika cesarz.\nPierś ozdoba zupełnie epoka mały spokój. Czynić wynosić przyszły zakład seks pomarańcza głupiec. Ogon ślad wszelki krótki umożliwiać okazja prezydent.\nWydać dlatego ogród stopień bezpieczeństwo lekcja.\nZimno pięćdziesiąt większy. Zjawisko ból oddać ona.\nHiszpański religijny metal styczeń dlaczego.\nZiarno lód trudny obywatel odcień pojazd. Inny kształt pracownik kino tradycja. Pozwalać urzędnik ja ten sam żółty.\nNoga niedźwiedź cierpieć część. Restauracja sprzedawać dalej.\nHałas pamiętać trochę umiejętność wiadomość. Godność dzisiaj opinia powieść zainteresowanie dziób.\nSprzęt ze wyrażenie działanie.\nDalej grudzień 80 dźwięk rodowity do. Przeznaczyć koniec nazwa cześć jakby Stany Zjednoczone.\nStawiać sztuczny ostatni zły Włochy wszystek malować.\nEnergia istotny dobro dwa w kształcie obserwować.', 'Lekcja.'),
(20, 'Do św. Klari', 'Jaki dopiero gwiazdozbiór stać się dział tysiąc.\nCzerwiec forma Jezus policja.\nPaństwo stać się mama społeczeństwo fizyczny bułgarski podobny.', 'Organizacja charakter model odcień powstać uznawać.'),
(21, 'Do św. Wiktora', 'Pół płynąć zawodowy palić kolumna dziki.\nWychodzić taki jadalny seksualny otwór kierowca.\nSmutny źródło trzeba azjatycki. Ślad wujek niebezpieczeństwo sytuacja szeroki hałas 1.\nZakończenie powstanie w wyniku wtorek w.\nfunkcja obserwować.\nWalczyć narzędzie wątpliwość ze. By cena stawiać sąd pojemnik cienki 50 masa.\nSprzęt partia hałas nadzieja użyć.\nZwykle kolejowy całkowity przestrzeń dziadek miasto. Zamknąć stanowisko kino złoto lud spotkanie oczekiwać co.\nSłońce ciepło Polak brzeg z krwi i kości. Rozwiązanie górski ludowy elektryczny tytuł.\nLotnisko stać się świeży stado jedynie biskup jedynie.\nZatoka ozdoba wyjść krzesło poniedziałek sok zbiornik. Miejski określony pora wzrok zamieszkiwać sztuczny.\nMrówka panna kolejny gniazdo. Partia chłop szeroki rozmawiać czwartek.\nZbiornik strona sobota przyszły.\nJakby wynik lek krok piętro pasmo morze. Bank Litwa państwowy promień 6 cierpieć.\nPrezydent przyszłość wada niewolnik. Całkowity późny autor mądry.\nSposób zdarzenie wtorek filozofia trudno metalowy.\nEuropejski ani alkohol następny gałąź. Rosyjski siedzieć pole czy przestać dla nowy.\nSzczyt opuścić pożar noc Słowacja. Port zimno obok znak dyrektor trzydziesty tak temat.\nKuchnia córka — znaczny tydzień. Pióro milion tradycja władza duży.\nPołączyć kochać jądro kłopot sprawiać.\nWęgry motyl przynieść urządzenie koszt.\nPróbować urządzenie odczuwać dlatego górny. Wniosek mieszkać trzeci armia.\nPamiętać - uderzać bycie moment leżeć.\nWydarzenie ryzyko odzież postępowanie dach kolej siedemdziesiąt także.\nTemat albo trzeba. Zwolennik drobny dodać uderzyć tradycyjny biskup.\nŚwieży czyn kształt rodzaj fabryka chociaż okno. Powietrze gospodarczy starożytny krok.\nBiskup przerwa 4 listopad tysiąc poruszać otwierać. Partia pływać rzucać diabeł w..\nDać Się młody cel rezultat przyjechać czerwiec drugi.\nGdyby Węgry dokładnie pałac ubogi artystyczny 7.', 'Francuski.'),
(22, 'Do św. Eryka', 'Chcieć odbywać się wprowadzać.\nAzjatycki jego gra pacjent włoski obserwować. Popularny 20 kula 1 mój.\nPrezent umowa kult flaga zazwyczaj zły bić komórka.\nSamolot paliwo kraina położenie dokładny. Warunek spać zamknąć stawiać.\n30 relacja ryzyko piątek okno ponieważ wrócić narząd. Górny umieć już zobaczyć człowiek dokładny. Zapomnieć niż nosić marka mieszkanie Kościół.\nZnaczny wystawa nasz robotnik.\nSyn Australia cesarz rak przejście waluta gorący. Trzy lubić ciemność taniec czwarty ślad powód.\nLitwa żona wóz ulegać Chiny.', 'Dawny prostytutka procent historia. Św. ! ruch użycie budynek obraz.'),
(23, 'Do św. Franciszeka', 'Kwestia dokładny podnieść popularny działać burza.\nCzy poprzedni akt przechodzić siódmy tytuł lubić. Pojawić Się różnica pająk znajdować się.\nPowstawać but rzadko dokument.\nNarodowość bądź ocena. Uznawać Afganistan wysokość za pomocą.\nTrochę móc bić odważny znaczyć sobą ogon. Przeszkoda robota miły pociąg.\nWydawać święto pociąg węgiel Europa ona obóz.\nLitera artykuł kierunek w kształcie klub przeszkoda pole turecki. Amerykański kobieta srebrny wspaniały. Uczeń kwestia poduszka klucz skóra wódka. Parlament ten sam położyć religia słoneczny.\nDalej historia piec pół położenie w celu.\nProdukcja pogoda dziś ryż blady. Początek biedny Szwajcaria kaczka rzeczownik pojawić się poduszka.\nMiejscowość istotny dar poważny zachowywać się położony. Napój wprowadzać malować zamykać radiowy ona choć.\nReligia prawo towar samolot co zdolny pokarm. Czuć ramię klasa jedzenie jedzenie wygrać siódmy.\nSowa naród aby walka nad ale nastrój papieros.\nPełen drewniany żart czytać ludzie klimat. Jednak z krwi i kości szereg student płaszcz.\nOdczuwać zbiornik szczęśliwy nastrój umowa.\nSzczęście medycyna sól prezent czwarty kobiecy Włochy poprzedni. Cały wschodni jesień święto wojsko futro złodziej.\nZimny wynosić tłum łuk i seksualny. Odcinek pojawiać się za skała nie ma m.in.. Produkt abugida ludowy pas specjalny.\nWspólny potrawa morski średni seks własny.', 'Fałszywy 2 własność. Szczególnie sędzia zakres wiedza znowu.'),
(24, 'Do św. Róży', 'Jesień zwolennik wydawać się porządek kościół.\nBogaty budowa kult organizacja bajka. Karta bilet budowla całkiem bronić. Czarny mama mężczyzna gęś szczególnie.\nWybrzeże norma posiadać lekcja poprzedni nigdy zabawka.\nWięcej czas flaga równy układ powszechny. Jeden artystyczny pojazd bawić się.\nWzrost ciąża Hiszpania przy orzeł statek kostka gałąź. Pełnić cukier wy państwowy np.. Kontrola góra dalej prosty traktować.\nPole wolno stosować patrzeć.\nRodzina uważać gra rodzina rządzić. Z Krwi I Kości żaden wkrótce trwały grudzień.\nCoraz twardy udział.\nŚciana piasek brzydki rada fizyczny gmina. Naukowiec ile połączyć tytuł płaski. Znaczyć amharski rząd początek pływać.\n? trzy bar narzędzie.\nWschodni trwały traktować należeć zbierać oddać historyczny. Zeszły teoria wisieć. Mistrz przychodzić okoliczność pamiętać człowiek przedstawienie przedstawienie.\nCierpieć sądowy chociaż ciepło śniadanie.\nMożna przechodzić pozwalać polować Jan prezydent urzędnik. Rzeczownik w ciągu wybuch żaden więcej.\nPieniądz okoliczność ogromny wódka. Krok tarcza 9 piątek.\nZdjęcie siedemdziesiąt brak łódź. Rumunia opisać ciężar znajdować się. Kolej mebel cel dziecięcy fragment katastrofa w celu.\nZadanie ilość grunt jeździć uczucie alfabet.\nCzęść cichy pamięć rzeczownik dzielić. Klub piłka nożna prostytutka świat powolny.\nCharakterystyczny fakt wschodni plac książka dziewięćdziesiąt wszystkie.\nZa Pomocą jajo bądź centrum waga. Dłoń nauczyciel budowla port próba promień wysyłać. Kanał zwycięstwo figura przyjaciel lekcja potrzeba szybko.\nO alkoholowy zdobyć stan ofiara przestrzeń wyścig.\nMiłość pióro włosy płacić miecz.', 'Przeznaczyć ogół grecki rada babcia lud. Pierwszy handel plama zmienić.'),
(25, 'Do św. Artura', 'Rozmiar masło światło.\nGospodarka kolacja los Litwa. Interes plecy cukier przyszłość łódź bogini.\nPołączyć mieszkanka wyrażenie zdjęcie gęś.\nDzielnica igła intensywny przedstawienie kurs butelka. Kieszeń obiekt wrogi wytwarzać nie ma.\nNigdy głupota punkt. Starać Się Egipt pieniądz.\nBlisko śpiewać prostytutka rzucać samica wysyłać abugida. Wóz jego park USA.\nCoś sól spadek siedziba impreza stały.\nGrzyb dziób ale chyba jakby zatoka.\nMiasto surowy dyskusja żółty kanał Słońce gotowy. Język zająć Australia strach uwaga dom informacja.\nZawodowy przygotowywać farba artystyczny urodziny. Smutek to plan strach.\nStudiować zapach odpowiedź wyłącznie złodziej. Radość ich to linia.\nWygląd przyszły gospodarczy paliwo gwiazdozbiór.\nSkłonność włosy fizyczny naród sygnał Niemcy. Wyrób literatura terytorium wygrać.\nAfganistan jej wysłać lata tytuł.\nWłos pojęcie poczta miejsce. Rzym siedemdziesiąt urządzenie decyzja.\nŁyżka dziewczynka państwowy duński środa. Uciec dawać zielony.\nPas podróżować pięćdziesiąt ilość jadalny.', 'Terytorium ładny dusza umieścić. Odpowiedź powiedzieć pochodzenie.'),
(26, 'Do św. Adrianny', 'Motyl dziać się jajko Niemcy sos służba.\nDrugi ja istotny palec chmura dziewiąty. Wziąć we odmiana słowo.\nPrzyjaciel udział kobiecy pytanie wiedzieć.\nFilm zielony ramię wokół. Katolicki lud lis smak sowa piąty.\nPiosenka wyjście daleko członek gwiazdozbiór banknot ze ty.\nStrój przestrzeń wrażenie one czwartek członek. Następować dać spotkanie własność ukraiński chociaż.\nWojsko odkryć polityczny wybierać liczyć kontynent (…).\nŻona uciekać układ jakość chłop podatek. Całkiem środkowy wprowadzać łąka rana dla. Orzeł elektryczny wyrażać.\nWczoraj sen scena wojna bank dział. Epoka pojawić się budynek pomiędzy urodziny Belgia.\nPamiętać przebywać chęć sieć stopień grób.', 'Spadek 20 można późno.'),
(27, 'Do św. Anna Marii', 'Polityczny czy nauczycielka broda górski.\nKról kolor masło oś pomiędzy źle określenie dobry.\nPrzybyć głównie nauczyciel woda walczyć parlament. Zwierzę wódka ludowy dla przepis należy ja organizacja.\nDokonywać reakcja warunek.\nWyrób jakiś kierowca brać.\nPomoc plemię trzeba. Królewski ostry posługiwać się walka.\nJęzyk wykonanie deska oś.\nInstytucja lekki mi dusza wada krzesło. Miara długo miejski ci gardło drobny charakterystyczny.\nTekst rzeka środkowy akcja Azja burza.\nGodzina by praca. Górny ludowy zły głos zbiornik trzymać zbudować.\nWiara potrzebować dokładnie terytorium. Wczesny katastrofa w czasie marka stopa państwowy miesiąc wspomnienie.\nOgromny więzienie m.in.\nmieć na imię oni.\nSzkolny spadać oddział masa trzydziesty kolejowy mocz wy. Zarówno trawa produkcja zapis tysiąc 30 też długość.\nPomoc siedzieć łąka pani waga przyjaźń.\nUkraina jadalny gotowy zacząć pięć. Kończyć rana wykonywać grób odczuwać.\nLiczyć mąka rzucić wioska.\nPojemnik przestać deska. 900 gmina zamek kontynent lubić łyżka zaczynać.\nRobotnik 8 rzucić. Stary lotniczy port.\nGo wspólnota lek opinia tkanina Turcja kurs. Który powstać w formie szybko sądowy graniczyć.\nNarząd sztuka złożyć przerwa.\nŚmiech śmiać się seks biały córka publiczny. Rozwój sobą urząd mi południowy.\nNp.\nport obiad jądro surowy spór trzy dziewczynka. Plaża przyszły mieszkanka teoria.\nTłuszcz itp.\nłatwy słuchać USA.\nTrzymać położenie stworzyć. Pod pomysł czwarty poruszać lato związek towar.\nOpuścić szósty prowincja ocean piasek całość.\nGłos termin płakać jeździć. Pewien odcinek osoba stać.\nCzwartek u otrzymywać potem pozwalać jednocześnie. Przyprawa przerwa fabryka dodać zanim lekarz.\nCałość ani amharski tytoń myśl polityk spowodować.\nZbiornik wielki wiek broń wybór.', 'Przyprawa składnik prawny trzeci podstawa naturalny przejść późny. Wioska ciotka dziecko.'),
(28, 'Do św. Julianny', 'Ksiądz poprzez koza hałas.\nKierowca starać się podłoga budynek sobą okropny biblioteka ból.\nAdministracyjny zatrzymać pijany szczególnie ty następny rozpocząć. Nadzieja 6 wnętrze strój.\nŚwiat Niemcy ciągnąć dzielnica i osiągnąć.\nTeoria liczyć niebo but niedźwiedź dym centralny październik.\nHotel wspomnienie stół czterdzieści przeciw miód. Abugida niech tutaj armia gwiazda wczoraj.\nSklep Polska flaga bohater uśmiech.\nUmiejętność włożyć godność pojemnik. Zbiornik jeśli umieszczać jezioro można hałas.\nIdea powiat armia Rosja adres rasa wczoraj. Fizyczny technika jutro element.\nPomidor zdjęcie jakość wydawać się jeść instrument.\nTelewizja bogini spać zawartość nikt rzeczownik kolejny. Biblioteka odmiana las produkcja określony ksiądz zaburzenie.\nMieszkanie czasownik wrogi Indie.\nAktor mały śpiewać rodzina przestać. Świątynia numer lek.\nDopływ grzyb gleba modlitwa szósty.\nPieśń starożytny jajko okres. Morski lina duch wolność.\nWłosy cisza samolot dobrze już dodatek procent czterdzieści.\nWiadomość pytanie dziewiąty badanie problem rzeka. Płynąć osioł razem substancja Ameryka zwykle.\nM.In.\njapoński uważać znać organ przyjmować. Krótki ksiądz rzadko piątek koło np.. Służba rejon turecki pusty jeszcze.\nZająć to wiatr pomarańcza. Co słowacki należy słowo.\nSztuczny urodzić wstyd pojawiać się. Koza wyspa przeciwnik uczucie dzisiaj europejski. Tani wzrok materiał piątek zwrot koło utrzymywać.\nBy produkować przerwa 100 dzień wilk w formie drogi. Lew siła naukowy substancja pójść czerwiec ona.\nWielki zjeść ojczyzna kieszeń.', 'Gospodarka sieć pałac stały trochę konflikt.'),
(29, 'Do św. Daniela', 'Słuchać gwiazda maj broda święty udać się.\nTalerz wtorek obowiązywać istota wniosek okno cień.\nPrzejście wytwarzać upadek Bóg sztuka mój.\nZnów śmiać się by odpowiedź. Narodowość wartość podać znajdować się problem.\nUsuwać znaczyć koło św..\nŻeby wolność wiek wejść klasa. Postępować siostra dla od przygotowywać.\nSpaść słoneczny posługiwać się w ciągu.\nSiedziba rachunek piękny. Jeżeli piosenka zbiór.\nCierpieć niewielki nazywać czuć lód. To 1 wodny.\nWiosna lotniczy kaczka. Rynek substancja lub. Grzech wstyd żaba los.\nPotem odwaga lotnisko gatunek wodny.\nDach w czasie narząd zdarzenie. Znosić bogini zawód ich głównie. Natura przyprawa odnosić się zamiar płakać zbudować republika potrzeba.\nDrewniany powstanie most umożliwiać. Pochodzić śpiewać pragnąć wycieczka wczesny francuski.\nWybór pieniądz pociąg płakać. Razem jesień sala jeździć typowy zimny Pan.\nProjekt oddawać ser Niemcy przeznaczyć.\nNaprawdę przyjaźń anioł Chrystus warzywo odzież. Anglia jaki dialekt.\nDecyzja traktować prawdziwy zdrowy substancja.', 'Oglądać polityka czyjś barwa. Rozmowa pewny północ samochód czyli wysoko śmiech.'),
(30, 'Do św. Klari', 'Ale sklep religijny organizacja transport.\nStany Zjednoczone zainteresowanie styczeń ! należeć dziać się Niemcy.\nŁódź jakiś dawać przyjmować skala kraina pomoc przygotować. Postępować ocean samiec ponad tamten.\nIndie powolny dokonać wysiłek poważny.\nWysokość zamieszkiwać Białoruś. Lipiec poznać Stany Zjednoczone okropny duch w kształcie brudny południowy.\nZły 60 pismo dla choć.\nSamiec dlaczego północ Unia Europejska pan rzymski prawy.\nZaraz filmowy uśmiech osiemdziesiąt. Ponownie śmierć problem między.\nInternetowy tyle przyprawa chronić wyglądać różowy cisza skóra. Czerwiec wszystek butelka inaczej przejście.\nLitwa pomieszczenie podstawowy rak.\nKolega waluta narodowy sprawiać. Wolność międzynarodowy struktura inny smak metal.\nNiewielki reguła Szwajcaria wtorek zdrowie lub bar Turcja.\nSłowo gość prawda. Obrót Piotr piec minuta państwo odważny zaraz.\nPiąty bogaty wniosek budynek. Żydowski poprzez wyjście elektryczny bez tu.\nDziałać położyć mieszkać.\nWarstwa róg kwiat wrócić.\nPrzeciwnik spodnie podczas mały pozostawać upadek nazwa. Toponim ty posiadać karta.\nPewien podstawowy sól rozpocząć do cebula.\nStyczeń moment miejsce budowa. Doskonały razem pamięć flaga pozwalać byk wspomnienie.\nDziś dziki sok przemysł kino wojsko brak. Instytucja Hiszpania część ktoś czapka zapomnieć oczekiwać surowy.\nNaturalny stan obok farba.\nKsiądz proces medycyna lub żywy procent próba pieśń. Wyrażać dym wrażenie instytucja pokój pewny.\nWalczyć wkrótce żywność radość brak kula ssak okrągły.\nWąski przyjechać umowa całkowicie granica podstawa chęć. Ilość pojemnik muzyczny ofiara wykonywanie.\nŁóżko niedźwiedź lub zapis starożytny październik można powiat.\nZajmować Się lew zbierać.\nGrób woda zbyt pas kalendarz ile. Piosenka odwaga wykonywać dwudziesty jako.\nNiebezpieczeństwo park urodzić się mi dawny. Leczenie grać składnik piąty.\nWidoczny zaburzenie strach świeca. Głupek prawny wyraz.\nSygnał kolor te punkt.', 'Czwartek Niemcy umieścić miejsce.'),
(31, 'Do św. Fryderyka', 'Cierpieć egzamin gotować stanowisko.\nUżytkownik spokój struktura rolnik go.\nDotyczyć łączyć 90 metr nosić przez. W Końcu pusty hodować.\nPokój przerwa jazda nadawać gra tyle bliski.\nDodawać rzadki wybory zacząć nowy użytkownik zmęczony my.\nKu widoczny tak maj królowa miejsce zdrowie. Organizm wskazywać szkoda lekarz owad.\nWykonać gorący poprzedni książka zmiana wziąć. Po obiad rodzina plecy bajka zwycięstwo.\nKolega przyczyna Pan kostka pojedynczy.\nZgromadzenie do księżyc wtedy.\nSobie instrument zdanie powodować dolny trzeci.', 'Atak wczoraj one dobrze. Bieg głównie park — obóz.'),
(32, 'Do św. Jakuba', 'Grecja wiedza czwarty źródło zaburzenie doprowadzić błąd.\nRóżowy nauka brać litera. Wróg wieś zawartość dar.\nIgła bardzo okno ssak wnętrze spaść. Pracownik historia egzamin podnosić Azja reakcja gotowy.\nChiny jeśli szkło uprawiać. Zaraz Azja bilet co.\nŁagodny uzyskać uważać ogród nasz.\nŁadny krew prawny również duński martwy metal zły. Czynność las Kraków żołnierz te futro uczyć się.\nJeśli kraina fałszywy połowa my otwierać. Uczyć specjalista autobus godny chiński artykuł.\nButelka kościół wyrażać chłopak.\n- wygrać dobro zajmować linia i. Pełen bieg jeździć ciemny obecny nieść ciepło. Mocz paliwo istnienie życie przejście dość skłonność świat.\nNagły ogólny także znać wracać.\nLas kura szczególnie wieś wieczorem wielki międzynarodowy. Przykład płaski gatunek zwykle skała prosić powierzchnia.\nTeoria ponownie leżeć niż.\nTakże czoło pierwiastek chemiczny pomiędzy przyjmować. Podróż francuski powierzchnia coś szklanka wschodni szkło sztuczny.\nWojenny przecież przyjaźń pokarm wrócić dziecięcy wątpliwość. Lekcja los siedem który zmarły.\nŚniadanie stworzyć wysoki drewno piękny liczba wada.\nZaraz transport gołąb. Uprawiać wielkość duński maszyna wspomnienie.\nSzkolny prasa powoli pójść. Mierzyć te słoń zawartość sen wyrok anioł.\nPożar moneta twarz strata rozwiązanie. Specjalista kupować mieszkanka dom.\nSpaść produkcja sygnał umożliwiać słońce tytoń klub.\nPłaszcz skończyć w wyniku tańczyć przyjechać hotel.', 'Francja niedźwiedź wąż zero naturalny 9.'),
(33, 'Do św. Julity', 'Zimno uniwersytet utwór ktoś jakby piątek.\nIstotny pokarm Boże Narodzenie.\nZacząć strefa ryzyko płyn. Spokojny jedenaście znać pomieszczenie rząd przygotowywać.\nNazwisko klucz rak zabawka kieszeń myśl dawny.\nPrędkość pragnienie też. Gotować ozdobny Hiszpania powietrze zjeść położony typ.\nPiękny sala woda fala wybierać lekcja.\nBrzeg straszny bycie metalowy wysyłać mama park. Uczucie odcinek korzeń mysz Słońce ładny.\nZawsze komputer zabawa dorosły Egipt reakcja. Wolny sieć kolejowy członek listopad.\nSkłonność pies słownik gdzieś krowa rzucić mądry szlachetny. Głos Turcja stosunek 9.\nRobotnik płacić mama noga.\nPrzedstawiciel oddać stopień połączenie minister. Polityk zwykle region te budzić głowa znajdować wreszcie.\nZjeść orzeł pod kij korzystać. Chęć czoło powietrze ale.\nPodnosić cukier reakcja taki zawierać centralny przyjemny.\nChcieć również wspólny chrześcijaństwo wchodzić. Piękny róża znaleźć duński różowy.\nStarać Się trwać pamięć gorący. Gęś przestać dostęp pokarm.\nCienki piątek aktor.\nGrecja ściana ona wziąć. Musieć zły piasek para urząd dowód.\nPapier zasada twój tylko.\nZachodni płaszcz pismo ona telefon. Grunt zapalenie zadanie one tracić.\nBudowa istnienie malować złapać.', 'Litwa robota autor 20. Dzień mrówka radio nadawać zrozumieć.'),
(34, 'Do św. Konrada', 'Pięć raz krok podnieść.\nZainteresowanie odpowiedni trzeci wy.\nZniszczyć plama zapach inny piwo pomoc 50. Zbyt prywatny syn dzielić Szwecja ogień mysz nic.\nObejmować japoński spodnie wzór istnieć obecny. Prawy gniew analiza zarówno zawierać nazwa wyjść.\nNawet ludzie policjant Morze Śródziemne budować porządek zwyczaj wpływ. Pojechać szlachetny wspólny komputerowy różny posiłek minuskuła samica.\nWłos siebie woda pasek pojedynczy szukać specjalista.\nZwycięstwo pytać domowy przyjemny. Wynik wioska kłaść szybko róża obraz kolorowy.\nAlkoholowy wartość niszczyć ponad przyprawa.\nWedług straszny wokół imię zajmować się domowy podobny. Lub wprowadzać środkowy tytoń należy niebieski archipelag obcy.\nTłum 90 obecny oznaczać ryż lud.\nNiebo postępować przeznaczyć bogaty. Ciągle w ciągu połączyć składać się rzeka wiek dać się.\nKwiecień ryba poduszka lekki. Sto zwolennik studia szybko świeca region hiszpański plemię.\nLotnisko dokładnie ponieważ głupi brak móc. Partia chłop jeździć.\nNadmierny park oko wewnątrz wiara.\nProszę następować zobaczyć pomagać.\nStarać Się głupiec temat i. Oznaczać który sala ojczyzna.\nKolacja but student szkoda.\nZima las urodzenie. Wodny zachodni przeprowadzać zdolność wiosna kosz rozmowa.\nObóz historyczny piwo zwłaszcza sytuacja.\nGołąb współczesny tor tani zbiornik. Cebula wzdłuż relacja tutaj spokojny powód.\nStały prawny mąka podróż włożyć starać się ukraiński poprzedni.\nTaniec trudno utrzymywać otworzyć fabryka. Rasa majątek treść. Uprawiać gazeta historyczny przecież koniec łagodny wyścig.\nWalczyć prawda oficjalny żeby zaufanie kawa lipiec.\nTu rzeczywistość Niemcy pragnienie prawo bogactwo koszt. Rada wypadek święty mocno partia płynąć epoka skrzydło.\nAzjatycki sklep naturalny z powodu.', 'Ze matka złożony. Środkowy lata przestać wierny czwarty.'),
(35, 'Do św. Filipa', 'Dodać w.\npunkt finansowy pokarm włosy wokół.\n- dlatego wnętrze naj- umysł stolica internetowy.\nŁódź męski południowy ukraiński człowiek dostęp. Całość zamknąć ocean mocno Kraków.\nSpowodować właściciel zanim roślina obok symbol kwiecień aktywny.\nLato drobny błąd intensywny dolina sprzedawać. Z Krwi I Kości zawartość ogół jedyny żywność czasem firma odczuwać.\nWprowadzać obraz inny barwa długość kobieta. Dzięki silnik szanowny pierwiastek całość dyrektor blisko środkowy. Godzina brzydki zabawka mieć na imię. Głos podróż piętnaście metalowy gospodarka rower.\nDział oznaczać np.\nadministracyjny papież kościół dwa. Daleko prywatny spodnie światło.\nKościół przedstawienie pieśń poznać handel nazywać.\nDługo struktura upadek skała.\nSurowy gęś problem gruby srebrny. Pustynia lato piłka ocena. Rozmawiać kino jutro ciepło.\nLiteracki papier spadać zwolennik odmiana.\nCzłonek letni znak stolica ojciec Czechy rzadki. Artysta piętro kolej rower historyczny diabeł wspaniały.\nŻycie szef pojawiać się w metal archipelag.\nGrzech strona ziemski kawałek. Własność gruby noga wypadek pszczoła żydowski.\nPiętro zakon występować miasto średniowieczny. Naj- żaba bać się przedmiot teoria towar stosować.\nHiszpański księżyc wstyd Stany Zjednoczone duży.\nUczyć Się ser sześćdziesiąt metal postać. Wrogość niebo Polska właściciel lotniczy mieć wypadek.\nPłeć złożyć porządek. Kolejny szary mózg wspomnienie.\nChory mieszkanie oddział wyrażenie.\nZnosić trochę rozmawiać położony wysiłek brać ciekawy. Wtedy wiadomość publiczny. Postawić przed zapis zamknąć stado idea.\nPewny pójść rzeczownik godzina zamek zarówno.\nPies uczyć śmiać się. Podczas oko mieszkanie gleba amharski szczyt. Robotnik banknot przez stary.\nHistoria zabawka siedem dzielnica.', 'Bądź.');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `obrazek`
--

CREATE TABLE `obrazek` (
  `id` int(10) UNSIGNED NOT NULL,
  `tekst_alternatywny` varchar(128) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `obrazek`
--

INSERT INTO `obrazek` (`id`, `tekst_alternatywny`) VALUES
(1, 'Domyślne zdjęcie profilowe'),
(2, 'Model pokarm.'),
(3, NULL),
(4, 'Papież składnik godzina prędkość olej.'),
(5, NULL),
(6, 'Koń teren wybitny zakończenie różnica. Poeta podatek kontrola jeszcze oddać obecny.'),
(7, NULL),
(8, 'Zakon dziki r..'),
(9, NULL),
(10, NULL),
(11, 'Złożony ciecz kraina oglądać te ile poduszka naukowiec.'),
(12, '? narzędzie zgodny nie spadać zdjęcie.'),
(13, 'Religijny produkt 6 wkrótce.'),
(14, NULL),
(15, 'Wykonywać.'),
(16, 'Moneta zakres.'),
(17, 'Tyle wrażenie zamiar wyrażać obok dokładnie.'),
(18, 'Czy bliski.'),
(19, 'Pojemnik trzydziesty bawić się strach.'),
(20, NULL),
(21, 'Tak zachodni sądzić niewolnik gdyby lubić miesiąc nasiono. Lotnisko nie ma Kraków Chiny wodny.'),
(22, 'Usta córka ryż okolica. Zdobyć bajka szpital osoba. Ręka szczególnie Kraków śmiech egzamin bezpośrednio organizm.'),
(23, 'Daleki dostać potem ludność czas alfabet.'),
(24, 'Powodować wracać chmura rysunek historia.'),
(25, 'Szczyt łóżko słowacki zły pić jeśli. Kwiecień słowo cały rodzic spokojny obiekt albo.'),
(26, 'Kolano podawać plemię.'),
(27, 'On wódka cukier metr pusty złoto kapelusz psychiczny.'),
(28, 'Otwarty gęś świeży syn. Piętro twardy obrót wszelki jakby członek ślub.'),
(29, 'Biały narzędzie.'),
(30, 'Rozpocząć brzeg kobieta dany znać stado zielony.'),
(31, NULL),
(32, 'Niemiecki grób umożliwiać włożyć. Płyta zawodnik zgromadzenie.'),
(33, 'Niszczyć inny ta osobisty analiza. Ocena cień pójść danie produkt następny raz.'),
(34, NULL),
(35, NULL),
(36, 'Pogląd milion zawodowy złoto. 20 taniec odbywać się bez stary wynosić jaki.'),
(37, NULL),
(38, NULL),
(39, NULL),
(40, 'Piękny kilometr metal nagły.'),
(41, 'Zająć mur okazja znajdować nie- piąty.'),
(42, 'Dawny to zdjęcie. Rosja but bok. Zdjęcie obchodzić sądzić wywoływać.'),
(43, 'Nowy naczynie gatunek tkanina.'),
(44, '80.'),
(45, 'Chiny silny miód.'),
(46, 'Ojciec obowiązek główny staw. Pokonać flaga cześć jabłko Słowacja pamiętać pierwszy.'),
(47, NULL),
(48, NULL),
(49, 'Gotować operacja zbyt rodzina brzydki śniadanie papier.'),
(50, 'Nigdy.'),
(51, 'Krok.'),
(52, 'Szyja armia.'),
(53, 'Północ ofiara pływać ogon. Nazwisko biblioteka wojna mapa obraz mrówka.'),
(54, NULL),
(55, 'Wtorek centralny.'),
(56, 'Wąski lęk podatek warstwa powstawać odnosić się znaczny.'),
(57, 'Lot zachodni psychiczny tor piosenka coś. Pieniądz literacki więc brązowy.'),
(58, 'Osioł obchodzić plan 80 wolność postać korzystać. Prawda suchy przecież.'),
(59, 'Sytuacja przechodzić plan rozmiar literacki trzeci podział.'),
(60, 'Pora charakterystyczny walka dokonywać USA m.in. treść.'),
(61, 'Koszt ssak drewno przyjemność życie złoto.'),
(62, NULL),
(63, NULL),
(64, 'Płeć wąski błąd połączenie zadanie.'),
(65, NULL),
(66, 'Grób symbol bądź gdyby piętro przyjąć.'),
(67, 'Obecnie świadczyć wszyscy ponieważ wejść dokonać.'),
(68, 'Pełny kościół przemysł pisarz barwa. Też wtedy Bóg jadalny.'),
(69, 'Uwaga szkoła duński kierowca.'),
(70, 'Ktoś użytkownik państwowy Indie. Kiedy zając wspomnienie tworzyć siódmy.'),
(71, 'Długo.'),
(72, 'Tani.'),
(73, 'Sukces człowiek książę walczyć cierpieć kilometr nocny.'),
(74, 'Udać Się pismo przyczyna interes. Niech zbiór ze słyszeć pisanie. Strumień wszyscy czuć zły.'),
(75, 'Pokój ubranie brać wilk papieros no. Życie Czechy przerwa w wartość lotnisko. Święto obowiązywać podnieść moc nazywać.'),
(76, 'Ciało cierpieć Kraków tracić krzew.'),
(77, 'Zakończyć dach gdyby może.'),
(78, 'Kto.'),
(79, 'Artystyczny utrzymywać termin dziura.'),
(80, 'Gniew interes 80 dany na przykład jaki. Wzrok sygnał brzydki.'),
(81, 'Taniec lubić.'),
(82, 'Wieczorem historia narkotyk zachowanie ziemniak woda zamknąć.'),
(83, 'Pokryć w formie skóra.'),
(84, NULL),
(85, '6 liczyć żeby śniadanie. 90 przypominać głośny.'),
(86, 'Skłonność francuski religijny święty.'),
(87, 'Słoneczny akt sąsiad sześć.'),
(88, 'Odnosić Się ryzyko wiosna one nauczycielka przynieść muzeum. Dziewięć rozumieć miasto sól.'),
(89, 'Zgoda.'),
(90, 'Liść sieć spotkać zapach wujek morski. Wstyd pieniądze iść naj- przebywać.'),
(91, NULL),
(92, NULL),
(93, 'Pragnienie pieniądz tajemnica dyrektor. Kraków szacunek czoło kupować trzeci tradycja.'),
(94, 'Gmina centrum żyć narodowy zamykać Czechy. Owoc park bogini uderzyć.'),
(95, 'Cierpienie gaz wytwarzać bać się. Robić ono funkcja żeński poprzedni czarny.'),
(96, 'Umysł ono stolica.'),
(97, 'Ameryka gwiazda lew sport.'),
(98, 'Wada drzwi żeby syn.'),
(99, 'Dzięki Kraków niewolnik.'),
(100, NULL),
(101, NULL),
(102, 'Ciasto praktyka kolacja pokarm możliwość.'),
(103, 'Zwyczaj stać odkryć też. Wysłać rodzic przyrząd.'),
(104, 'Wąski punkt zimno ozdobny wtedy. Aktywny dawny szklanka piosenka symbol kwestia sobie.'),
(105, NULL),
(106, 'Postępować danie pewny smutek mgła.'),
(107, NULL),
(108, 'Milion użyć spodnie mleko. Pałac Izrael dziewięćdziesiąt potrzebny zwrot. Poniedziałek polegać miesiąc kraina.'),
(109, 'Otwarty ksiądz zjeść głupota.'),
(110, 'Stopień jutro większość otworzyć klasztor prezent ośrodek. Cienki jutro postawa.'),
(111, NULL),
(112, 'Pusty traktować martwy łatwo.'),
(113, NULL),
(114, 'Okazja nasiono pod. Palić jeździć czynnik chronić.'),
(115, 'Przeciwny w czasie babcia białoruski.'),
(116, 'Zamek wszystek 60.'),
(117, NULL),
(118, 'Chłopak artysta powód kształt.'),
(119, NULL),
(120, NULL),
(121, 'Opisać nieprzyjemny otwierać wąski żeński 20 wobec. Figura świeca lekki przyjąć.'),
(122, NULL),
(123, 'Związek produkować stanowisko kościół.'),
(124, 'Dzień komputer kostka poeta.'),
(125, NULL),
(126, NULL),
(127, 'Uciekać zawodnik chmura coraz. Nikt wystawa napisać przyszły wykorzystywać użycie dziś.'),
(128, 'Operacja udać się łagodny Jan łąka.'),
(129, 'Dorosły 6 Słońce obowiązywać aktywny położyć stracić.'),
(130, 'Istnienie wspaniały zajmować się naród go. Spokój sklep jeść cebula. Parlament czasem wiedza szczyt.'),
(131, 'Który godny w wyniku.'),
(132, 'Może władca ozdoba.'),
(133, 'Chrystus.'),
(134, 'Dzisiaj program ogień umrzeć adres dźwięk mieć. Otoczenie uważać hodować długi lód płeć wykonać ciepły.'),
(135, 'Uważać cebula koń Afganistan mysz dom.'),
(136, 'Sobie Izrael łatwy postawić od.'),
(137, NULL),
(138, NULL),
(139, NULL),
(140, 'Obóz uchodzić pochodzić możliwość pochodzić wakacje.'),
(141, 'Pomieszczenie rzucać ustawa waluta rozumieć Azja. Tylko reakcja gwiazda zamknąć powoli.'),
(142, 'To zaś teren średni masło kurs siedem.'),
(143, NULL),
(144, 'Jego róża zabić długi hasło.'),
(145, 'Wóz grudzień moralny republika szczyt.'),
(146, 'Teoria wierny metal sposób wypadek ukraiński wolny. Czeski jedzenie piasek komórka plac.'),
(147, 'Centrum akcja oddech myśleć.'),
(148, 'Aż zdrowy październik.'),
(149, 'Kolumna doświadczenie zewnętrzny cierpienie wprowadzać. Szkło uczyć ziemia.'),
(150, 'Różowy połączyć żołądek pytać okazja. Gleba marzec Ameryka Austria całość obchodzić.'),
(151, 'Praktyka Kraków koniec oddział. Poważny droga wreszcie dobrze robota.'),
(152, NULL),
(153, NULL),
(154, 'Podczas albo umieścić piłka nożna ostry. Brudny łagodny obiekt azjatycki można.'),
(155, NULL),
(156, 'Kłaść skała ? różowy zupa ochrona.'),
(157, 'Przybyć zero zwyczaj nauczycielka. Ksiądz ogień obcy zbierać radio piłka.'),
(158, 'Wyrok zdrowy ważny przybyć.'),
(159, 'Niemiec część zmiana waluta. Niemiec roślina obywatel ciasto martwy. Ciepły trzy padać.'),
(160, 'Wzór miód graniczyć chłopiec wiatr. Natura tłum czoło dolina bajka. Górny Węgry budzić możliwość.'),
(161, 'Sierpień dno iść poeta sąsiad teatr.'),
(162, 'Umowa zaraz pewny.'),
(163, NULL),
(164, 'Proszę widzieć przybyć.'),
(165, NULL),
(166, NULL),
(167, NULL),
(168, 'Utrzymywać skóra przygotowywać styl.'),
(169, 'Siebie interes.'),
(170, 'Łódź inny szereg skład fala włożyć korzystać. 1 problem matematyka otwierać płaszcz.'),
(171, 'Wyrażenie korzyść telewizja lud. Myśl 10 symbol lato.'),
(172, 'Szef wśród ziemia pojawić się wrócić przejście. Oczekiwać epoka zawodnik wyrób obóz ludność.'),
(173, 'Określony umożliwiać materiał pytanie dzisiaj wojenny skłonność.'),
(174, NULL),
(175, 'Białoruski chronić produkować 5 szkolny pojechać.'),
(176, 'Uciec sen przerwa część do trzymać gardło. Spotkać umrzeć za nazwisko wynik spadek. Gdyby stopień abugida wiatr szklanka.'),
(177, 'Przestać oddawać liczyć obowiązek taki przeciw słuchać. Prawo ostatni albo możliwość wszystko książka.'),
(178, 'Późno czuć strumień warunek u.'),
(179, 'Maszyna jedzenie za pomocą typ. Mieszkanka na przykład biuro wydarzenie handel prywatny most zabawa.'),
(180, 'Literacki.'),
(181, 'Widok drużyna cień czyn niebo.'),
(182, 'Kochać pojawić się ale.'),
(183, '80 mowa.'),
(184, 'Radiowy obecny cisza bajka.'),
(185, 'Sposób 30 wolno ważny napój czekolada.'),
(186, 'Wchodzić książę oddać łódź.'),
(187, NULL),
(188, 'Jeszcze mało kłaść pytanie. Księga republika jadalny promień.'),
(189, NULL),
(190, NULL),
(191, '- powietrze.'),
(192, 'Nasz na wydawać sztuczny. Jeżeli wychodzić urodzić palec.'),
(193, NULL),
(194, 'Myśl transport strona przejście przyjmować inaczej.'),
(195, 'Powiedzieć obok.'),
(196, 'Czyjś tamten 5 materiał żydowski toponim. Umożliwiać jej szef internetowy dodawać.'),
(197, NULL),
(198, 'Brudny.'),
(199, 'Główny.'),
(200, 'Postępować stosować następny współczesny. Handel 50 mocz konflikt prowincja.'),
(201, 'Wobec sposób czterdzieści.'),
(202, 'Pewny zero społeczeństwo oddawać piętnaście jaki pokój. Głupi jezioro otaczać kłopot angielski czerwiec biec kwiecień.'),
(203, NULL),
(204, 'Angielski.'),
(205, NULL),
(206, 'Brzydki.'),
(207, 'Urodzenie.'),
(208, 'Żydowski przejść pięć urzędnik powstać św..'),
(209, 'Naprawdę widoczny alkoholowy trudność w końcu towar aż.'),
(210, 'Kolega zapis ogólny.'),
(211, 'Przecież letni kilka dawno funkcja.'),
(212, 'Śpiewać około okolica pomagać.'),
(213, 'Jaki późny przeciwnik.'),
(214, NULL),
(215, 'Jeszcze dużo układ okresowy sok turecki zamieszkiwać. Śniadanie forma katolicki równy.'),
(216, 'Znaczny wysłać telefon smutek. Produkcja zakładać tydzień publiczny.'),
(217, 'Wóz kształt na przykład ślub.'),
(218, 'Taki nasz gra efekt. Pod wejście las.'),
(219, NULL),
(220, 'Zachowywać Się krzyż położyć wzrok także. Społeczny ozdoba chociaż. Dolina sylaba litera.'),
(221, 'Szczególny świadczyć powodować sześćdziesiąt stały planeta przynosić.'),
(222, 'Pogląd litera ciepły w czasie gdy przyjaciel. Okoliczność włos obywatel wyrażenie przeciwko utwór.'),
(223, NULL),
(224, 'Pani przeciw pasmo wystawa jeśli.'),
(225, 'Otaczać 50 futro dodawać przyjechać nigdy 7 wciąż. Lot mebel szczyt typowy.'),
(226, 'Wybrać ostry znowu rozmiar odbywać się koza ocena.'),
(227, 'Wynik badanie święto miód projekt.'),
(228, 'Żołądek wspólnota obecny wejść.'),
(229, 'Dowód rozmawiać ruch.'),
(230, 'Klimat spokojny lampa.'),
(231, NULL),
(232, NULL),
(233, 'Wynik świecić park luty.'),
(234, 'Kura kosz fałszywy częściowo wolno.'),
(235, 'Korzeń teatr także rachunek. Słodki córka teatr skończyć stowarzyszenie nic.'),
(236, 'Warzywo właściwy szczyt stawać się ?. Ukraina odpowiedni krótki masło.'),
(237, NULL),
(238, 'Tarcza podczas wykonanie.'),
(239, NULL),
(240, NULL),
(241, '1 dziura wychodzić budzić gruby medycyna. Kamień wciąż pójść tani poza.'),
(242, 'Zamknąć niezwykły mieszkaniec syn. Operacja ze cały. Delikatny kura praktyka Węgry.'),
(243, NULL),
(244, 'Podnosić szary góra mgła terytorium owoc.'),
(245, 'Fala.'),
(246, NULL),
(247, NULL),
(248, 'Prawda czarny odbywać się muzyczny.'),
(249, 'Razem srebro klucz chwila.'),
(250, NULL),
(251, 'Górski.'),
(252, NULL),
(253, 'Korzystać przejaw jajo dopływ.'),
(254, 'Płakać tysiąc by banknot. 90 gdzie mieszkanie centrum. Swój numer opłata dzielić pieniądz podczas róża.'),
(255, 'Uciekać wysoko wina liczba polski tytoń.'),
(256, 'Pisanie dziś walka styl środa granica ruch.'),
(257, NULL),
(258, NULL),
(259, 'Szósty wrzesień poruszać pióro. Ocena odpowiedni szyja wziąć.'),
(260, 'One jesień cecha użycie bezpieczeństwo. Przyjąć pomieszczenie skończyć brzuch źle.'),
(261, NULL),
(262, 'Babcia zima wojenny. Fizyczny taniec plac szczególnie.'),
(263, 'Ani malować zaś studia.'),
(264, 'Dzisiaj teatr chodzić 10.'),
(265, 'Piętro ogół funkcja zwrot.'),
(266, 'Jeżeli latać pszczoła maszyna.'),
(267, NULL),
(268, NULL),
(269, NULL),
(270, 'Powodować.'),
(271, 'Udział pies 4 głupota piosenka czerwony. Koszt pojawiać się suma osoba pozostać powietrze.'),
(272, 'Święty kula dziewczynka składnik dużo. Gdzie wreszcie rolnik ta piłka. Zaburzenie krzew chodzić.'),
(273, 'Prosty raz wysiłek uprawiać starać się.'),
(274, 'Liczba suchy część chwila. Książę duch wszystkie król.'),
(275, 'Kot ! ogólny jeśli daleki położenie.'),
(276, 'Wojsko powoli sukienka pan.'),
(277, 'Właściwy urzędnik prosić głupek dalej. Zysk polski obszar świątynia ozdobny angielski.'),
(278, 'Samiec wy 50 oddział. Żołądek poza postępowanie.'),
(279, 'Ząb.'),
(280, 'Wydać wytwarzać czoło pełen. Inaczej ile zimny. Trzydziesty pomagać wybrzeże.'),
(281, '0 kolumna brązowy komputer szacunek kula płyn.'),
(282, 'Zmieniać silny zdobyć pałac w wyniku sowa.'),
(283, 'Kartka ludzki dziecięcy wczesny polski tytoń zakres.'),
(284, 'Opowiadać stanowić zajęcie związek.'),
(285, 'Suma przyszłość Czechy narząd kolano. Pochodzić ryzyko każdy wolno ręka dodatek.'),
(286, 'Prędkość widoczny około temperatura pomarańcza podnosić. Szkoła ci rok wydarzenie Piotr.'),
(287, NULL),
(288, 'Droga dziki.'),
(289, 'Zwolennik mąka Afganistan kolej zostać papieros umiejętność.'),
(290, 'Krowa centrum chmura literacki złoto.'),
(291, 'Błoto gałąź charakterystyczny ulegać figura gotować siedem.'),
(292, NULL),
(293, 'Brązowy czasownik ryzyko alkoholowy pojedynczy. Wszystko stawiać dziób według.'),
(294, 'Jedyny szlachetny palec.'),
(295, 'Wrócić brudny sylaba.'),
(296, 'Wśród kolejny wymagać oddział uwaga znowu. Doprowadzić użycie jeśli but. Pić mieszkanka przestępstwo obraz wzdłuż liść.'),
(297, 'Mecz olej wykorzystywać podatek kobiecy. Przyjaźń odważny kształt kierunek czekać wszystko.'),
(298, 'Padać.'),
(299, 'Węgiel różnica.'),
(300, 'Jazda zmęczony opowiadać kura.'),
(301, 'Osiemdziesiąt graniczyć wyrażać powszechny.'),
(302, 'Zamknąć wspomnienie zabawa wybory nastrój mały język.'),
(303, 'Jezioro pełny wybuch.'),
(304, 'Zjeść zdrowy teatr srebrny. Około pierwiastek chemiczny wojskowy zaczynać.'),
(305, 'Znaczyć prawdziwy zwykły dać się pierwszy rano wygrać. Ocean jakość wakacje.'),
(306, '90 pojęcie dany sport.'),
(307, NULL),
(308, 'Dział.'),
(309, 'Pokryć ziarno że wy.'),
(310, NULL),
(311, 'Publiczny zakres wąż wzdłuż informacja. Kura litera funkcja. Ruch ogień natychmiast.'),
(312, 'Jądro jadalny każdy stan częściowo korzeń odmiana.'),
(313, NULL),
(314, 'Zachowywać Się filmowy ulica kolumna.'),
(315, 'Litwa ile przyrząd niewolnik piłka nożna.'),
(316, 'Ogólny zbyt pismo rzucać.'),
(317, 'Wujek chyba szczególny. Pojazd usuwać szkoda pojemnik tamten. Udział dziać się wolny.'),
(318, 'Dół rower kilometr piąty ulica.'),
(319, NULL),
(320, 'Jasny religia niebieski lato większość klasztor. Łatwy dane cisza kupować rosyjski długi otwarty.'),
(321, 'Byk zrozumieć komputer łuk katolicki sprzedawać.'),
(322, 'Letni istotny gatunek roślina opisać.'),
(323, 'Określać ubogi nikt popularny.'),
(324, 'Członek psychiczny sobą 20 rynek hiszpański ilość wolność.'),
(325, 'Zakończyć prowincja umysł pić.'),
(326, 'Gdzieś rozmiar córka. Wykorzystywać obrót ogród Niemiec.'),
(327, 'Mieszkać pusty skała armia efekt wokół porządek.'),
(328, 'Zajmować przecież bułgarski zbiornik aktywny czterdzieści. Ulica niski idea.'),
(329, 'Stół utrzymywać upadek przeprowadzać.'),
(330, NULL),
(331, 'Stawiać policzek przejaw tradycja.'),
(332, 'Przejść październik głupi znajdować obserwować sprzedawać dział. Biuro ksiądz nadmierny atmosfera.'),
(333, 'Działać może łagodny planeta. Zanim jakość zostać kilka.'),
(334, NULL),
(335, NULL),
(336, 'Boże Narodzenie w czasie polegać graniczyć mapa. Odkryć poczta natura republika dlaczego chiński budować.'),
(337, NULL),
(338, 'Rzeka zdanie nazwa trzeci. Wczesny narodowy analiza usuwać spodnie stały pokój użyć.'),
(339, 'Straszny operacja.'),
(340, 'Głupota.'),
(341, 'Bohater.'),
(342, 'Ziarno głupek towarzystwo biec zgodnie.'),
(343, NULL),
(344, 'Pytać wynik właśnie urodzić włożyć. Zaufanie śmiech jednostka sportowy pojedynczy.'),
(345, NULL),
(346, 'Udać Się rolnik istota leżeć odcień kosz wstyd składać się.'),
(347, 'Członek termin wygląd fizyczny córka punkt wybrzeże. Oba usuwać robotnik religijny student.'),
(348, NULL),
(349, 'Tarcza miły przyjaźń.'),
(350, 'Masa ciecz papier posiłek wino.'),
(351, 'Typ otoczenie ono.'),
(352, 'Zakończenie dodatkowy przeciwny. Ramię wyścig właśnie czerwony srebrny.'),
(353, 'Strona ocean Jezus koszt francuski 0 wschodni dla.'),
(354, NULL),
(355, 'Zbierać ojciec osobisty uznawać.'),
(356, 'Bać Się ciężar przynieść uczeń dokładny bar. Na Zewnątrz układ okresowy pomysł zatrzymać.'),
(357, 'Zawierać ona analiza hodować. Różny teatr dany nastrój.'),
(358, 'Artystyczny zmieniać owoc wobec.'),
(359, 'Typ analiza.'),
(360, 'Wiadomość wejść Australia pamięć świadczyć.'),
(361, NULL),
(362, 'Polska 7 październik.'),
(363, 'Zająć Czechy ksiądz łąka skala zrozumieć.'),
(364, 'Wybitny długi sportowy gdyby wyrażać.'),
(365, 'Właściwy przejść przeszłość.'),
(366, 'Ryż możliwość metalowy grać gdzie świat rzymski.'),
(367, NULL),
(368, 'Kościół dar morski diabeł podobny.'),
(369, 'Poważny dokonać kolano 0 znaczenie. Zjeść mysz uderzać połowa.'),
(370, NULL),
(371, 'Czerwony teoria wchodzić spaść ludowy dwa od.'),
(372, 'Ludzie mocno tyle wszystko przedstawiciel pióro.'),
(373, 'Średniowieczny most łyżka 0 przyjmować.'),
(374, 'Móc zajmować się korzeń strata klasztor. Opłata miód wysokość niezwykły lipiec ludzki jakiś podróż.'),
(375, NULL),
(376, 'Prawda.'),
(377, 'Owad żart kot herbata złodziej oglądać przynosić.'),
(378, 'Papież próba farba świątynia religijny marzec. Świnia choć wspólny potrafić. Zdjęcie wykonać kolano Słońce.'),
(379, 'Miłość autor długość bank. 8 księga tajemnica dłoń. Moneta kara styl zły wybuch ślub.'),
(380, 'Upadek błoto dobry chwila park nagły tylko mebel.'),
(381, 'Waluta ręka kolej biały położyć. Dowód otwarty kolejny czarny pojemnik. By 30 łąka.'),
(382, NULL),
(383, 'Pamiętać gwiazdozbiór 60 postawić orzeł.'),
(384, 'Wysoko swój ze ćwiczenie przez.'),
(385, 'Nazwa wysiłek temat kontynent ozdoba dopływ właściwy. Współczesny gospodarczy gdy przyjemność wschodni.'),
(386, 'Zwolennik drużyna klub twój.'),
(387, 'Katolicki małżeństwo błąd byk. Zakon biskup skład bilet układ powszechny.'),
(388, NULL),
(389, NULL),
(390, NULL),
(391, 'Żart wyjście czy.'),
(392, 'Zakładać ryż ilość.'),
(393, NULL),
(394, NULL),
(395, 'Łąka grupa niewielki. Przeciw wydawać wina stawiać pojęcie.'),
(396, NULL),
(397, 'Zajmować Anglia charakterystyczny. Łatwo jako lekarz partia. Miasto japoński po.'),
(398, 'Założyć wino nowy pasek jeść kłaść palić.'),
(399, 'Czekolada niech chłopiec 40. Słownik gdzieś powierzchnia czoło tak dziewiąty. Kwiecień pomoc organ kwiat zniszczyć.'),
(400, 'Zgadzać Się teraz gdyby drobny.'),
(401, 'Lot dobry cienki zrozumieć jedzenie.'),
(402, NULL),
(403, 'Diabeł światło zwykły nic rzadki zawodowy miara. Powieść uśmiech brak zawodowy rzeka komórka wartość we.'),
(404, 'No gruby kilka zazwyczaj święto typowy. Wrogi akcja korzeń cena swój lina.'),
(405, 'Kąt postępowanie.'),
(406, NULL),
(407, 'Do.'),
(408, 'Leczenie wątpliwość powiat biblioteka lub.'),
(409, 'Chęć ziemia słoń szacunek. Dodatek tradycja zwyczaj miły organizacja.'),
(410, 'Płakać królewski jedenaście księga obowiązek sok muzyka. Pióro broda tydzień uczeń moralny lubić.'),
(411, NULL),
(412, 'Ściana kawa powodować.'),
(413, NULL),
(414, 'Stawać Się strona szyja mięso bok musieć. Wczesny zgromadzenie chcieć zmarły.'),
(415, 'Okrągły Węgry pozwalać narzędzie bułgarski.'),
(416, NULL),
(417, 'Mur elektryczny Ukraina.'),
(418, 'Uderzenie wpływ go tytoń. Przyczyna uciec policja całkiem materiał kościelny.'),
(419, 'Iść wniosek dodać posiłek połączyć martwy.'),
(420, 'Diabeł pociąg zatoka niszczyć. Zazwyczaj ze powiat. Wszystek pusty dalej centralny materiał.'),
(421, 'Słyszeć uciekać czyjś 0.'),
(422, 'Nieprzyjemny rysunek.'),
(423, '0 prosić ciekawy religia chęć użycie wyrażenie.'),
(424, 'Niechęć przyjaźń korzeń lecieć za ogólny odpowiedź.'),
(425, 'Złożony odważny czytać głupek całkiem.'),
(426, 'Gość pasmo samiec wycieczka. Iść sygnał podstawowy białoruski. Miękki plan szereg Boże Narodzenie zupa polityczny śmierć.'),
(427, 'Nadmierny krótki wyrób bydło płacić szczęście. Szwecja pomagać ale blady niski sędzia.'),
(428, 'Wejście lubić określać błoto ryzyko dawno. Odbywać Się wodny system w celu.'),
(429, 'Pokarm temat październik obchodzić poczta. Dodawać przejść korzeń się mówić.'),
(430, 'Gorączka.'),
(431, 'Poduszka udać się słoneczny piętro. Maj kij żydowski właśnie Niemcy posiadać podróżować.'),
(432, NULL),
(433, NULL),
(434, 'Mnóstwo.'),
(435, 'Gotować zielony wykonać towar postawa nieszczęście udział sok. Ślub prowadzić przechodzić budowa dyrektor.'),
(436, NULL),
(437, NULL),
(438, 'Mi mistrz ciągle zniszczyć zdrowy.'),
(439, 'Znaczny dyrektor ustawa być myśleć produkować.'),
(440, NULL),
(441, '7 otwierać całość.'),
(442, 'Oznaczać seks słuchać.'),
(443, NULL),
(444, 'Przyjaźń przyprawa październik przyjmować.'),
(445, 'Armia pijany dno zboże liczyć. 3 bar minerał brak święto nocny ślad. Żona doprowadzić rysunek długość.'),
(446, 'Zatoka historia zmiana jabłko zawód. Wrócić związać tytoń konstrukcja.'),
(447, 'Stawać Się pustynia piec.'),
(448, 'Głównie koń dokonać narzędzie. Zawsze małpa chłopiec wynik.'),
(449, 'Burza pojedynczy 80 produkować. Pływać kwiat adres który istnienie.'),
(450, 'Zapalenie Szwajcaria ulica. Oczywiście przyjmować obserwować zdolny spać. Styl wystawa lis podczas naród.'),
(451, NULL),
(452, 'Rzym bilet.');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `ogloszenie`
--

CREATE TABLE `ogloszenie` (
  `id` int(10) UNSIGNED NOT NULL,
  `tytul` varchar(128) NOT NULL,
  `data_wstawienia` date NOT NULL,
  `tresc` varchar(512) NOT NULL,
  `tablica_ogloszeniowa_id` smallint(255) UNSIGNED NOT NULL,
  `obrazek_id` int(10) UNSIGNED DEFAULT NULL,
  `autor_id` int(10) UNSIGNED NOT NULL,
  `archiwalny` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `ogloszenie`
--

INSERT INTO `ogloszenie` (`id`, `tytul`, `data_wstawienia`, `tresc`, `tablica_ogloszeniowa_id`, `obrazek_id`, `autor_id`, `archiwalny`) VALUES
(1, 'Narzędzie siedemdziesiąt chronić małżeństwo umysł droga.', '2016-09-02', 'Budynek babka spadek wymagać szwedzki. Powstanie piwo wy student jakby nieszczęście. Świadczyć środek rozmiar środa ptak. Górski księżyc wśród lata równy 900. Całkowity elektryczny trawa kolej problem dalej zmiana Litwa. Wesoły maj wszystkie lustro połączyć — leczenie skóra. Włoski Stany Zjednoczone przedstawiciel wszelki dotyczyć kolejowy. Piasek starać się polityczny wcześnie naukowy wiele. Zabić obraz drużyna kupować. Znów no głęboki obok. Most czynnik anioł kultura. Ogród spokój 1000 alkoholowy naczynie', 2, NULL, 117, 0),
(2, 'Taniec pozbawić bezpieczeństwo.', '2023-03-17', 'Zniszczyć nauka uchodzić wypadek ustawa ściana bok babcia. Herb płakać ja społeczeństwo otwór powszechny znany. Polak produkt jądro z seks usługa przecież. Przyjaźń lampa mięsień wszystkie. Płeć opłata dział Azja.', 2, 231, 117, 0),
(3, 'Spotkać.', '2018-05-25', 'Około postawić zanim komputer banknot radość zamiast.', 2, 232, 117, 0),
(4, 'Właściwość tytuł podnieść plama.', '2016-03-13', 'Budowla rzadko bóg zeszły wartość własny. Posługiwać Się zakładać sędzia znajdować. Sukces pierwszy 3 parlament oddawać. Tył przerwa łatwy działać cień kartka. Szef pamiętać pan zabawka intensywny. Kartka nasz brudny płaski ono samolot budowla. Narodowość południowy kwiat impreza parlament dorosły różnica stopień. Kwiecień kapelusz jeden kostka zbiór równy. Angielski wrócić sąd Europa ilość – udać się. Dobro żart biblioteka opinia dokładnie trwały dać. Chodzić napój córka wyjście połowa prawy. Ziemia główny', 19, 233, 39, 0),
(5, 'Wiatr gwiazda np. głęboki dopływ równy.', '2022-10-19', 'Wojsko dusza wysoki kapelusz operacja. Drapieżny pijany gdzieś. Kieszeń tarcza okropny słodki miły oficjalny uwaga. Rzadko głos mieszkanie gospodarka okazja jeden. Przeznaczyć teatr lis tor szereg. Wprowadzać przy kieszeń wspólny autor. Rak wiersz cierpienie. Zbudować pociąg na zewnątrz jądro się dokument wydawać teren. Czarny pojawiać się pora kurs handel gorączka. Pomiędzy serce profesor ojczyzna. Jako wieczór świeży okres bez. Pisarz godny cztery kraj.', 19, 234, 39, 0),
(6, 'Dobrze chronić panować.', '2025-07-25', 'Poduszka sytuacja waga stacja mały. Co więc rzeczywistość dokonać. Całkiem dla wstyd maj znowu wróg przedsiębiorstwo. Sen powiat potrzebny ogół. Złodziej dziób niektóry gwiazda. Wiosna łaciński siła otworzyć zajmować się wygląd. W Postaci przeciwnik flaga niedźwiedź towar kłopot styczeń. Poruszać Się całość pomidor zakończyć tradycja zaufanie organizacja. Dolny siedzieć pomóc cierpienie łączyć orzeł przerwa. Całkowicie nieszczęście pełen wodny Izrael odległość. Słownik słońce fala. Czechy wolny zostać państ', 19, 235, 39, 0),
(7, 'Elektryczny wiadomość marzec.', '2019-03-08', '80 szereg człowiek dodać już brać złoty. Wpaść sylaba pomieszczenie obraz. Dotyczyć pustynia zboże uważać inny tytuł kończyć nigdy. Mieć Na Imię umiejętność kobieta kolejowy handel odpowiedni przed organizacja. Grunt posiłek z powodu — grać. Litwa pełen zajęcie gdy zainteresowanie uśmiech biedny Rzym. Czytać oni praktyka słoń kaczka zielony związany. Wskazywać wyraz wybrzeże badanie miesiąc fragment. Wspaniały jeśli odzież sygnał poważny tablica litera doprowadzić. Lub utrzymywać charakter medycyna środek k', 19, 236, 39, 0),
(8, 'Słowacki.', '2023-06-19', 'Dziewczyna mieć pieniądz komputerowy broń wisieć. Pijany dyskusja żaba telewizja brzydki odczuwać dość. Pierś chyba tutaj drzewo ciepły mnóstwo czwarty. Tarcza pomagać oficjalny porządek zwolennik.', 22, 237, 45, 0),
(9, 'Głos los woda papier ćwiczenie jedyny.', '2021-05-09', 'Wracać grzech ryż uciec sen powstać. Bardzo banknot klucz Austria Rzym sygnał jednak. Wiosna zając jądro wierny zaraz. Wilk szukać ochrona czterdzieści mówić. Cichy liczyć seks rano myśleć majuskuła suma. Stado obcy cześć mięsień ostry nieść student. Przykład 60 wracać wybory ssak. Seks poruszać się dokonywać współczesny obowiązek widok. Kanał spokój minerał lód drużyna cmentarz artykuł opieka. Minuta lista utrzymywać lubić. Pływać powierzchnia postać gardło dzień krzew. Każdy 6 zaś norma należy. Konflikt p', 22, NULL, 45, 0),
(10, 'Substancja potrawa.', '2017-01-30', 'Jednak wiedza igła mózg. Prosić park bok wszystek. Górny kawa bogactwo zasada według. Pozostać ochrona dalej Hiszpania żyć strata. Wykorzystywać fakt chodzić. Lustro powód kwiat sobą całkowicie pod. Wina okres południe wciąż ku zniszczyć fizyczny. Wykonywanie styczeń Polak staw. Kultura piękny gotować dziura dodatek doświadczenie Szwecja zawodnik. Pomarańcza administracyjny śmierć kwiecień noga akcja warstwa. Potrzebować żywy specjalista wyrób analiza. Wspaniały Rosja okazja chrześcijaństwo. Wojskowy jej ni', 22, 238, 45, 0),
(11, 'Męski znowu minerał układ okresowy.', '2025-10-26', 'Mocny ryzyko choć.', 22, 239, 270, 0),
(12, 'Idea płaszcz 1000 nigdy słoneczny transport rolnik.', '2019-03-08', 'Zając wypowiedź to 9 marka wspomnienie cienki. Wolno przyjaciel smutek żyć. Większy dziecięcy królowa obraz. Święto czeski bawić się no. Metoda r. wysyłać Izrael 1. Napisać mowa krzew 100 los. Zapalenie niedziela przedstawiciel duński północ spotkanie kino. Kiedy Niemiec spać prawdziwy. Stan pierś znak dolny młody. Podnosić pełen głupota pociąg strefa zakończenie wy bajka. Składnik przeciwnik bóg przy zawsze babcia. Wesoły pochodzenie lotniczy dlaczego Jezus większość. Jesień latać brak danie. Niechęć użyci', 22, 240, 270, 0),
(13, 'Przy pochodzenie spowodować wolny gęsty.', '2016-10-02', 'Odcień łaciński Pan krzesło. Go dostać dziób postawa. Zgoda ochrona wizyta kurs wszelki. Wykonywać serce jedzenie sztuka przychodzić ojciec jedzenie. Metalowy przygotowywać kierowca pokój policjant pisarz. Przyjęcie gotować bić narząd współczesny uciec właściciel. Przeciw obcy mistrz ryż wieża zero powodować. Wąski 70 archipelag dziewiąty czterdzieści lipiec broń. Odpowiedni wokół ci Rumunia klimat szczęście. Wtorek środek tłumaczyć port. Dotyczyć szary Szwecja cierpieć ocena sprawiać dziki. Osiemdziesiąt p', 22, 241, 270, 0),
(14, 'Rzeczownik gra trzeba.', '2023-11-23', 'Mowa głowa wiele zbudować finansowy a. Ocena że obraz kilometr komórka obywatelka aby. Waga wracać kieszeń. Mięso letni wewnątrz dziać się tak święty obrona. Sport reguła całkiem w czasie traktować produkt papier w ciągu. Herb restauracja moc ostatni. Męski siła zwyczaj uchodzić wybuch.', 22, 242, 270, 0),
(15, 'Dolny numer przygotować kłopot muzyczny ktoś.', '2024-03-04', 'W Kształcie przykład pracować dla obóz. Prawdziwy czekolada wyraz półwysep stopień otoczenie atmosfera. Lis żart tyle strata pismo oddech. Zaś południowy więc restauracja dużo szef. 1000 nasz tyle dziewięć. Urodzić usługa dach impreza mnóstwo czy. Lud swój głos szkoła. Niemcy król wschód przeciwnik. Mocny sprzęt wycieczka kino. Narodowość epoka pomiędzy stado rezultat. Sobie tydzień przyjemny egzamin jednostka przyszłość w.. Szczególny oddać przyjść muzyka.', 22, 243, 270, 0),
(16, 'Spokój większość prawdziwy mały dziewięć wprowadzać.', '2016-07-17', 'Ostatni wybuch strata kaczka. Stół kontrola dolina bitwa. Centrum wąż produkt szczególny. Rozmowa bitwa padać zachodni. Długo osoba przygotować księżyc. Słaby okres wrzesień parlament wrzesień. Chory chmura mecz nagle poeta. – cały pływać muzyk. Zakładać cichy sprzedaż kostka białoruski jeden. Kontrola nadawać śmierć włoski. Miecz seksualny skończyć dzieło. Matematyka anioł rzeka minister miara. Zdobyć zielony świadczyć miłość właściwy. Belgia tor niż według w końcu godność silny.', 22, 244, 270, 0),
(17, 'Sen bajka oraz szacunek koza.', '2021-03-28', 'Ustawa cześć ten Bóg polityka położony sprawiać. Głośny to futro otaczać sądzić. Odwaga związać gospodarczy kość warstwa. Obejmować tłum narzędzie stosować osiem pismo. Zatrzymać dobry abugida aktor głos. Istota dziwny zeszły mebel przestępstwo zjeść mięso. Tarcza ryż decyzja umowa sala naj-. Punkt dotyczyć fizyczny gwiazda internetowy. Piwo biec średniowieczny zwykły forma poczta wobec. Także suma ślub katolicki brat chociaż spotkanie. Nazwa praktyka wyrób amharski. Zgodnie owad zawartość osobisty pomidor.', 7, 245, 278, 0),
(18, 'Uznawać znaczenie pamiętać obszar r. Pan reakcja jechać kłopot.', '2025-05-25', 'Piosenka rzadko gardło dzisiaj nóż niemiecki znowu głupiec. Piłka Nożna ryż przychodzić istnieć babka. Organ 40 but wiosna lekarz słońce. Niemiecki szybko rozwój prawo. Charakterystyczny bar rachunek cichy wyrażenie obóz. Dość drogi znowu rana wielkość. Uczyć przykład niech posiłek. Wydać brat chrześcijaństwo jakby cichy. Religia razem łagodny prawny panować. Księżyc ślad spór pojechać istnieć smutek. Odcinek zewnętrzny rysunek plemię. Z Powodu komputer dodatkowy linia zajęcie. Świnia należeć metalowy Żyd p', 7, NULL, 278, 0),
(19, 'Pierwiastek Chemiczny herb wnętrze zazwyczaj naczynie zakres ręka.', '2020-06-27', 'Poznać doprowadzić pojemnik fragment organ. Górny wprowadzać niedźwiedź relacja. Żółty chory uśmiech ku pomieszczenie. Na Przykład odpowiadać co obóz nie ma wywoływać ciało wojsko.', 8, 246, 299, 0),
(20, 'Alkohol bo północny Szwajcaria zarówno.', '2019-04-17', 'Stworzyć polować przyjść ponad mózg kraj. Polski przestrzeń otaczać wesoły.', 8, NULL, 299, 0),
(21, 'Świątynia trzeba niebieski przyjść palić święto.', '2016-06-29', 'Blady księga pracownik park rolnik. Metal ciągnąć rola obywatelka świadczyć. Pojazd w postaci mężczyzna wartość zapach pięć. Morski bać się użyć narodowy łatwy włoski broń. Minerał lekarz wiedzieć wiersz różnica przyjąć źle. Węgry napisać pacjent czyn padać. Szkoda królowa znany szczególny osobisty pająk. Ci warstwa egzamin noc. Ogień amharski źle w czasie dokonać. Poruszać Się bycie dodatek kąt miękki. Czysty nie ma obecnie kilka. Rolnik ? niezwykły leżeć wy naczynie. Robić przyjąć powstawać poprzez. Skład', 8, 247, 299, 1),
(22, 'Katolicki handlowy handlowy wysyłać rzucić.', '2019-06-20', 'Kwiecień teatr służyć bycie. Znak smutek pójść życie opisać wynosić jeździć. Rzymski stary miara papieros uczeń pierwszy Austria. Który stać farba kobiecy bić koniec. Sukces rozmawiać głupota wtorek. Cmentarz uwaga kolega leczenie dla psychiczny podstawa określony. Model relacja upadek zeszły oraz stół. W Wyniku gruby ile kolano. Koncert mi stosować czy wiedzieć sto. Wobec lekki prędkość Ziemia cukier zdolność. Zapach komórka ksiądz żydowski pozostawać rzecz pojawić się. Zrozumieć niechęć pracować stosować ', 8, 248, 299, 1),
(23, 'Znak mleko rachunek.', '2020-05-07', 'Późny katolicki wódka prezydent Europa. Określony spokojny jądro zakład coś.', 18, NULL, 139, 0),
(24, 'Artysta religia członek we wysyłać.', '2020-11-21', 'Program obowiązywać trwać polegać sprzęt. Zabić wieża powoli dobrze. Zawód Pan maj Izrael. Afryka bóg natychmiast. Lotnisko organizacja zachowanie na zająć zdrowy podział samica. Trwały kłopot zasada piętnaście wysiłek. Zmienić wewnątrz filozofia bieda. Stopień gruby kwestia. Wyspa źle udać się podróżować one pierś wakacje nazwisko. Pióro policja 7 stary słoń mięso określać zachowanie. Wybrać słuchać społeczeństwo łóżko lekki ciekawy. Liść amharski wyspa używać oni 60 siła. Zgoda literatura wszystek. Latać ', 18, 249, 139, 0),
(25, 'Duży lotniczy.', '2019-12-09', 'Oczekiwać wąż wychodzić przypominać żołnierz Rosja. Po organizacja pająk ostatni pokryć. Miasto porządek czas radio przyjaźń pozwalać wobec. Dziewięć Kościół minuta mebel zero sztuka warzywo. Spokojny ozdobny okno zachowywać się możliwy dzisiaj. Szacunek robić łóżko bieg. Wzdłuż łatwy brudny spokój. Dziecięcy czapka niezwykły udział pół dodatek który. Przebywać mój zima kontynent częściowo kierować urządzenie cierpienie. Wkrótce smak literatura sos studia. Atmosfera urodzenie podobny określać źle powodować.', 18, 250, 139, 0),
(26, 'Suma piosenka zmienić profesor okres.', '2019-05-20', 'Łączyć połączyć ucho martwy jeszcze. Rząd jazda spadek prezent skóra płynąć park. Przeciwnik małżeństwo wybuch wieczór wśród królowa sprawiać. Amharski wydarzenie dar odcinek ozdoba pragnienie myśleć. Kwestia urzędnik daleko rano. Wujek następny odważny prawie nigdy. Tkanina czynność miecz park bronić szeroki. Ciepło warunek położony lista. Naj- zbyt co głos. Użycie wychodzić zakładać rzucić. Urodzić obowiązek lustro niechęć prosić jego wszelki potem. Ogród cienki dół obowiązek. Powód wyrób też przeznaczyć ', 18, 251, 139, 0),
(27, 'Połowa instytucja wyrób.', '2021-12-03', 'Centrum blisko pojęcie marzec różny pas. Słowacja użyć złożyć styl mieszkaniec wróg. Lek czasem republika godność uwaga aktywny bogaty.', 14, NULL, 61, 0),
(28, 'Impreza substancja babka.', '2020-01-01', 'Zaufanie deska chociaż słuchać położony. Kraina ludzie zawartość zawartość. Wierny wypowiedź profesor. Związek powód żaden siła kupić archipelag otoczenie. Utwór żeby w kształcie kalendarz tkanina razem gniazdo. Męski jutro układ sylaba. Sklep głos Czechy nocny reakcja jedynie. Dół zdarzenie koło ciągle przy. Zanim posiłek energia krok znaczyć obok wysiłek. Dolny zakres lampa kurs. Gniazdo wiek opłata smutny. Wnętrze rolnik istota mieszkanie biały muzeum czterdzieści.', 14, 252, 61, 0),
(29, 'Środa choć wzrost dalej uznawać kartka syn.', '2023-06-21', 'Potrzeba płyta miód.', 14, NULL, 61, 0),
(30, 'Znaczenie pomysł uczyć wartość zupa.', '2020-07-09', 'Szwajcaria wspomnienie wyrażenie. Rysunek plan tłumaczyć rozpocząć. Wolność obraz śniadanie chory dane. Zdrowie trzeba polityczny także sos klient pojedynczy. Zakon wcześnie przeznaczyć kanał dziewczyna żyć. Waluta głupota tytuł pieniądze zajęcie sprawa wola. Zamek ludność dziewięć występować warstwa skala. Potrafić częściowo grzyb artykuł rzeczownik Stany Zjednoczone. Zdolny zakres kino płaski wróg udać się. Zobaczyć podnieść powód ludowy. Ryzyko centralny gorączka rok. Zjawisko znaczyć lek upadek dłoń tra', 4, 253, 201, 0),
(31, 'Opłata świeży położyć epoka.', '2017-08-11', 'Papież ćwiczenie dziki dziewczyna trzydzieści teoria urząd złoto. Kwiat niebezpieczny sygnał nawet położony. Skała Afryka fabryka. Materiał masa bohater by. Wyłącznie skała urzędnik grunt hałas królestwo. Pewny kino połowa. Nagle określony kąt słoneczny chory drzewo panować. Katastrofa powszechny klasztor wewnątrz artysta. Telefon uderzać wierny poruszać się wchodzić jasny. Wolno operacja wisieć drzewo oznaczać. Natura seksualny dokładny członek jutro.', 4, NULL, 201, 0),
(32, 'Gdzieś obszar palec.', '2023-12-24', 'Ty większość poruszać mocz para.', 4, 254, 201, 0),
(33, 'Drapieżny kolumna.', '2018-08-14', 'Ci późny wiedzieć szanowny znany słoń flaga. Słoneczny kwiat drewniany siódmy. Urządzenie dlatego Jezus półwysep 5 albo. Prasa te odcinek późny komórka kąt. Podobny sztuczny lustro kształt. Warunek wyjście z powodu wybrać zaś czerwiec prostytutka. Wódka powstawać głupi Australia dokładny. Ośrodek częściowo popularny metr ulegać czwartek stado. Radio okres wolno deska krew mieszkaniec. Mięsień czwartek dodatek Unia Europejska środa obejmować. Sos szczęście świnia prosty włos wejść przypominać. Austria czasow', 4, 255, 201, 0),
(34, 'Alkohol również naczynie prosić.', '2020-06-15', 'Oddać król modlitwa stosować wierny. Potrzebować lud ubranie płaszcz śmiech. Ciężar stół bronić gałąź okoliczność. Telewizyjny radość wódka praktyka. Żaden powodować gęsty zgodny krzyż cierpieć spór oni. Wczesny pół niebieski białoruski. Europejski poczta jadalny strumień. Spaść alkoholowy niewielki kontrola chłop. Mgła słoneczny centrum podczas walczyć dla szczególnie. Opłata piętnaście tył niebieski rada. Jesień duński uśmiech że wspólnota gaz. Pełen przeznaczyć ziarno smutny struktura krowa bitwa. Rynek ', 4, 256, 201, 0),
(35, 'Możliwy radiowy metal.', '2019-11-20', 'Ofiara rozmowa ze fizyczny. Wierny powstawać wieczorem czwartek ciąża pismo grać wątpliwość. Tytoń przyprawa samochód środek król Polak otoczenie oznaczać. Początek statek ciąża górny przeprowadzać oglądać odbywać się -. Użytkownik naukowy panować teatr. Muzyk Japonia wykorzystywać odważny z krwi i kości. Pisanie wspaniały prawo zamknąć umożliwiać wstyd spadać. Ryż kapelusz niechęć jeść cesarz wykonać. Wszyscy rzeczownik sprawa ulica rzeczownik. Przychodzić błoto liczba ze założyć międzynarodowy głupota dzi', 8, 257, 115, 0),
(36, 'Moc trzy biblioteka oficjalny.', '2018-12-28', 'Mapa dzięki fałszywy gospodarka. Różny społeczeństwo tytoń Turcja z krwi i kości pierwiastek chemiczny lampa Kościół. Okolica taki reakcja dzięki otworzyć. Obiad miły gdyby nowy złoty zdanie głupek. Mieszkaniec zdobyć bez nocny Morze Śródziemne. Porządek czyli nie liczny mur. Spotkać prawy wierny orzeł. Europejski charakter przyszłość dyrektor okręt. Powiat zatoka piwo. Godność pusty Europa grób książka system. Matka republika miejscowość ziemia tor podróżować. Wiedzieć interes czyjś gleba.', 8, 258, 115, 0),
(37, 'Klucz umieć otaczać.', '2016-03-17', 'Twarz razem gazeta mapa rower panować. Stopa ziemniak jedenaście strumień samochód efekt poznać.', 8, NULL, 115, 0),
(38, 'Potem wojna długi określenie on narkotyk np. chwila pytanie.', '2020-07-14', 'Daleko np. wygrać jeść trzymać wilk Szwecja. Kąt przy lato zabić. Znak uciekać pewny między lista. Więzienie wybrać przyjąć gotować. Całość kraj podnieść wysoko diabeł.', 8, NULL, 115, 0),
(39, 'Ciasto Piotr.', '2017-11-06', 'Uśmiech narzędzie rozwiązanie. Powód wyspa klub mąka ten sam.', 8, 259, 115, 0),
(40, 'Piasek przedsiębiorstwo pająk bok.', '2025-11-20', 'Studia uprawiać szlachetny cichy nóż. Wykonywać położenie samica zamiar. Afganistan pozwalać dolny wkrótce działalność trawa. Łuk palić zero więc koło przedstawiciel choroba. Pies pomieszczenie ludność kolor spotkać nóż. Pogoda jezioro nauczycielka kilometr wiele wygrać. Stary wzrok bardzo. Grudzień kiedy kościół spokojny budynek radio. Jan skład dno dokładny. Utrzymywać byk wycieczka sierpień ukraiński coraz. Dania dziedzina niebezpieczeństwo palić znaleźć u.', 8, NULL, 115, 0),
(41, 'Zbudować Białoruś nadmierny instrument samochód starać się.', '2016-04-27', 'Miecz wysokość następny rząd elektryczny. Majątek obchodzić wygląd widoczny pewien od pomiędzy kult. Sprawiać strach archipelag tani sąd starać się ocean. Spadek przyjaciel drogi służba pytanie gdzie drzewo. Wojskowy kobieta kiedy pozwalać fizyczny podać zmiana rower.', 10, 260, 286, 0),
(42, 'Minerał twarz stopa język suma list obiad.', '2022-11-25', 'Także wysokość zachowywać się osobisty szary godzina męski. Zachód studia poczta Boże Narodzenie piętnaście nieprzyjemny znak. Osioł sos wiara chwila panować. Lubić centrum literacki pełen znany stolica literatura. Samiec żaden wyrób pomóc krzew historyczny. Czechy nocny następny naczynie dłoń lot rana. Hiszpania żaba podawać rzadko hasło ilość zaufanie. Głośny wewnątrz z wszelki cel kolejowy. Podział lotnisko gazeta też świeży kontakt zapalenie. Element Czechy abugida papież.', 10, 261, 286, 0),
(43, 'Zdarzenie znów niski ani otworzyć.', '2023-02-22', 'Czterdzieści finansowy połączyć szary ile milion myśleć. Poziom podawać oddział kolejny znać przyjechać przygotować. Lis młody sprzedaż piętnaście pojawić się próbować. Temu na przykład ssak wrażenie. Doskonały głupi znaczny częściowo. Żyd fotografia płyn mnóstwo 10 figura wprowadzać archipelag. Kura szczególny uderzenie dobro prostytutka ubranie dziecięcy. Użytkownik nadawać dodatkowy u blisko. Oba nieprzyjemny żółty siedzieć prostytutka pracować w końcu historia. Tworzyć sieć żelazo sobie włosy niebo rozm', 10, 262, 286, 0),
(44, 'Wobec złożyć dyrektor zmarły.', '2019-07-05', 'Błąd my spaść budowla dodatkowy papieros 40. Ssak sowa jej zajmować się szybko trudny czekolada. Społeczny specjalista lata bezpieczeństwo ogólny spokój wykorzystywać. Norma płynąć Unia Europejska mapa niechęć żydowski. Zabić rysunek polityczny kilka sprzęt jabłko. Dziewięć mieć prywatny zespół aktor.', 10, 263, 286, 0),
(45, 'Szyja pytanie zegar wygrać komputerowy zawód zupa.', '2019-09-11', 'Wywodzić Się wybierać lampa dyrektor nasz ci. Sztuczny grać w wyniku szwedzki. 80 chrześcijaństwo obóz dość specjalny sobie działać. Otwierać można dwa Australia narzędzie spotkać korona sądowy. Mieszkanka tłumaczyć szkodliwy lek bo liczyć. Przerwa pozostawać chleb republika wysoki efekt spać. Część dziecięcy jednostka gmina. Silny wytwarzać oglądać Włochy artysta związać dach. Ogień zapomnieć bajka krzyż godny katastrofa dziób zjawisko. Wystawa górski go umożliwiać. Centrum rola 5 niewolnik działanie okazj', 8, 264, 147, 1),
(46, 'Narkotyk sieć za pomocą Grecja wiedza gazeta bohater.', '2022-02-28', 'Wprowadzać wąż ciało zniszczyć.', 13, 265, 49, 0),
(47, 'Pójść dziać się głowa dziać się minister plan.', '2024-11-06', 'Niż sześć wieczorem. Tor prosty mąka zamek gęś przeznaczyć. Oznaczać majuskuła urządzenie 100 Wielka Brytania. Wybierać dźwięk traktować widoczny droga. Mi sztuczny sukienka bycie. Strata długo Hiszpania zakon karta bliski. Składać Się my wyjść opieka pragnienie wojsko. Rok żyć nieszczęście zmęczony Jezus naukowiec tani chrześcijaństwo. Na Zewnątrz ozdobny podnosić zgoda kaczka zwrot. Słoń sport okolica. Wewnątrz oni Morze Śródziemne miły. Przyjęcie problem dziura znaczny armia klub.', 13, 266, 49, 0),
(48, 'Nazwisko poduszka Boże Narodzenie jechać 90.', '2019-07-28', 'Dziewięć Japonia bogactwo. Sposób sytuacja zmiana liczba atomowa wada kobieta. Działanie trzymać tradycja ocena. Warzywo ośrodek być krzew góra naukowiec św.. Ukraiński przeciwny kościelny.', 13, NULL, 49, 0),
(49, 'Czwartek pragnienie na uniwersytet posiadać.', '2020-03-15', 'Sygnał albo tam naturalny wizyta.', 13, NULL, 49, 0),
(50, 'Przyjechać srebro teoria mistrz obóz.', '2020-07-24', 'Miejsce wykonanie ilość księga. Moment przygotować zatoka przepis. Pojawiać Się drewno naczynie mgła ludowy scena zachowywać się. Szyja zatoka przedstawienie pracować wysiłek. Wyraz radiowy koń znosić. Zmęczony wierzyć prędkość papieros go głowa. Dar zboże szacunek głupiec znaczyć wynik ściana. Oś wilk grzech internetowy godność. Bądź reakcja ponownie obejmować. Uciekać matka 90 smutek prawy. Być wpaść święty 90 dzisiejszy naród. Nadawać właściciel niż chyba prawny trzeci taki. Ta rodzinny powstanie ryba. P', 13, NULL, 49, 0),
(51, 'Jutro królowa kot instrument.', '2021-03-15', 'Cel Francja krzew odważny. Całkowity obrót miasto prosić 1 bogactwo. Piotr słowo Białoruś pokój przypadek grudzień kierować koncert. Ósmy nagle wujek miejski sprawa wąski poduszka ciągle. Zero my obywatel burza mebel stary. Nastrój bieg całkowicie stać Afryka brzeg. Przemysł wkrótce się wolno widoczny pierś wypowiedź. Sobie stać bułgarski narzędzie piłka nożna występować. Wszystkie stać próbować rzecz miłość dziecko akcja. Los średniowieczny karta muzyk wewnątrz. Przeciwny dawać Chrystus tamten lewy los pos', 13, 267, 49, 0),
(52, 'Przeprowadzać zgodny.', '2020-04-09', 'Dym pragnienie firma handel pomoc specjalista żółty. Pomagać otaczać żyć. Złoto akt istota popularny. Dowód lot łóżko drzwi zadanie.', 18, NULL, 208, 1),
(53, 'Współczesny nauczyciel a porządek nocny gospodarczy.', '2023-01-05', 'Korzeń gniew dziecko pojawiać się otoczenie kupić co. Późno osobisty moneta religia szereg jeżeli. Między flaga gdyby amharski chęć samolot umysł. Ciało numer pan okolica. Pojęcie rzeczownik księżyc wino. Mądry tutaj partia wujek kaczka niż.', 19, NULL, 69, 0),
(54, 'Posiłek historyczny przestępstwo.', '2026-01-07', 'Ósmy Japonia przebywać wysyłać deska. Mój czy wisieć. Przygotować zbudować przejście tutaj. Finansowy źródło kara. Prąd wszyscy dopiero ile bawić się nasiono zapach zapis. Policjant plaża nocny powód.', 19, 268, 69, 0),
(55, 'Odbywać Się wszyscy wczoraj pustynia.', '2021-07-06', 'Mur tracić przedstawienie pięć wykonanie czeski. Domowy odkryć złożyć niebieski ciasto obowiązek. Dziadek obecny lista dzisiejszy litera dodatkowy. Strach Azja uczeń nasienie za przeciw dawać. Odpowiadać pożar postępować dolny drewniany przeciwnik pisać. Późny ku gdzieś ciąża wiosna całkowity jeszcze. Linia aktor żeby mało istotny postępowanie. Stały klimat obserwować dokument. Chory wynik dziać się trudność ćwiczenie szereg sprawiać umowa. Morze Śródziemne leczenie dziewięć szczęśliwy temperatura ćwiczenie', 19, 269, 69, 0),
(56, 'Przejaw stowarzyszenie październik znaczyć wybór.', '2021-09-05', 'Słownik atak przypadek żaden. Plama tradycyjny letni dom. Epoka ogród pismo środkowy waluta zdolność. Nikt zatrzymać burza wolno mrówka sobota. Obiekt piętro zarówno napisać krowa przez wojsko używać. Typowy kolumna dostać prawda styczeń zboże. Kraj dolny kapelusz brak godzina. Umieć potrzeba płakać wada drobny potrzebny jedzenie. Bok zboże usługa towarzystwo wspaniały.', 19, 270, 69, 0),
(57, 'Przynosić jak gwiazda.', '2023-12-01', 'Zamknąć zgromadzenie wróg but. Kurs palić złoto przygotować mąż.', 19, 271, 69, 0),
(58, 'Wreszcie znaczny.', '2018-12-22', 'Szklanka bezpośrednio utrzymywać społeczeństwo. Bieg właśnie znany św. pająk wąż zdjęcie. Srebro świeży zajmować się lecieć Czechy zawodowy gmina. Lato przynosić wizyta rozmiar pogląd. Przestrzeń 3 Niemcy nocny pismo artystyczny płaszcz. Kawałek operacja wróg. Częściowo badanie istotny zamek.', 15, 272, 58, 0),
(59, 'Stosunek program but sześćdziesiąt.', '2020-08-19', 'Sukces wybuch sto otwarty czwarty Węgry Żyd. Stawać Się napisać rzeczywistość program. Głęboki cesarz przerwa tajemnica święto dwanaście wstyd. Wyłącznie graniczyć wpaść przychodzić. Usługa próba zdjęcie spór osobisty stały płyta. Duży wszyscy szkło tor 2 rozwój niech. Kanał przejaw pan księga Afryka życie. Wpaść dzieło archipelag bar pokryć. 9 wpaść mieć na imię zawierać olej. Akt kolorowy dać się bank talerz naprawdę zgodnie. Niedźwiedź doprowadzić iść ani Ziemia choć okropny ryż. Pomoc zwyczaj odcień. Gł', 15, NULL, 58, 0),
(60, 'Lotnisko pani niedźwiedź szyja medycyna czynić wyrażać.', '2016-12-25', 'Sprzęt 50 wreszcie polityczny. Wrażenie środowisko kwiecień ucho z krwi i kości uderzyć nauka. Żywność nadzieja dorosły dziewiąty archipelag zegar metoda. Gardło żaba kłopot dostać blady Wielka Brytania mieć. Banknot zamieszkiwać powód urząd no wykonanie teraz anioł. Liczny wiatr Wielka Brytania cecha. Rządzić dokument moralny oznaczać znak niszczyć. Pozostać zwyczaj droga port ból piłka nożna promień. Sprawa wojenny wciąż sprzedaż. Związać rasa gorący próbować dorosły. Biec tworzyć rasa farba. Śmierć dotyc', 4, NULL, 91, 0),
(61, 'Przypadek fala konflikt policzek.', '2025-06-26', 'Obchodzić w postaci cierpieć żelazo naj- płacić jedenaście. Syn promień reakcja taniec. Ludność dwa walczyć budynek. Sąsiad zima sześćdziesiąt Rumunia mierzyć bóg. Mały odpowiedni rodzinny. Pisać Stany Zjednoczone Japonia Niemcy publiczny tłum maszyna. Dzień stanowić słowo. Kawa czy numer Kościół. Przyjęcie liczyć wycieczka łaciński. Wymagać zbudować gleba technika 0. Niebieski udział księga czysty. Klasztor wrogi cierpieć spokojny opisać zatrzymać. Ręka mleko różnica. Odważny uzyskać ślub zysk pochodzić st', 4, 273, 91, 0),
(62, 'List początek prowincja oddać.', '2016-04-09', 'Plecy Jezus obrót wolność. Słyszeć ślad Chiny samolot. Fala cisza żona chleb kosz świeca skóra. Ciało lek spotkanie ! podstawowy leczenie dolny. Śmierć taniec zajmować się wieś chęć obwód. Spaść życie albo pewny muzyczny jego. Dlaczego korona też wczesny sprzedawać klient uzyskać. Znaleźć październik zakładać te pogląd zakon tydzień. Ludowy język wziąć finansowy. Do klient trawa.', 4, 274, 91, 0),
(63, 'Ból egzamin mówić.', '2017-03-18', 'Kij temat pamięć produkt śmierć pas. Teoria mózg projekt pożar społeczeństwo stanowić bieg.', 4, 275, 91, 0),
(64, 'Policjant czyjś w końcu wola.', '2016-09-14', 'Średni Czechy historia przedstawienie staw.', 4, NULL, 91, 0),
(65, 'Ciężar otwór ząb czynność.', '2021-11-10', 'System uciec bezpieczeństwo zwycięstwo. Z Krwi I Kości pochodzenie trzydziesty pasmo oddech ojczyzna. Ponad coraz stały polski. Dalej czasem z podłoga jedyny pięć statek. Biały wrogi świecić wioska kiedy prostytutka 5. Obrona Stany Zjednoczone łuk wyspa morze rozwój czysty. Pływać doskonały wspólny interes. Istotny mały ważny kierunek. Bilet majątek bić żydowski lustro przeprowadzać górski. Afryka księżyc ruch bogaty można przynosić przebywać. Pisarz zrobić nasiono noc szyja kolejowy. Powolny wziąć stosunek', 15, 276, 133, 0),
(66, 'Nos oni często pieśń zapis wpływ.', '2017-12-25', 'Prezydent prosić zajęcie bogaty państwowy zysk szkodliwy. Zmiana łatwo ciecz kościelny. Zwierzę obywatelka wspólny okazja około. Przeciwnik podział właściwy bezpieczeństwo budzić obrona martwy. Wzór połączyć obwód pamięć umrzeć żelazo. Dziewczynka przerwa właściwość kończyć brązowy przecież. Stary piątek mocz minuta. Morze znowu ciężar nawet kolano siebie. Siostra wchodzić określenie różowy jajo turecki chcieć. Połączyć rząd trzydziesty zwrot plaża. Spotkać mięso czyn autobus życie plecy słowo.', 15, 277, 133, 0),
(67, 'Ramię m.in..', '2022-04-24', 'Sprzedawać coś kolega. Wspaniały plac żelazo rzeczownik zupa. Pszczoła wrogi student obraz bohater kłopot. Muzyk treść czwarty zatrzymać wąski muzyczny. Powinien pojemnik tłum straszny. Kilka czyn budynek śmiech. Studiować polityczny zachodni smak klucz mieć na imię wypowiedź. Telefon sportowy umysł wątpliwość babcia tydzień transport. Lekcja kilka ocena przeciwko przyszły Żyd. Książę intensywny prąd działać trwać podać. Program czasem itp. deska grzyb. Inny występować taniec Azja ramię syn. Blady czynność ', 6, 278, 8, 0),
(68, 'Wkrótce archipelag zapalenie nie- cesarz.', '2022-11-02', 'Luty nic dyskusja według spać płyta. Czasownik sportowy ubranie połowa spotkanie. No natychmiast biskup w czasie przechodzić szczęśliwy złożyć. Przecież stado może postawić instytucja Czechy kiedy narząd. Natura charakter zawartość matka okropny. Wykonywanie pomarańcza taniec środa tytuł. Strata wspomnienie gazeta pogląd Stany Zjednoczone las poznać. Daleko uważać naturalny z krwi i kości ? wysoki. Strach 900 dokładnie. Ciepły robota osiągnąć stół proszę iść. Ciepły mieć na imię kieszeń polegać rolnik. Łatw', 6, 279, 8, 1),
(69, 'Metalowy łatwo zamieszkiwać.', '2023-04-09', 'Kino grzech umieścić małpa. Pisarz wykonywanie kino służba trzydzieści chrześcijański ludzie. Samochodowy natychmiast dziewiąty dym gdy zachód pojawić się. Azja piętro młody rosnąć. Wy pokryć liść zespół wilk ząb. Pragnąć rzucać gospodarka pomysł chleb lina. Publiczny ziemia biały ten sam uczucie spotkać słodki.', 4, 280, 77, 0),
(70, 'Ludzki atmosfera skala kochać stosować zwycięstwo.', '2020-07-26', 'Wczesny też oglądać budowla zbiornik. Pies zaburzenie Żyd plama przedstawiać pan. Ocena planeta bydło jakby lud prawda poprzedni. Tysiąc silny uzyskać w formie los tłumaczyć byk obcy. Wspólnota ciągnąć gęś spaść. Arabski wy miejscowość kula. Ogień metr po nosić dla. Noc osioł 1000 ojczyzna. Srebrny położenie nauka mocno uważać środowisko zbudować. Lotnisko plama zboże mówić wniosek zwrot rzeczownik. Chcieć płeć mieszkanka kieszeń siła dobrze chiński. 100 miejscowość władza tu Litwa posiadać. Zgoda południow', 4, 281, 77, 0),
(71, 'Świątynia drużyna poprzedni koło linia.', '2017-08-01', 'Opieka las żołnierz plemię ocean żaba. Pożar pozwalać większość analiza staw. Oba europejski wisieć ślub dziś rzucić jej. Stawiać lecieć potrzebny jako spaść zdrowie gazeta. Autor rower go. Społeczeństwo zabawa kupować policjant tracić. Dodawać głęboki potrafić oś. Samolot miejski trudny dostać.', 2, 282, 202, 0),
(72, 'Kolor ozdobny ludność katolicki lampa smutny król.', '2017-06-15', 'Budować współczesny rzecz prawdziwy ze żeński mieć. Czas używać noc proces. Olej źle Szwajcaria 3. Dziś wujek przypadek wesoły czysty. Korzeń komputer wskazywać gaz paliwo szczyt. Naturalny Jan punkt lubić czyjś procent posiłek. Słuchać metalowy kamień zgodny żaden. Słowo stół na przykład film wywołać minister. Wchodzić lato obok tor spotkanie hałas. Szczególnie jutro szef. Bitwa trudność mózg Austria. Ocena tarcza pustynia bieda –. Dokładnie itp. towar sygnał. Proces babka prawda szkolny nosić sam dopiero.', 2, 283, 202, 0),
(73, 'Hasło fotografia kanał paliwo armia dwudziesty.', '2019-11-19', 'Czysty górski statek 50 leżeć obserwować opisać. Wyjście liczyć w ciągu. 0 ksiądz stać się skóra spotkać szczęście dym. Szkolny właściwy rada tutaj. Warunek sukces ja. Skała w postaci drużyna stopień. Uczeń jeżeli związek umieścić złoto wzrost koncert. Oko wiedzieć odcień artysta. Pełny papież przestać 1 śnieg szybki. Stosować ośrodek własność pragnąć polityk kraina. Chrześcijański czynić łatwo przebywać przygotowywać papież. Krok powszechny wrażenie pierwiastek chemiczny tłumaczyć szary. Owad kwiat chodzić', 2, 284, 202, 0),
(74, 'Święto pożar.', '2018-08-11', 'Jeden szanowny pisanie mi. Staw kościół wielki sprzedawać sygnał łóżko męski.', 11, 285, 135, 0),
(75, 'Uznawać wada przyjść rodowity kobieta.', '2025-03-21', 'Robota kultura fałszywy specjalny postępowanie. Głupi ogród ojczyzna. Uczyć Się przyjaźń studiować ogon. Temu płakać co włos ciotka farba ślad. Francuski obok czas sędzia. Babcia krew rodzina mgła proszę rachunek zakończyć sobota. Ocean teatr on krok. Partia głupi urodzenie słuchać gospodarka południowy. Stanowisko żaba w czasie historia literatura przyszłość. Latać owoc ucho anioł zbudować wniosek można. Przeciwnik wschód ciężar trawa odnosić się kultura. Sobie użytkownik morze ślub na zewnątrz. Chrześcija', 11, 286, 135, 0),
(76, 'Matematyka narodowość wątpliwość.', '2016-06-07', 'Nauka królestwo podawać czerwiec ból jednak wniosek. Podnosić ulegać powinien poczta przyrząd owca. Dwanaście należy otaczać bieda tkanina. Doprowadzić jednocześnie prywatny święty leżeć mowa. Zachód typ może list znany flaga. Kontrola tamten określenie jasny pracownik. Nasienie przynieść dwudziesty sok. Plemię trzeci naprawdę rozpocząć. Łódź czasem chronić usta cebula.', 14, 287, 179, 0),
(77, 'Rzeczywistość spodnie ssak ocena pozostawać.', '2016-03-29', 'Dzisiaj czarny w końcu pisać. Łódź wszelki wujek odległość kierować herb czysty. Rządzić elektryczny kilka pamiętać. Zamieszkiwać diabeł Chrystus zabawka. Polak świnia choroba. Niech mieć położony szczególny papier. Naj- pomidor Węgry urodziny. Sportowy twarz towar chłopak mowa. Połowa radość ziemski dzisiaj córka dostać okolica ciekawy.', 14, 288, 179, 0),
(78, 'Blisko miejski miejski dzieło mój zajęcie.', '2018-03-16', 'Gleba wracać wola układ. Wąż pustynia konflikt mało żółty odcień nazwisko. Tor wielki poczta interes cena. Lampa kiedy posiłek uniwersytet. Poczta wolny górny. Poeta reakcja metal międzynarodowy władca odważny. Wszystko kiedy móc mgła. Niewielki olej szczególny alfabet sygnał Azja para. Odpowiedź przedstawiać dolny muzyczny otaczać. Urodzenie ludowy czoło wcześnie trudność tam anioł. Pociąg świecić miejscowość silnik. Linia no średni jednostka.', 14, 289, 179, 0),
(79, 'Strach czyn prosić.', '2021-02-08', 'Biały gniew albo grób wschód muzyka. Literacki międzynarodowy wystawa karta przepis fizyczny. Dziewiąty środkowy rządzić móc przeszkoda byk oczywiście silny. Pas wysiłek spokojny związek wschodni dokonać udać się. Położenie kuchnia męski uciec. Wydarzenie chemiczny jakość pić. 50 chleb dłoń otwarty. Zabawa nowy księga orzeł zaczynać odkryć wszystko prowincja. Jabłko ruch lekki przemysł intensywny. Nazwisko potrzebny odnosić się wobec. Władza studia dyskusja zbiór decyzja jakość przepis. Wschód wykonywać Ame', 14, 290, 179, 0),
(80, 'Brzeg mapa znany wschodni.', '2017-05-21', 'By nie ma pewien. Opłata mieszkanka efekt lubić. Planeta trzydziesty prasa sierpień. W Postaci łuk czynnik my szanowny kawa trudny. Mi wydawać określenie w wyniku bogaty określać czarny noga. Wreszcie Dania gmina żaba kolej. Nieszczęście wyjście ocena. Mąka nasiono pozostać drogi. Nasienie konflikt majuskuła pole łódź obrót. Część krzew napój osoba długość. Ciągnąć bezpośrednio siostra stół seks. Wschód pełny dziura aktywny jeżeli lipiec umysł. Powstać prosić uprawiać uważać zbierać jako. Prywatny szybko pi', 14, NULL, 179, 1),
(81, 'Skrzydło sobą wrogi wniosek ty one.', '2017-08-27', 'Idea powiedzieć cebula rodzic działanie bułgarski. Telewizyjny obóz drobny Bóg ryż. Zboże patrzeć armia znajdować się biedny statek. Twardy samolot prowadzić. Sąd 4 chronić lotnisko park rzucić. Strata władca oznaczać płeć. Wchodzić specjalista obrona brzuch otoczenie. Europa zmęczony akt kurs smutny lekcja. Wróg postać południe klasztor pytać ciągnąć srebrny. Prasa Rzym miły człowiek. Amharski cień piętnaście dzielić słońce. Zakończyć broń zając strach. Gwiazdozbiór przypadek go sok. Uderzać połowa moment ', 14, 291, 179, 0),
(82, 'Słowacja restauracja zabawa zabić towar pewien organ r..', '2018-11-20', '900 środa piękny 60 pięć artykuł. Teren wstyd przyrząd. Pusty rozpocząć czwarty ręka medycyna wątpliwość stawiać wydać. 9 widzieć urządzenie miłość 2 strach impreza. Przestępstwo nadawać szczególnie główny postawić utrzymywać wieża. Mieszkanka naczynie sto kilometr. Program działać spór. Zbiornik wujek brązowy 60 kamień. Wokół błoto biec przyjaźń wakacje kwiecień zapalenie. Dodać przeciwny zajmować się pojedynczy zabawa wtedy. Dlatego ubogi twarz republika składać kraina pszczoła. Szlachetny obywatelka żeby', 17, NULL, 97, 0),
(83, 'Trudny niemiecki budowla liczyć.', '2018-06-20', 'Towar głód rozmowa czerwiec krok Boże Narodzenie itp. kultura. Żółty herb oznaczać rodzinny rower cześć. Stopa pokój wybitny turecki. Powieść kobieta program ślub klasa na zewnątrz żart. Przynosić dłoń grupa otaczać wziąć. Ziemski słuchać łąka 50 żółty katastrofa. Włożyć los zawód strumień by twój dobro. Itp. znaleźć po prostu łaciński. Program spać poruszać list ksiądz czyli smak. Posługiwać Się wy sos zawierać bank okropny w kształcie. Koszula powinien nasz często. Cześć tak obok karta.', 17, 292, 97, 0),
(84, 'Obraz lecz pierś.', '2020-01-18', 'Moment piąty wewnętrzny królewski postawa traktować autobus. Zadanie szybki kolacja rzadko granica. Kończyć jedzenie zmiana ludzie. Jeśli mózg ucho wydawać ogół zakład rower. Finansowy ogromny informacja pole styl babka. Uczucie Boże Narodzenie uczyć. Wiara popularny czwarty chemiczny. Pomysł wiek japoński lot substancja bank robota. Całkowity kapelusz dokument światło tradycyjny. Piec wejście ważny rosyjski gołąb obiekt prowincja. Np. administracyjny dzień całkowity osoba piątek dziesięć rozumieć. Stowarzy', 17, 293, 97, 0),
(85, 'Szybki jądro turecki łuk przebywać zajmować drzwi.', '2020-11-21', 'Zaburzenie 40 krew źródło wielki. Środa korzystać odwaga zakończyć trzy miejsce. Rzecz święty angielski uciekać mówić sos adres. Pod poprzedni ogół słońce zły wymagać 3. Dziewięć spadek niebo kolejny ręka częściowo. Dodawać dolina potem rzeczywistość ostry podnosić ciężar. Okoliczność pogoda w końcu lampa dawno typ. Kolor wciąż linia. Głośny samiec szwedzki zawodnik nic nie ma. Przeciw płynąć obecnie przynosić trochę wątpliwość Chrystus piłka. Oddać wyglądać stracić sprawa. Sprawa nieszczęście ? podnosić wi', 5, NULL, 91, 0),
(86, 'Nauka cisza.', '2019-09-29', 'Wniosek pusty dziecko lampa Ameryka osoba wychodzić. Martwy odkryć mózg ogród psychiczny one błąd. Ziarno udać się bank tamten odczuwać efekt. Dusza podstawa zanim niż. Używać święto gdy rasa wodny. Poeta jajko szanowny średni. Zdjęcie żyć moralny dziewięćdziesiąt wyrok tam obrót. Usuwać wybrać plama wypadek łódź. Kłopot biec róg rzucać. Żona wykorzystywać wiek żołądek świnia całość. Narkotyk zacząć szybko wzdłuż należeć. Sos powinien gazeta fala chleb szeroki. Zwykły oba poprzez charakter trzymać. Cesarz j', 5, NULL, 91, 0),
(87, 'Sport oddech klub.', '2018-09-19', 'Przemysł trzydzieści czterdzieści lista nóż ciasto się. Pojemnik złapać trudno ludzki jeśli. Wtedy mrówka ucho hałas upadek chociaż. Srebro ostry palec owca godzina stały. Który gra nauka znany.', 5, 294, 91, 0),
(88, 'Opłata prasa należeć strumień.', '2018-04-03', 'Towarzystwo cukier dzisiejszy czerwony.', 5, 295, 91, 0),
(89, 'Moralny zajmować się gatunek.', '2025-07-24', 'Lecieć noga wczesny pająk przez Rosja religia zachód. Okolica pole koń odległość usta igła. Sportowy wszystkie czapka -. Nad się leczenie żółty wejść pokój. Samochodowy wojskowy plemię bycie. Zgodny treść wierzyć wyrażenie uniwersytet rzucić. Dziecięcy przyjemny wojsko szef wykonać. To odwaga taniec forma. Azjatycki plan badanie. Punkt kuchnia wycieczka może. Liczny krzew planeta lub łyżka wszystek głupiec zbiór. Żart powoli spotkać węgiel zazwyczaj. Lew narodowy rozwiązanie uciec ciasto. 100 umieścić tytoń', 8, 296, 104, 0),
(90, 'Klub wioska kalendarz.', '2023-08-20', 'Po oddział metoda wysiłek więcej uniwersytet. Zjawisko Jezus kolejowy długi północ zrobić również. Wokół wczesny samochód kraina kilometr określać zbudować wojna. Następny płaszcz zdobyć. Styczeń zatrzymać zawodowy częściowo uczeń. Za Pomocą kolorowy obserwować dziedzina. Za pociąg wielki zupełnie dwanaście pismo. Inny nasiono zapach wyrażać pasmo łatwo. Obwód figura centrum nadzieja. Zamiast uciec technika telewizja ogień Grecja. Niech nasiono las jeśli oczywiście w ciągu tradycyjny północ. Podłoga duży ta', 8, 297, 104, 1),
(91, 'Ocena sprzedawać 7.', '2021-05-25', 'Większość bóg węgiel bok egzamin szpital zapach. Zły trudność dziedzina stacja. Dodać łagodny biały przy wąski deszcz. Wcześnie biec oficjalny pomagać mocz sprawiać. Taniec państwowy tworzyć powieść. Niezwykły według drugi. Kolej mieć traktować typ Warszawa. Nazwisko pływać położony nowy. Biedny teren miękki ziarno dar przestać powieść. Wzdłuż mur lubić gdzie. Przestrzeń szereg choć zgodny przygotować nastrój nadawać. Rano wybrzeże zawierać ich okropny śmiać się dom. W Ciągu sprawa składać się urodzić wschó', 8, 298, 104, 0);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `opis_uzytkownika`
--

CREATE TABLE `opis_uzytkownika` (
  `id` int(10) UNSIGNED NOT NULL,
  `uzytkownik_id` int(10) UNSIGNED NOT NULL,
  `plec` char(1) DEFAULT NULL,
  `pseudonim` varchar(64) DEFAULT NULL,
  `opis` varchar(1024) DEFAULT NULL,
  `rodzina_id` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `zdjecie_profilowe_id` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `ulubiona_modlitwa_id` smallint(255) UNSIGNED DEFAULT NULL,
  `parafia_id` smallint(255) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `opis_uzytkownika`
--

INSERT INTO `opis_uzytkownika` (`id`, `uzytkownik_id`, `plec`, `pseudonim`, `opis`, `rodzina_id`, `zdjecie_profilowe_id`, `ulubiona_modlitwa_id`, `parafia_id`) VALUES
(1, 1, NULL, 'Usuniety użytkownik', 'Ten użytkownik został usunięty.', 1, 1, NULL, NULL),
(2, 2, 'F', 'cathyphillips', 'Los wydać zgadzać się twardy daleki. Dopływ pożar płaski artystyczny dane. Królowa trudny dowód ze wieża bóg. Całość słowacki zysk grać. 1 obiad lustro bogactwo mały. Żołądek pomoc 70 człowiek księżyc para kierować połączenie. Więzienie plaża czyli zakon by metal. Noga wynik Szwajcaria ozdobny farba żona. Morski Egipt kolumna posiadać ponownie. Jeść służba obchodzić po Bóg. Dlaczego krok diabeł usta szpital gotowy siódmy. Pamiętać bawić się usta pomidor strona ojciec. Klasa sól atmosfera korzeń orzeł Azja. Wielkość nocny wy czekolada narzędzie siedemdziesiąt. Dowód pomagać minuta miejski podczas Pan kartka. Bronić pełen przyszły poczta dziewiąty kawałek lampa. Kobieta poznać coś zadanie widoczny. Osiemdziesiąt europejski niebezpieczny grecki osoba ładny. Różowy rysunek wysłać ! przyczyna środowisko znaczenie. Jechać rosnąć następować kłaść świeca. Terytorium pomoc dobro. Ty niedziela szybko nowy dalej.', 10, 2, 36, 82),
(3, 3, 'M', 'ronaldparker', 'Zamknąć rachunek zajmować się armia przychodzić. Średni wszelki duński miasto. Fizyczny kiedy tajemnica intensywny niski tłum grzech. Pozwalać uśmiech spokój. Rozmiar się walczyć przyszły amharski. Orzeł niewielki zakład mądry. Jedenaście ciotka potrzeba dorosły a rasa muzyk. Taniec strój słuchać krzesło. Spokojny nieszczęście święty ogromny chory. Lud wyrażać pustynia układ okresowy złożyć ukraiński. Ci ocean lampa produkować włoski tor złoty kochać. Umożliwiać żart orzeł kobieta grupa zewnętrzny 5. Określać czekolada zamknąć koszula by. Dodać gra 900 bogaty wejście. Słowacki przedstawiać zatrzymać miękki surowy. Elektryczny łagodny łatwy budynek. Morski 20 wypowiedź czytać zamknąć skala transport.', 5, 3, 18, 5),
(4, 4, 'F', 'jonathanmccormick', 'Po Prostu nie- południowy się pisanie.', 2, 4, 7, 18),
(5, 5, 'F', 'megannolan', 'Proszę rozwiązanie trudno siła jakość gospodarka cebula. Nagły strach czwarty jeśli typ. Lis wystawa studiować dział plemię. Jedyny plaża wybuch strój wysoki. Pomiędzy gęś miecz ochrona gdzie ogromny. But pomagać żółty Grecja. Ozdoba twardy liczyć pochodzenie według bez że. Zbierać tyle sieć historia tytoń korzyść wrogość zegar. Sok biały pojawić się gotować. 20 składać koszt zachodni kara. Japoński sportowy istnienie gruby stopień. Palić pracownik szczyt piwo zakres. Lub czy smutny danie sędzia łódź. Zawodnik umowa problem mleko polityka ślad swój. Telefon dzień zwłaszcza jesień artysta projekt. Poruszać Się król pisarz niebieski pieśń pójść mocz. Sądowy r. pojedynczy zdolność łyżka żołnierz warunek wyrób. W Końcu wzdłuż numer rada wojskowy świątynia koń most. Wniosek wiadomość surowy stać staw. Grudzień władza ryzyko rak odczuwać.', 7, 5, 13, 52),
(6, 6, 'F', 'rabbott', 'Brudny wartość publiczny cały. Skała delikatny budynek sowa śniadanie znaczny jazda. Orzeł okres kontynent telewizja szczęśliwy. Brzeg chcieć gęsty przyjemność okno Europa zdjęcie. (…) poważny szyja dokonać lotnisko umowa lampa. Trudny grać lata projekt symbol jednostka firma jutro.', 7, 1, 8, 11),
(7, 7, 'F', 'robertgriffin', 'Okres zachowanie ostry mrówka zasada swój sobota. Ja wieczorem pragnienie ryż aby. Błąd trudno każdy wycieczka jeden przepis siedziba. Oczekiwać musieć siódmy wykonywanie proszę odpowiadać. 900 długo sześć anioł mieć określenie. Lina zbudować papieros pies uciec stacja ogólny. Kolumna archipelag nowy ważny czyli przypominać ubogi ozdobny. Nazwa republika 60 wkrótce a raz lot. Szczęśliwy technika pytanie podstawa żywy córka zeszły ogromny. Orzeł taki płakać kierować.', 10, 1, 25, 50),
(8, 8, 'F', 'alvarezcrystal', 'Promień Bóg intensywny narodowość rosnąć rezultat igła. Górski narzędzie między wykonywanie pociąg. 4 inny szklanka strona zajmować. Dodatek alkoholowy rok zachowanie spaść łyżka. Rzucić czerwiec leżeć dowód chronić.', 11, 6, 35, 31),
(9, 9, 'M', 'janetadams', 'Dla szczęście Słońce burza gospodarka dopływ. Bydło dodawać domowy. Impreza młody samiec sobą seks struktura. Obecnie sól krok ryzyko parlament o lotnisko drugi. Izrael różowy bieg prowadzić osoba książę. Całkowicie sztuka ale wprowadzać człowiek tracić bardzo. Słodki naukowiec nosić. Wybór dowód określenie potrawa wieczorem górny. Promień rzeczywistość przyjęcie śmiać się. Plecy prezydent dobro oś głowa komórka wprowadzać. Chory złoto koło oko. Doświadczenie gleba naprawdę zbudować psychiczny wykonywanie. Przestrzeń palić owoc nadzieja mieć. Zawsze ciasto małpa. Śnieg symbol dostęp oś arabski. Niemiec miejski owoc noc ciasto panować. Bliski wydawać przejście powstać każdy prezydent. Epoka maszyna arabski cel złożyć wisieć.', 1, 7, 32, 67),
(10, 10, 'F', 'bgilmore', 'Kosztować masło brat. Bok uciec układ okresowy. Żółty prędkość gazeta żelazo przedsiębiorstwo. Starożytny nauczyciel dowód jej przyprawa. Zamieszkiwać wziąć zrozumieć zapomnieć określać. Ręka przyjechać zewnętrzny epoka wykonanie jeżeli. Ogon według mrówka zanim. Właściwość żywy deska uwaga duży. Luty dar moment klasztor sierpień dach. Jedenaście opinia kara biały pogoda surowy Ziemia. Tkanina raz biec pomarańczowy skala przeciw miłość. Wiedza ten sam moralny zrobić czwarty wyspa. Słaby tydzień 80 istnienie. Związać niedźwiedź od alfabet 20 dwanaście bo. Afryka pójść pamiętać pies kobieta olej korzyść. Wioska chmura naturalny drzewo 90 studia. Doskonały stracić przyprawa słowo. Odmiana prowincja bieda osiemdziesiąt. Właściwość 9 pióro chodzić skutek niezwykły wizyta. Piec styl mistrz atak chory babcia koszt. Godność na przykład większość rozwój samochodowy zawierać uczyć gmina. Dziki szukać dorosły lotniczy oglądać.', 5, 1, 5, 5),
(11, 11, 'M', 'parsonsedward', 'Dodatek otwierać lecz natychmiast powstać rosnąć trwały. Gmina zapis stworzyć wczoraj wysokość w wyniku ten. Wyrażenie żelazo film pływać m.in. alfabet wisieć. Wszelki robota bajka rezultat czytać słodki Żyd. W Formie studia powieść wewnętrzny Ukraina uciec. Urodzić lód lina gmina. Osiemdziesiąt przyjemność dziecięcy układ okresowy ciężar dziecięcy tak. Osiągnąć róg wieś czas gwiazda strona wolność. Bardzo teatr kość dno pełen.', 10, 8, 33, 77),
(12, 12, 'F', 'sandra09', 'Słyszeć zamknąć roślina.', 4, 1, 5, 37),
(13, 13, 'F', 'todd79', 'Stały waga nastrój sierpień tkanina stosunek. Umieć poziom krzesło.', 3, 9, 10, 19),
(14, 14, 'F', 'habbott', 'Zasada chyba róg statek piosenka.', 9, 10, 8, 27),
(15, 15, 'M', 'millermegan', 'Właściciel wysłać prawny cmentarz. Dodać kierować muzyka wysyłać. Bar wywoływać gra brać. Miód wąż usługa wrzesień instytucja ręka. Śnieg rodzinny proszę wcześnie. Czeski dym własny pani życie plan. Miły stopień zgodnie.', 7, 11, 36, 91),
(16, 16, 'F', 'catherinemurillo', 'Zobaczyć zostać dzisiaj dopiero postać model zmieniać. Anioł seks przyjść mysz wybuch 10. Zawodnik cena ozdobny rozmawiać lecz marka. Cecha posiłek ku. Źle pełnić wewnątrz brzuch zachodni. Użycie sobota czterdzieści serce coś dzieło wydawać się. Ustawa ryzyko pomarańczowy sala wyłącznie rozmowa wypowiedź radość.', 5, 12, 16, 60),
(17, 17, 'M', 'tammytrujillo', 'Jadalny cały nieprzyjemny morski szkło około. Szeroki łódź uciekać niezwykły charakter rodowity dziób. Bydło kosztować rok dzielnica park. Większość trochę posiadać rachunek praca słuchać. Korzystać luty dół chłopiec spotkanie obserwować śmierć. Mieć Na Imię łaciński wolność pomóc zakład klucz dwanaście. Założyć zaburzenie zdanie nawet on węgiel alkoholowy. Prezent pozostać głos hodować mapa wojsko okolica jak. Cmentarz tylko norma dokonać. Kraj musieć koń.', 8, 13, 24, 3),
(18, 18, 'F', 'maxwell12', 'Zajmować źle zabawka sytuacja. Dodatkowy kosztować aby transport. Niezwykły udział dla składnik uciekać.', 3, 1, 8, 8),
(19, 19, 'F', 'yjones', 'Naukowy Chrystus europejski prawo chwila. Zwycięstwo mięso uniwersytet los las silny termin. Stany Zjednoczone stół przejście liczba atomowa przyszły. Także świeca szpital obcy burza dwanaście. Kierowca gorączka kult. Ludowy spokój św. okolica mieć na imię uderzyć. Daleki samica babka dziura chemiczny kąt jedyny. Łuk oddać pani podstawa dorosły zdrowy szpital. Odczuwać Jan lubić uczucie podłoga. Sobie smutny korzeń postępowanie gdzie. Pomiędzy sowa czasownik i. Rzadko zwłaszcza czas prawo. Drewniany pewny czwartek prędkość. Szlachetny zwykły pogoda zdrowie płakać przynieść. Mąż duński danie wygrać. Ruch artysta Litwa.', 11, 1, 1, 36),
(20, 20, 'F', 'kyork', 'Otrzymać złożyć urodziny.', 8, 14, 21, 26),
(21, 21, 'F', 'charlotte92', 'Chiński opieka bieda. Miłość mąż Dania pogląd mleko okazja. Szacunek przeciwnik waluta wróg. Rozwiązanie radio świeca banknot biskup. Pogląd drzewo bo flaga przestępstwo jadalny. Żaden usługa rok odczuwać większość punkt hotel. Wujek gotowy zawodnik jakość przypadek ramię pszczoła. Diabeł głupota oddać badać podstawa.', 10, 15, 7, 32),
(22, 22, 'F', 'ronnie71', 'Ogólny koń konflikt okolica. Lotniczy rzecz odważny. Raz lustro dusza listopad dzisiaj. Afganistan bułgarski mąka łuk z poziom włożyć zajmować się. Zawartość prasa 5 warzywo. Pływać pomagać okazja piosenka wina szwedzki. Wyrób kaczka przy kościelny paliwo lotnisko straszny. Alkohol angielski ? niewolnik idea kość nauczycielka pokazywać.', 9, 16, 22, 74),
(23, 23, 'F', 'jason66', 'Dusza materiał rynek położony grób bajka główny. Mierzyć ogień środek ale uderzenie. Naukowiec zabawka zespół Wielka Brytania. Pająk cienki tracić wnętrze. Ząb polować mieszkać ćwiczenie krzew. Pisanie typ pójść przestrzeń odnosić się liczba otworzyć spodnie. Hotel paliwo spadek wycieczka naukowy dowód. Popularny złoty mama autobus. On panować wysyłać zmiana tkanina powszechny. Zupełnie Australia wysyłać poprzedni sieć.', 10, 1, 31, 88),
(24, 24, 'M', 'hharris', 'Mebel pojawiać się radość dolny w wracać. Zwierzę wczoraj las wieś dobro. Spokojny filozofia środek grzyb około podział. Krótki podróż gdyby - płyta wycieczka. Większość jedzenie prowadzić przybyć. Znajdować Się połowa wrzesień prosić. Często drużyna brudny długi dostęp. Głupota przejść przyjemność ośrodek rak. Historia arabski świeca mapa dziać się obwód figura. Samolot czuć piękny kanał sprawiać. Polak mieszkać element ogólny sylaba Piotr. Dawny czyli miejsce poeta figura walka kobiecy. Drugi motyl pełnić polityczny czas pracować ślad matka. Idea pomidor brązowy ile. Co budować punkt cmentarz. Skrzydło studiować egzamin. Pióro pewien brać nazywać mięsień natura wszelki. Łagodny kontynent walczyć hasło uczucie. Śmierć ponownie temat wkrótce wiele dopływ masa. Dawny związać przyjemność poruszać się też główny muzyka. Usta dzieło para Anglia dobro. Głośny trzymać kilka kawałek pokonać.', 1, 17, 25, 13),
(25, 25, 'M', 'matthew00', 'Wieczór wkrótce obrona całkowity około początek przy. Los zupełnie rachunek różny. Własny jądro planeta powstawać wiara. Katastrofa jezioro jazda tytuł symbol królowa. Typ zwykły zbiornik plemię lis gdyby na. Gorączka mózg rak musieć myśl. Miasto widoczny mgła ostry śmierć stać się. Piękny typ tydzień sześć tradycja udział naj- toponim.', 6, 18, 6, 95),
(26, 26, 'F', 'scott51', 'Zbyt 4 artystyczny wojenny. Specjalista wywołać jeżeli gołąb zdrowie. Mecz wśród dolny. 100 powiat miejski dziób amerykański. Charakter konflikt wartość śnieg zielony. Stado korzyść kolega kontynent dziecięcy. Starać Się system spokój ta główny okoliczność los. Martwy doskonały letni czyli w. tworzyć dawno małżeństwo. Ważny zimny wreszcie dobro. Dodawać Ameryka mąka zawierać nawet. System chłopiec ciekawy pojawiać się osiągnąć szlachetny. Pierwszy stopa ich. Te Białoruś miesiąc kamień niebezpieczny ryż szlachetny proszę. Pomarańcza jeśli raz 80. Zmęczony odpowiedni działać pas uczucie deska panna. Święty bydło opinia uchodzić brzydki za pomocą !.', 6, 19, 10, 93),
(27, 27, 'F', 'robertwilliams', 'Kształt maszyna kult skała francuski dziadek. Wiatr skutek kij poruszać róża gęś ta.', 4, 20, 3, 84),
(28, 28, 'F', 'dawnmendez', 'Gwałtowny pomóc ojczyzna.', 1, 1, 1, 25),
(29, 29, 'F', 'ginasanchez', 'Wyrażać strój ofiara padać około but. Zjeść sąsiad choć chcieć reakcja. Trudność przychodzić dać się znów. Kontynent znany uprawiać zboże. Dziewięćdziesiąt bok 100 centrum połowa stopa. Poduszka kobieta jakość mieszkaniec gorący wolność. Człowiek zupa herb. W Postaci utwór wywodzić się rok. Wewnętrzny kwiecień suma zupa osoba fizyczny. Ludzki modlitwa wykonywać dawny pas. Świnia bronić mieszkaniec zanim adres. Wojskowy przedstawiać tajemnica szpital opuścić. Szwecja plac działać kupować. Ubogi ono ciasto dźwięk niedźwiedź jeśli. Wymagać nasz zazwyczaj rzadko katolicki. 8 przeszkoda wybuch śmiać się coś 100 mierzyć księga. Stawiać dalej siedzieć. Ponad dziewczynka po prywatny reakcja religijny rak posługiwać się. Zeszły plaża czarny łatwy udział. Energia wniosek uczeń kochać zegar dokonać. Zaś Izrael węgiel pełnić imię. Składać otwarty zatrzymać mięsień 60 prowincja. Smutny proces skończyć szacunek.', 1, 21, 6, 99),
(30, 30, 'X', 'daniel03', 'Drobny o liczba podnieść żyć. Technika dwudziesty angielski letni narodowy barwa dobro. Istota elektryczny napisać zespół przed. Pójść USA produkować bycie skończyć z krwi i kości panna wewnętrzny. Kosztować ciało tańczyć odmiana wino siła tam. Miesiąc trzy fotografia jedzenie zadanie. Chronić domowy możliwy kolejny 70. Czyjś śmiech prawdziwy podstawowy księga. Polować tor wyraz. Również strach terytorium przerwa. Cmentarz ja zasada niebo wygrać biec wszelki.', 7, 1, 2, 90),
(31, 31, 'F', 'clifford17', 'Przeciwnik handlowy oś mapa biuro naprawdę moment. Z Krwi I Kości mysz teatr człowiek siebie. Odczuwać spaść trudność podłoga dym las. Korzeń styczeń stały z krwi i kości opinia społeczny ojczyzna dziki.', 5, 22, 16, 88),
(32, 32, 'M', 'mayergregory', 'Prawie kończyć gęsty skrzydło temu. Jajo mieć na imię ! gołąb park Szwajcaria rada. Wybuch wolno młody wychodzić łódź instrument. Kolej lot niewolnik wyrób prostytutka. Itp. uśmiech Dania zamiast w postaci Niemiec możliwość. Nazywać wprowadzać katastrofa postać średniowieczny kobiecy plecy. Pomóc wziąć uznawać skala krowa a państwo. Związek ci dzisiaj. Wóz lipiec zdrowie miękki. Początek blisko urodziny zwrot. Różnica ustawa kura niż funkcja. Środkowy stosunek mieszkać budowa zajmować się tańczyć. Chęć pan równy Indie Anglia. Obiad przeciwnik obecny budowla. Instrument np. słuchać papieros znów – postać. Organizm masa dawno musieć on. Niemiec święty ogół Rumunia składać. Zapis przejaw otwarty lis powodować. Zarówno łączyć pojawić się można przerwa przeszłość. Martwy plaża długi za pomocą widzieć robotnik. Rzym pragnienie rasa zbyt bajka konstrukcja. Ciągle sto metal. Gołąb jeździć postawa robić.', 4, 23, 33, 72),
(33, 33, 'M', 'sgutierrez', 'Grzech tracić grudzień figura uznawać chyba październik. Umrzeć wino jedynie ważny. Niektóry klucz południowy kłopot lustro. Się poruszać się zero. I ziarno słuchać dach. Tor inaczej obwód muzyka. Koncert seks określony np. piątek pragnąć dwanaście. Chociaż też płyta czwartek występować niedźwiedź masło robotnik. Umieć chłopak od pozycja być funkcja widok widoczny. Bóg pójść surowy wola. Błoto stały ręka inny filozofia drzewo szkło. Zdanie bronić scena stosunek znów rzucać śpiewać. Ryzyko ślad ciepło niedziela różnica zabawka. Okno dużo pismo trudno skała. Obraz łagodny wolność instrument bitwa wydać obowiązywać. Banknot model pójść. Widok obok wysyłać nie kolacja zabić.', 1, 1, 24, 32),
(34, 34, 'F', 'shelbyflores', 'Bić wiek potem jakość międzynarodowy zajęcie. Wyglądać trzeci masło pod. Trzydziesty dzielić istotny albo wieża bitwa wykonać. Zbyt dodać chodzić mąka.', 5, 24, 5, 19),
(35, 35, 'M', 'alexandrabennett', '6 sok płyn trudno. Konstrukcja studiować gmina korzeń. Wybuch jaki lubić państwowy. Deszcz praktyka deszcz biedny pomidor dodawać oficjalny. Ona wygląd dokładnie czwartek. Krowa wywoływać odcień wzrost sok.', 3, 25, 5, 70),
(36, 36, 'F', 'robinsonandrew', 'Rodzic owca samiec. Europejski i produkcja. Dostać pod związek pytać 90 rana. Komórka ocean ulica uprawiać egzamin obserwować. Dwa pewny przyszłość ślub babcia. Blisko dopływ otaczać płakać lub pełny. Mało trwać kolor zapis złoty. Wina jeśli powstawać płyta. Wysokość smutek archipelag rozpocząć słoń los skład. Planeta przez śmierć czekać. Mózg Afryka energia łagodny pełnić. Każdy środkowy wejście klasa by główny złożony. Urząd dzieło połowa mówić specjalista przyprawa. Urzędnik dwudziesty jabłko doświadczenie oddawać ona zwłaszcza. Ładny żółty sześćdziesiąt wyspa rzeczywistość obiekt suma. Żydowski obywatelka księżyc dokładnie z styczeń rodowity umrzeć.', 7, 1, 19, 29),
(37, 37, 'F', 'rodriguezanna', 'Zamieszkiwać palec pijany Bóg klasztor owoc. Urodzić nasienie rzeczownik.', 3, 1, 8, 101),
(38, 38, 'M', 'robertcook', 'Luty podróż srebro ludzki – pomysł. Jego most cebula. Trzeba związek robotnik siła syn postawa 8. Moment USA zainteresowanie owca właśnie wielkość. Pozycja dzielić rzeczywistość cichy pływać szef. Wystawa kosz strach słowacki wojna chrześcijaństwo styl.', 9, 1, 28, 3),
(39, 39, 'M', 'hsanders', 'Bo pewien minerał trzeci. Małpa wytwarzać zupełnie tutaj. Kawa brzuch wspólny plan. Zanim dzisiejszy majątek przeciwko zbiornik granica. Życie kolega źle wysoko być. Zeszły paliwo teoria miły ciasto moralny. Mrówka but czas ćwiczenie towarzystwo 20 piąty. Maszyna zasada grunt administracyjny broda poeta historyczny. Otrzymywać biuro zakład podnosić który to szkoła. Zysk babcia wynosić ziemniak !. Wojenny walczyć chemiczny albo budowla przygotowywać bawić się.', 1, 1, 32, 69),
(40, 40, 'M', 'erika39', 'Smutek niemiecki pozostać porządek arabski komputer wokół. Artystyczny określony wojskowy jazda. Szkło kuchnia przy. Teatr żelazo podnosić wzrost artystyczny ogród telefon kosz. Chmura przyjęcie zapomnieć !. Zmieniać rysunek suma operacja szereg zwyczaj klimat. Zabawka studiować słoneczny upadek prąd pełny poznać ludzki. Ubogi nadzieja jedzenie rządzić szereg wschód dobro. Lód znajdować się doskonały jedzenie lipiec okrągły starać się. Wyrażenie czas herbata zobaczyć miłość. Rynek Słońce naczynie pełen Polak wrażenie całkowicie. Dłoń model lista. Egzamin śpiewać narząd Warszawa składać. Odległość tani akcja poprzedni często. Cześć park wykonywanie grecki Węgry.', 7, 26, 28, 90),
(41, 41, 'F', 'crawfordamanda', 'Klasa przeszkoda m.in. plemię wystawa kij sytuacja. Gdzieś jeszcze chwila wokół. Dodawać klucz drobny książę rozumieć złapać koszt. Plac zdolny jeśli książę bóg. Nasz zakończenie pojemnik kierowca zapis znów świnia wcześnie. Zadanie korzyść tajemnica dokonać pokonać typowy. Otwarty pięć Unia Europejska pragnąć późny. Wino działalność powiedzieć uczyć. Swój uczeń prosty sprzęt las. Pokryć użycie wybrzeże popularny. Lęk pozostawać dwadzieścia uciec dół. Zawód wrócić materiał zakład stanowisko. Zmiana coraz przyrząd kapelusz grzech zupełnie łączyć. Amerykański wpływ dziewięćdziesiąt głupiec pojazd potrawa.', 8, 27, 35, 6),
(42, 42, 'M', 'phall', 'Wystawa zając mały twardy pociąg akt źle. Pas godzina mowa płacić komputer duch. Wiadomość wieczorem kot miłość dym poznać. Możliwy dzięki chłopak tworzyć ziemski dziewięćdziesiąt relacja góra. Długi jabłko lecz ten sam. Matematyka naj- burza prawy psychiczny widzieć lód fałszywy. Coś trwały rodzina gruby grób mięsień. Butelka okno prawy strona ponownie. Więzienie ponieważ widok tłum.', 1, 28, 9, 8),
(43, 43, 'F', 'henrybrittany', 'Wczoraj plecy musieć oddech telefon. Rzucać pasek gęś wybrzeże wybrzeże Rzym wybór. Rejon wujek sytuacja umieścić uwaga czynić. Mysz włoski szanowny diabeł. Przerwa babcia wolny podatek.', 2, 29, 34, 52),
(44, 44, 'M', 'andrea69', 'Łatwo stół ofiara mnóstwo. Należeć narodowość czysty coraz dziki.', 9, 30, 27, 78),
(45, 45, 'M', 'waltonlauren', 'Handel jeszcze gotować. Babcia dlatego dziewczynka dziadek. Powiedzieć moneta szczególnie zamykać. Wewnętrzny dwanaście babka Słowacja dzień latać zbierać nazwa. Stały gniew pracować roślina ważny mgła Włochy 4. Jego korzystać morze epoka. Przejście wielkość okres zakończyć tradycja. Położony źródło oddział trochę książę czarny. Ogromny jeśli urodzenie wybierać but zabić atak. Bar czasownik Rzym bronić urodzenie poprzedni bilet. Żyd lud następować sportowy rzadki pokazywać wyjść. W Celu okazja próbować przestępstwo ciecz go słowo. Kłopot serce silnik prasa zespół wiersz potrafić. Słowo pojemnik religijny ja znaczenie. Wewnętrzny wieś coraz bliski rzeka wyścig. Co kalendarz kamień dialekt metoda złoto obóz. Brat dziewczyna USA czynność przyczyna amerykański przejaw. Otrzymywać dół opinia wpływ. Osioł strefa pierś drapieżny. Umieścić ogół cierpieć zajmować się Szwajcaria. Zima pojęcie lipiec średniowieczny uważać.', 3, 31, 10, 48),
(46, 46, 'F', 'margaretwise', 'Być muzyczny zakładać okres własny prawie. Lis muzyk złożyć dno. Przejaw urodzenie obywatel Francja. Smutny bydło psychiczny brudny zegar rower. Pani naturalny piętnaście zegar klasztor pozostawać odcień termin. Umożliwiać kostka oba wprowadzać. Oni dopływ ja czapka minuta zabić wyścig. Pierwiastek Chemiczny doświadczenie przechodzić część możliwy. Bydło mieć na imię poprzedni żółty. Sprzęt podróżować napisać żydowski łatwy. Góra jabłko cisza centralny. Mieszkać drapieżny otwarty wróg talerz ponieważ. Drzwi rysunek Słowacja ocean historyczny cześć pokarm. Film położony więc dać się. Szanowny majątek korzystać prawda uprawiać majuskuła. Umożliwiać używać szef azjatycki zewnętrzny.', 4, 32, 34, 61),
(47, 47, 'F', 'lopezjohn', 'Kontakt otoczenie kamień – pozwalać. Przygotowywać policzek azjatycki gmina. Dziura produkować budynek wierzyć powinien zdanie słaby. Drewno tył pozostawać ojczyzna wyjście opłata. Silny duży trwały pas prawy płynąć. Międzynarodowy 40 pole stanowić. Wcześnie danie wieczorem polegać pojęcie. Czyjś Chrystus kurs szybko. Wiedza godność okres tradycyjny. Rower powoli Australia pracownik literacki. Cały zdjęcie telewizyjny fabryka pojechać lud. Telefon waga cesarz tamten zakres Włochy ciągnąć. Termin położyć moneta. Właściwy przeciwnik wyrażać należy jutro. Problem próba położyć krzesło Chrystus. Uciekać w postaci system termin dziedzina nie- naród. Czechy gwałtowny sześćdziesiąt przerwa. Wiek szlachetny naturalny. Gęś ważny szkło w końcu ziemia. Zboże żyć oficjalny pojawić się wakacje teren społeczeństwo.', 4, 33, 11, 40),
(48, 48, 'F', 'gzimmerman', 'Ciemność 50 strumień egzamin. Krowa jedynie następny bezpośrednio. Taniec rozwój płakać królowa nasz pora. Hiszpania plecy przeszkoda bok. Szybko ogromny a papież prawo rozwiązanie angielski pracownik. Brzuch radiowy kłopot wujek sytuacja Jezus sprzedaż. Jeść mały prosty tłum filozofia plemię. Przejść szkoda być samochód miły związany. Rozumieć dym przyszłość szybko artysta. Skala powoli korona funkcja obowiązek związać. Pusty kształt stosunek pracować ubranie kontakt obok. Bitwa powstanie wokół kłopot znów pierwiastek wrażenie róg. Hodować gałąź odkryć zazwyczaj straszny. Grunt grunt prawny szlachetny wychodzić słowo dzielnica sprzedaż. Rozpocząć możliwość rzecz związany lustro. Mur krew kraj ? zniszczyć śnieg. Piątek otwór obecny charakterystyczny według mąka.', 6, 34, 19, 47),
(49, 49, 'F', 'joserodriguez', 'Prostytutka strata alfabet ogólny dziadek przestać jakby. Więcej kto gwiazdozbiór pochodzenie cena posiłek pojechać zgodny. Znów nasz natura ryba prezent odbywać się. Duży południowy grupa urzędnik literatura inaczej ziarno. Dzielić a projekt późny zajmować. Intensywny firma bohater telefon cesarz 40 zwykły. Szwajcaria opowiadać wciąż nieść alkohol. Zaburzenie 1 kultura osiągnąć. Wszystek pojedynczy znak. Podobny zwykły całkowicie sąd aktor pomagać. Ciągle pomieszczenie głupota głośny wierny zbiornik mięso. Fabryka wartość banknot słaby kobieta. Mleko północny szereg kolejowy gruby zaufanie. Bilet zawartość może plama oba wniosek sześć.', 10, 35, 25, 30),
(50, 50, 'F', 'brookslarry', 'Muzyka drugi umrzeć należeć. Kobiecy interes blady jedenaście ciekawy nauczycielka. Niemcy Wielka Brytania korzeń zły Białoruś. Więcej średniowieczny grzech niebieski. Znak rolnik pojawić się zamek morze zawód przychodzić. Niemcy ruch szczęśliwy dziś strach kontakt. Płyta szkoda wyraz babcia pełen. Postawa by mistrz opłata. Umieć charakterystyczny element telewizyjny klimat. Mówić stary czerwony dobrze otworzyć obóz praca.', 11, 36, 3, 28),
(51, 51, 'M', 'nharris', 'Położony orzeł dziewięć wrogość majątek tworzyć słyszeć. Ocena okropny ponad szef związek pojechać. 1000 masa u norma gołąb o wygląd wybuch. Babka drużyna Włochy parlament gotowy. Lista świecić dzięki wejść doprowadzić. Produkcja zgodny serce zjeść interes kolumna. Muzyka sportowy pole twardy. Głęboki twarz ustawa zająć nocny. Afryka osoba we brat. Poruszać wystawa kamień dwudziesty miły.', 4, 37, 30, 70),
(52, 52, 'F', 'santiagotom', 'Wprowadzać nasz nie głód 30 okropny. Zboże litera nie ma korona wolno.', 2, 1, 13, 24),
(53, 53, 'F', 'danielle05', 'Mnóstwo reakcja bać się zajęcie. Jajko styl liczny płaszcz pod wiadomość ktoś. Reakcja klasztor tutaj srebrny róża. Nosić kontrola robotnik prawda – uczyć się firma. Spokój pisanie autobus kultura ważny.', 6, 38, 25, 6),
(54, 54, 'F', 'richardfisher', 'Duch obejmować słoneczny szukać studiować zniszczyć muzyk mieć na imię. Ojczyzna przyjechać praktyka Wielka Brytania metoda ze istota. Serce oficjalny potrzebny powstać zdanie świeca ważny. Tajemnica pozostawać ogół żelazo nocny nie wybierać. Zamieszkiwać wczesny Stany Zjednoczone trwać pragnienie. Przestać włos przybyć drugi. Wrażenie tor siła.', 11, 39, 25, 15),
(55, 55, 'M', 'amandakane', 'Powietrze różnica biały szanowny wokół.', 4, 40, 9, 13),
(56, 56, 'M', 'walkershelley', 'On.', 5, 41, 32, 35),
(57, 57, 'M', 'wreyes', 'Litera od ksiądz szkolny. Wola piwo hiszpański czyjś informacja. Przyjaźń zbierać obowiązek zeszły ocean ukraiński. Centrum waga upadek jego odbywać się biskup zamknąć. Jakość odległość muzeum funkcja mierzyć mieć. Krowa urodzenie piosenka tor świadczyć rynek. Pięćdziesiąt strach wieczór warzywo piwo płacić posiadać. Wystawa kilometr prawdziwy wąż Węgry. Rachunek wywodzić się szkło funkcja nad minerał władza. Japoński kierować patrzeć. Państwo wysiłek błoto skończyć położyć zgadzać się zmęczony. Własny tekst oczekiwać niewielki. Przygotować plan brzydki ładny trzy. Ziemia panować kolega zając. Ksiądz plecy telefon środowisko wskazywać palec.', 6, 42, 33, 24),
(58, 58, 'M', 'hammonddiane', 'Związać wybitny by niebezpieczny pewien kartka Żyd. Odmiana ile kraj panować narkotyk. Otwarty jeden żaden zanim skala działanie powoli. Więzienie smutny dar żaba. Przedstawiać dodawać może odległość. Przyjść płynąć prawo starać się pies zbiornik pojazd norma. Nagle miłość jego wydać.', 11, 1, 14, 22),
(59, 59, 'M', 'jonathanburton', 'Lis bydło narząd pracować górski alkohol. Gołąb liczba atomowa koza 80 przyjemny. Wielki gołąb zewnętrzny. Gleba chrześcijański model. Mnóstwo jeżeli szkoła śmiech olej. Tajemnica uczeń turecki gra dokładnie. Katolicki mgła przeszkoda poduszka.', 4, 43, 15, 46),
(60, 60, 'F', 'steven19', 'Walka terytorium Warszawa plac gwiazdozbiór. Złoty włos mapa stary mieszkanie krzyż świątynia. Wchodzić drogi 2 korzystać. Zgromadzenie kontakt królowa wybory. Żelazo odpowiadać sklep to w dać się. Wewnątrz wrażenie aby ksiądz sok. Sukces organizm wrażenie kilometr wszystkie. Stracić plama płakać przyjmować widzieć. Zbierać lęk bawić się latać zero marka. Zniszczyć szczęście wracać oni. Walka chwila pełnić port pytać wybierać powstać pora. Lotnisko podobny stać obrót. Gatunek sport zwycięstwo ciało przyszły. Scena rzymski doświadczenie wcześnie już sukces. Wybuch wynik wspólny alfabet filozofia dym krzyż. 8 zniszczyć 40 różny. Czytać artykuł figura coraz energia opinia zamieszkiwać. Wprowadzać twój uprawiać świeży pacjent. Dawać śnieg pomagać rynek cesarz mapa. Internetowy potrzebować bajka stawiać typ dzielnica burza. Oddech związany konflikt.', 11, 44, 28, 14),
(61, 61, 'M', 'eugenewest', 'Porządek czynnik jedenaście nikt forma. Trzeci fakt czynność złożyć policja epoka jabłko. Jechać tajemnica poprzedni kochać. Rodzina dłoń nazywać 30 rzeczywistość. Kilometr cienki dość narząd przedstawiciel. Umożliwiać odpowiadać literacki osobisty królestwo wiedzieć. Lek blisko hałas kura. Żelazo wzdłuż pokryć rana Ameryka życie następny. Sprzedawać potrzebny przyjmować choroba utrzymywać. Wchodzić zmienić droga łyżka ojczyzna biblioteka. Kontakt wypowiedź kobieta ono tłumaczyć !. Urządzenie dopiero otaczać spotkać iść wysokość nauka czuć. Stosunek tytoń tutaj pomarańczowy tu średni smutny. Jutro ręka cień cebula łączyć. Skrzydło usta dodać motyl wąski teoria. Chiński herbata strach czeski jeść cecha. Niechęć jakby grupa łączyć. Procent mieć na imię siódmy ogólny twarz. Robić pomieszczenie napisać jeżeli w końcu. Postawa przykład dłoń twarz rodowity cześć.', 1, 45, 17, 96),
(62, 62, 'F', 'karenking', 'Rana patrzeć oba kuchnia silny. Odwaga współczesny przejście. Opowiadać Jan bezpieczeństwo właśnie rosnąć. Czasownik szczególny pływać strach przykład od nowy krótki.', 1, 46, 2, 69),
(63, 63, 'M', 'abigail53', 'Żywy Chiny nocny sztuka.', 4, 47, 34, 97),
(64, 64, 'M', 'ajames', 'Rumunia Austria kot pomarańcza.', 5, 48, 26, 95),
(65, 65, 'F', 'dianaharding', 'Czekolada sklep głos styl czeski 10 wino. Marzec mebel ciekawy to próba układ. Telewizja zachodni wyglądać kapelusz pamięć. Uczeń siebie można czas religijny drobny działalność łaciński. Ogród wkrótce reguła wrócić piętro ludowy. Mowa maj jeść. Ogół zamieszkiwać współczesny ogromny studiować obywatel pochodzenie. Ozdoba północ radio poprzez Francja. Stosunek butelka tytuł usuwać most. Dwudziesty lęk wspaniały nasz. Piłka dar cichy głęboki mąż miłość minuskuła. Gatunek seksualny zawodnik drobny 5. Stosunek waga jakby Szwajcaria widoczny urodzić się mężczyzna wiek. Stolica ozdobny widoczny traktować poziom. Zdarzenie ? otoczenie drobny. Księżyc zewnętrzny specjalista umrzeć potrzebować mocny. Odważny konstrukcja wąż tekst 9 także. Smak nazwa grunt cały zrozumieć rodzaj dodawać 3. Babka pracownik właściwość święto. Zakres całość uciec rozwiązanie. Długo poprzedni siedzieć zdolny literatura ćwiczenie. Wiosna biuro cienki 4 podobny słodki. Głównie oddawać oddać mistrz.', 11, 49, 4, 31),
(66, 66, 'M', 'carrollarthur', 'Kula leczenie znać uderzyć. Słyszeć plemię niebezpieczeństwo zniszczyć. Kolorowy wieczór rodzaj wywołać dobrze. Funkcja impreza samolot fałszywy połączenie doświadczenie futro. Chronić wśród kuchnia. Zmęczony serce dane okolica zakon Słońce drogi. Mur żyć 100 burza taki twardy tydzień. Wejść tłumaczyć ptak mocny Boże Narodzenie zdolność jedzenie. Nocny zapis chmura pomidor gniew żeby. Godzina wyrok kupować około przedmiot łaciński. Patrzeć ofiara otaczać mądry ciało wydawać się utrzymywać. Marzec zgodnie całkowity zabawka czytać łaciński sprawiać. Dwa wzgórze wiedza. Usa królowa poczta właściciel. Jesień lekki krzesło krzew. Pamiętać zgoda już przedsiębiorstwo powstać czynność otwór. Inaczej kąt internetowy żaba jego zielony lis.', 11, 50, 7, 65),
(67, 67, 'M', 'mackmark', 'Niebezpieczeństwo oddawać męski ssak. Ośrodek nosić podnosić ale. Mapa kanał kupić mapa Polak. Program rano zawierać papieros. Członek ślub rzucać stacja. Pozostawać zamieszkiwać cztery ogólny banknot. Choroba prawy cierpieć głęboki pies także. Liczba Atomowa wódka przeciwnik wewnętrzny lecz. Lubić gra osoba region sprawiać. Oficjalny zająć przejść biblioteka. Bezpieczeństwo szczęście by ręka wielki. Coraz przeciwko instytucja. Sklep określenie zawierać problem iść. Kaczka istnienie bar podłoga więcej pierś. Płaszcz przynieść pytać 40 rolnik obraz. Wykorzystywać wtorek południe kolumna. Gniazdo efekt zwolennik rak. Niemcy rok samiec ubogi wkrótce. Milion pisanie południowy wiedzieć efekt ich rozmiar. Użyć Kościół składać jesień lotniczy pies. Film nagle śpiewać gatunek wysiłek pracownik. Przyrząd tablica pan okazja.', 10, 51, 24, 71),
(68, 68, 'M', 'santiagojonathan', 'Wchodzić w końcu pieśń słoneczny przykład. Plaża fala dawno jedzenie. Atmosfera szyja podróż banknot bank odmiana poczta. Ogół ale ani Afganistan zamiast powodować myśleć. Rejon niebezpieczeństwo głos nieszczęście taki. Minuta leczenie dziewczyna. Przestrzeń autor siedemdziesiąt zabić sto przybyć przeciw. Powstać komórka żołądek szczęśliwy rower gniew przykład. Arabski ciepły oglądać promień społeczeństwo wrócić dostać.', 4, 52, 10, 23),
(69, 69, 'F', 'jgarcia', 'Założyć kształt wrogi tworzyć kula linia gotować. Chmura okres klient zmęczony. Mgła forma prąd ciecz kochać użyć. Zły aktywny wrogi rząd kochać. Strach cierpieć Pan tekst Czechy dzisiejszy. Ich zaś ilość dorosły brzydki. Święto kochać ciężar wyrób Jezus. Kapelusz nie ma droga skrzydło modlitwa. Dziedzina dobrze wiedza sierpień starożytny. Pieniądze w. tor ryż transport orzeł gdzieś. Zmienić przypominać dokładnie prostytutka kolano cukier przestrzeń miejscowość.', 1, 53, 35, 9),
(70, 70, 'F', 'samantha76', 'Dusza zachodni wrogi zdobyć. Wódka herbata zdolny kwiat upadek.', 1, 54, 17, 62),
(71, 71, 'F', 'krista00', 'Herb zupa armia podnosić. Piec ziarno wystawa uderzyć.', 11, 55, 20, 36),
(72, 72, 'F', 'mschaefer', 'Zająć szklanka chcieć papieros czerwiec wypadek. Całkowity pojawić się kto dany babka element. Powiat szacunek technika wujek. Bohater szkodliwy gdzie pytanie szkodliwy środowisko u. Potrawa zdrowy przyczyna intensywny. Operacja ich plemię położony. Kupić dzień majątek park żołnierz ulica kapelusz strata. Atak dziki górny zmęczony. Deska otwarty pociąg wyjście. Organizm Węgry program litera na zewnątrz ostry długo. Organ studia zwłaszcza spotkanie norma włożyć. Móc tracić miłość. Aż więzienie zasada metr. Pomoc biały grudzień spokój brzydki. Umożliwiać ku święty Niemcy dość niemiecki członek. Wąski srebrny duński sąsiad klimat czynić stawać się. Pieniądze mieszkanka zanim by wypowiedź. Stać zimny wynosić pieniądz książka określać. Wcześnie przeprowadzać jakiś wieś. Szwecja ser zasada stracić. Dziewiąty naród zwolennik noc zobaczyć temu pracownik narząd.', 2, 1, 2, 53),
(73, 73, 'M', 'jalvarez', 'Niewolnik po w kształcie morze szary łatwo. Powieść wywodzić się przestrzeń danie syn pociąg. Choroba zakres królestwo pojawiać się zysk własny. Nastrój mur dziesięć prostytutka uczyć niż lew taki. Żaden smutek wada ręka. Jedzenie dach pływać trzydzieści.', 4, 56, 15, 55),
(74, 74, 'F', 'frankjames', 'Kończyć pokazywać wydarzenie pytać spokojny. 0 model znowu. Nasz maszyna składać czyli efekt sytuacja. Pojedynczy dno 6 róża mieszkanka opłata. Dziewięć dawać wokół cień dwanaście. Liść chrześcijaństwo przyjemny. Przedsiębiorstwo przyjąć czynnik w składać szczególny. Św. nauka noga włoski powietrze zysk ktoś moc. Południowy wskazywać oko pojawić się. Orzeł dwanaście wszelki Polak silny. Mocno dostęp prywatny naukowiec okrągły waluta sam. Budowla klucz niezwykły trawa wojna treść ponownie królewski. Rzeka kultura martwy wodny dłoń nigdy. Autobus stan złodziej krzew wszystko. Mieszkać ty ani umrzeć powierzchnia surowy minuta środowisko. Krok zrobić polityka przedsiębiorstwo 9 listopad dużo.', 6, 57, 31, 80),
(75, 75, 'M', 'smithkatherine', 'Śmiać Się czeski ocean kierunek trudno gałąź. Wtorek Izrael skała Polska wracać. A miecz chłopak dziura twarz klimat. Robotnik zawierać następny przyjaźń stosunek okazja. Strefa słoń wybór tajemnica zły wąski kolejny. Ciągle małpa taki budować. Atak dwanaście przypominać zakład wczoraj. Kto atmosfera brak żywy. Zwykły polityk sieć. Trwać Piotr żeński budować. Nauczycielka herbata warstwa północny zmieniać. Krok wodny piękny odpowiedź epoka rzucać byk 50. Jezioro czynność mieć na imię przypadek. Piotr oczywiście Rzym dawny niewolnik kolega. Gotowy wewnątrz związany niszczyć można klasa. Nie godzina przedstawiciel ulica pociąg spotkanie. Słoneczny sowa wisieć narkotyk dopływ przybyć.', 1, 1, 13, 45),
(76, 76, 'F', 'tmiller', 'Pożar klient piwo funkcja. Dzisiaj symbol handlowy szkodliwy pozbawić 1000 w relacja. Raz dotyczyć studiować suma wpływ zmęczony zaufanie. Restauracja mama nagły pusty padać. Mięsień program po zdolność. Poprzedni znaczenie papieros otoczenie pszczoła okręt. Zdrowie zupa wisieć. Korzeń 8 siła paliwo herbata. Materiał lód lód wokół styczeń. Wolno ani dziedzina często. Używać gaz zabawka późny gra znosić jednak spotkać. Męski dziewiąty starożytny. Przyjemny łatwo jasny stosunek pytać.', 10, 58, 7, 7),
(77, 77, 'M', 'jonesstephen', 'Zachód jeździć martwy palec dziewięćdziesiąt. Niski gdzie wielki szczęście. Światło zbierać dzień zatrzymać toponim włożyć. Uchodzić 50 istotny. Wszystek dostać medycyna artysta żołądek. Ile wstyd zbiór władca wujek jabłko. Tłumaczyć umożliwiać brat drogi atak pomieszczenie głęboki. Wybrzeże wybitny Europa wrócić kierowca tłum mi zapis. Wyjście punkt rzecz przeznaczyć.', 3, 59, 16, 89),
(78, 78, 'F', 'princebruce', 'Dobry kolumna charakter pan. Panna lud marzec większy rana średni. Zakres człowiek proszę. Chory działać plemię -. Internetowy mój religia naukowiec nauczyciel. Środkowy ciepły zdjęcie ciąża telefon fakt. Bitwa drzewo otrzymywać byk mebel mistrz. Żyć znajdować się dziesięć przedstawiciel. Żołądek istotny bić wolny godność dzięki. Dom malować muzyka błąd skóra 8. Panna zamknąć wyrób przybyć. Powszechny choć obowiązek gdzieś czy. Strata odpowiedź biblioteka wilk uzyskać. Rower składać szary uwaga łąka scena.', 6, 60, 28, 53),
(79, 79, 'F', 'isimon', 'Wtorek różowy równy kij kontynent właściciel. Minister reakcja ściana. List udział udać się prawy publiczny pogoda. Przemysł płyn równy wejść. Łódź przed wierny smak cukier trudność. Sos potrzeba trwały dzisiejszy. Przedstawiać historyczny rodzaj chiński. Konflikt łatwo Afganistan należeć płaski łóżko lew. Rozumieć uśmiech zabawa coś dawny. Władza podawać księżyc mięso kura charakterystyczny. Ktoś bydło gospodarczy gdyby koncert ptak. Osobisty pisać piękny dostać odcień wtorek mało. Rzeka praktyka prostytutka Niemiec wesoły rejon. Prawy wypadek but drobny zgromadzenie łódź. Chrześcijański nieszczęście Rosja obywatel poniedziałek Wielka Brytania granica.', 5, 1, 9, 62),
(80, 80, 'M', 'jaredjones', 'Dziewięćdziesiąt zero zespół chociaż USA.', 7, 61, 34, 42),
(81, 81, 'F', 'phuang', 'Dobry plecy przez matematyka pogoda należy odmiana. Działać wizyta chłopak korzyść. 100 lista smak parlament aż złożyć. Pokój niszczyć trudność taniec spać.', 6, 62, 1, 45),
(82, 82, 'F', 'rsexton', 'Lubić ciekawy drzwi kostka znowu zmarły Słowacja. Godny głęboki uzyskać odmiana mieć na imię komputerowy. Niebo widoczny te stawiać. Obecnie gęś oczekiwać lotnisko matematyka latać. (…) zwolennik barwa służyć kij podłoga ciepło. Pokryć niebezpieczny szybko stado więzienie głupek. Przyszły zdolny pałac czerwony roślina słaby. Wyjść strumień odpowiedź sukces. Dorosły według uderzyć igła naukowiec. Polska smak list moment. Odnosić Się pewny tylko wywoływać ksiądz dużo. Gdzieś mleko prostytutka. Bronić deska otoczenie dodawać dom chronić nastrój. Srebro tylko zwykły 70 wojna zawsze położyć władza. Lubić mecz księga uczucie. Jeść pracować srebrny Niemiec jeździć. Bóg oznaczać podobny. Drogi wszystkie pozostać lis. Zbierać służyć żołądek dostać w kształcie. Wojsko pani mierzyć zarówno Polska szkoda pożar wy. Czasem Morze Śródziemne wiersz gruby bogactwo polować. Ci czy pieniądz krowa ssak kąt rzucać skała.', 11, 63, 28, 12),
(83, 83, 'F', 'slee', 'Kontrola letni miły działalność na kto. Uprawiać biec stawać się gołąb. Byk pytać owoc pochodzenie. Św. papier siostra liczba atomowa Szwajcaria. Miłość czynić działać rozpocząć. Szczyt Stany Zjednoczone zobaczyć ta czysty jeszcze stado. Ziemski pióro rzadki korzeń sposób.', 4, 1, 7, 41),
(84, 84, 'F', 'chelsea16', 'Obowiązek herb produkt przeszłość problem pasek. Zegar w starożytny szczęście hasło próba szybko. Wydawać Się wrogość krew dokument. Pokryć okrągły dawny dzielnica akcja głód. Okres tytoń pewny oficjalny trzydziesty. Seks procent on kanał brak fotografia.', 8, 64, 9, 66),
(85, 85, 'F', 'catherineking', 'Chleb pokarm film trzymać żelazo przybyć. Pani interes umysł narodowość oraz bać się. Środa budzić lewy ja. Umieścić towarzystwo ręka zeszły. Błąd zmarły bardzo plac komputer trwały. Ukraina rozmowa wczoraj właściciel jedenaście koło szczególny. Ósmy widok podstawowy idea przeznaczyć. Łatwy mały chiński oni policja wyrób rynek. Wąski listopad tracić list szkodliwy gdzieś. Pacjent pozostać pieśń 10 dodatkowy pałac trzydzieści transport. Kij domowy dziewięćdziesiąt prowincja dziewiąty. Linia obecnie wystawa koszula pszczoła ocean. Urodzić Się inaczej włos pojazd. Pojawiać Się służyć urząd wydawać się przynosić zupełnie stan. Adres litera ponownie przyprawa zrozumieć czynić. Gorączka grudzień cena za nadzieja praktyka trudny. Pokarm moneta polować muzeum wydać Włochy. Instytucja aktor Rzym japoński drobny słońce.', 8, 65, 6, 26),
(86, 86, 'M', 'pinedaluke', 'Dorosły Słońce zboże sen w. kraina dodać domowy.', 7, 66, 36, 41),
(87, 87, 'M', 'stephensjill', 'Komórka dobro niedziela upadek wydarzenie związek symbol bać się. Znajdować barwa wisieć dym gwałtowny Czechy. Ktoś dziać się orzeł dzięki róg. Smutek temperatura pozbawić wolny brak kurs tańczyć zapis. Wprowadzać teraz obwód korzyść surowy prawie urzędnik wspólny. Danie potrafić całkowity broda cel dostać. Korzeń religia – trzydzieści bok. Wydać wybrzeże ziarno (…) mierzyć Hiszpania. Zespół pacjent środa wschodni nastrój cecha wskazywać. Sierpień wejść 20 zacząć papież Izrael biskup fotografia. Zbierać wewnątrz lis szef artykuł. Zespół umieszczać wkrótce daleko aż niszczyć. Moment jutro przy dyskusja noga widok. Zamiar biały jądro odwaga rodowity odpowiadać. Stworzyć potrawa wprowadzać siostra kolumna wyrób otrzymywać. Ludzie trochę poprzedni można oddawać twój partia rozmawiać.', 1, 67, 5, 20),
(88, 88, 'M', 'harrisonsabrina', 'Rzadko efekt powód jeżeli mądry. Szczególny babka można Morze Śródziemne tył kobieta. Metal turecki lustro pociąg mieszkanka szwedzki. Region but przynosić Anglia. Postać wewnętrzny amharski sport. Wolność długi zjeść delikatny. Dziewczyna dany żyć. Australia rodowity październik dodatkowy. Pusty krowa obywatel. Robić okazja pochodzić kolejowy ile.', 10, 68, 5, 75),
(89, 89, 'F', 'qcross', 'Mężczyzna owoc tajemnica całość artystyczny udać się. Właśnie no szary ! próba. Czytać Turcja pomieszczenie dyrektor wykonywanie artystyczny bić wierzyć. Zbiór pytanie anioł powstawać spać stopień kolejny. Wreszcie smak owca norma ubogi.', 1, 69, 31, 38),
(90, 90, 'F', 'heather06', 'Być ciemny taniec wysoko podstawa język. W Ciągu liczba kosz moc przykład zawodnik wolność. Zapach praca biedny opuścić. Lekki styczeń Morze Śródziemne dobrze. Mięso przeciw mleko powiat rolnik wiadomość wreszcie. Las widzieć przeszkoda lekcja układ okresowy wiek. Dziewczyna rysunek kupić igła wykonywać. Mieć duński wola wczesny. Korona przeznaczyć kurs związany kupować. Koło dziedzina ? swój naukowiec. Więcej Francja chemiczny dziura wynosić. Dziura zawsze wskazywać operacja. Relacja grupa palec władca sztuka słuchać. One kalendarz śmierć koza obywatel. Milion komórka zdobyć sieć szkło kara głupek. Pochodzenie lis zwolennik. Katastrofa pomysł Kościół temat dusza. Środa współczesny piętro noc na przykład. Muzyk jak liść wioska piętro projekt. Dania zaufanie lekarz Belgia specjalny sukces przeznaczyć. Wstyd składnik ozdobny prezydent dobro. Wielkość spadać ciężki jako. Jasny ocena gość strój.', 5, 70, 34, 10),
(91, 91, 'F', 'vshannon', 'Artykuł przechodzić obiad dawno styl np.. Alkohol kto dziewczyna. Także pieniądze babka zakon. Przypadek muzyk internetowy ziarno. Rachunek doświadczenie 4 wzrost czyjś Rosja. Pozbawić Francja Włochy długi głupi urodzenie. Piłka Nożna proszę wpaść plecy samiec. Wysokość plemię syn chleb hasło. Trochę bo odbywać się ty specjalista zakład. Posługiwać Się model tkanina taniec substancja silnik jeszcze. Słodki Afganistan jabłko spowodować. Te raz — zwycięstwo. Praktyka osiągnąć siostra samolot Chrystus. Podłoga prosić angielski organ kupować znów ulica mysz. Głód rodzinny pragnąć wtorek. Władza gniazdo sala jeździć morze wszystkie dwa.', 6, 71, 8, 63),
(92, 92, 'M', 'lutzcharles', 'Tytoń epoka mąż plac spotkać starożytny chrześcijański tracić. Śnieg powinien zachowanie brat książę Litwa słaby. Wieczorem średni gotować szczęście budynek bitwa wiek. Na Przykład nieść dopiero ziemniak mocz postawa. Chłopak no wybierać krzyż oddech osiągnąć stosunek. But skład narodowy bajka skóra. Rzeczywistość pijany zmienić obchodzić fabryka chcieć późny. Wojsko skończyć zaraz złodziej.', 8, 72, 4, 48),
(93, 93, 'F', 'vmckee', 'Urodzenie wiele zazwyczaj rozumieć. Nowy słyszeć dzieło też pokój. Znosić wykorzystywać półwysep bilet 7 po głupiec wierzyć. Każdy badać głupota prawny. Pół szef poprzedni bezpieczeństwo. Występować dziki autobus tracić przestępstwo rozmawiać. Źle sukienka starać się. Góra surowy znów polegać prosić wzgórze. Kolejowy przyjęcie szybko gość zdanie temat interes. Złożony składać posiłek rachunek czasownik słaby służyć. Muzyczny biały gdy przestrzeń podróż pająk zgadzać się. Oddział oznaczać miły udać się ogromny kto włoski. Te istnienie okropny córka dziać się. Wybuch leżeć orzeł. Włochy przyszły uderzenie umożliwiać szef odzież. Ssak wytwarzać zawsze różnica struktura samochodowy. Warszawa komputer bądź istota szukać Europa. Owca dokument przybyć w wyniku. Wspaniały międzynarodowy Ameryka zasada powodować. Wszystko filmowy znajdować południowy szczęśliwy więc chłopak.', 2, 73, 12, 14),
(94, 94, 'M', 'wilsonroger', 'Afganistan typowy alkoholowy lekki w końcu. Tytoń Afganistan żydowski dyrektor. Czarny obowiązywać potrzebny tu. Wygląd sierpień według pomysł. Podobny śnieg ku rzeczownik zadanie zgadzać się masło łaciński. Ilość wieś żyć proszę. Nazywać dlaczego stanowisko prawo brzydki wniosek zwierzę. Przypominać rzeczywistość matka.', 6, 74, 28, 58),
(95, 95, 'F', 'bsanders', 'Prosić gardło gdy konstrukcja program dawny pokazywać. Modlitwa dialekt pełen wiosna zdobyć. Samochód przez dzień przybyć. Parlament piosenka tekst naród Kraków napisać państwo duży. Uprawiać chcieć cienki wspólnota układ okresowy późny. Uznawać traktować ubogi rodzic lekarz nosić. Zamknąć okrągły związek. Modlitwa na przykład ręka. Trudny rak własność. 0 partia dawać tysiąc. Koniec niech duży otoczenie warzywo. Pierwiastek Chemiczny rolnik publiczny grzech zadanie. Działalność doprowadzić region ocena. Kraków wyrażać jeśli cały specjalista złożyć. Ptak partia rosyjski nigdy otoczenie dział nie wspaniały. Dzielnica hasło stowarzyszenie dziewiąty. Ból szklanka coś budzić śniadanie hałas. Słońce pasek dziewczynka siostra barwa szósty starożytny.', 8, 75, 8, 11),
(96, 96, 'M', 'wilsonjoshua', 'Z Krwi I Kości w wyniku w postaci pełnić.', 9, 1, 27, 99),
(97, 97, 'F', 'leekaren', 'Próba ona rynek powszechny który 9 przygotować metoda. Dziewięć lis proces siedemdziesiąt kupić społeczny wydać. Przecież narząd 4 pytać rządzić przeprowadzać musieć. Słuchać spór ci wizyta róg wnętrze. Smutek wiosna pomóc półwysep średni całkowicie uważać. Lew pisać wymagać. Wybrać brzydki sposób źródło kwiecień. Mebel przyjmować nieść pływać każdy mój. Wesoły traktować Litwa. Niektóry szkolny sytuacja dlatego mieć wybrzeże pora. Lekki wojna para wynik zamieszkiwać ostry Austria. Poduszka piłka dość angielski.', 1, 76, 27, 82),
(98, 98, 'M', 'kimberlyrosales', 'Głęboki ogół kartka zeszły relacja port prawdziwy.', 4, 1, 17, 46),
(99, 99, 'F', 'xvincent', 'Zakres pomoc wąż wybitny filozofia. Pewien wszelki pusty w końcu.', 3, 77, 8, 90),
(100, 100, 'M', 'margaretorr', 'Prędkość jezioro zniszczyć. Rak obiekt potem mieć rodzina część umożliwiać niebezpieczny. Zespół powiat metoda narkotyk. Skutek danie wierzyć. Powszechny autobus mięsień powstanie ksiądz nocny wyrażenie szkolny. Robota zaraz scena umożliwiać urodzić się jej raz. Adres kawałek typowy szczególny. Region Warszawa uśmiech spór. Telewizyjny Niemiec całość zajęcie dolny głównie pole żelazo. Więzienie postępować nie ma kwiat wspólny lubić. Używać choroba moc japoński. Ani stosunek pierwszy profesor wyrób. Figura kolejowy Holandia ściana. Prawdziwy żołądek lustro spowodować bułgarski narodowy. Blady Belgia grunt strach zjeść dany czarny. Koszula trawa zarówno port język. Zgoda pole społeczny sprzęt temu minerał zamiar.', 2, 1, 7, 5),
(101, 101, 'M', 'diazangel', 'Jaki broń międzynarodowy łagodny lampa dzieło. Robić także otworzyć jeden czynność.', 8, 78, 24, 23),
(102, 102, 'M', 'meghanmay', 'Prędkość żydowski pozwalać postępowanie. Wódka jednostka telewizja zawierać czynnik historia kamień dziób. Ojczyzna 1000 żart więc drzwi. Pojedynczy pióro wyrok. Nad para tkanina kość. Broda autobus wolno w końcu.', 3, 1, 8, 44),
(103, 103, 'F', 'hking', 'Szczególnie wiatr jeden państwowy. Ściana życie tekst. Działać żelazo dokładnie mnóstwo kara amharski powstawać zwrot. Sto co dziewczyna członek zaczynać Wielka Brytania. Styczeń świeży 20 w.. Wynosić otaczać poznać. Tarcza mąka jutro głupota krótki lud ciekawy naczynie.', 4, 1, 8, 3),
(104, 104, 'F', 'walshdawn', 'Nastrój materiał próbować maszyna pomiędzy. Towar ruch ćwiczenie za pomocą planeta nóż. Gwiazda wejść mały pogoda uczeń myśleć. Sportowy wiadomość skutek przyjechać ziarno przyszłość poważny. Pomysł wyjście zapis kij. Wziąć tam niebezpieczeństwo bezpośrednio chodzić w formie szeroki. Klub 40 jakiś zupełnie. Zakończyć zgodnie zbudować korzystać otrzymać telefon naj- ogień. Wypowiedź stopień 50 sukces zakład oddać podstawa. Port publiczny ryzyko prawo obecnie policzek gwałtowny. Rok Rosja kolor mocno ząb. Pokazywać ulica azjatycki wieś. Nawet pieniądze mieszkanka funkcja ich słodki hiszpański treść.', 4, 79, 22, 21),
(105, 105, 'F', 'colton78', 'Zawartość teren górny m.in. podstawa doprowadzić. Mapa zimny spowodować płaski pojawiać się.', 4, 80, 2, 9),
(106, 106, 'F', 'ssmith', 'Wieczór pierwiastek chemiczny niebo muzyk. Postawa przykład go. Uważać zazwyczaj serce tekst prawy królowa mur duch. Autor tracić urzędnik strefa rząd wino wzrok. Wchodzić powoli szwedzki wcześnie. Twarz stosować szyja komputerowy pisarz zaraz. Linia no robić zegar osoba południowy jej.', 6, 81, 27, 44),
(107, 107, 'M', 'ryantyrone', 'Przyjechać zatrzymać wokół oznaczać wcześnie. Budzić pozwalać konflikt piec.', 5, 82, 19, 61),
(108, 108, 'F', 'sarah59', 'Poza własny Rosja sto. Plama kobiecy tradycyjny iść.', 6, 83, 24, 19);
INSERT INTO `opis_uzytkownika` (`id`, `uzytkownik_id`, `plec`, `pseudonim`, `opis`, `rodzina_id`, `zdjecie_profilowe_id`, `ulubiona_modlitwa_id`, `parafia_id`) VALUES
(109, 109, 'F', 'jamiemyers', 'Powolny szkolny USA w celu. Wytwarzać plemię duński grób oko tytuł. Wieczór całkowicie wyjście dziewiąty błąd pierwszy. Trochę okoliczność słuchać dawać r. wódka. Ciało gwałtowny kula zmęczony aby prawo jako. Europa papier w ciągu podstawa wczoraj czwartek dokładnie po. Zamykać zawodowy tysiąc. Zeszły zgromadzenie korona pragnienie w formie opłata zawód kosz. Warstwa chmura kwiecień kawa Japonia gdzie bank wolny. Gałąź królewski paliwo. Mały różowy księga lekki rodzina dyskusja daleko naturalny. 1000 stół cisza zespół technika. Pomieszczenie a 80 sen tydzień średni długość lecz. Rzeczywistość postępowanie cień niebo odmiana godzina poniedziałek. Białoruś większość kolejowy polegać. Warzywo przeprowadzać pomidor. Ubranie lubić gazeta nadmierny prowincja.', 8, 84, 5, 4),
(110, 110, 'X', 'lewisdonald', 'Zły pomieszczenie polski św. płynąć graniczyć burza. Ludzki 900 Boże Narodzenie autor okres liczny naród. Postawić koło wykorzystywać dobry wodny. Zboże autobus charakter styczeń piec brzydki rodowity. Leczenie modlitwa wprowadzać żelazo. Lina przestępstwo wydarzenie potrzebować Hiszpania przyszły dokładnie wyraz. Upadek powinien krzesło palec dać się blisko szanowny. Się skończyć lina hotel zwykły. Późny kwestia prawie połączenie. Morski wolność więzienie zaburzenie umrzeć. Rolnik nie i zbiór razem on pomoc istnieć. Dodatek powietrze most zajęcie wioska siedem zegar poznać.', 8, 85, 31, 92),
(111, 111, 'M', 'brettphillips', 'Piec produkować bydło Żyd. Płynąć centrum pociąg chociaż. Zawodnik gwałtowny telewizja choć myśleć sprzedaż. Rozumieć zamek egzamin kościół minister dolny mocno. Bydło broda stopa reguła ciemność mężczyzna. Na Zewnątrz doświadczenie lekki. Drewniany teoria piłka nożna czwartek czarny ośrodek. Naturalny słowacki oko Kościół drewno - często wewnętrzny. Znany nos pięć pomidor. Drogi Grecja wspomnienie ludność. Norma środa 7 mleko. Tytoń siła 20 odległość róża szyja zamiast. Afganistan strumień życie koniec muzyczny krzyż. Banknot grunt rano droga. Wysoki grunt dusza bajka. Wizyta przyjmować pokonać pragnienie przemysł obejmować. Bliski konstrukcja układ swój. Coraz przepis dół robić. Np. sobota zatrzymać forma letni wspólnota.', 5, 86, 25, 6),
(112, 112, 'M', 'erika38', 'Dziki Japonia natura wolny łóżko przepis. Ktoś uderzenie bronić organizm iść duży nazywać ciasto. Motyl miękki piętro kąt. Połączenie las zobaczyć Dania psychiczny albo. Głos problem bycie pić stosunek ciepło. Listopad w ciągu zwolennik społeczny aby. Chociaż minuta decyzja łyżka polityk bar. Ciepło oddać jaki wspólny wracać bydło przynieść. Gęś niszczyć środkowy. Naczynie jeżeli zwłaszcza 50 chemiczny. Przyjść studia ulegać mózg. Zachowanie malować jaki liczba procent 10.', 9, 1, 5, 54),
(113, 113, 'M', 'jamiefrench', 'Leżeć wykonać przeciwnik liczyć dym. Seksualny radiowy środowisko narkotyk. Spodnie odważny okres blisko. Umiejętność podróżować głównie letni kaczka wybrzeże chrześcijański.', 8, 87, 28, 68),
(114, 114, 'F', 'kcampbell', 'Wcześnie szkolny wysyłać wszystko kurs służba. Położyć spokojny zwrot wesoły kwiecień filozofia. Polegać pamięć daleko kontynent pomieszczenie broda. Rzeczywistość owca pisarz radość. Podawać rzeczywistość lekarz bilet. (…) wieczorem składnik. Hiszpania odcinek krew. 10 zachodni patrzeć należeć nowy. Muzeum dużo wojsko kość skład jak system piłka. Czechy twarz zmieniać górny strój jednocześnie. Pijany spadać łatwy cień rak. Odcień sport koza. Życie spadek gość powszechny 10 złodziej wynik. Nauczyciel istnieć pokarm wytwarzać. Trzydzieści bank turecki robota dziecięcy. Mierzyć rzadko święty danie większość siedziba silnik. Tradycja żywy przechodzić próba wchodzić iść zdarzenie decyzja. Umysł po prostu natychmiast piec. Dziób związek społeczny piąty mięso spór. Dużo szczyt wcześnie obserwować wiele główny. Nic specjalista kraj jazda mama zespół. Brudny odwaga wy.', 2, 88, 28, 60),
(115, 115, 'F', 'nicole95', 'Zajmować decyzja wszyscy niebieski. Władca między sok dokładny 6. Organizm świeca ciemność ziemia zbiornik. Gdy zdobyć uniwersytet obowiązek żywność zupa wiara. Dzielnica cześć teren uczyć księżyc narząd strach fałszywy. Wskazywać liczba atomowa bić kwestia jeden. Świadczyć pokarm każdy użycie studia. Bogaty choć ciężki oś czynnik ciąża Morze Śródziemne.', 3, 1, 10, 69),
(116, 116, 'F', 'gregg83', 'Metr nadzieja wydawać wybitny piasek liczba. Wina las zmarły dzisiejszy wujek. Okres lata chociaż pojęcie dać się uczeń dziewczyna. Koza zostać relacja pozwalać sztuka głośny spadać. Pole smak gołąb specjalista leżeć 100. Postępowanie środek potrawa biuro Grecja zbudować środek. Kieszeń obszar przyjść świątynia. Kula pociąg zachodni uczyć klasa szwedzki atak. Promień za pas koniec jutro. Wieczór może prawda plemię symbol. Pić dane nadzieja dostęp wojna 1000. Zdjęcie kaczka natura jazda miejscowość tłumaczyć szkodliwy.', 4, 89, 22, 48),
(117, 117, 'X', 'williamsjoel', 'Policja oczekiwać rejon. Wiedzieć wódka 50 wydawać. Połowa wolny morski pływać powszechny październik. Ty zachowywać się swój postać prowadzić za pomocą Izrael. Wczesny bułgarski wywoływać. Gałąź (…) badanie kwiecień. Opisać europejski czynność drewniany. Radio co ojczyzna. Miejsce malować tańczyć użytkownik ludzie wóz zapomnieć. Kończyć próba czyjś drzewo zdolny. Posługiwać Się stać sztuczny skończyć. Włosy dom Egipt okoliczność. Środek dostać ja występować zwrot cień. Według Słowacja teraz Stany Zjednoczone pracować pozostawać kilka. Kilka przestępstwo 0 przygotowywać.', 3, 90, 13, 47),
(118, 118, 'F', 'rwatson', 'Określać urodzić się dla gdy łagodny cisza. Pora społeczeństwo łąka policja odzież wątpliwość. Określony stawiać szukać prawny ładny wakacje ochrona. Szukać wygrać sylaba orzeł. Dziewięćdziesiąt w norma mieszkaniec samica. Krowa następować napój wtorek gdy ofiara. Grecja uciekać łuk wywoływać. Znaczyć skłonność sól. Dać hiszpański student w postaci za padać. Wiersz obserwować jechać -.', 4, 91, 8, 85),
(119, 119, 'F', 'christinelawrence', 'Martwy mysz rok ofiara ludzki gęsty. Dorosły więc paliwo dach punkt. Pojedynczy zgodny uciec zainteresowanie taniec przypominać. Służba tkanina okręt zgoda. Masa bronić całość sobą oddech. Wartość wesoły interes pierś. Paliwo drzwi ssak zamiast. Indie coś bawić się wczoraj. Miejsce dać się oś szukać my. Poruszać Się rozmiar kilka Japonia padać. Łóżko cały międzynarodowy 20 pas symbol. Czyli kiedy piasek opłata przyjęcie. Niedziela jutro banknot rzadki podróżować poznać. Hotel 4 składać św.. Ocean pieniądze powieść luty. Przynieść środa wiedzieć decyzja siostra pani. Herbata wesoły zwykły komputer królewski leżeć. Archipelag ogień naj- Holandia u wolność cienki. Wszystko wada odkryć Chrystus dziób. Anioł przyjmować przyjąć zdobyć kilka.', 10, 92, 35, 73),
(120, 120, 'M', 'sdavis', 'Mocno pojawić się oni dziadek przygotowywać wódka oraz powieść. 60 płaszcz znaleźć rada większy. Przeszkoda Rzym wykonać centralny abugida przed dalej jakby. Postawa koszt wrażenie cień. Zdrowy wiele pan czekolada dostęp minuskuła krew. Płaszcz przyszłość muzyk świeca wystawa grzech lipiec ci. Dania badać ty złożyć. Urzędnik budować nagle jakiś. Samiec kwestia statek wierny pisarz latać znajdować się urodzić się. Uderzać złoty 40 przechodzić pokonać chyba raz. Szacunek odpowiedni styczeń wątpliwość słoń mieszkanka na. Morze Śródziemne dziedzina kultura tekst aktor zwolennik. Sala społeczny osiągnąć Afryka amharski grecki wejście. Ciągle rower umieć ozdoba japoński rower.', 9, 93, 16, 78),
(121, 121, 'M', 'bakerzachary', 'Odważny więcej ziemniak babcia problem tekst. Błoto mieszkać znaleźć zdolny teatr 1. Cecha układ okresowy dokładny Chiny wzdłuż. Komórka paliwo drzwi robić. Warunek dusza tani 900 zdrowie zwłaszcza. Święto skrzydło gdzieś wybór kalendarz lekarz pojazd. Wybuch wrogość brać wykonywać. Zakon psychiczny ubogi oraz diabeł szeroki plama. Południe instrument nadzieja olej 9 pokryć żółty.', 10, 94, 35, 87),
(122, 122, 'F', 'bryan66', 'Postawić 6 cukier ciepły poważny brzeg. Przybyć zachodni tamten dolina morski zwierzę. Wojenny możliwy tylko większość powierzchnia republika ktoś. Dolina mowa on tytuł albo. Ukraina Afganistan samochód wytwarzać krótki dawny.', 2, 95, 13, 58),
(123, 123, 'M', 'morakathleen', 'Wziąć lipiec jednak alkoholowy śmiać się. 80 panować płakać lubić. Serce dach temu. Przykład wysłać bieg Chrystus piłka pozycja butelka radiowy. Nowy właściwy niż literatura umiejętność. Raz gleba znajdować się kawa fałszywy zdrowy. Akcja te myśl Rumunia gwiazdozbiór czyli styl. Świnia np. rozumieć maszyna. Tyle jedenaście móc ramię. Uciekać broń złożyć ocean. Otrzymywać klub itp. piosenka. Zmieniać obowiązywać dać się oddawać broń gardło. Wprowadzać władca mądry stosunek pióro np. wieczór kontakt. Należy Czechy dyskusja. Stany Zjednoczone ziemia waga atmosfera kosz. Owad ile swój dopiero spotkanie. Jakość siedziba organizm drzwi ciepły zatrzymać.', 11, 96, 10, 47),
(124, 124, 'F', 'kaylawolf', 'Składnik Egipt pływać odbywać się połączenie powiedzieć. Wszystkie osiągnąć działalność model. Ukraina modlitwa Polska promień przerwa bóg metalowy. Martwy kształt umieszczać dopiero świecić ryba powstawać. Danie oś nie- samiec. Stworzyć szacunek zbierać władza produkować miód (…). Dziadek pióro poprzedni kończyć ojczyzna obiad. Most mecz system gaz trzy skłonność. Styczeń sygnał wycieczka Litwa pracownik zachowywać się ciemność. Wszystkie wino przebywać członek uprawiać. Chrystus wewnątrz opieka. Usa 90 niedźwiedź zapach poduszka ziemski współczesny. Pszczoła kolega bić Boże Narodzenie uśmiech kostka. Ciemność uderzenie zewnętrzny obywatelka kto uchodzić. Umieścić róg stawać się wiedza przyjemność.', 5, 97, 36, 45),
(125, 125, 'F', 'joshuawilson', 'Stopień oficjalny trzydzieści grunt tworzyć skutek.', 10, 98, 18, 84),
(126, 126, 'M', 'ayalavirginia', 'Letni postawa pomagać niebieski sądzić wchodzić ładny. Skutek metr 1000 węgiel. Osiemdziesiąt umieszczać zegar pomóc pomysł krzesło król. Potrzebny sukces mało rana psychiczny. Spokój adres granica cień czuć główny proces. Ludność rzucać stół przerwa kwiecień. Powstawać czasem Słowacja republika zupa śpiewać. Naukowiec okolica dlatego latać. Jajko właściwy męski kawałek przeznaczyć słoń udział. Dokument wspaniały produkt pojawiać się. 8 grunt półwysep literacki. Nawet mięso fragment wniosek. Dawny lek 20 papieros listopad. Np. głupiec filmowy 3 dobry brudny. Robota dyrektor słyszeć francuski sąd. Spór wszystek Litwa przechodzić cierpienie wojenny głównie. Tytoń silnik grudzień ptak gęś. Polski wydawać się mowa jedenaście liczyć. Styczeń szczęście niebieski wiatr stopień. Świeży sala cierpienie aby obóz sposób ponad dzisiaj. Pragnienie zakon skala cisza mowa. Ucho urodziny trzeba ziarno te przyjechać zająć. Wódka strona Rzym po.', 5, 99, 31, 18),
(127, 127, 'F', 'tonyapeterson', 'Według rzeka młody papieros siódmy sportowy ponownie. Stopa teren pokazywać ich akcja. Dyrektor zabawa marka umieścić. Okno ściana funkcja posiadać na dokładnie.', 4, 100, 24, 95),
(128, 128, 'M', 'johnsonjose', 'Nie Ma z krwi i kości chrześcijański jasny biblioteka amerykański góra. Wada choroba wziąć wewnątrz papież ozdoba kąt. Ciemny taki filozofia list główny lina.', 6, 101, 16, 60),
(129, 129, 'F', 'sabrina53', 'Koniec aby wada gniazdo. Nazywać korzyść blisko bezpieczeństwo powietrze surowy Warszawa polować. Przynieść arabski fałszywy. Maj kościół żeński należeć oczywiście rzeka. Niemiecki wino cecha. Mieć Na Imię ja igła nagle kilometr. Zmienić jednak kontrola jakiś ciężar. Jedyny służyć zboże osiągnąć. Zwolennik kształt straszny.', 8, 102, 36, 82),
(130, 130, 'M', 'lisastewart', 'Projekt wielkość oczywiście. Igła pijany natychmiast wspomnienie karta. Pomiędzy osiągnąć jabłko kupić właściwy kartka wycieczka jakiś. Zabawa oznaczać 5 temat rosnąć gazeta skład. Rzeczownik bajka położenie obiekt otwarty przyjść dłoń. Stół zostać rzeczywistość. Zatoka góra kąt chronić. Lub utwór wróg – wziąć ksiądz leżeć. Wskazywać biblioteka mieć na imię związek. Administracyjny spaść nadzieja dział Piotr umożliwiać. Ludzki jakość jego sztuczny znać. Artystyczny jakiś niebieski masa przeprowadzać wrogość lew miękki. Budowla analiza kula Belgia sobie los krzyż. On zapomnieć wolno imię skutek. Uchodzić przypominać rzadki wszystkie zarówno elektryczny. Biedny samica zmieniać Jan. Powód miły zbiór. Długi wciąż częściowo osobisty posiłek las rozmiar. Grób pies przyjaźń spotkać żywy głośny 4. Reakcja stracić składać budzić. Wszelki obchodzić ciągnąć (…).', 10, 1, 20, 6),
(131, 131, 'M', 'ikelly', 'Odcień osiągnąć kłopot wpaść całkiem wzrok grzech. Wykonanie Ukraina wschód kostka. Udział oś rano małpa dodatek umrzeć chrześcijaństwo. Praktyka usługa walczyć. Pierwszy klient sprzedawać. Obywatelka cześć co żółty idea jeśli lubić. Znaleźć dziś analiza. Stopa poprzez temat potrawa sobą. Restauracja błąd współczesny ogromny świat szef przypadek kiedyś. Sport prowincja matka białoruski wujek żyć starać się. Australia ile późny może. Włosy mąż ryba skutek Indie żołądek. Czysty panować moneta. Gaz wspólny plaża wiedzieć wewnątrz złodziej. Łagodny w końcu narodowy niechęć pragnienie park. Wybitny kończyć graniczyć gdyby hotel hotel. Kontynent złoto środkowy.', 2, 103, 26, 36),
(132, 132, 'M', 'robinsoncassandra', 'Wolno jądro głupi obejmować. Niewolnik często do obrona kolacja matka. Dwudziesty suma gęsty dzielić panować no trzydzieści. Kamień ktoś proszę żaba. Gleba wzrok błoto i wystawa. Liczyć informacja rodzina zbyt obrona przestępstwo następny. Sportowy gardło typowy. Nieść czyli przyjechać sposób wąski. Karta klub anioł siła. Narkotyk chłopak żyć praca.', 4, 104, 2, 6),
(133, 133, 'M', 'flowersaustin', 'Trudny zakres rzeczywistość. Lis członek masło herb siódmy. Natychmiast uderzać włoski krew opuścić rok dziki. Język społeczeństwo Niemiec parlament godzina kolejny obrót. Jadalny napisać żaba Anglia działać gdy. Wspaniały widoczny poznać. Zero róża dziewiąty ziemniak pół. Przyjęcie babka który miesiąc dla. Kilometr użyć oddawać naukowy straszny ponieważ uderzenie. Wszyscy tradycja środa otrzymywać letni bogini samochód.', 2, 105, 8, 6),
(134, 134, 'F', 'richardedwards', 'Używać pierwszy przyrząd autobus. Ocena lecieć czynnik zatoka rzeka oglądać smak. Bliski toponim sprzęt. Kawa wrócić wynik sportowy kalendarz znowu. Tajemnica słyszeć zawód żaden podatek drużyna usuwać podział.', 2, 106, 3, 9),
(135, 135, 'M', 'hillsarah', 'Budować mąka uzyskać mgła nadawać osioł. Postępowanie film komórka fizyczny człowiek ogień. Cień kto czasem. Kultura w końcu usługa zajęcie środa. Nikt dokonywać węgiel kamień. Treść układ czarny nigdy rzymski jego chłop. Papież zdobyć przynosić miejski. Zupa grupa los szacunek. Ponad imię stworzyć pomoc punkt wywoływać. Gruby słodki doświadczenie wrócić. Północny muzyka sztuczny utrzymywać obcy zwykle skończyć. Turcja jedenaście radiowy telewizyjny świątynia profesor. Przygotowywać temu często mięso. Jezus międzynarodowy wyrażać stosunek przybyć wpływ wartość.', 7, 107, 9, 66),
(136, 136, 'M', 'stephenskatherine', 'Wstyd długo coś opinia kierunek strata. Poza spać oczekiwać niebezpieczny. Częściowo Japonia pomóc przy podać stracić oraz. Użytkownik masa w ciągu sposób taki pomieszczenie. 5 krzew itp.. Przedsiębiorstwo się teraz metal zarówno kula zupa. Zatoka przecież zespół. Teren odważny ból. Osioł czarny osioł głupi miód jako ziemniak upadek. Uwaga plaża tu. Świątynia finansowy znaczyć centrum elektryczny wyraz 9. Pojazd zawierać potrzebny czyjś sala służba św.. Dużo czynnik oraz warzywo osobisty pogląd towar proszę. Gospodarczy daleko palić małpa restauracja płynąć 0. Deska szlachetny powolny zwierzę inaczej stosować. Martwy katolicki wesoły twardy ściana święty.', 9, 1, 22, 66),
(137, 137, 'M', 'ttownsend', 'Artykuł Izrael potrzeba środkowy. Tytoń dusza śmiać się trzymać inny ich. Właściciel słownik 100 żaden służba nadmierny. Wieczorem ocena numer duński tu.', 8, 108, 31, 9),
(138, 138, 'X', 'popekari', 'Pod telewizyjny polować prawny szczęśliwy wodny. Liczba urodzić panować przeznaczyć kawałek kolejowy ludzki. Teatr podstawa usta wzgórze robić.', 10, 109, 9, 77),
(139, 139, 'F', 'shannon84', 'Graniczyć europejski postawić istnieć ćwiczenie niebo. Książę wiek martwy głos wszelki stowarzyszenie mebel. Można odpowiedni zwykły 9. Nóż nieprzyjemny postępowanie więzienie. Przynosić warzywo czekolada uwaga głupota żeby stawiać. Wziąć babka pragnąć jedenaście grać wybory. Wyścig łatwo daleki zaraz każdy. Jeśli miejscowość pusty walczyć żaba pewien szanowny artysta. Gniazdo tkanina gdyby urządzenie. Poza Australia pragnienie zwycięstwo zostać. Rodzic kobieta widoczny ósmy kilometr obszar religijny społeczeństwo. Bogini 0 Ameryka anioł. Pasek obrona ciężki cztery. Nagle pełen hałas dużo żaba klucz. Udział lew Włochy religijny. Historia - charakter praktyka szczyt wojna. Dzisiaj okoliczność długo. Tkanina zawodowy przed korzeń lipiec działalność. Wszyscy dopływ przyprawa tak zimno zwykle plan mieć na imię. Nastrój towarzystwo słyszeć. Mieszkać róg istnieć spotkanie. Zamknąć kult pod dać się. Nasienie opowiadać fotografia pasmo służyć szlachetny całkiem.', 2, 1, 31, 1),
(140, 140, 'F', 'laura16', 'Państwowy naukowiec jeździć trwać punkt ziemniak. Broń sam pod kawałek dwa chrześcijaństwo. Dawno kiedy pojazd leczenie. Cienki wysyłać zaufanie potrawa. To plaża pogląd głośny. Ciało oni bezpieczeństwo przeznaczyć Austria ubogi ten. Móc kierowca zielony głupek. Zimny daleko ściana strój różnica ktoś. Dziadek zdanie uśmiech mieć. Odpowiadać publiczny płaski wtedy nadzieja jutro rozwój. Wejście strona pustynia pojemnik mnóstwo lód samochodowy. Wpływ przechodzić to każdy stary wisieć katolicki. Godzina pozostać jednostka królowa niektóry dobro rozmowa. Indie burza drewniany idea szczęście ziemia zakończenie. Tłumaczyć z powodu jeść plemię. Transport sprzedawać położyć but grób żółty partia. Siedem fabryka gałąź pojawić się.', 4, 1, 24, 89),
(141, 141, 'F', 'daniel34', 'Dziewczynka wciąż ten mnóstwo sukienka.', 5, 110, 25, 25),
(142, 142, 'M', 'mary39', 'Uwaga szukać napój Egipt. Jedyny lis anioł no czuć cześć odzież. Napisać ramię skała powierzchnia nos czerwony zdarzenie przechodzić. Stanowić przynieść rozpocząć wpaść między lis znaczny. Wiadomość pracować marzec aktywny. Lato dzisiejszy sytuacja bank panować.', 6, 111, 11, 17),
(143, 143, 'M', 'rhunt', 'Pozbawić przerwa pas stolica smutek decyzja urodzenie. Dział egzamin gość podać urodzić. Lekcja ulica iść się przygotować. Skład tytuł dobro wspaniały gwiazdozbiór narodowy przychodzić długość. Wolność wracać drapieżny posiadać. Metoda japoński gospodarka piłka nożna. Podstawowy pozostawać dzisiejszy planeta który kolega Belgia. Sztuczny dziki czterdzieści typ wojsko pozbawić młody flaga.', 10, 112, 25, 101),
(144, 144, 'F', 'amandasmith', 'Daleki gatunek wziąć broń. Kolano określony nikt szary próba. Zbudować ziemniak pół nauka ludność ciepło. Silny w formie określać cebula Chrystus. Rower drzewo ziemski kobiecy uniwersytet. Symbol fabryka rzymski bohater. Całkiem niezwykły 8 podawać pracować. Szkoda palec duch. Muzyk ze nadawać. Wprowadzać świnia wewnątrz wybuch głupiec pacjent minuskuła. Niemiec otrzymywać struktura mapa przyjechać 6. Patrzeć wierzyć świadczyć. Tłuszcz muzyczny Morze Śródziemne poprzez pierwiastek chemiczny pokazywać. Tłum czyli wiek różowy oczekiwać okropny królewski. Wieża miasto azjatycki posługiwać się cześć cisza lud. Lód ziemski gdy rosnąć pomoc szczęście. Ono włoski sam policja czy doprowadzić.', 9, 113, 20, 37),
(145, 145, 'F', 'thomasgregory', 'Wynik jajko urodziny. Towar układ przedstawiać panna. Szczęście Australia drużyna dziewczynka ojczyzna. Efekt srebrny nauczyciel związany tekst przyjść Węgry ciemność. Zdolny wilk świątynia dziecko waluta otoczenie produkcja ucho. Niemiecki statek teoria chmura obecny jeździć substancja swój. Cień tor umrzeć płynąć. Chyba rozmowa m.in. pojedynczy w ciągu. Pomieszczenie Bóg spowodować. Rasa fala ziarno działanie poza temat. Pomieszczenie zakład modlitwa niedźwiedź.', 8, 114, 16, 88),
(146, 146, 'F', 'walkertina', 'Węgry oficjalny we radiowy.', 8, 115, 27, 34),
(147, 147, 'F', 'lmartin', 'Niż igła stan rzecz gniew okno. Móc stado kartka żydowski broda wszystek obrona but. Słownik pomarańcza futro dwadzieścia. Francja poruszać grzyb przyjąć sól. Prezent lecz jedenaście matematyka w czasie. Wszystko miasto państwowy wpływ. Kraina nazwa znaczny żydowski pociąg służyć. Mierzyć dać się jądro głos nocny wiek miasto. Użycie reguła łagodny z krwi i kości most. Cmentarz siedziba moc piwo mierzyć zanim bać się internetowy. Przedstawienie zacząć szkolny mój.', 9, 1, 36, 2),
(148, 148, 'F', 'zjohnson', 'Wóz płaski oczywiście. Siódmy jeśli kształt złożony kino działać stacja. Sukienka obserwować pod. Plecy drużyna owca nasiono. Psychiczny się dolny łatwy 30 albo. Profesor utwór zamknąć miły. Cukier robotnik dach wyjść cecha poczta. Dostęp żart dotyczyć. Właśnie przygotować mały możliwy ofiara musieć robić głos. Stać przecież siedziba seks. Kosz alfabet spotkanie dziecięcy Belgia powód. Bezpieczeństwo ofiara żywność oznaczać wybierać syn pozostawać. Przyjaciel liść marka pozycja. Siostra zdjęcie stacja koń płakać mądry początek. Czoło gniazdo nigdy użyć 1000 chcieć odcień wreszcie. Okno ludzki dziedzina jedzenie hiszpański kiedyś ryba ono. Posiłek napisać 6 oddawać budzić. Dziewięćdziesiąt upadek pasmo niechęć potrzeba. Budować wada ale krowa sklep seksualny. Smutny obchodzić postępowanie dobry mierzyć. Region dodawać nazwisko wchodzić okolica lewy. Profesor wobec butelka każdy obcy teren.', 4, 116, 20, 65),
(149, 149, 'F', 'taylor04', 'Intensywny 100 położyć poruszać się.', 8, 117, 24, 18),
(150, 150, 'F', 'lisa37', 'Położony sędzia drewniany pieśń. Rosja brać wpaść.', 6, 118, 12, 40),
(151, 151, 'M', 'chelseajackson', 'Gatunek kult cichy. Powstanie podatek ludowy błoto plama samica. Zrozumieć nieszczęście kula dzielić czynność. Otrzymać trzydziesty opisać zawodnik. Kontakt męski nauczyciel widok nagły Polak. Metalowy plama mój dotyczyć międzynarodowy prywatny wodny. Dzielnica świecić praca przestępstwo. Trzydzieści postawić napój Warszawa – trawa. Odległość aż zaś projekt kiedy. Próbować czynić układ tak maszyna dialekt wykonanie. Waluta Polak wywodzić się dowód płynąć. Rzecz właściwy zmęczony sylaba bajka umożliwiać. Energia żywy waga opowiadać niedźwiedź.', 6, 119, 1, 75),
(152, 152, 'F', 'mathewguerrero', 'Łóżko czerwiec tracić żeński. Małpa obserwować ochrona 7 trzydzieści. Dziedzina świecić środek z krwi i kości. W Czasie wspólny potrafić mi warunek okrągły szereg byk. Szybki kalendarz kolacja mieszkaniec. Letni sala jajo następny. Zapomnieć jednak głód lecz termin zwyczaj. Wysłać strach słoneczny miłość metr kochać. Sądzić powieść siedziba tablica.', 9, 120, 6, 32),
(153, 153, 'M', 'devinlewis', 'Dzisiaj obiekt wóz 2 pas moralny długość. Zero właściwość ustawa rodzaj pokazywać. Zajmować cesarz zupa gęś kilometr prasa rzucać. Tekst brak dodatkowy członek skończyć naturalny. Powoli handel prywatny srebro obrona fakt. Dwanaście pozwalać okrągły wywoływać. Miejsce herbata skała trzymać oddać zatoka czekolada. Szereg śmiech sto. Wschodni mysz rodzina patrzeć żywność żaba. Pomidor ryzyko ktoś listopad na zewnątrz chwila pewien. Właściwy przedsiębiorstwo podnieść poziom dwudziesty osiemdziesiąt. Ale spadać rosnąć cierpienie masło. Wielka Brytania cisza mieć na imię podstawowy wypadek żyć masa. Przejście zabawka średniowieczny burza umysł wewnątrz. Cień projekt łaciński mysz jeść zupa. Polegać abugida potrzebować wypowiedź. Świeca cichy sportowy zawierać kierować kij rozpocząć.', 6, 121, 24, 57),
(154, 154, 'F', 'wcampbell', 'Nos oczekiwać wzrok urządzenie.', 6, 122, 24, 83),
(155, 155, 'F', 'stevenrobles', 'Żyć zachowanie przerwa film nieszczęście nikt. Według jeżeli świeży uderzać złożony przerwa. Budowla wieś Chrystus jutro zamykać powieść czekolada. Krew prostytutka Egipt minister plan wspólnota wytwarzać. Sowa kamień długo piętro. Wybierać wyglądać wzór. Przeszkoda długo naród. Odległość czas całkowity duński albo.', 5, 123, 10, 5),
(156, 156, 'F', 'charlesdiaz', 'Policjant znów bitwa nic. Gorący bądź więzienie kobiecy dobrze Japonia narkotyk. Nagle szyja pusty w ciągu pomóc gdy pozostać masa. Transport dym bez siedem gwiazdozbiór kolacja ze. Spotkanie piąty węgiel bogini. Kościół pozwalać orzeł pamięć klient głupek palec.', 5, 124, 15, 31),
(157, 157, 'M', 'eriggs', 'No królowa taki kaczka. Płacić powszechny zbyt kapelusz. Uprawiać komputer żona jeszcze przyszłość. Ta płeć więzienie królowa umieszczać reakcja uderzać dotyczyć. — w kształcie ponownie martwy lista. Mieszkaniec zupełnie zmienić pół. Gniew ktoś minister rozpocząć. Podnosić dane państwo. Królewski polegać uderzenie dziób komórka pójść. Pokonać zaś posiłek strumień Niemiec. Wydawać rok przeciwny chociaż między styl. Kij Litwa produkt Polak to głowa. Stopień cienki opisać. Dorosły niebo kraina urodzić się operacja. Bułgarski itp. samica nasz lęk dział południowy. Organ różowy podstawa zielony nieść my ogromny. Pustynia europejski Azja główny naród pióro. Książka wciąż ludzki piłka nożna zamieszkiwać pusty kąt.', 8, 125, 32, 33),
(158, 158, 'M', 'lhoward', 'Głód zapach cukier miękki. Naukowy arabski a ukraiński herbata imię rzecz. Moneta babcia szeroki w ciągu. Zachodni jutro ? sklep. Kraków postać świeca 3. Stopień niech Białoruś mistrz obejmować Słońce powodować. Jezus obcy udział Jan Włochy własny. Żelazo kara jeszcze miłość ciepło. Nowy ludność ciepło czterdzieści. Kłopot robota poduszka twardy. Zbierać początek świnia doprowadzić. Zeszły słoń 6.', 8, 126, 15, 101),
(159, 159, 'M', 'klevy', 'Metalowy wygląd jechać. Słońce opinia urodzenie strach wartość przecież pacjent półwysep. Głód 5 obchodzić mistrz sposób wiara przecież. Morze Śródziemne wiek przypominać telewizja elektryczny pomarańcza. Chrześcijaństwo teren gorączka wybór pożar domowy.', 11, 127, 3, 11),
(160, 160, 'F', 'bellaudrey', 'Zniszczyć śmierć morski żywność znów oznaczać. Lina współczesny 30 odwaga jabłko kij. Wierzyć dodać minerał bitwa. Sukienka piąty powstać lotnisko. Wino wprowadzać Kraków wygrać. Imię biuro piosenka organ.', 4, 128, 36, 79),
(161, 161, 'M', 'christine25', 'Męski wiek partia pożar jej program teren. Kolejowy właściwy skała stawać się uderzyć. Specjalny Słońce badanie pszczoła kilka. Włos port delikatny dopiero posługiwać się jechać przypominać. Energia ładny Azja. 8 powierzchnia umieszczać. Pojemnik lud opłata znaczyć zewnętrzny brązowy adres. Mały ocean sposób myśl. Dokonywać głupota jeżeli droga uprawiać zdarzenie Warszawa. Przeciwny dla pomiędzy procent potrzebować lekki. Majuskuła piątek aktywny umrzeć. Pójść noc ciężar dziewięć żeński seksualny. Jeśli starożytny jezioro. Dodatek szkło dziura może godny. Drugi rozmowa ziemniak chodzić. Ryzyko pomiędzy przedstawiać droga więcej wpływ administracyjny zielony. Który prowadzić powód kość materiał zamiar.', 9, 129, 1, 72),
(162, 162, 'F', 'donna90', 'Warzywo rolnik prawda 5 opłata. Panna egzamin główny przepis położyć wspólnota. Wejść kara kilka rozpocząć na że przedstawienie. Dzień białoruski 3 wierzyć kij. Dlatego lista ciemność pochodzenie.', 7, 130, 34, 15),
(163, 163, 'M', 'martinezjacob', 'Wrócić bułgarski zapach czyli dyrektor teoria przeznaczyć milion. Klub zgadzać się wszystek prawie. Swój japoński stały. Strefa warstwa warunek panna. Owca dla jednocześnie poruszać się. Gotowy bądź finansowy większy. Górski hiszpański dzielić określony dziewiąty. Ponad mistrz kościelny właściwość pogoda.', 9, 131, 22, 3),
(164, 164, 'M', 'paigele', 'Gmina ochrona siostra tłum. Francja łóżko sto igła wywodzić się przedstawienie wysłać. Litera tłum rosyjski sześćdziesiąt plac. Postępowanie literacki korzyść dzielnica. Działać komputer trwać myśl nieprzyjemny dzielnica Polak wisieć. Skończyć centralny muzyka drobny przeszłość. Potrzeba dokonać uderzać pokój małżeństwo instrument mąż miły. Związać wydarzenie stawiać zgodnie posiłek. Naukowy coś pracownik miara złapać.', 8, 132, 19, 44),
(165, 165, 'F', 'timothy88', 'Jeść ona rzadko roślina wiosna kobiecy dom. Sportowy włożyć 1 można łuk. Kosztować bycie otwarty piętro ulegać dokładny smak poczta. Źle dolny korzystać jakby sposób odważny. Wątpliwość sprzedawać spotkać szukać przeciwko przeszkoda. Przyprawa kultura wkrótce alkoholowy. Urządzenie robotnik skład kłaść wypowiedź 50 babcia. Uderzać wódka energia blisko. Listopad również władca zmęczony. Tu sądzić pokazywać ojciec część owca. Wysoko pływać białoruski kontakt zdolność. Ulica lampa ja. Stanowić córka według srebro rada ponad analiza hotel. Bić sztuka ci odważny sowa ponieważ. Ich nosić zgoda. Boże Narodzenie związać delikatny broń pewny. Pora uciekać zaufanie serce przyjechać niż dopływ przypominać. Aby abugida w wyniku o. Przedmiot 50 drzwi kurs wynosić poniedziałek. Wysyłać pomoc jajko zmarły. Danie książka pływać podział. Tłumaczyć słodki szczególny częściowo.', 5, 133, 33, 101),
(166, 166, 'F', 'wonglynn', 'Okręt drewniany ogół stały mistrz. Uderzenie ich błoto głupi niebezpieczeństwo nawet.', 11, 134, 36, 35),
(167, 167, 'F', 'npoole', 'Piłka Nożna dopiero słowo 80 czwartek pozycja dzielić istota. Indie świadczyć żaden gość. Zakładać interes przedsiębiorstwo połączenie Belgia. Towar klub przedstawienie wiedza. Do republika płakać. Szkolny lipiec źródło. Zdobyć kula starać się szef powstać. Wojsko Anglia poważny ból odwaga.', 11, 135, 13, 53),
(168, 168, 'M', 'jasonrollins', 'Dowód elektryczny lubić stado liczyć katastrofa. Gorączka rola cierpieć zdolność raz. Podczas mocz pszczoła. Marzec trzydzieści Białoruś wiosna 7. Twój stół na zewnątrz. Ogień powietrze jeszcze narzędzie oddawać. Wydawać nawet bycie sukces kaczka strój.', 5, 1, 20, 52),
(169, 169, 'F', 'jeffreyhammond', 'Hiszpania potrawa zwyczaj wąż. Połączyć przebywać akt oba kolorowy obok pojawić się program. Brudny słuchać słuchać. Grzech hasło wartość gwiazdozbiór dobrze. Wieś rysunek ubranie by także równy. Późny obywatelka Jan system pływać. Serce wnętrze egzamin sportowy. Przyjąć znaczny pomarańczowy małpa pełen ząb. Dlatego ból młody polityka zawierać głupek. Ale chodzić zmieniać rola jedyny małpa Chiny dzieło. Ślub walczyć impreza pomoc przyrząd. Dzieło dziewczynka ale księga fizyczny. Wprowadzać rząd ubranie znajdować wewnętrzny. Jakby żydowski sam kaczka. Ośrodek niedziela z planeta kłopot średniowieczny pokój. Członek fotografia nieść. Rachunek musieć wiek kolejowy rolnik wiadomość piąty.', 11, 136, 23, 93),
(170, 170, 'M', 'garciashannon', 'Stracić teatr kolumna styl dokument udział. Odmiana zupełnie wartość otworzyć. Czasem czynnik półwysep iść nagły 3 wilk czeski. Natura usługa część niedziela bezpieczeństwo. Deszcz rodzaj skrzydło ulegać oddać lód dwadzieścia. Brzydki opisać gotować amerykański dziewczynka Holandia. Piękny zmiana określać myśleć. Przeciw wydarzenie uznawać tytoń wolność. Kraina papież opowiadać wzrost zima. Kierować przyjaźń jądro ciekawy złożyć obszar listopad. Stosować archipelag procent sądzić szlachetny cisza.', 11, 137, 22, 75),
(171, 171, 'M', 'bryancarlos', 'Byk środa bohater niebieski studiować wypadek. Pójść przeciwny szklanka węgiel cały liczba atomowa. Ochrona co miejscowość myśleć. Herb aktywny dopływ wesoły właśnie maj. Łagodny symbol odpowiedni cebula zapach. Wybrać koza przyrząd pożar powieść trudny papier kanał. Srebro kultura żydowski składnik zboże poruszać Azja. Piec nagle ono. Wydarzenie pomidor móc kura złoto płaski. 4 w formie pisanie dość orzeł Ukraina. Opieka łagodny banknot płaszcz. Posiłek liść wydawać mieszkaniec poważny. Odwaga wizyta teatr cienki. Poznać dlatego obiekt. Wiele masa jasny mądry z powodu. Element zapomnieć położyć pociąg żart. Gałąź chory wzgórze lato bądź. Zbiór szybko wykorzystywać szkło należeć Holandia lustro pałac. Handel ryba dźwięk. Trzydziesty dzisiejszy biedny. Wracać czynność równy dobry lud.', 6, 1, 25, 77),
(172, 172, 'F', 'garcianicholas', 'Sieć mysz pole administracyjny. Utwór wąż zjeść sztuczny wrażenie ryzyko wiersz. Ubogi blady zwyczaj obrót ramię rzeka. Złożyć składać się czasem przyjaciel czytać. Procent skończyć obchodzić stosować nazwisko odczuwać wakacje klucz. Ustawa np. nieść wyłącznie śnieg urząd. Położyć wniosek smutek rosyjski istotny bydło. Śmierć kończyć zawodowy. Atmosfera tracić obowiązywać Anglia. Pies wyłącznie ich żaba pracować pracownik. Rzymski ziemski moralny długi zachodni. Lista znaczyć granica państwowy uczucie lot. Postawa sprzedaż łódź. Zboże grunt dokonywać kraj niebieski. Piękny olej chłop stać się Morze Śródziemne a. Chleb kilometr barwa.', 11, 138, 18, 94),
(173, 173, 'F', 'ustewart', 'W Wyniku lista zbudować wymagać sąd Indie. Uczucie trochę samica przyrząd 10 – zamiast tydzień. Lud zupełnie wczoraj wywołać latać złoto. Atmosfera odcinek sprzedaż próba nazywać. Naukowiec przyjaciel zacząć. Który ciągnąć plan wiara Anglia gwiazda. Gatunek stopień o 8 studia dobro miesiąc siedziba. Technika bardzo produkt niski ryzyko zboże. Powodować przynieść czwartek podstawowy. Ręka uważać filozofia wysyłać wszystko gazeta. Słowacja sukienka stół narodowy posiłek 9 pies. Oczekiwać źle zgoda pół skóra zachowywać się we. Konflikt łączyć bić obowiązek. Kanał zacząć żółty więcej jądro 30 liczba. Samolot okropny okrągły niedźwiedź.', 4, 1, 20, 1),
(174, 174, 'M', 'ahill', 'Wąski szkło pod przedsiębiorstwo analiza wierny morski. Dwudziesty czy wyglądać dokument zazwyczaj wzgórze. Ryzyko postawa cebula narodowy dotyczyć mi język ćwiczenie. Żyć 40 zwycięstwo bronić skład 900 rok. Pojemnik grunt ona niektóry kara św.. Sytuacja kolor metoda dziura. Kłopot bieda rodzic hasło samochodowy dach miękki. Przypadek zwykły dzieło uczyć potrzebny. Ciężar podać oznaczać spadać pole. Chemiczny stół motyl bohater rezultat. Itp. fotografia okres spadać część samochód. Niemcy wieża nasienie świeży. Poruszać Się czterdzieści 0 zawodowy w celu rzadki ten sam. Hałas aktor książka. Piękny przygotować produkt całkowicie wiara ukraiński słoń. Jedyny wiek osobisty bydło dział działanie. Opłata liczba atomowa struktura cały złoto.', 9, 139, 11, 1),
(175, 175, 'F', 'kellypeck', 'Stolica młody tak bydło słownik. Zysk skala książę butelka zachowanie raz utrzymywać. Określać współczesny francuski zachodni kto. Panować przygotować telewizja dać się. Pomysł dawać zaburzenie pieniądze sportowy.', 2, 140, 24, 56),
(176, 176, 'M', 'richardmerritt', 'Czynnik Anglia składnik chwila nieprzyjemny papieros nikt. Pomóc kolano królewski graniczyć. Działanie konflikt pszczoła. Półwysep oddawać otoczenie gotowy prawda. Grudzień góra system jezioro tamten ogród jaki. Siódmy analiza muzeum niechęć może działalność królowa. Blisko przyszły tydzień broda ale duży. Sześćdziesiąt pamiętać pszczoła trzydzieści most. Sygnał wakacje jeśli stosunek. Taniec moment mieszkanka ślad Pan głęboki. Ameryka sygnał rozmiar uderzenie ! samochód. Gotować 6 żółty punkt Jan.', 6, 1, 11, 90),
(177, 177, 'F', 'bcooper', 'Ludowy powstawać kino coś. Uważać zwierzę noc zatrzymać różnica księga. Okolica handel kwestia uchodzić. Koń zbudować pas fala dzisiaj znaleźć kłaść. Tydzień długo spowodować nadmierny duży okazja zewnętrzny towar. Daleki statek zbudować stopa jakość burza. Hałas Stany Zjednoczone cześć wybór odważny.', 10, 141, 35, 58),
(178, 178, 'F', 'sheila30', 'Grecja szukać rejon mężczyzna Kościół flaga. Babcia tłumaczyć gaz temat rzucić. Liczba wojna ślub ósmy. Półwysep lina żydowski wykonywać. Wizyta związany koza niezwykły. Duński tytuł obiekt koncert katastrofa dwa. Sieć dziedzina ozdoba muzeum. Umieszczać węgiel niezwykły raz płakać dar stworzyć. Jezioro gdy starożytny dom. Szkodliwy święty jeszcze dziecięcy korzyść. Wy miejski cecha zainteresowanie srebrny południowy. Głupek znany walczyć z krwi i kości polityk cztery padać. Mózg proszę dar rok wydawać trudny. Pięć społeczny plemię biblioteka. Zjeść mnóstwo przeciw. Kiedyś górny kolor lustro. Biały kwiat narząd parlament owoc. Królestwo szczęśliwy właściwość tablica.', 4, 1, 27, 82),
(179, 179, 'X', 'lcampos', 'Inny zainteresowanie poważny cień zaraz wojna rządzić. Drobny siedziba kształt masło odważny rzymski koń. Handel klimat pływać palec owca. Woda pas 80 ciasto. Wyspa istota Kościół niebo władza kolorowy obowiązek. Dziób nie albo Rosja. Aby oficjalny zero tablica struktura. Partia książka elektryczny herb 900 ból. Internetowy trudny trudno słońce połączenie angielski znajdować się. Zgoda sen złodziej Węgry mierzyć zawierać. Kolano lub impreza znaleźć trudność brat kolor. Okolica element królestwo gospodarka ludzki często.', 5, 142, 34, 77),
(180, 180, 'F', 'robertgamble', 'Wspomnienie literatura niebo piętnaście. Planeta sztuka szczególnie żyć ? cienki radiowy. Zawsze grupa wnętrze. Postawić życie flaga tylko traktować pomarańcza międzynarodowy. Rejon figura budować. Zdobyć trzymać robota internetowy. Zjawisko ciąża podać on. Śmierć rzeka zwyczaj autor wschodni pracować.', 7, 143, 15, 98),
(181, 181, 'F', 'scottellis', 'Jakość niedźwiedź plemię. Gwiazdozbiór cukier wojna rozmawiać Afganistan potrzeba zająć. Sowa określenie bitwa pociąg rząd pałac być.', 4, 144, 3, 24),
(182, 182, 'M', 'heatherjohnson', 'Szwecja przypominać.', 5, 145, 24, 98),
(183, 183, 'M', 'bonillasarah', 'Niewielki otoczenie mebel seksualny okoliczność wróg. Zupełnie bóg waluta cecha długo lata występować. Lub region pochodzić z krwi i kości w.. Żelazo kosz posiadać zdobyć ocean cukier klient. Świątynia narząd przyczyna mysz herbata dziewczynka. Piąty zrozumieć długo Unia Europejska dziesięć ten. Zadanie imię Niemiec przecież. Wywodzić Się rządzić jeżeli odpowiedni urząd farba przemysł. Pojazd czerwiec USA poczta sobie pożar może imię. Zbiór Ukraina w formie zająć bitwa student mebel. Luty dziób powszechny ustawa Słońce. Kolejny roślina dotyczyć. Różnica coś żołnierz ciemny pojemnik. Numer klient artykuł. Przyjść w rządzić głód dziecko pokonać pożar centrum. Do aby szklanka czysty mieszkaniec ciepło znaczny. Stan 8 punkt drzwi miłość że grzyb. Wytwarzać cały pożar.', 7, 146, 29, 85),
(184, 184, 'F', 'williamjackson', 'Szkło pokryć droga córka. Dziecko wcześnie samiec szeroki przeprowadzać. Zakład zabawka wyspa tekst pani odwaga głód.', 9, 1, 19, 49),
(185, 185, 'F', 'stephaniepowers', 'Potrzeba kamień pamięć tani Afryka tysiąc.', 9, 147, 5, 18),
(186, 186, 'F', 'gwaters', 'Statek dział bać się raz mądry tarcza. Głęboki okno poniedziałek paliwo cisza prawo 10. Miejski wojenny reguła przemysł mierzyć syn daleki. Skrzydło Słońce wystawa klasztor filozofia doprowadzić to. Tutaj ogon wpływ prowadzić rak. Morski studia ogólny natychmiast. Francja w wyniku warstwa student. Strata pasek niebezpieczeństwo 900. Stacja dziś przemysł osioł mąż dopiero. Rodowity w ciągu uczyć się mówić pomagać Boże Narodzenie samolot. Ból zaraz twarz coś całkowity powierzchnia. Cesarz dwanaście natura wstyd relacja. Móc jazda Hiszpania rola naprawdę efekt. Lubić jabłko Pan z. Rola chodzić zamknąć przestać 50 sos mgła płyn. Zgoda bok właściciel ósmy król.', 1, 1, 3, 51),
(187, 187, 'M', 'alex86', 'Niebezpieczny pojazd poziom służba myśleć nie. Ubranie położyć transport podłoga mieszkaniec. Trochę przedsiębiorstwo godzina słaby poduszka radość. Cesarz co posługiwać się okropny jezioro korzystać. Ludowy grupa japoński wchodzić luty produkcja stanowisko. Sytuacja chmura filozofia długi północny. Narodowy daleki ci olej część związać jej wolno. Już dziać się dziać się zakres. Rola udać się Jezus trzeci patrzeć. Ludzki do świat pismo przeznaczyć zanim nie-. Północny spaść dać się element. Ogólny obywatel przynieść wesoły krótki. Prosić jeżeli głos majuskuła. Razem złożyć samochodowy pomóc cierpieć pokazywać. Przedstawiać ziemniak kolejny koszula. Biec rzymski region stawać się. Płakać historyczny umysł natychmiast plaża Niemiec.', 10, 148, 9, 2),
(188, 188, 'X', 'deancurtis', 'Sos uciekać otworzyć związać skutek słowacki kaczka. Jeżeli strona wolność kawałek. Austria śnieg połowa zatrzymać zamknąć uderzać Morze Śródziemne. Europejski nadawać owca oglądać zajmować się. Nieszczęście widoczny angielski zawsze. Jajko nasienie muzyka naprawdę wywodzić się powiat. Blady nie- krowa dawny obywatelka ogólny kiedyś mówić. Spokój należeć dziadek podatek wejść. Skrzydło wrzesień zamknąć pani. I para biskup pole akt grupa zamiast ser. Wrażenie planeta rozwój. On wyścig może stanowisko siedzieć bydło upadek. Rozmowa słońce ludzki poniedziałek miłość tył Turcja. Płeć kiedy wciąż przedstawienie okazja obecnie widoczny. Nazwisko straszny francuski ciężar 1000 siódmy przeszłość.', 4, 149, 33, 88),
(189, 189, 'M', 'whitejoshua', 'Łódź wyspa nieść gniew wczoraj turecki święty. Mierzyć wartość Chrystus przyszłość region wnętrze choć. Choroba obrona Szwecja budynek prosty wada ściana oczekiwać. Połowa narząd osobisty przyjemność stosunek rozumieć prawo. Mało potrafić wybory metr poza również. 60 nie centralny prawdziwy. Gwiazda robotnik poprzez podróż noc. Łódź po wola wykonanie ponownie Szwecja pieniądze. Bez wewnątrz wojna gorący 0. Dawać handlowy gałąź spadek. Go polityczny dwudziesty zima wiatr. Złoty literatura męski marka podnieść masa wydać pochodzić. Państwowy energia tor fizyczny. Posiadać sprzęt złożony. Książka wilk obcy kościelny postawa. Dokonywać Chrystus skrzydło śniadanie pismo.', 6, 150, 36, 20),
(190, 190, 'F', 'kvaughn', 'Fizyczny rzeczownik matka dane państwowy siedemdziesiąt zadanie. Itp. prędkość niewolnik wczesny. Tyle wewnętrzny dolny zgodnie nikt w formie. Zwycięstwo bank administracyjny spotkać Białoruś co. Aby atmosfera człowiek oś. Miejski okolica piec konstrukcja zmęczony bo tłum. Gwałtowny przeciwny problem wewnętrzny ubranie chrześcijaństwo. Związek wreszcie motyl. Rzecz sklep tamten myśl. Zanim powstanie noga gęś metr siódmy. Tracić 50 wóz zostać wygrać toponim. Tłumaczyć cień gałąź talerz fakt kwiat.', 5, 151, 10, 7),
(191, 191, 'F', 'thomas13', 'Boże Narodzenie bardzo miłość. Przypadek wrogość góra. Częściowo handlowy prędkość rzecz radiowy. Ważny na zewnątrz prosty strój świątynia ręka. Pomóc wyspa ciągle możliwość postać rola Ameryka. Przerwa pomiędzy norma sygnał lampa poniedziałek niewielki. Pół Czechy pióro wyrażenie wybory masło. Koncert wojenny pałac rysunek. Rak jeszcze trudność. Suchy bogaty tak istotny ryzyko. Ręka wtedy mebel wracać jak naj- potrawa komputer. Rozpocząć trzymać wilk poziom nad. Medycyna wybory pojemnik obowiązywać. Dać obchodzić cecha śmierć wyjście rodzic jedenaście. Pragnienie dziać się uważać pani wojsko uśmiech jedyny skała.', 6, 152, 30, 71),
(192, 192, 'F', 'coreywhite', 'Tylko choroba jeśli ubranie prawo mózg. Ojczyzna czynić pytanie kolej sklep zgadzać się. Tańczyć naturalny dzielić. Tłumaczyć polegać prędkość biblioteka wesoły ciepło. Społeczny przyrząd obowiązek wrócić dwanaście.', 2, 1, 35, 55),
(193, 193, 'F', 'seanlewis', 'Widoczny lekarz sylaba.', 4, 153, 17, 2),
(194, 194, 'M', 'bradleyjacob', 'Kalendarz autobus suma pożar. Dany rozwiązanie szkło fotografia dwudziesty ryba. Fala prawo godzina powoli jeżeli. Zdanie dłoń minuskuła włoski scena słoń zielony zobaczyć. Wysyłać budowa lista książka. Żona postępowanie wysokość gorący upadek młody polski lub. Papieros Austria opowiadać barwa. Oficjalny zaraz wojskowy tańczyć sądowy. Na Przykład słońce delikatny zainteresowanie zawierać zewnętrzny.', 4, 154, 18, 97),
(195, 195, 'M', 'walkerkimberly', 'Mocny miejski zupa mięso rozwiązanie szkolny ta. Typowy uważać korzyść lato również mistrz kontrola.', 3, 155, 7, 95),
(196, 196, 'F', 'patricklane', 'Październik uniwersytet prezent wykorzystywać kupić. Trzymać taki zaufanie.', 4, 156, 19, 27),
(197, 197, 'F', 'dcrawford', 'Klub powstać skład produkcja łuk głęboki. Białoruś trzy ozdoba połączyć samica. Użycie literatura biuro półwysep osobisty wy ósmy. Alkohol rzucać wymagać głośny państwowy wystawa żydowski. Zwykły wpływ odważny tytuł ból USA tydzień. Odzież stanowić książę – jądro. Mieć gorączka krzew władca pieśń. Śpiewać rolnik potrzeba Chrystus wrócić wybór ogólny. Łagodny gdzieś funkcja swój dzielić własny. Kij ubogi jechać obchodzić smutek zjeść śmiać się. Poruszać ziemniak alkoholowy ani głupek telefon śnieg. Ta głupiec dobrze kontrola północny finansowy. Sylaba skała hasło maszyna temu mama specjalny trzeci. Nasiono książka projekt biec organ wymagać wyspa pomieszczenie. Ósmy fala wzrok otoczenie. Wróg lód Chiny Dania region położyć. Władca wszystek wąż powstanie sztuczny. Zamieszkiwać drapieżny ostry dźwięk żywy znaleźć luty kontrola. Trudno oglądać dany szlachetny brać.', 9, 157, 9, 98),
(198, 198, 'F', 'rodriguezautumn', 'Rasa bezpieczeństwo olej na przykład wiek środa handlowy. Władca łatwy gatunek minuta za wszystko wojskowy.', 5, 1, 21, 43),
(199, 199, 'M', 'vnguyen', 'Białoruś bok instytucja aktywny płakać sowa. Odzież radiowy poeta policjant Rosja ząb. Pomidor całkiem gospodarczy dobro szybki uciekać jednak. Chodzić trudność skóra założyć stado Rumunia zboże. Wybory no dzielnica pokryć miejski związek dziecięcy. Opieka żydowski wydawać się noga z powodu wąż. Połączyć aktywny restauracja przyjąć lód. Dolina teraz ciepło wkrótce. Przeprowadzać ludowy napisać pojęcie naturalny bogini. Sport ser 90 seks w czasie zima. Utrzymywać specjalny wojsko następny. Prosić złoty powód. Figura zmieniać nagły port część graniczyć. Połączyć ćwiczenie użyć szklanka godzina.', 6, 1, 30, 26),
(200, 200, 'M', 'deanna51', 'Nasz dostęp w formie. Ten Sam kara pieśń proces lew litera zatrzymać. Bajka gra ręka mieszkanka dodać czoło chrześcijański naprawdę. Instytucja anioł wyjść Szwecja starożytny szef wóz pająk. Jakiś przyjmować zegar teoria drobny akcja te gotowy. Babka kij angielski róg kobiecy rok. Drewniany chłop zwyczaj niebieski 10 cesarz litera seksualny. Woda obchodzić brzydki pogląd. Żółty jazda ośrodek środa włosy z krwi i kości. Bez nasiono postawa obiekt plac prawda szybki. Francuski niedziela atmosfera bydło dźwięk pozostawać. Ksiądz sprzęt 60 czynić pochodzić strój alkoholowy pomarańcza. Pogoda Jan zamykać dach. 40 przejście flaga podobny przejście pozostać. Pewny większość lew. Oba królowa las nieszczęście.', 8, 158, 24, 58),
(201, 201, 'M', 'jennifer10', 'Szybko ulica.', 2, 1, 18, 55),
(202, 202, 'F', 'ostewart', 'Pacjent ci bezpośrednio proces syn. Czynność o we flaga dwudziesty uderzenie szyja. Biuro skutek wilk koncert. Gołąb świnia znaleźć międzynarodowy znosić niż otwierać. Cena lis jezioro mowa utwór biuro. Obywatel za pomocą 7 funkcja piątek spotkać. Powszechny wieczór znać bo fala. Policzek powodować wyłącznie biskup własny zgoda. Sytuacja USA ciekawy zdrowy początek także. Mgła pierwiastek chemiczny biuro pracować ćwiczenie artystyczny. Serce dyrektor fala szkoda prawda. Grecki mężczyzna ciągnąć grunt u. Dość nic dokonać udział własny dzieło. Obecnie wnętrze ciało. Interes sprzedaż cesarz bułgarski. Udać Się pierwiastek siedzieć ósmy oddech w formie większość. Królewski ramię złodziej róża wartość. Wydarzenie gra po metalowy ?. Grupa wstyd Kościół.', 1, 159, 24, 97),
(203, 203, 'M', 'rebecca24', 'Specjalny noga np. chyba.', 10, 160, 22, 38),
(204, 204, 'F', 'kbell', '— metal tor wycieczka. Wschód dziewczyna przyszły krew finansowy. Znajdować Się przecież kilometr płacić nastrój. Stolica religia zwierzę dzięki. Ogon tradycyjny religijny nowy 70. Urodziny zając kontrola. Zawartość siła głupiec. Lato 50 potrzebować pieśń budowla akcja zmienić. Anglia nosić północny instrument. Pływać roślina aktor sport współczesny. Warszawa tydzień zrozumieć przy łuk usuwać otrzymywać. Uderzać mieć brązowy w postaci. Wiele 1000 palec lustro.', 10, 1, 27, 90),
(205, 205, 'F', 'rileylinda', 'Organizacja 20 poza liczba. Zajmować prawdziwy znak chcieć pochodzenie w celu Ameryka. Słownik wolność chleb jasny. Jutro — rosyjski cel. Zawartość finansowy ocena złapać miara żeński pokryć zwykle. Północ ziarno klimat dane luty jej wyrób. Iść wolno różny twardy złożony opieka specjalny. Otaczać szkło można prosić padać świadczyć. Modlitwa następny minister doświadczenie wina osobisty. Sobą nikt 900 przeszkoda student grzech. Patrzeć zły kalendarz drewniany miękki czyli kosz łatwy. Modlitwa tradycja lampa bilet zwolennik czysty parlament.', 7, 1, 9, 92),
(206, 206, 'F', 'chancarol', 'Skłonność prasa przeszkoda szkło muzyczny panować walka. Drogi sól wszyscy przedsiębiorstwo pytanie. Zgoda literatura zapis aż gęś zapis małżeństwo. Okoliczność dawać piątek wydać pojawić się no pełen nazywać. Strefa republika pogląd chrześcijański Ziemia. Samica poza chociaż materiał. Interes majątek domowy przypominać lęk. Pełnić gruby głowa stać się stado drapieżny powinien użytkownik. Liczba jakość poeta postawić zawodowy godzina łyżka ćwiczenie. Wywodzić Się stanowisko żeby rosyjski mężczyzna. Trzeci owad decyzja wiek grudzień leczenie płyn umysł. Prostytutka ! wpaść ciasto wykonywanie telefon. Muzeum niski biedny prąd gwałtowny słuchać prąd okropny. Rana wy ramię zabić w postaci siedemdziesiąt budzić. Konstrukcja wybitny danie śmierć księżyc człowiek kultura drużyna. Cel sygnał u obchodzić drzwi przyczyna.', 11, 161, 35, 56),
(207, 207, 'M', 'fjames', 'Ryż lekki r. kościół sukces. Zrozumieć mężczyzna Afryka prawdziwy starać się. Szary twój niebezpieczeństwo mecz informacja pomoc niewielki. Prywatny przeznaczyć ostry naukowy literatura kiedy gorączka czterdzieści. Model chrześcijański polski tyle klasa ubogi cukier. Król hiszpański tylko Kraków pustynia. Wybuch zabawa dodatkowy szeroki chęć wczoraj umiejętność. Obecnie Rzym ilość 7 drobny niedźwiedź. Pokarm jadalny daleko bawić się. Szczególnie symbol klub metal papieros. Dzień koncert gotowy powoli atmosfera. Blady z całkiem pomarańcza wesoły odpowiedź kolano. Luty napisać Japonia telewizja świadczyć Węgry serce pewien. Technika zachowanie lotniczy rzadki miasto miejscowość zwycięstwo. Ofiara spadek krok. Wilk liczba atomowa polować szlachetny własny. Hotel 0 połowa żołądek. Kapelusz zakończenie ogień dziecięcy seksualny.', 1, 1, 2, 7),
(208, 208, 'M', 'edunn', 'Albo naukowiec koło sędzia. Pochodzenie rok godność zrobić. Zobaczyć śpiewać śmierć Wielka Brytania ćwiczenie smutek.', 9, 162, 23, 8),
(209, 209, 'M', 'hillmelinda', 'Cztery wszyscy delikatny. Praktyka wysokość umieścić właściwość tłum. ! dawać dźwięk godzina niezwykły odpowiadać. Patrzeć martwy kupić kult wywoływać. Wiosna kartka wziąć stan przeszkoda.', 6, 163, 14, 68);
INSERT INTO `opis_uzytkownika` (`id`, `uzytkownik_id`, `plec`, `pseudonim`, `opis`, `rodzina_id`, `zdjecie_profilowe_id`, `ulubiona_modlitwa_id`, `parafia_id`) VALUES
(210, 210, 'F', 'jamesrichardson', 'Piłka ciasto oddział napój następować turecki. Kawałek drzwi cisza głowa potem zakończenie. Małżeństwo prosty klub wydawać się dodatek utrzymywać zimny aktywny. Potrzebny ty policjant 5 sportowy odmiana nazwa. Palec znaczyć dlatego chronić przyjmować narkotyk. Umiejętność chłopiec potrzeba stopień. Zaczynać oddział masło młody nic odzież. Prawie odnosić się obok wzdłuż ojciec.', 7, 164, 20, 66),
(211, 211, 'F', 'brownlinda', 'Grecja kupować położyć wolno piąty drużyna zrobić. Podstawa zamek późno rozwój. Specjalista nasiono wykorzystywać. Ofiara powiat potrzeba słuchać.', 7, 165, 30, 27),
(212, 212, 'M', 'hansonjeffery', 'Hasło ty skutek problem. Gazeta określenie my żywy proszę technika dziewczyna.', 4, 166, 31, 75),
(213, 213, 'M', 'nataliecollins', 'Wojenny.', 6, 167, 36, 66),
(214, 214, 'F', 'amandasherman', 'Przeszkoda hasło oczekiwać tradycyjny ponieważ świadczyć. Ostatni słowo zupełnie. Grecja żeby punkt. Mąż kino dość organizm. Brzydki stworzyć pójść system tak wspaniały. Jeździć czynić smutny sobie łaciński książę aktor. Pojazd jasny udział zmiana. Organizm dziewczynka podawać religijny rzucić stanowić mowa przestać. Czasem ciało czynnik błąd Australia. Fakt płynąć góra kwiecień niebezpieczeństwo. Bogactwo lipiec pamiętać opisać Szwajcaria bogaty. Odczuwać powodować obserwować młody pojawić się chyba samiec. Potrafić szukać pojechać ręka. Przyjść biblioteka okres nasz Piotr. Otworzyć powstanie wzrok płeć książka. Na pisanie bieg mrówka deszcz zająć pójść krótki. Tam sieć szkodliwy przedstawienie ogromny spotkanie zając. Okropny rzucać przebywać często wszelki księżyc uderzać analiza. Doprowadzić Niemiec daleki mały pojedynczy but pies.', 7, 168, 33, 15),
(215, 215, 'F', 'bentondaniel', 'But stół kierowca grudzień wejście pomarańczowy przyjść minister. Skała wybuch czyli daleki. Zgodnie zaburzenie wolność abugida biały. Osiem rada płeć wiosna. Zaufanie włos Holandia. Dodatek internetowy pokonać słowo chronić gwałtowny znaleźć. Atmosfera pić przyjaźń zbierać Niemiec czwartek naj-. Organ św. przygotować lustro ile. Zająć koncert brzydki w celu program. Morze błoto zero. Przychodzić ludność 6. Szacunek program wada wygląd kolacja złodziej. Działanie itp. użycie polityczny. Przeznaczyć cierpienie teren ty obywatel babka aktywny pójść. Koło brzeg ludzki stado narodowy podawać.', 9, 169, 18, 39),
(216, 216, 'M', 'ylawrence', 'Zwykle babka piłka piosenka w celu właściwy. Czasem kraj wujek mówić kij. Także karta literatura kwiat.', 3, 170, 9, 94),
(217, 217, 'M', 'alexosborne', 'Mysz forma pole niedźwiedź smutek aktywny. Rząd wszystkie skrzydło. Niedźwiedź nad pływać grunt restauracja dużo. Brzydki gruby mięsień gęś pokazywać pomidor model. Polska mieć srebro samolot przed. Poprzedni kolumna żaden widok.', 5, 1, 11, 15),
(218, 218, 'F', 'kimberlyjackson', 'Popularny wykonywanie pijany Węgry mnóstwo głupiec zabić niebo. Więzienie należeć ser samica wyjście katastrofa. Igła produkować one motyl dzięki plecy. Szary filmowy mówić wąż wzrok. Wzrok stopa księżyc promień bar zostać wilk.', 1, 171, 8, 14),
(219, 219, 'F', 'mcdanieljennifer', 'Treść szybko trzydziesty kartka. Pomysł mąka noga bar. Pole kultura stać się chyba biedny grzyb. Austria sposób arabski jezioro sprawiać czyli wspólny. Rozmiar te kościelny poprzez miłość odległość ulegać ubogi. Domowy obejmować bar. Pytanie zimny małpa. Ty oglądać początek. Zamieszkiwać pacjent postępować Niemiec. Narzędzie rok bułgarski babka płacić teraz długo. Lato potrzebować efekt pociąg. Ziemia rodzina godzina zajmować się białoruski jądro.', 1, 172, 22, 60),
(220, 220, 'M', 'mramirez', 'One nic alkoholowy Żyd. Podczas kwestia Azja błoto średniowieczny 1. Broda but włożyć użycie bóg rower. Pismo strefa spokojny młody papier region zająć. Masa pięć sobą teoria jeśli. Określenie jednostka strona przemysł. Katastrofa zewnętrzny wysokość sąd nauczyciel. Mecz trzeci alkoholowy tradycyjny wszelki. Kościelny wola sztuczny z powodu dolny lista pracować. Osiemdziesiąt specjalny silnik od. Polegać kontynent przestać w końcu. Policzek dwudziesty znać ktoś zawód. Bogini popularny pojedynczy całkowicie. Korzystać minuta dłoń.', 4, 1, 2, 101),
(221, 221, 'F', 'lisasmith', 'Zazwyczaj znaleźć zespół długo biskup naczynie. Badanie związany łaciński poduszka. Wyrok wywodzić się udział zaburzenie. Urodzić chmura wielki sok francuski osiemdziesiąt. Turcja podać proces. Żeński wrócić ciężar przyjaciel ocean oddział. Tłum nieść zatoka odcień wygląd choroba wejść zły. Natura oddział małżeństwo Polak muzeum. Świeży długo Rosja. Fabryka sprawiać gęsty bogaty łyżka usługa mieszkanie. Żydowski słownik mało interes zakończenie wszystek przyjaźń. Papier posiłek uciekać pies mierzyć. Panna 20 obywatel wtedy tłumaczyć język. Bieg tytuł większy szczególny kolacja. Zdolność gaz mapa ich jeździć. Zwrot Afganistan sprzedaż dziewiąty następować stawać się bitwa umysł. Służyć liczba atomowa wejść kultura lina polityczny.', 5, 173, 23, 95),
(222, 222, 'F', 'fvasquez', 'Wszyscy wyrażenie ośrodek wspaniały pamiętać. Włoski połowa czekać toponim jeden. Grupa wrogi kartka ruch.', 1, 174, 31, 27),
(223, 223, 'F', 'tiffany66', 'Wujek przyjaźń wolno zero. Dawny płyn instrument pełny wydawać się pisać. Brat norma gmina Anglia zupa państwo dawno. Litera rok wyrób robota Grecja sprawa. Dokonywać skład nazwa teoria. Owad temu większość głośny ja. Zielony wspólny wszystek gwiazdozbiór na system klimat prowincja. Stać Się istotny narzędzie pozbawić ze skutek. Rodzina zawodowy nagły napój. Żywność powstawać świeży. Miejski konstrukcja trudno ! dodatkowy kartka. Rzym jeden błąd noga brat wybory. Osiemdziesiąt pociąg kamień aż. Białoruś urodzić deszcz sędzia pojazd. Wpływ wydarzenie sen lekki wystawa ciepły fałszywy. Szybko wyrażenie ser bar ziemia. Oko wciąż ogród lista. Zwierzę północ autor stosować cały towar prywatny film.', 9, 175, 18, 83),
(224, 224, 'M', 'cassie03', 'Port twardy internetowy 7. Właśnie seksualny publiczny język bar śniadanie. Teoria wada obowiązek 900 wynosić wiosna. Sok wzrost sądzić podobny rzucać dyskusja. Dziewiąty raz urodziny skala one m.in. umieścić. Pojazd lustro maszyna dyrektor słaby niemiecki wyraz. Ofiara zgoda bajka Żyd rower. Od teraz danie Rosja kwestia szybko. Słowo minerał tamten własny. Sygnał we potrafić chociaż ponad. Nosić cześć ludzie zajmować dział opuścić transport. Wykorzystywać wypowiedź znowu warstwa iść. Czterdzieści temperatura wytwarzać napój. Telewizja naj- postępować wieczorem ogień. Kiedy człowiek zgodny zielony. Kościół ojczyzna tańczyć próbować. Obchodzić zwykle ale Stany Zjednoczone dźwięk. Tkanina nic tablica niechęć surowy itp.. Od ich ktoś ocean. Blady opinia kraina dziedzina bieda. Dłoń – córka byk szwedzki wola. Powierzchnia złożony wybuch miejski śmierć daleko lub. Właściwość wierny tu. Dotyczyć poziom cena uzyskać akt. Może czwartek dodatkowy bajka krowa.', 8, 176, 2, 23),
(225, 225, 'M', 'bestjoan', 'Obrona malować wiersz pozostać ręka samochód. Teatr m.in. niemiecki pojazd. Dania prędkość jakby dalej religia ofiara. Drogi głupota bogini USA samochód. Twój — moc przeciwny zaczynać miecz urzędnik. Konstrukcja wybory biedny około przeszkoda czasownik. Płakać przedstawiciel społeczeństwo religia obecnie. Wiedzieć ciepło spodnie spadać bóg. Cukier region pierwszy pokój minister. Dania wydawać drzewo ciężar sprzęt kolacja aktywny.', 11, 177, 13, 17),
(226, 226, 'F', 'wilsonchristopher', 'Pierwszy struktura państwo rak. Błoto opowiadać handel ciepły rozumieć oraz dźwięk. Również łatwy dotyczyć pracownik zapalenie panować prawda. 70 rasa ważny wywoływać znów Turcja. Wino zakończyć grupa wytwarzać poziom papieros francuski. Przyjechać poznać japoński ludzie farba. Wnętrze modlitwa wątpliwość wojenny gdzie czasem. Wiosna Węgry zdrowie 3 figura. Nocny udać się różowy zostać. Księga zwrot wiara kąt pomarańcza. Odległość kolejny republika. Pieniądz naczynie podstawowy.', 1, 178, 31, 65),
(227, 227, 'M', 'analambert', 'Szwedzki liczyć żydowski określenie warzywo ból komórka. Samochodowy zmarły przedstawienie tradycja silnik wiara chyba. Narodowy wyglądać natychmiast marka bezpieczeństwo wysoki. Brzuch termin wprowadzać powolny. Kino prawny różnica. Państwo i nos japoński te wyrażać kupić. Bezpośrednio tamten europejski robić typ. Lecz złożyć operacja coraz niebo pająk ziarno wielkość. Krzesło orzeł analiza teraz środa towarzystwo kamień psychiczny. Obrona podstawa szklanka wtedy naprawdę ciepło. Smak nic Rzym gdzie ponad pojęcie motyl. Tyle wskazywać oddawać prosić mało ? dostęp. Motyl zbiór czekać sześć głównie zewnętrzny wiara raz. Sen pogląd Izrael publiczny.', 8, 179, 36, 77),
(228, 228, 'M', 'christineross', 'Konstrukcja wioska brzeg. Ślub dusza hasło zarówno Kraków orzeł. Pływać świecić przy. Czuć nasz rzeczywistość skala masa nauczyciel. Babka cierpieć chory odnosić się kolano urodzić. Przeszłość metoda kura bardzo łąka akt. Pojazd ósmy wydarzenie ciąża Grecja owoc. Efekt mózg dalej narodowy planeta program. Litera sok krzew córka Polska piec. Głównie niewolnik zwycięstwo teraz przynieść chrześcijański pytanie. Działalność sobie podatek złożyć ciotka złodziej lis.', 2, 180, 2, 70),
(229, 229, 'M', 'farnold', 'Połączyć szef pragnąć bliski ogromny. Siostra dział plecy łatwy postać. Dolina dopiero wojsko szczególny. Pić Warszawa pokazywać zainteresowanie muzeum. Uderzenie lot bieda ćwiczenie nie. Srebro obywatelka 5 miejscowość rodzaj.', 8, 181, 30, 100),
(230, 230, 'F', 'marshallcindy', 'Fotografia zamykać wolny olej środek. Strata wzór czynnik jeżeli pies. Rzeka sprawa wyrok. Zobaczyć w wspomnienie. Starać Się budowla wyłącznie rzadko. Całkowity potrafić 50 autor próba jeśli rola. To rynek cukier dziesięć. Obraz zaczynać port wewnątrz. Połączyć od lampa widzieć centralny Unia Europejska sportowy. Wydawać Się wspólny dziewczyna alkoholowy brzydki seksualny. Zrozumieć głośny znaczyć mieszkanie jasny. Wewnątrz wpaść płaski dyskusja. Szósty zdjęcie rzeczywistość szkolny. Uwaga opisać ssak złapać musieć lęk. Wisieć rezultat odwaga przestać zająć wyraz. Pogoda tysiąc bajka wygląd poruszać wybuch. Umieć nie ma 3 zakończenie wynik. Kontakt plecy ciąża policjant ciężki.', 8, 1, 12, 48),
(231, 231, 'M', 'nberry', 'Nie- broda numer wysoko koszula butelka kontynent napisać. Służyć przeciwko bić razem czwarty bić żart szybki. Np. chłop krew.', 2, 182, 32, 32),
(232, 232, 'M', 'shawnwilliams', 'Gmina bohater ojczyzna zamknąć. Jeżeli poruszać grunt wróg tarcza nauka daleko. Wywodzić Się podział krew wewnętrzny. Kupić słowo relacja głupota. Obraz podłoga forma 8 mama pomarańczowy tu. Obrona szósty zając 2 plac artystyczny. Świątynia żelazo różnica prawy przynieść. Czynić rozmowa taniec w podróżować ćwiczenie Europa. Zająć 6 bank. Włochy uzyskać bardzo umieć w.. Osioł się położony pogoda. Możliwość mało wyglądać przejść mieszkanka 2. Łatwo papieros taniec przyprawa organizacja produkować partia. Wyścig rola próba zrobić usta żywy kaczka jeść. Ryba oczekiwać wartość historyczny Wielka Brytania.', 3, 1, 32, 43),
(233, 233, 'M', 'smiller', 'Świecić dawny wyraz praktyka. Kolorowy przebywać początek śmiać się. Na Przykład gospodarczy zawodowy telefon samolot Pan.', 2, 183, 31, 79),
(234, 234, 'F', 'acevedodaniel', 'Lotnisko w czasie stopa krok rzadki. Niedziela wieczór pamięć otworzyć wszystek otwierać rower. Gniazdo lipiec miasto cmentarz trzydzieści szef. Pozbawić szczęśliwy Niemiec wcześnie ty całkowity 1000. Umowa głód diabeł potrzeba plan litera zapalenie nowy. Cierpieć typ umieszczać doprowadzić wprowadzać Jan dać się. Szary wartość czerwony ten sam powstać. Młody godność oznaczać wina. Moc charakter zbierać. Oddział sport by żaden. Wódka być osoba zawód cześć wioska. Wybory grób narodowy tam ulegać krew.', 9, 184, 19, 77),
(235, 235, 'F', 'amandacollins', 'Siedemdziesiąt poruszać się język umieszczać czekolada 60. Dialekt tłum ona sprzedaż babcia. Trzy teraz zamykać. Ja wewnątrz ile tysiąc coś zapis lata. Dokładnie szkolny otwór pokazywać. Francja pić składać mleko tamten efekt płaski. Między rysunek przeprowadzać rządzić. Sprawiać żyć sala oczywiście. Srebrny brzuch państwo jedenaście położenie. Biuro trwały warzywo pokonać. Chociaż policzek jesień wiedza obowiązek stacja. Składać mówić obiad zewnętrzny. Model radość psychiczny plac jednostka lotnisko. Deska wpływ dodatek. Moment obiekt pisarz zgromadzenie tradycja 20. Złapać odcinek wchodzić. Dziedzina spotkanie jakiś okręt gałąź (…). Ich przedstawienie ponownie. Choroba idea domowy. Wierny znowu podróżować amerykański wiek rzeczownik. Deska zamknąć zjeść przeciwko obwód. Milion listopad obecny za pomocą pisarz krótki. Przeszkoda jaki dziewczyna wiadomość Austria czyn. Zły mądry pałac ciemny zjawisko. Azja usuwać mleko tutaj.', 11, 185, 13, 8),
(236, 236, 'M', 'mballard', 'Zaczynać kłopot lipiec marka Dania ku przechodzić. Pomarańcza 1 włos malować mebel. Grzech wyrażać korzeń przygotowywać Grecja. Suchy wschód miejscowość transport listopad. Program środowisko Morze Śródziemne zbierać 50. Powiedzieć zwykle działanie mieszkaniec mąż. Turecki zaraz moralny łódź telefon. Składać Się zawierać cebula zmiana siódmy. Płyta dodatkowy charakterystyczny. Wada grupa jajko córka ziemniak dłoń. Żołądek czeski atak dzieło. Zachowywać Się umieścić dwa komórka siedziba wynik obywatel. Proces sąd cena majątek stanowić obejmować gra. Wniosek bawić się członek wiedzieć powodować piętro. Nieść rozpocząć dziób dzisiaj rząd okrągły. Żółty palić sprawa uderzyć ten srebrny. Interes wyrażenie przechodzić książka. Lecieć znać wąż. Ziemski człowiek stały spokój chiński wartość pająk funkcja.', 4, 186, 24, 76),
(237, 237, 'F', 'markfry', 'Sposób zachowywać się wyścig. Późno w czasie wszystek lekcja wąski nie- egzamin daleki. Wrogi zakończyć łuk prawo. Twarz wykorzystywać Belgia 90 nie. Zdolny itp. chwila jak dwanaście w miód. Hasło maszyna pomidor metoda składać się owoc. Każdy przynosić oznaczać Kraków nauczyciel zwłaszcza. Użytkownik urząd wynosić twardy uzyskać lekki na przykład. Zwykle pojawić się 50 piwo. Głupiec ustawa dziecko nagły reguła dzień. Herb literacki jabłko alfabet wysokość jasny godność medycyna. Kłopot w pochodzić numer. Ameryka zawód reakcja deska ciemny budowa wydać. Policjant wiedzieć władca wątpliwość zeszły opowiadać czoło.', 11, 187, 23, 100),
(238, 238, 'M', 'murphybradley', 'Dostać jezioro papier mieszkać zatoka ból skała. Polska oczywiście przypadek lipiec bronić czerwony. Śmierć w kształcie zachód Egipt rozpocząć 20 składnik. Własny dawać kto pojawić się grzyb książka zachód Dania. Rejon abugida aktor a Litwa metalowy dialekt. Poeta zgodnie nóż korona. Zamiast kultura koszula trzeba dzień dodawać. Grzech te dach zamiar. Kura kłaść rzucać religijny to robota kosz zamiar. Książka masa zabawka złoto maj tytuł. Dziewczyna łatwo wysiłek zaufanie potrafić niektóry. Rosja zamknąć czasownik silny kawałek wioska według przyjechać. Rozmiar dziwny palec bądź daleki. Oko swój czeski system pełny. Typ Niemiec sygnał. Mężczyzna pieniądz obszar oznaczać. Okoliczność te z. 80 odpowiadać moc zostać posiadać. Sen urządzenie zakład. Kawałek narodowy koniec sukces ośrodek jego nikt. Jednak życie futro orzeł klucz.', 4, 188, 36, 90),
(239, 239, 'M', 'david85', 'Znaczyć zdrowy gatunek śmiać się wybory. Głupek pływać podział zbiornik wywodzić się wciąż. Mięso uderzać 2 m.in. uwaga -. Wieczorem dostać miód substancja nastrój zjawisko proszę. Jedzenie dziki przyjść okres symbol. Fizyczny granica obok temat. Brak mocno ludzie ojciec klimat łąka zmieniać. Głupi gęś miecz wokół słoń królewski strata. Zapach dłoń kot kupić plecy dzisiejszy. Brzuch rola obchodzić igła lek przed. Ponieważ toponim krótki funkcja postawić kobiecy ale mi.', 3, 1, 29, 64),
(240, 240, 'F', 'simpsonanthony', 'Staw danie znaczyć sierpień. Kto fabryka odcień wtedy myśl miły miłość. Wyrok owad przy wypowiedź dobro utrzymywać rozmiar. Zakładać herbata plama operacja pomiędzy wydawać napój. Temu pomidor wąski jądro. Wzdłuż banknot wybitny babka kaczka. Bohater strata potrawa. Albo tylko palić. Lecieć czerwiec ubranie liczny cichy wzór Morze Śródziemne wewnątrz. Niszczyć martwy Azja kostka należeć pusty. Uchodzić muzyczny niech w ramię. Pomagać wniosek cisza orzeł do. Przygotowywać wynik połowa nowy. Zwykły krzew wujek wąż hasło. Piasek dobry uniwersytet. Wodny pomagać centrum cienki więc wysokość epoka banknot.', 7, 189, 21, 14),
(241, 241, 'X', 'shane19', 'Element podróż korzeń żaden przyjaźń niezwykły naukowiec banknot.', 9, 1, 8, 38),
(242, 242, 'F', 'aimee80', 'Kara las niebo. Polityczny chwila sztuka system spadek być. 900 głupota modlitwa olej. Lampa powszechny międzynarodowy Jan. Święto alkohol metr ośrodek wysłać pokonać. Walka smak naukowy łączyć umieszczać ogólny szkoda.', 9, 1, 15, 39),
(243, 243, 'F', 'kristin14', 'Dobrze hałas we wynik 30 zdjęcie rodzic.', 9, 1, 16, 47),
(244, 244, 'F', 'kevin72', 'Połowa cel padać odpowiadać. Budowla gazeta prawo upadek choć.', 3, 190, 24, 5),
(245, 245, 'M', 'patrickyoung', 'Gałąź domowy - umieszczać autor ponieważ. Podawać kolumna stanowisko rozumieć. Kiedy 70 społeczeństwo – budować brzydki następować. Sok rozwiązanie pisać. Milion metal charakter tkanina głupiec kawałek. Sobą konstrukcja kupić termin związek.', 8, 1, 25, 67),
(246, 246, 'F', 'skoch', 'Pomoc jaki rada hiszpański. Aby zboże odnosić się. Komputerowy lata straszny fabryka postępować nawet ser. Herb oficjalny wspomnienie wielkość tył. Włoski walka telewizyjny warzywo taki ci chrześcijaństwo punkt. Naturalny wykonanie mieszkanka Bóg zrobić. Trzeci morski znaleźć przynosić cel tańczyć. Graniczyć północny uciekać płyta zapalenie moc miły nasienie. Nauczycielka lek ciekawy handlowy radio rozwój przyjęcie. Wśród naród bać się społeczeństwo poprzedni według forma szkło. Podróżować itp. intensywny ciepły. Przedstawiciel spadać młody rolnik. Siódmy wilk ślub trwały. Bądź żyć pozostawać sprawiać. Umieścić istnienie uniwersytet długo dom lis. Dotyczyć ciąża słoneczny miłość port własność do.', 11, 191, 14, 89),
(247, 247, 'F', 'samanthaphillips', 'Zjawisko żeński samolot sala proces ludzie sąsiad. Taki leczenie szkodliwy czas właściwość pani toponim bitwa. Królestwo w formie młody wybrać okolica tajemnica. Drapieżny produkt kobieta latać. Wszystko usługa toponim bieda użyć ogród muzyka. Wydarzenie dwadzieścia Belgia albo reakcja. Krew wieczorem sok księga brzeg wygląd. Roślina trudno liść rosyjski telewizyjny maj lekki. Pacjent forma wypadek jednostka interes. W obecny istota jeden. Dodać nigdy przestępstwo powszechny stary drapieżny kij. Żeby paliwo bank odcień żelazo szczególnie umożliwiać żywność. Modlitwa piłka lampa złożyć piętnaście. Okropny koniec pozostać Słońce rzucać pióro uchodzić. Robić aby szkło tkanina kwestia. Rumunia wspomnienie ciągnąć żona obiekt.', 1, 1, 27, 37),
(248, 248, 'M', 'jameshawkins', 'Muzyczny r. szybki powinien mowa. Proces śmierć raz linia. Skończyć 6 użycie rodzic Boże Narodzenie nadzieja palec słownik. Drobny ćwiczenie zielony rasa czasem zakładać. Oczekiwać mocny przestać po prostu zwrot służba babka. Szereg wybitny lub dom pracownik. Sprawa Japonia ślub handlowy zwierzę drzewo igła. Dotyczyć jakby sądowy dowód pływać scena wybierać. Rzadko wywodzić się plan zmęczony wóz stały sposób żeby. Projekt alfabet — zewnętrzny czy tradycyjny wydawać. Sobą sobą substancja zysk zdobyć nasienie. Zabawa dach ani kraj przyszły wśród wysłać. Pismo muzeum jezioro. Ameryka sklep chcieć panować godność złapać. Zamykać ksiądz liczyć nauczycielka but suma wchodzić. Tracić zgromadzenie usuwać wśród czterdzieści za.', 1, 1, 23, 82),
(249, 249, 'F', 'kelsey26', 'Lecz cień pewien temperatura sukces prosić. Robota ryzyko przedsiębiorstwo masa Niemiec. Świadczyć przedstawienie pieniądz płyn dach bawić się szczęście samochód. Na zwłaszcza pójść dlaczego północny we ja. Głupek dawny 10 roślina zjeść zysk trudno podobny. Wzrok morski narodowość czoło przez. Miękki biały podnieść element otwarty cel zgodnie. Napój kupić zazwyczaj wczoraj węgiel odkryć aktor go. Możliwy zwyczaj głupi odzież. Całkowity poprzez uwaga lud pogląd znaczny tworzyć. Lata rower coś wypadek jedyny znowu. Praca kłaść miłość siedemdziesiąt położyć. Terytorium wierny określony samochód kolorowy siedzieć wiatr muzyczny. Uciec pierwiastek chemiczny arabski ponad list Węgry plan stopa. Wysyłać ludzki tamten. Tyle stopa całkowicie okropny. W Kształcie bydło ślad znaczny fizyczny. Smak sukienka rejon chłopiec. Strach zakończyć rozwój polityczny zatrzymać wycieczka.', 4, 192, 7, 70),
(250, 250, 'F', 'regina87', 'Ćwiczenie siedem złożony ofiara wy autobus w celu. Osioł pióro miłość stać ! liczba atomowa. Często w wyniku pomieszczenie orzeł Szwajcaria osoba wątpliwość. Student 70 drogi jeszcze tytoń przyjemny należeć 7. Okropny ponieważ lampa płaski graniczyć niedziela pochodzić.', 3, 193, 36, 53),
(251, 251, 'F', 'kathleensmith', 'Zamiar krowa smak czysty. Popularny termin zgodny następować. Właśnie podawać niebieski. Partia prawny usuwać sprzedawać pora wrzesień. Wujek babka urodziny dym ? podróżować. Zdobyć ślub czynność ruch miasto alkohol.', 10, 194, 25, 66),
(252, 252, 'M', 'ibrown', 'Powieść księżyc wyspa port proszę r. odpowiedni okres. Biblioteka czynić próbować. Widoczny naczynie szczególnie ciężar określony. Określony chleb wypadek wschód. Produkt miłość muzyczny przedstawienie. Państwo podatek fragment bić figura prędkość. Zgromadzenie wzdłuż dawać obecny. Różowy małpa struktura. Okazja wieczorem zakład świecić liczyć sos. Spotkać otworzyć wycieczka. Piętnaście mężczyzna bardzo wychodzić. Róża graniczyć chodzić sądowy położony azjatycki. Trwać żeby południowy dowód przyjęcie. Oni dziać się ziemski. Przejaw pisanie płynąć użyć wniosek. Dolny — użycie wieża jabłko.', 8, 195, 3, 81),
(253, 253, 'F', 'mcphersonlisa', 'Piękny Warszawa dobrze partia kolejowy uchodzić drogi późny. Można mi łuk świecić wejść suchy. Prostytutka działać maszyna. Dopływ zwycięstwo jutro okazja. Rosyjski nasienie wrogość pozostawać wysłać. Chłopak kwiecień zaburzenie. Zgodnie sok tak wpaść sprawa aby brak. Powiedzieć pomagać chyba ten przyrząd ośrodek duch. Biały forma złoto wyjść zobaczyć. Ramię związany smak zawodnik nóż umieć morze. Rzymski urodzić wyrok wieczorem. Czerwiec mistrz powodować tworzyć całkowicie podobny amharski. Początek las odpowiedź danie kraj jadalny. Padać narodowość przykład Kraków dowód złożyć męski instytucja. Krew siedzieć bo więc chronić skrzydło wada. Strumień na parlament materiał smak śpiewać. Poduszka służyć twardy znany lew pochodzenie zwykle. Technika piec ofiara wysoko widok skład może.', 3, 196, 1, 12),
(254, 254, 'M', 'amy19', 'Strumień grunt sos żaba trochę zachowanie dlaczego. Zbyt żeby oni widok chociaż konflikt ta. Strona wnętrze wielki przeszkoda dokładny ptak. Straszny mózg dać pamięć wrzesień tradycyjny francuski jakiś. Pozostawać jedynie moment mój głowa zabić.', 8, 197, 2, 64),
(255, 255, 'M', 'matthew68', 'Jutro zajmować wzdłuż np. gotowy przypadek. Rasa powstawać średni polityk zasada dar korzystać. Zrozumieć zwycięstwo seksualny pełen. Gdyby złodziej w kształcie wartość kobieta lubić dotyczyć. Mierzyć temperatura tkanina kolorowy wiedza szwedzki szlachetny. Środek dzięki chodzić. Stawiać problem park małpa pies skała. Jesień wojna most wiara przepis. Wąż prasa popularny jedzenie dziwny choć. Zakon oddech uwaga partia. Pani dłoń rodzinny pod 30 wieczorem metr proces. Kolano dość znowu pomysł. Stacja wczesny dzieło nadawać otworzyć ciepło. Prezent być informacja przeprowadzać udział 50.', 9, 198, 35, 10),
(256, 256, 'F', 'bmorrison', 'Książę owoc Chrystus wszelki. Potrzebny kiedy wybitny czasownik. Własny ojczyzna oddział przestrzeń. Bądź złożony czynność planeta mapa przed lód. Naród wizyta tydzień Indie. Żołnierz październik zrobić klub miesiąc przygotować. Wypowiedź gdy obecnie lista terytorium Anglia powinien południowy. Bać Się ubranie skłonność. Naj- pewien niewolnik. Sądowy kontynent urodziny dziewięćdziesiąt bohater choć. Jadalny budowla już fakt wyrażenie nazwa. Przeciw grób kraina hałas. Abugida papier sok policzek no. Zgromadzenie gotowy pytać ludność Ukraina dolina.', 6, 1, 5, 57),
(257, 257, 'M', 'gardnerwilliam', 'Powiat mężczyzna przyjmować skutek ojciec. (…) proszę odnosić się srebrny. Babcia sobie dzielnica usuwać chleb wszystek. Obrót całkowicie odpowiadać dziać się. Więzienie 1 mecz krzesło pióro siedem. Dzisiejszy obwód traktować. Ogromny nadmierny zamek kult. Czechy oddawać transport akcja. Kolor rak położyć bać się hotel. Prędkość pieniądze u przygotować wykonanie klimat ja. Pijany fałszywy skład. Film dotyczyć USA stół ocena ssak dno. Fizyczny walczyć Węgry USA morski. Powiedzieć nóż wschód odpowiedni seksualny otworzyć poduszka. Sowa brzeg zadanie oczekiwać egzamin. Rzeczownik narząd świeca wydarzenie zabawa podział czoło. Zakończenie napisać podróż elektryczny.', 10, 199, 4, 92),
(258, 258, 'F', 'crossstephen', 'Zapalenie górny Hiszpania skóra.', 7, 200, 24, 49),
(259, 259, 'F', 'dennis40', 'Kieszeń zostać złożony zajęcie pojęcie dobro. Łatwo następować sześć my delikatny potrawa łódź. Trzeba wydarzenie świecić następować. Robota Izrael słownik ona według. Własny europejski czerwiec plama moc. Fala uderzać cebula dawno jadalny czysty pływać rodzaj. Szósty rzadki umieścić polski dziura. Zapomnieć ci dodatkowy zdrowie seks przyjemność. Wątpliwość dół kolacja kot.', 1, 1, 33, 98),
(260, 260, 'F', 'gharris', 'Korona ukraiński mistrz problem. Funkcja zaburzenie wspomnienie przyjaciel prowincja.', 3, 201, 11, 11),
(261, 261, 'M', 'myersronald', 'Wyrok ksiądz moment byk plecy. Szczególnie niektóry swój opinia zdolny. Silnik kończyć wybierać raz. Południe wyspa pewien karta płeć. Zamiast co starożytny tłumaczyć. Rozmawiać mleko 4 kraina Warszawa wychodzić następny. Czeski powierzchnia uchodzić porządek. Własność rolnik internetowy szybki nóż prawie rządzić. Jezioro oddech prowincja choroba komórka kość. 1000 korzystać kura. Doprowadzić pojawiać się znosić średni dar usuwać. Kwiat dwanaście krzyż europejski niski świecić. Oficjalny list masa około księżyc zamiast. Zostać podstawowy punkt między barwa. By łóżko występować policzek zgadzać się biec ciotka długi. Sportowy środkowy woda również przypominać.', 10, 202, 17, 14),
(262, 262, 'F', 'ashley83', 'Własność go Japonia rzeczownik częściowo 80 usta. Sylaba znowu zachód bóg. Okres kolega całkowity oś. Historia wieczór dach piętnaście. Wolny użyć szary silnik. Przyszłość Bóg niemiecki zrozumieć podział podróżować samiec obiad. Cesarz róg przyjaźń stosunek określać oddawać Jan. Wydać dziadek czasem np. marka wciąż. Styl tamten okno sposób słowo kościół. Samolot przedstawienie mgła stanowić rosnąć. Obserwować żelazo bez. Czerwiec ile noc mózg w celu. Korzystać wewnątrz wszelki proszę środa obywatel. Dać całkowity pomieszczenie własność. Naturalny głównie trudność organizacja pusty alfabet pozostać kwiat. 100 funkcja działalność sos.', 2, 203, 18, 83),
(263, 263, 'F', 'stephanieking', 'Świat pozostać bóg kobiecy. W Końcu duch uderzenie choć. Chrystus minister porządek prasa domowy. Przepis ciepło 40 prosić. Kwiecień wschód piętnaście. Wykonanie poruszać się produkt łuk mecz. Ogół droga czeski dać prostytutka jajko drogi krew. Trudno dzień całkiem siła – obraz istnienie. Usta palić rzadko mrówka. Norma morski przyjąć stały charakter. Przeciwny początek 9 znajdować tytoń. Tracić czekać dzisiejszy właściwość. 900 Australia niedziela urzędnik kino zgoda znać przeprowadzać. Wieś seksualny muzeum autor nazwa. Znany 100 drużyna ośrodek.', 7, 204, 5, 48),
(264, 264, 'F', 'lauren63', 'Wyjść kapelusz 70 przyjemny móc stanowić wytwarzać. 900 most oni. Prawie równy pewien Belgia pojęcie słyszeć. Oddawać kot letni 8 ponad Morze Śródziemne samochód.', 3, 205, 23, 51),
(265, 265, 'F', 'potterdennis', 'Córka cena jazda kaczka czas mapa łuk wprowadzać. Linia pod blady pustynia babka oznaczać. Napisać jeden przyjemny dać. Martwy alkoholowy powietrze moment. Dialekt powodować wywołać budowla gdzieś muzeum. Reguła lekki katastrofa dość rzecz. Szósty pragnienie dotyczyć zespół Egipt. Słyszeć bardzo pomoc szary posiłek twardy. Grudzień Unia Europejska płyn wysoki zainteresowanie. Kobiecy ciąża rodzina film. Całkiem wtorek południe całkowicie kolorowy pełny. Projekt tradycyjny jakość radio potrafić ona narząd motyl. Poprzedni umieścić urodziny. Więcej odnosić się mięsień. Sukces wrogi odpowiedni. Telewizyjny wartość drużyna walczyć zupełnie plan. Włożyć niedziela kierować. Zawodnik hiszpański obrót. Dziura poruszać się wiedza. Publiczny ale niewolnik dostęp.', 4, 206, 30, 14),
(266, 266, 'M', 'john81', 'Robić ulica czuć otrzymać spotkać. 2 chemiczny 100 pożar dorosły.', 4, 207, 21, 95),
(267, 267, 'F', 'michael40', 'Święty pisanie letni właściciel oko słaby wspólny. Zysk zwrot szybki przykład razem zwycięstwo. Delikatny majątek np. wybrać dawać. Prowincja dziecięcy międzynarodowy skrzydło wąski nasz piłka nożna. Wykorzystywać marzec treść wojenny przyjmować. Kara prezent organizacja firma dlaczego jazda społeczeństwo. Ulica istota diabeł radość pismo rodowity —. Zajmować dwadzieścia majuskuła ziarno narkotyk byk luty. Pieniądze produkować moment chłopak kolega powierzchnia kolejowy. Wiele oglądać tracić poza małżeństwo zdanie ssak. Zdanie bliski smutek litera zwrot. A prasa klient zapalenie równy czyjś. Pięć tu główny tyle metal niebezpieczeństwo całkowity. Aby poczta niszczyć ciekawy chleb. Zimny rzeka dzisiejszy tutaj.', 11, 208, 7, 24),
(268, 268, 'M', 'rosspatrick', 'Chronić gra wciąż posiadać brudny szacunek dodawać. Sześćdziesiąt przejście gwiazdozbiór może mocz szlachetny gospodarka lotniczy. Wykonać poczta nauczyciel projekt miłość czyli. Trzy szkolny praca próbować. Wyścig strefa wspomnienie stopień nazwisko dać się chyba. Siła rachunek spotkać głupek chleb. Lata artystyczny oni 2 powód lot lis. Rząd pszczoła tytoń zająć płakać. Serce smutek odpowiadać. Fakt igła głupiec marzec zbiornik latać. Krew dziewięć kanał. Zgoda waluta linia miesiąc siła bliski. Poruszać kilometr gęś coraz styczeń mama siła. Ciasto siedemdziesiąt oni aktor. Wspólny zobaczyć jądro wybory miłość przebywać aktor słońce. Rodzinny abugida poniedziałek. Do Jan św. kierowca kalendarz dwudziesty znaleźć.', 1, 209, 32, 44),
(269, 269, 'F', 'cynthia24', 'Sprawa kraina technika stać przeszłość. Pomarańczowy dostęp jakiś. Złożyć dać zakończenie stać się grupa być godność.', 1, 210, 11, 96),
(270, 270, 'M', 'jeffrey97', 'O rzeczownik osiągnąć wola. Wolny ucho krótki pozwalać może niewielki. Rozwój ona odwaga złożyć łaciński spadek. Tu ciąża funkcja transport szpital. Jedyny lek nadmierny spadek. Więc 1 właściwy wszyscy odzież. Europejski wszystkie jakby parlament wypadek własny brać. Szwedzki jadalny wiedzieć ptak wzgórze. Mysz samica gruby cmentarz model płyta siedem. Położony owoc ocena ogród płaszcz wina rządzić ani. Dno jutro bycie kobiecy widoczny pływać. Film firma obywatelka naj- związać mysz. Ocean koniec zaufanie wielki ona obrót. Niektóry włożyć wykonywać ośrodek nie ma zły ząb. Jako źródło strata region. Prezent relacja pięćdziesiąt bać się. Królestwo róg wtedy długi amharski okolica poważny. Dobrze gazeta wolno. Kostka starać się osiągnąć szkło ciepło. Republika dzielić Jezus ochrona łagodny. Miecz nowy wziąć słońce domowy.', 9, 211, 11, 94),
(271, 271, 'F', 'qstark', 'Dziewięćdziesiąt czerwiec św. operacja teraz wypowiedź wnętrze następować. Reakcja rasa prawdziwy zdarzenie jabłko coś. Podróżować obejmować oddać. Współczesny muzyczny lis suchy. Półwysep świeca cena krzew. Komputerowy wewnątrz rezultat Włochy wcześnie. Chemiczny lud Polak suma samolot powstanie. Kolej źle serce szybki. Potrawa pełnić nadmierny przyjaźń żywność. Pokarm palić narząd rejon częściowo. Punkt ulegać umowa tkanina Czechy. Wnętrze interes pokazywać gdyby słowo składać.', 7, 212, 34, 67),
(272, 272, 'F', 'lortega', 'Chociaż metalowy polski związany tarcza przechodzić. Ogon sposób okolica aktor istnienie gęś chwila traktować. Rzeczywistość podróż decyzja samolot potrzebny wrócić liczba atomowa. Wielki przeszłość radio. Skutek podać przeprowadzać kraina miesiąc drużyna właśnie. Tani spotkanie smak planeta pogląd pisać brać. Postać pasek wybór niedźwiedź nazywać posiadać odległość. Na nagle fabryka kościół potrzeba kupować.', 1, 213, 13, 60),
(273, 273, 'F', 'ywright', 'Królewski bohater ponad całkowity stracić. Koniec rządzić sądzić bułgarski wtedy. Lekcja szczęśliwy warstwa przyjemny. Technika pokonać bez popularny niech chęć. Głupi położyć bronić rosnąć próbować transport. Późny wybrać szwedzki tani przyszły osiągnąć teoria. Ostatni szybki ciemność korzystać mały. Ulica 7 muzyka muzeum działalność. Strona stać teren Włochy wojskowy drzewo. Wyraz razem Hiszpania północ płacić. Tracić kolano ssak cukier słyszeć. Dokument gołąb chiński rasa żółty. Dzieło Ziemia pragnienie materiał stosunek. Lata rodzic jakość. Czasem nic gniew według. Sprawa pamięć kalendarz rzadki nóż.', 4, 214, 2, 55),
(274, 274, 'M', 'kingdanielle', 'Doprowadzić rzeczownik walka usuwać. Wrzesień bilet by sieć stopa rządzić. Warunek korzyść bank włożyć gorączka szczególnie wchodzić. Cukier urodzić się energia umowa wiadomość ponownie równy rodzina. Widoczny narodowy jeśli skłonność inaczej wobec robota. Trochę mięsień instytucja zupełnie różowy żydowski zakres. Gwiazda biblioteka suchy dane fizyczny odkryć filmowy niedziela. Wejście scena układ okresowy jednocześnie przybyć deska. Temperatura skład uciec. Sowa no ćwiczenie rozumieć spór stacja. Sylaba minuskuła ciecz odwaga. Medycyna dzisiejszy trwać.', 2, 215, 15, 12),
(275, 275, 'F', 'rebeccawood', 'Natura jeżeli rozmawiać źle.', 11, 1, 5, 99),
(276, 276, 'M', 'moorejason', 'Gazeta osoba większość. Pójść umieścić chłopak. Zajęcie strata wzgórze naród. Głupek Dania inaczej gra. Produkcja olej głośny dane mapa stopa. Tracić traktować wypadek. Samolot gwiazda katolicki zostać. Dopływ lata chyba szczyt obiekt. Prawdziwy robotnik amerykański wpływ sport używać powiedzieć płaszcz. Dziać Się parlament bitwa. Dopiero duński kwiat główny. Babka powszechny dolina. List zamek słoneczny miły zamiast. Dzieło współczesny użyć kontakt pięćdziesiąt. Piętnaście wejście trawa 5. Jeść trawa Warszawa. Fragment nadawać typowy Hiszpania czapka niewielki czysty męski. Termin tu wstyd spać oddech. Trzy moneta oczekiwać. Przyrząd typowy wywołać zmęczony barwa wreszcie. Ból dlaczego przeciwnik szybki prawny przestępstwo. Jutro po dom stolica pełnić wino muzyczny.', 10, 216, 12, 69),
(277, 277, 'F', 'katherinebrown', 'Surowy polski ogród powstawać wąski strój. Prędkość bok własność smutny pomoc. Kolor gruby gleba kłaść posiłek planeta dzielnica miękki. Poruszać Się wewnątrz złoty pomiędzy. Bank tysiąc pies pani.', 3, 217, 18, 4),
(278, 278, 'F', 'robersonlauren', 'Jeden teraz żyć termin szereg szkoła. Wzór kochać dostęp katolicki Białoruś studiować. Osobisty składać się nazwa miesiąc alkohol. Poniedziałek lis przyczyna Rosja pozostać próba przeszkoda. Obrona seksualny zgodny niski klasa człowiek. Minerał słowacki zamiast minerał wejście. Przyjęcie służyć sprzedawać hałas myśl centralny. Próba klimat sukces krzyż klub zwłaszcza. Kwiecień ksiądz wybitny polować rzucić powstanie. Dobry lipiec uzyskać mieszkanie pomieszczenie. Okres pisanie pogoda urodzenie. Myśleć wyjść alkohol brudny zacząć strój uniwersytet ona. Szkło czwartek wada artykuł niebezpieczeństwo piosenka tajemnica atak. Liść banknot 70 liczny wpływ uderzać urodzić się. Bogini Piotr zapach zapach łaciński bitwa.', 2, 218, 23, 27),
(279, 279, 'F', 'omyers', 'Twój ustawa słuchać warunek. Ziemia poziom rzadko region liczyć. Przygotować zamykać mózg bieg całość tutaj wydać. Delikatny jabłko ciecz półwysep pióro mocno. Mocny św. 90 wpływ minister nasiono. Dania świadczyć ruch ubogi południe. Usta trochę medycyna barwa korzeń Australia. Wszyscy urodzić się pojedynczy błąd. Rozpocząć nic kura stały termin.', 10, 219, 22, 21),
(280, 280, 'M', 'kenneth77', 'Niszczyć w. złapać list jasny. Studiować droga narząd zapomnieć. Ponieważ otworzyć mieszkanie efekt moneta. Rozumieć tłumaczyć różnica przerwa obywatel płyta. Orzeł traktować więzienie. Woda żaden powodować Pan rozmiar. Tracić kupić rano studiować. Hotel bank żywy wobec jakość pomiędzy gotować. Pojedynczy tyle Niemiec twardy naukowy. Gleba surowy wesoły brać narodowość. Można użycie bok śmierć doświadczenie. Przedstawiać poprzedni czarny masa. Nazywać narzędzie aby śmiać się czasownik policja.', 3, 1, 35, 34),
(281, 281, 'F', 'hughessteven', 'Czyjś stół majątek bank grób papież. Jednocześnie pomoc stolica reakcja. Pacjent kartka gospodarka pierwiastek chemiczny myśl. Szybko piętnaście przeciwko cel patrzeć uderzyć stanowisko. Cebula artykuł szkodliwy hotel szkoda prowadzić. Fałszywy obywatelka dłoń metalowy. Szereg dno niezwykły litera tamten. Na lekarz system nasienie. Każdy szkodliwy posiłek. Ciemny azjatycki nos zostać. Układ metoda szczególnie sędzia róża razem. Ulica Unia Europejska pozostać 50 milion mówić. Sto wierzyć okolica lekcja wyjście. Oczekiwać suma zakład most pewny. Korzyść wiek święto jego marka tysiąc struktura.', 6, 220, 21, 7),
(282, 282, 'M', 'heather66', 'Razem doświadczenie charakterystyczny cena dziecięcy trzeci potrzeba. Wybierać prawo dialekt rodzaj przebywać używać mózg. Seks tytoń choroba wódka porządek ty fragment. Sygnał wieczorem w wyniku plac wysoko europejski także. Wynosić pomarańcza kot policja. Anioł zawartość ozdobny cierpienie głośny organizacja związek. Jezus wiele w. symbol podnieść w postaci opisać tłum.', 5, 221, 21, 21),
(283, 283, 'F', 'murillosally', 'Źródło rozmiar 0 figura wystawa siedzieć. Wydawać wola pomarańczowy. Pomarańczowy ciągnąć muzyka szanowny zaburzenie. Przebywać prawie tłum wydarzenie bohater historia siedem. Lekki służyć rysunek wizyta żydowski zająć czwartek postawić. Ozdoba gość sobą naprawdę. Dziwny nazywać zbierać słownik mebel waga. Wejście grzyb okolica jeszcze dwudziesty. Rumunia św. azjatycki Bóg pozostać but stosunek odmiana. Znaczny pojedynczy broń lecz tracić. Cichy nieszczęście Kościół kąt głupiec miły. Powietrze prostytutka siła intensywny święto Chrystus. Obowiązek wilk sąsiad technika. Bezpieczeństwo wspomnienie upadek umowa naturalny ciemny powstawać. Typowy prawny góra na przykład żołądek praca stosunek. Starać Się zamykać smutny. Dzielnica biec wobec pole polegać. Pięć wspólnota współczesny woda pusty nieść. Medycyna dziura list gardło przyjęcie.', 10, 1, 31, 25),
(284, 284, 'F', 'jennifer44', 'Komputer wiadomość literatura hałas łaciński. Czerwiec mieszkanie pewien podawać północ poprzez szczęśliwy żywność. Teoria matematyka przeszłość surowy wziąć. Metalowy czterdzieści że dziób wybory wola. Słownik autor prąd.', 4, 222, 6, 23),
(285, 285, 'M', 'mendozaaustin', 'Gniew zbierać własny rada zima lekcja. Spotkanie Niemcy rodzinny zdobyć przyszły reguła zainteresowanie. Godny otrzymać książę tydzień zero zmarły aż. Abugida walczyć polityczny wielkość dźwięk kartka. Zawartość nie ma powód nos dzielnica. Często amerykański na strój coś wybuch. Chleb na gruby kwiecień kilka grzyb położony wyrób. Lubić sport róg.', 3, 223, 33, 75),
(286, 286, 'F', 'qfitzpatrick', 'Przyszły tkanina ogromny może śmiać się silny przejście. Wyrok dowód dziób pragnąć analiza hodować dlatego. Jądro majuskuła ziemniak radość usta grzyb. Stopień surowy koniec tak teoria. Koszt błąd ozdobny. Zawartość południe zgadzać się Rumunia. Mały hotel instytucja księżyc liczny zmęczony. Założyć zimny odkryć długo otrzymywać gość powstać owoc. Zbiornik duży ile ustawa. Aktor dla aż.', 5, 1, 26, 78),
(287, 287, 'M', 'ballardmichael', 'Czy silnik tradycyjny (…).', 6, 1, 29, 10),
(288, 288, 'X', 'bradypaul', 'Wyspa wyjście pół. Państwowy akcja oraz kij kochać wchodzić piętro danie.', 10, 224, 18, 44),
(289, 289, 'F', 'sarah38', 'Mysz każdy zawodnik czasem dźwięk pojawić się zielony atmosfera. Wóz południowy słowacki oddawać. Oficjalny niebezpieczeństwo cel okoliczność. Broda bać się film gotować jeśli ubranie. Historyczny ósmy seksualny przyrząd pożar płaski całkowicie. U pełen chłop te 2 wzdłuż. 5 szczęście smutek naukowiec. Równy niektóry reakcja dawno. Szwajcaria jej Boże Narodzenie słownik. Alkohol męski dostęp trzydziesty zabawa centrum zwrot 9. Zachowywać Się żydowski tłum bycie zwłaszcza strefa pisarz umieć.', 4, 1, 20, 30),
(290, 290, 'F', 'bartlettjames', 'Nigdy pisanie gwałtowny wybitny pasmo pomidor przeznaczyć. Zielony rodzic jedenaście działanie ich ciekawy palić. Zachodni zainteresowanie organizm zwyczaj prostytutka nocny. Przeciwny rezultat wzór związany lecieć. Stosować mąka udać się tyle przechodzić ludzki układ okresowy. Nazwa nie ma Morze Śródziemne zgoda komputer fakt. Autor termin szybki strona łóżko Kościół traktować. Lot pusty miecz ilość syn pasmo ani. Wywoływać rodzina środowisko dać międzynarodowy kino. Hałas gdzieś szef Rumunia choć liczba aktor. Lato czarny wolność pochodzenie oraz. Czas danie strona spokojny pisać śmiać się moment. Gdzieś duch ofiara most Turcja płakać. Mocz uderzenie ofiara sobota. Doskonały toponim gniazdo relacja scena Chiny skala urodzić się. Radiowy elektryczny fragment piosenka bardzo. Film zaraz ktoś praktyka. Ponownie zamknąć kościelny uniwersytet niebo.', 4, 225, 18, 36),
(291, 291, 'F', 'kenneth32', 'Powstać lub poznać rynek bić móc. Ulegać niedziela następny. Pozbawić miękki obrona. Komputerowy wybrzeże godny 90 3. Papież włosy jutro niechęć pracownik rządzić czerwiec.', 7, 1, 15, 70),
(292, 292, 'X', 'stephen12', 'But rower owoc wąski dziura jego. Wrócić policjant uciekać zamiast styczeń. Nagły bank firma hałas piłka nożna biec Niemcy. Metalowy ponad korzystać obrót wybitny 7 wybór hodować. Ślad powinien przy wierny na przykład wspólnota sprawa jasny. Obok ulegać pojawiać się okno cienki budować kilometr. Powietrze mi dym trawa ukraiński. Praca wina tracić. Proszę dzień zaczynać połączenie blisko oczywiście majątek. Krzyż w wyniku obowiązek połowa pojechać. Jako rodzina układ dobry chwila obywatel wzrost. Odwaga sądzić decyzja zbyt ogród pieniądze nie-. 1 otaczać na przykład wspomnienie pierwiastek chemiczny. Założyć pragnąć niszczyć chodzić. Kultura przeciwny sprzedaż męski tu władca kolano warunek. Popularny Pan wszystko pasmo wywołać postawić dzięki. Kara pani umożliwiać.', 4, 1, 27, 46),
(293, 293, 'F', 'jeremyhull', 'Szczególny minister cześć miasto kino Polak cierpienie naj-. Obecnie ani szwedzki słowacki atak królowa herbata. Potrafić ogół stracić słuchać papier łączyć. Element kuchnia kosz żydowski. Starożytny lina towar sposób osiem miejsce odległość. Poznać sądzić wielkość leżeć. Wrzesień sąd linia krzew transport. Rolnik wciąż zimno ucho maszyna. Wyrok postać uderzać klient. Przy wyrażenie rzadki 0 tutaj żaba. Koszula przyjaciel kobieta wiosna. Utrzymywać liczba atomowa zeszły środa pole sędzia przedmiot. Trawa inny Bóg. Obywatelka znowu dany woda. Kawałek bezpieczeństwo lecz adres opłata miejsce otwarty choć. Lampa lampa zwykły hasło waluta kraina. Lipiec kolega wodny medycyna nie stawać się. Plac piątek skutek figura podróż seks rano. Tekst gospodarka jesień własny łąka. Czyn co ja naród południowy teatr.', 4, 1, 35, 20),
(294, 294, 'F', 'stacey07', 'Wyrażać miły.', 4, 226, 9, 95),
(295, 295, 'F', 'rebeccawolfe', 'Istnieć rozpocząć m.in. obywatelka krzyż metalowy wy. Dzieło bo 6 należy dziób mało jeszcze. Biedny rzadko rysunek my górski klasa. W Ciągu pomoc wspaniały potrzebny. Proces biuro żeński błąd wystawa jeść. Kościół piąty pod znów. Oddech starożytny radość sygnał. Wykonać ryzyko podczas umieć. Interes hodować polować księżyc złożony. Krok domowy nagle styl mój powietrze ja źle. Strach tamten wszyscy nad czynić centrum. Herb partia by bułgarski maj polować Austria rozpocząć. Przeciwko herbata telewizja własny pierwiastek doprowadzić. Władca czynnik Niemiec piętnaście poruszać się przedstawiać. Nic zmarły konflikt dział ruch. Zasada moralny odkryć. Kłaść zgodnie właśnie.', 6, 1, 18, 42),
(296, 296, 'M', 'jacquelinelawson', 'Metoda oba świadczyć. Zawodnik wysłać męski koszula. Rozmawiać 2 kuchnia jeździć wspólnota. Pies ładny północ zdolny dziewczyna jako umysł. Alkohol charakter roślina. Talerz określony pozostać właśnie nasz świeży ktoś dalej. Uprawiać hodować przyjęcie głównie dobro jakby wiadomość brudny. Właśnie Boże Narodzenie Warszawa cukier książę. W Kształcie mąż Japonia podłoga wieża. Kończyć gdyby dowód brązowy urodzić się wywoływać. Znany przechodzić przecież zdjęcie robotnik. Wybrzeże gospodarka wrzesień za pomocą rejon styczeń rasa podnieść. Znajdować siedzieć pojawić się błoto.', 2, 1, 23, 47),
(297, 297, 'F', 'nguyenbenjamin', 'Trudny zdrowie przedsiębiorstwo pójść wieża proces. Mięso centralny graniczyć. Dopływ naprawdę zajmować szósty rada prasa. Kość uczyć się otwarty dodatek tradycyjny. Moment kupować wszystko orzeł zaburzenie cel. Deska trzeba przyjemność mąż Boże Narodzenie promień. Linia dziewczyna sytuacja badać noc czasem. W Czasie tak dyskusja doświadczenie sprawa. Futro pogląd mieć na imię gdy układ lud. Ludowy żaden długo dziewięćdziesiąt. Zachód powstać teatr modlitwa lina jednostka deska. Izrael banknot październik kiedyś. Obserwować obserwować cecha poważny zwykle skała m.in.. Zadanie anioł istnieć. Bok używać aby złoto kilometr można książę. Chłopak promień wpływ pięć. Minuskuła prosty woda chrześcijański choroba grób pogląd mama. Zakład Holandia kolorowy wrócić jazda liczny. Trwać dyskusja szwedzki owca autor. Przemysł sierpień gdy wykonać. Potrzebować tu narząd domowy. Malować książę wykorzystywać brązowy. Policja nauka pomysł szczególnie.', 2, 227, 1, 40),
(298, 298, 'F', 'carlos28', 'Kieszeń prezent wiele ilość korona ciemność egzamin siedziba. Prawny pracownik sąd księżyc człowiek mocny. Rządzić lew stworzyć robić studiować prąd. Śmierć student wywodzić się rządzić też delikatny teatr. W Ciągu atak wojna błąd możliwy pole. Świątynia nosić poprzedni wypowiedź tam samochód porządek historia. Kartka obywatel posiłek obraz.', 11, 1, 36, 77),
(299, 299, 'M', 'benjaminbarber', 'Jabłko przedsiębiorstwo wyjście tradycja prawy. Ludność zgoda jezioro pięć sądzić bilet. Siedem na średniowieczny Włochy. Ja szybki morski przyczyna. Sos północny tyle sprzedaż. Kula bułgarski plama babka warunek ostry. Szanowny system prawy ostry.', 6, 228, 33, 52),
(300, 300, 'F', 'fpeterson', 'Rzeczywistość chłopak odnosić się radiowy słoń kilka. Kwiat odnosić się a. Pozostawać dokument zdolny łatwo majuskuła w.. Dym świeży wolny tworzyć.', 6, 229, 34, 17),
(301, 301, 'M', 'greenrachael', 'Zajęcie grzyb płaski Morze Śródziemne. Muzeum wyrażenie przeszłość.', 4, 230, 16, 9);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `parafia`
--

CREATE TABLE `parafia` (
  `id` smallint(255) UNSIGNED NOT NULL,
  `nazwa` varchar(256) NOT NULL,
  `proboszcz_id` tinyint(255) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `parafia`
--

INSERT INTO `parafia` (`id`, `nazwa`, `proboszcz_id`) VALUES
(1, 'Zgromadzenie św. Sonii', 1),
(2, 'Zgromadzenie św. Piotra', 2),
(3, 'Kościół św. Olgi', 3),
(4, 'Bazylika św. Urszuli', 4),
(5, 'Kaplica św. Melanii', 5),
(6, 'Archikatedra św. Eryka', 6),
(7, 'Klasztor św. Karola', 7),
(8, 'Katedra św. Sylwii', 8),
(9, 'Sanktuarium św. Idy', 9),
(10, 'Bazylika św. Mikołaja', 10),
(11, 'Katedra św. Nikodema', 11),
(12, 'Archikatedra św. Norberta', 12),
(13, 'Sanktuarium św. Klari', 13),
(14, 'Misja św. Alberta', 14),
(15, 'Rektorat św. Aleksa', 15),
(16, 'Misja św. Maurycya', 16),
(17, 'Bazylika św. Barteka', 17),
(18, 'Kaplica św. Anastazji', 18),
(19, 'Parafia św. Jeremia', 19),
(20, 'Kolegiata św. Jeremia', 20),
(21, 'Archikatedra św. Brunoa', 21),
(22, 'Dom Zakonny św. Janiny', 22),
(23, 'Parafia św. Olgi', 23),
(24, 'Parafia św. Kajetana', 24),
(25, 'Katedra św. Ewi', 25),
(26, 'Dom Zakonny św. Elżbiety', 26),
(27, 'Rektorat św. Józefa', 27),
(28, 'Opactwo św. Józefa', 28),
(29, 'Opactwo św. Aleksandera', 29),
(30, 'Klasztor św. Radosława', 30),
(31, 'Klasztor św. Sylwii', 31),
(32, 'Katedra św. Ady', 32),
(33, 'Archikatedra św. Sylwii', 33),
(34, 'Archikatedra św. Mieszkoa', 34),
(35, 'Sanktuarium św. Aurelii', 35),
(36, 'Bazylika św. Sari', 36),
(37, 'Kolegiata św. Janiny', 37),
(38, 'Sanktuarium św. Liwii', 38),
(39, 'Parafia Rzymskokatolicka św. Barteka', 39),
(40, 'Misja św. Leonarda', 40),
(41, 'Opactwo św. Neli', 41),
(42, 'Archikatedra św. Oskara', 42),
(43, 'Kościół Rzymskokatolicki św. Kaji', 43),
(44, 'Zgromadzenie św. Nicoli', 44),
(45, 'Zgromadzenie św. Malwiny', 45),
(46, 'Klasztor św. Marianny', 46),
(47, 'Kościół Rzymskokatolicki św. Gaji', 47),
(48, 'Bazylika św. Przemysława', 48),
(49, 'Opactwo św. Marianny', 49),
(50, 'Rektorat św. Idy', 50),
(51, 'Parafia św. Anity', 51),
(52, 'Opactwo św. Elżbiety', 52),
(53, 'Bazylika św. Sebastiana', 53),
(54, 'Sanktuarium św. Roksany', 54),
(55, 'Kościół Rzymskokatolicki św. Borysa', 55),
(56, 'Rektorat św. Krystyny', 56),
(57, 'Parafia Rzymskokatolicka św. Konstantya', 57),
(58, 'Dom Zakonny św. Urszuli', 58),
(59, 'Kościół Rzymskokatolicki św. Michała', 59),
(60, 'Zgromadzenie św. Adrianny', 60),
(61, 'Kościół Rzymskokatolicki św. Apolonii', 61),
(62, 'Parafia Rzymskokatolicka św. Eweliny', 62),
(63, 'Katedra św. Rozalii', 63),
(64, 'Rektorat św. Roksany', 64),
(65, 'Bazylika św. Cypriana', 65),
(66, 'Parafia św. Aleksandera', 66),
(67, 'Opactwo św. Gustawa', 67),
(68, 'Archikatedra św. Melanii', 68),
(69, 'Misja św. Brunoa', 69),
(70, 'Kaplica św. Nicoli', 70),
(71, 'Kościół św. Anna Marii', 71),
(72, 'Kościół św. Sari', 72),
(73, 'Zgromadzenie św. Józefa', 73),
(74, 'Kościół św. Maurycya', 74),
(75, 'Kolegiata św. Maksa', 75),
(76, 'Dom Zakonny św. Cezarya', 76),
(77, 'Dom Zakonny św. Olgi', 77),
(78, 'Rektorat św. Macieja', 78),
(79, 'Kościół św. Anieli', 79),
(80, 'Sanktuarium św. Mikołaja', 80),
(81, 'Kościół św. Liwii', 81),
(82, 'Parafia Rzymskokatolicka św. Norberta', 82),
(83, 'Klasztor św. Karola', 83),
(84, 'Parafia Rzymskokatolicka św. Kajetana', 84),
(85, 'Sanktuarium św. Stefana', 85),
(86, 'Bazylika św. Wojciecha', 86),
(87, 'Zgromadzenie św. Krystyny', 87),
(88, 'Archikatedra św. Tymona', 88),
(89, 'Sanktuarium św. Aleksandera', 89),
(90, 'Kaplica św. Sonii', 90),
(91, 'Opactwo św. Olgi', 91),
(92, 'Archikatedra św. Agnieszki', 92),
(93, 'Kościół Rzymskokatolicki św. Jakuba', 93),
(94, 'Kaplica św. Roksany', 94),
(95, 'Parafia Rzymskokatolicka św. Michała', 95),
(96, 'Kolegiata św. Krzysztofa', 96),
(97, 'Archikatedra św. Krystyny', 97),
(98, 'Kolegiata św. Ewi', 98),
(99, 'Misja św. Sandri', 99),
(100, 'Sanktuarium św. Marcina', 100);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `plodnosc_kreatorow_postow`
-- (See below for the actual view)
--
CREATE TABLE `plodnosc_kreatorow_postow` (
`imie_pseudonim_nazwisko` varchar(196)
,`liczba_postow` bigint(21)
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `plodnosc_parafii`
-- (See below for the actual view)
--
CREATE TABLE `plodnosc_parafii` (
`id` smallint(255) unsigned
,`nazwa` varchar(256)
,`liczba_wiernych` bigint(21)
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `plodnosc_tablicy`
-- (See below for the actual view)
--
CREATE TABLE `plodnosc_tablicy` (
`id` smallint(255) unsigned
,`nazwa` varchar(256)
,`liczba_uzytkownikow` bigint(21)
,`liczba_postow` bigint(21)
);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `pokrewienstwo`
--

CREATE TABLE `pokrewienstwo` (
  `id` int(10) UNSIGNED NOT NULL,
  `typ_relacji` enum('mama','ojciec','córka','syn','siostra','brat','ciotka','wujek','siostrzenica','bratanica','siostrzeniec','bratanek','kuzyn','kuzynka','babcia','dziadek','wnuczka','wnuk','ojczym','macocha','pasierb','pasierbica','szwagier','szwagierka','teść','teściowa','zięć','synowa','mąż','żona') NOT NULL,
  `widzi_dane_osobowe` tinyint(1) NOT NULL DEFAULT 0,
  `spokrewniony_uzytkownik_id` int(10) UNSIGNED NOT NULL,
  `uzytkownik_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `pokrewienstwo`
--

INSERT INTO `pokrewienstwo` (`id`, `typ_relacji`, `widzi_dane_osobowe`, `spokrewniony_uzytkownik_id`, `uzytkownik_id`) VALUES
(1, 'pasierbica', 1, 278, 246),
(2, 'macocha', 1, 246, 278),
(3, 'ojciec', 0, 88, 121),
(4, 'syn', 1, 121, 88),
(5, 'brat', 1, 67, 75),
(6, 'brat', 0, 75, 67),
(7, 'pasierbica', 1, 215, 221),
(8, 'macocha', 1, 221, 215),
(9, 'wnuczka', 1, 270, 54),
(10, 'dziadek', 1, 54, 270),
(11, 'wujek', 1, 300, 274),
(12, 'bratanica', 1, 274, 300),
(13, 'babcia', 1, 29, 22),
(14, 'wnuczka', 0, 22, 29),
(15, 'ojciec', 0, 229, 59),
(16, 'syn', 1, 59, 229),
(17, 'synowa', 1, 298, 240),
(18, 'teściowa', 1, 240, 298),
(19, 'wnuczka', 1, 212, 106),
(20, 'dziadek', 1, 106, 212),
(21, 'żona', 0, 145, 81),
(22, 'żona', 0, 81, 145),
(23, 'szwagier', 1, 94, 24),
(24, 'szwagier', 0, 24, 94),
(25, 'wnuczka', 1, 110, 85),
(26, 'babcia', 1, 85, 110),
(27, 'mąż', 1, 23, 183),
(28, 'żona', 1, 183, 23),
(29, 'siostrzeniec', 1, 169, 266),
(30, 'ciotka', 1, 266, 169),
(31, 'syn', 1, 104, 35),
(32, '', 1, 35, 104),
(33, 'synowa', 0, 96, 62),
(34, 'teść', 1, 62, 96),
(35, 'wnuczka', 1, 82, 288),
(36, 'babcia', 0, 288, 82),
(37, 'kuzynka', 1, 38, 155),
(38, 'kuzyn', 0, 155, 38),
(39, 'synowa', 1, 137, 188),
(40, 'teść', 1, 188, 137),
(41, 'syn', 0, 7, 194),
(42, '', 0, 194, 7),
(43, 'żona', 1, 58, 281),
(44, 'mąż', 1, 281, 58),
(45, 'pasierb', 1, 187, 25),
(46, 'ojczym', 1, 25, 187),
(47, 'synowa', 1, 61, 253),
(48, 'teść', 0, 253, 61),
(49, 'babcia', 0, 131, 148),
(50, 'wnuk', 0, 148, 131),
(51, 'kuzyn', 1, 63, 238),
(52, 'kuzyn', 1, 238, 63),
(53, 'siostrzeniec', 1, 222, 176),
(54, 'ciotka', 1, 176, 222),
(55, 'synowa', 0, 128, 30),
(56, 'teść', 1, 30, 128),
(57, 'siostrzenica', 0, 301, 271),
(58, 'wujek', 1, 271, 301),
(59, 'wujek', 1, 202, 44),
(60, 'bratanica', 1, 44, 202),
(61, 'ojczym', 1, 283, 189),
(62, 'pasierbica', 1, 189, 283),
(63, 'siostrzeniec', 1, 195, 136),
(64, 'wujek', 1, 136, 195),
(65, 'bratanica', 1, 60, 119),
(66, 'ciotka', 0, 119, 60),
(67, 'ojczym', 0, 272, 299),
(68, 'pasierbica', 1, 299, 272),
(69, 'babcia', 1, 40, 277),
(70, 'wnuk', 1, 277, 40),
(71, 'ojczym', 1, 12, 153),
(72, 'pasierbica', 1, 153, 12),
(73, 'babcia', 0, 158, 13),
(74, 'wnuk', 1, 13, 158),
(75, 'bratanica', 1, 242, 197),
(76, 'ciotka', 1, 197, 242),
(77, 'bratanica', 1, 157, 6),
(78, 'wujek', 1, 6, 157),
(79, 'teść', 1, 231, 287),
(80, 'zięć', 1, 287, 231),
(81, 'szwagier', 1, 279, 276),
(82, 'szwagierka', 1, 276, 279),
(83, 'synowa', 1, 118, 198),
(84, 'teściowa', 1, 198, 118),
(85, 'siostrzeniec', 0, 290, 120),
(86, 'ciotka', 1, 120, 290),
(87, 'macocha', 1, 286, 65),
(88, 'pasierbica', 1, 65, 286),
(89, 'teściowa', 1, 80, 76),
(90, 'zięć', 0, 76, 80),
(91, 'macocha', 1, 97, 31),
(92, 'pasierbica', 0, 31, 97),
(93, 'żona', 1, 152, 139),
(94, 'żona', 1, 139, 152),
(95, 'mąż', 1, 226, 55),
(96, 'żona', 1, 55, 226),
(97, 'szwagier', 1, 177, 217),
(98, 'szwagierka', 1, 217, 177),
(99, 'mama', 1, 159, 95),
(100, 'syn', 1, 95, 159),
(101, 'teściowa', 1, 292, 18),
(102, 'synowa', 1, 18, 292),
(103, 'żona', 1, 257, 250),
(104, 'mąż', 1, 250, 257),
(105, 'siostra', 1, 193, 206),
(106, 'siostra', 1, 206, 193),
(107, 'wnuczka', 0, 8, 235),
(108, 'babcia', 1, 235, 8),
(109, 'syn', 1, 143, 164),
(110, 'ojciec', 0, 164, 143),
(111, 'siostra', 0, 289, 2),
(112, 'siostra', 0, 2, 289),
(113, 'bratanica', 1, 48, 125),
(114, 'ciotka', 1, 125, 48),
(115, 'córka', 1, 175, 89),
(116, '', 0, 89, 175),
(117, 'żona', 1, 122, 79),
(118, 'żona', 1, 79, 122),
(119, 'córka', 1, 244, 214),
(120, '', 1, 214, 244),
(121, 'babcia', 0, 170, 258),
(122, 'wnuk', 1, 258, 170),
(123, 'kuzynka', 1, 224, 166),
(124, 'kuzyn', 1, 166, 224),
(125, 'ciotka', 0, 219, 115),
(126, 'siostrzenica', 1, 115, 219),
(127, 'mama', 0, 243, 4),
(128, 'córka', 0, 4, 243),
(129, 'macocha', 1, 10, 179),
(130, 'pasierbica', 1, 179, 10),
(131, 'mama', 1, 107, 297),
(132, 'syn', 0, 297, 107),
(133, 'wujek', 0, 116, 232),
(134, 'bratanica', 1, 232, 116),
(135, 'bratanica', 1, 223, 37),
(136, 'ciotka', 0, 37, 223),
(137, 'córka', 1, 261, 20),
(138, 'ojciec', 1, 20, 261),
(139, 'kuzyn', 1, 210, 111),
(140, 'kuzynka', 1, 111, 210),
(141, 'kuzynka', 0, 127, 172),
(142, 'kuzynka', 1, 172, 127),
(143, 'macocha', 1, 146, 264),
(144, 'pasierbica', 0, 264, 146),
(145, 'zięć', 1, 201, 142),
(146, 'teść', 0, 142, 201),
(147, 'żona', 0, 124, 83),
(148, 'żona', 1, 83, 124),
(149, 'mąż', 1, 41, 9),
(150, 'żona', 0, 9, 41),
(151, 'kuzynka', 1, 248, 109),
(152, 'kuzyn', 1, 109, 248),
(153, 'siostrzeniec', 1, 77, 102),
(154, 'wujek', 1, 102, 77),
(155, 'brat', 0, 52, 213),
(156, 'siostra', 1, 213, 52),
(157, 'babcia', 1, 234, 267),
(158, 'wnuczka', 1, 267, 234),
(159, 'kuzyn', 1, 254, 233),
(160, 'kuzyn', 0, 233, 254),
(161, 'wnuk', 1, 228, 132),
(162, 'dziadek', 1, 132, 228),
(163, 'pasierbica', 0, 163, 262),
(164, 'ojczym', 1, 262, 163),
(165, 'żona', 0, 181, 103),
(166, 'żona', 0, 103, 181),
(167, 'ciotka', 0, 174, 156),
(168, 'siostrzeniec', 1, 156, 174),
(169, 'brat', 1, 245, 15),
(170, 'brat', 1, 15, 245),
(171, 'ojciec', 1, 33, 100),
(172, 'syn', 1, 100, 33),
(173, 'siostrzenica', 1, 282, 190),
(174, 'wujek', 1, 190, 282),
(175, 'siostra', 1, 123, 167),
(176, 'brat', 0, 167, 123),
(177, 'szwagier', 1, 17, 236),
(178, 'szwagier', 1, 236, 17),
(179, 'szwagier', 1, 151, 11),
(180, 'szwagier', 1, 11, 151),
(181, 'zięć', 1, 184, 135),
(182, 'teściowa', 0, 135, 184),
(183, 'kuzynka', 1, 171, 294),
(184, 'kuzyn', 1, 294, 171),
(185, 'pasierbica', 1, 133, 78),
(186, 'ojczym', 1, 78, 133),
(187, 'macocha', 1, 34, 117),
(188, 'pasierbica', 1, 117, 34),
(189, 'babcia', 0, 141, 260),
(190, 'wnuczka', 0, 260, 141),
(191, 'macocha', 1, 296, 218),
(192, 'pasierb', 0, 218, 296),
(193, 'ojciec', 1, 295, 86),
(194, 'córka', 0, 86, 295),
(195, 'żona', 1, 209, 150),
(196, 'mąż', 1, 150, 209),
(197, 'wnuczka', 1, 84, 69),
(198, 'babcia', 1, 69, 84),
(199, 'szwagier', 1, 99, 255),
(200, 'szwagierka', 1, 255, 99),
(201, 'wnuczka', 1, 293, 196),
(202, 'babcia', 1, 196, 293),
(203, 'wnuk', 1, 227, 39),
(204, 'dziadek', 1, 39, 227),
(205, 'żona', 1, 199, 16),
(206, 'mąż', 0, 16, 199),
(207, 'kuzynka', 0, 90, 186),
(208, 'kuzynka', 1, 186, 90),
(209, 'teściowa', 1, 140, 53),
(210, 'synowa', 1, 53, 140),
(211, 'bratanek', 1, 114, 207),
(212, 'ciotka', 1, 207, 114),
(213, 'ojczym', 1, 273, 101),
(214, 'pasierbica', 0, 101, 273),
(215, 'macocha', 0, 27, 138),
(216, 'pasierbica', 1, 138, 27),
(217, 'pasierbica', 1, 19, 192),
(218, 'macocha', 0, 192, 19),
(219, 'szwagierka', 1, 191, 263),
(220, 'szwagierka', 1, 263, 191),
(221, 'szwagierka', 1, 239, 74),
(222, 'szwagier', 1, 74, 239),
(223, 'wnuk', 0, 208, 42),
(224, 'dziadek', 0, 42, 208),
(225, 'synowa', 1, 291, 160),
(226, 'teściowa', 1, 160, 291),
(227, 'syn', 1, 64, 87),
(228, 'ojciec', 1, 87, 64),
(229, 'bratanica', 0, 161, 185),
(230, 'wujek', 1, 185, 161),
(231, 'wnuk', 1, 180, 280),
(232, 'babcia', 1, 280, 180),
(233, 'syn', 1, 66, 182),
(234, 'ojciec', 1, 182, 66),
(235, 'kuzyn', 1, 108, 268),
(236, 'kuzynka', 1, 268, 108),
(237, 'żona', 1, 43, 265),
(238, 'żona', 0, 265, 43),
(239, 'siostrzenica', 0, 57, 205),
(240, 'wujek', 1, 205, 57),
(241, 'żona', 1, 112, 144),
(242, 'mąż', 0, 144, 112),
(243, 'siostrzeniec', 1, 275, 32),
(244, 'ciotka', 1, 32, 275),
(245, 'ojczym', 1, 204, 200),
(246, 'pasierbica', 1, 200, 204),
(247, 'mąż', 1, 269, 130),
(248, 'żona', 0, 130, 269),
(249, 'siostrzenica', 1, 91, 147),
(250, 'ciotka', 1, 147, 91),
(251, 'zięć', 0, 73, 92),
(252, 'teść', 1, 92, 73),
(253, 'macocha', 0, 14, 165),
(254, 'pasierbica', 1, 165, 14),
(255, 'kuzynka', 0, 251, 36),
(256, 'kuzynka', 1, 36, 251),
(257, 'mama', 1, 247, 5),
(258, 'córka', 0, 5, 247),
(259, 'siostrzenica', 1, 216, 259),
(260, 'wujek', 0, 259, 216),
(261, 'siostrzenica', 1, 113, 241),
(262, 'wujek', 0, 241, 113),
(263, 'siostrzeniec', 1, 237, 203),
(264, 'ciotka', 0, 203, 237),
(265, 'ciotka', 0, 256, 230),
(266, 'siostrzenica', 1, 230, 256),
(267, 'babcia', 1, 47, 129),
(268, 'wnuczka', 1, 129, 47),
(269, 'kuzyn', 1, 51, 285),
(270, 'kuzyn', 1, 285, 51),
(271, 'bratanek', 0, 162, 225),
(272, 'ciotka', 1, 225, 162),
(273, 'pasierbica', 1, 46, 50),
(274, 'macocha', 1, 50, 46),
(275, 'siostra', 0, 72, 211),
(276, 'siostra', 1, 211, 72),
(277, 'wnuczka', 1, 178, 26),
(278, 'babcia', 0, 26, 178),
(279, 'brat', 1, 220, 45),
(280, 'brat', 1, 45, 220),
(281, 'teść', 1, 21, 68),
(282, 'synowa', 1, 68, 21),
(283, 'synowa', 1, 28, 149),
(284, 'teściowa', 1, 149, 28),
(285, 'kuzynka', 0, 134, 249),
(286, 'kuzynka', 1, 249, 134),
(287, 'bratanica', 1, 70, 71),
(288, 'ciotka', 1, 71, 70),
(289, 'babcia', 1, 168, 105),
(290, 'wnuk', 1, 105, 168),
(291, 'kuzynka', 1, 173, 93),
(292, 'kuzynka', 0, 93, 173),
(293, 'zięć', 1, 126, 98),
(294, 'teść', 1, 98, 126),
(295, 'mąż', 1, 154, 3),
(296, 'żona', 0, 3, 154),
(297, 'macocha', 1, 252, 49),
(298, 'pasierb', 1, 49, 252),
(299, 'siostrzeniec', 1, 284, 56),
(300, 'ciotka', 1, 56, 284);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `pozycja_modlitwy`
-- (See below for the actual view)
--
CREATE TABLE `pozycja_modlitwy` (
`id` smallint(255) unsigned
,`nazwa` varchar(128)
,`liczba_polubien` bigint(21)
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `pozycja_rodziny`
-- (See below for the actual view)
--
CREATE TABLE `pozycja_rodziny` (
`id` int(10) unsigned
,`nazwa` varchar(128)
,`liczba_czlonkow` bigint(21)
);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `proboszcz`
--

CREATE TABLE `proboszcz` (
  `id` tinyint(255) UNSIGNED NOT NULL,
  `imie` varchar(64) NOT NULL,
  `nazwisko` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `proboszcz`
--

INSERT INTO `proboszcz` (`id`, `imie`, `nazwisko`) VALUES
(1, 'Kornel', 'Chwała'),
(2, 'Daniel', 'Miodek'),
(3, 'Cezary', 'Procek'),
(4, 'Arkadiusz', 'Thomas'),
(5, 'Jacek', 'Gogol'),
(6, 'Bruno', 'Malara'),
(7, 'Mariusz', 'Stochel'),
(8, 'Fryderyk', 'Muniak'),
(9, 'Sebastian', 'Wosiek'),
(10, 'Jan', 'Wyroślak'),
(11, 'Maciej', 'Nagel'),
(12, 'Daniel', 'Smoter'),
(13, 'Paweł', 'Osial'),
(14, 'Antoni', 'Mosur'),
(15, 'Mikołaj', 'Popielarczyk'),
(16, 'Tomasz', 'Matyka'),
(17, 'Aleksander', 'Matejczuk'),
(18, 'Sebastian', 'Krajniak'),
(19, 'Norbert', 'Gula'),
(20, 'Mariusz', 'Chaba'),
(21, 'Emil', 'Fijałek'),
(22, 'Grzegorz', 'Dorawa'),
(23, 'Borys', 'Nalewajko'),
(24, 'Jerzy', 'Cieciora'),
(25, 'Kamil', 'Tatarczuk'),
(26, 'Oskar', 'Ślipek'),
(27, 'Arkadiusz', 'Błażejczak'),
(28, 'Bartek', 'Kutera'),
(29, 'Marek', 'Boruc'),
(30, 'Dawid', 'Ważna'),
(31, 'Kazimierz', 'Gogol'),
(32, 'Cyprian', 'Tryka'),
(33, 'Filip', 'Tymczyszyn'),
(34, 'Bruno', 'Maciejuk'),
(35, 'Arkadiusz', 'Skwira'),
(36, 'Ryszard', 'Powązka'),
(37, 'Grzegorz', 'Cichowlas'),
(38, 'Eryk', 'Langiewicz'),
(39, 'Juliusz', 'Wojtyś'),
(40, 'Dominik', 'Wiertelak'),
(41, 'Ernest', 'Długozima'),
(42, 'Juliusz', 'Szymków'),
(43, 'Rafał', 'Steinke'),
(44, 'Wiktor', 'Zastawny'),
(45, 'Witold', 'Ruszczak'),
(46, 'Jeremi', 'Pawlukiewicz'),
(47, 'Kornel', 'Sarota'),
(48, 'Łukasz', 'Och'),
(49, 'Gabriel', 'Słabosz'),
(50, 'Kacper', 'Doroszuk'),
(51, 'Jędrzej', 'Kuder'),
(52, 'Oskar', 'Karol'),
(53, 'Łukasz', 'Giec'),
(54, 'Tobiasz', 'Świątkiewicz'),
(55, 'Ernest', 'Małys'),
(56, 'Damian', 'Glenc'),
(57, 'Alan', 'Szarejko'),
(58, 'Dawid', 'Brojek'),
(59, 'Maurycy', 'Indyka'),
(60, 'Kajetan', 'Rurarz'),
(61, 'Hubert', 'Korniak'),
(62, 'Aleks', 'Kempka'),
(63, 'Iwo', 'Hirsch'),
(64, 'Bruno', 'Hennig'),
(65, 'Oskar', 'Łokaj'),
(66, 'Kacper', 'Gęca'),
(67, 'Olgierd', 'Pasiak'),
(68, 'Norbert', 'Rubacha'),
(69, 'Marcin', 'Waszczyk'),
(70, 'Alan', 'Gogół'),
(71, 'Marek', 'Pielach'),
(72, 'Franciszek', 'Kruszka'),
(73, 'Hubert', 'Salawa'),
(74, 'Ernest', 'Koziarz'),
(75, 'Daniel', 'Jędraszczyk'),
(76, 'Szymon', 'Hrabia'),
(77, 'Maciej', 'Łasak'),
(78, 'Kazimierz', 'Cywka'),
(79, 'Maciej', 'Hadam'),
(80, 'Jeremi', 'Murach'),
(81, 'Dawid', 'Domurad'),
(82, 'Nataniel', 'Witas'),
(83, 'Mieszko', 'Albin'),
(84, 'Jeremi', 'Schubert'),
(85, 'Błażej', 'Ficner'),
(86, 'Dariusz', 'Sycz'),
(87, 'Alex', 'Fras'),
(88, 'Leonard', 'Kapuścik'),
(89, 'Emil', 'Stoltman'),
(90, 'Sebastian', 'Furga'),
(91, 'Przemysław', 'Kusyk'),
(92, 'Miłosz', 'Piersa'),
(93, 'Daniel', 'Sankiewicz'),
(94, 'Natan', 'Wojtak'),
(95, 'Tobiasz', 'Fabiańczyk'),
(96, 'Tymon', 'Bareja'),
(97, 'Maks', 'Stojak'),
(98, 'Leonard', 'Cierpka'),
(99, 'Przemysław', 'Prygiel'),
(100, 'Mieszko', 'Maculewicz');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `rodzina`
--

CREATE TABLE `rodzina` (
  `id` int(10) UNSIGNED NOT NULL,
  `nazwa` varchar(128) NOT NULL,
  `opis` varchar(1024) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `rodzina`
--

INSERT INTO `rodzina` (`id`, `nazwa`, `opis`) VALUES
(1, 'Nieznana', NULL),
(2, 'Korfantego', 'Wrócić płakać płyn wiara powinien barwa. Czas dolny zaczynać koszula on. Ósmy wyrażenie władca łatwy. Proszę rosnąć drzwi biec decyzja mięsień amharski. Atmosfera radość podnieść gdzieś. Liść obrona problem całkiem. Relacja umożliwiać powód właściwość prawie trzeci wypadek.'),
(3, 'Starowiejska', 'Bohater specjalista rozwój straszny głupota cześć. Północny muzyka żart środek angielski. Urodzenie obecnie tyle dzień płynąć 8. Dyrektor pomarańczowy tysiąc muzyk. Wiek podział technika rynek kij radiowy błąd lęk. Ziemski wymagać wokół otrzymać talerz. Australia chmura zupełnie szkło promień 100. Wola wąski jakiś 70 długi komórka czarny wykonywać. Ręka ćwiczenie bułgarski dziewczynka tworzyć ludzki wybierać lista. Wywołać oddział morze płynąć oś 70. Rodowity wygląd USA włoski górski ładny płyn. Chwila opinia sport zaburzenie szlachetny. Stopa ten wiedza kupić. Klimat śnieg biskup podatek. Dużo podstawa spadek napisać. Sześćdziesiąt odważny własność kula poduszka wesoły. Narodowość 20 motyl ochrona umiejętność element pasmo. 3 powstawać Morze Śródziemne narodowy bawić się Szwajcaria założyć zgoda. Przyjemność nadmierny bogaty nawet miasto.'),
(4, 'Średnia', 'Zazwyczaj surowy czytać umiejętność rada wiara myśleć ciecz. Klub należeć kolega sprawiać. Widoczny dopływ śmiech krowa. - dwanaście religijny odmiana. Wolno daleko przybyć. Towar wiedza ludzki spać chrześcijaństwo cześć. Nazwa pierwiastek poziom spokój. Wydarzenie klient wierny bać się niedziela. Ochrona wybrać rodowity temu sztuka. Istnienie intensywny alkohol w. wrażenie szyja dół brzuch. Przejście sportowy łyżka odwaga. Pokazywać Francja przedsiębiorstwo głupi pierś ból dusza.'),
(5, 'Dojazdowa', 'Sala następować policzek. Wrażenie zmienić profesor obywatelka uderzać np. ?. Spać tłumaczyć dać styl. Unia Europejska następny więc ? wysoko dokonać wejść zasada. Uznawać droga 70 gwiazdozbiór znajdować się. Kończyć wino byk Wielka Brytania on. Ten Sam wśród obóz pogoda. Napisać umieścić jakiś dobry język płeć mrówka. Zupełnie Boże Narodzenie cmentarz 100 piękny. Wydać kontakt wejść deska oddać. W Formie zwolennik król dzisiejszy. Męski powstać lista dalej wskazywać. Włosy śnieg wybór lecz Izrael dziwny oddział rada. Pierwiastek Chemiczny kawałek bydło różowy kiedyś. Ludzie naukowiec suchy. Następować wzór gotować wyłącznie stan wizyta. Przypadek coś poruszać się domowy. Towar żydowski mapa rzecz. Urodzenie wszystek powinien uzyskać trzymać kartka jesień wyspa. Zaufanie 8 lotnisko listopad gorący metalowy wokół. Zarówno ważny Słowacja stary sądzić Słowacja.'),
(6, 'Zdrojowa', 'Prostytutka pokazywać jako obiad. Cisza osobisty bóg roślina. Wybory lot przejście marka. Dzisiaj waluta występować filmowy palec wrogi dokument. Zamiast rządzić małżeństwo but napisać doświadczenie zacząć. Królowa zgoda farba mały polski mądry umożliwiać. Rozmiar odnosić się masa prawy dokonać górski zwrot. Miód strefa wiek powstawać czuć Wielka Brytania zniszczyć pole. Owad spaść stopa skała podnieść uznawać broń. Jako składnik uciekać dotyczyć. Dno kot polityka litera. Poznać wobec znaczyć sól wąż. 30 mały cień ludzki. Gotować ale siedzieć sierpień obcy pomagać przepis róg. Sobota środek przeprowadzać ocean port trzydziesty. Osiągnąć transport pomoc wyjść czerwiec zrobić tyle. Piąty dyrektor list. Głód dać się arabski czynnik. Ochrona gwałtowny pracownik ile noc. Przyjęcie pomieszczenie dla przedsiębiorstwo czekolada 10 dalej. Pić centralny film wszyscy.'),
(7, 'Łabędzia', 'Linia podać technika za pomocą posiadać właśnie pełny. Podstawa około paliwo Belgia tytoń. Stół naukowy odczuwać. Pozycja umiejętność masło drużyna dobry temperatura ponad. Praktyka państwowy powieść numer. Herb palić Holandia wódka handel. Obserwować liczny Azja system robota budowla. Zająć całkowicie wojna przeszłość siebie. Kłopot psychiczny pijany malować pora. Smutny handlowy mysz seks. Prawda tkanina przeciwko mało serce. Nauczycielka wypadek posługiwać się św.. 0 łódź pół półwysep bank zakładać okres. Z niż zająć wziąć piłka nożna. Walczyć wskazywać ofiara latać sobota chyba. Odbywać Się otwór skała uderzenie. W Kształcie prowincja narzędzie komputerowy lecieć. Wyłącznie hotel technika spodnie 70. Potrafić kierować rodzaj zostać sala. Płaszcz doskonały jajko nasiono martwy krok samiec.'),
(8, 'Myśliwska', 'Gleba wycieczka gwiazda wszyscy. Dziób gorący Pan jednocześnie oraz mieszkanka. Jeść dialekt mecz seks nasz wspólny wyjście.'),
(9, 'Podmiejska', 'Masa artystyczny telefon park. Tłuszcz lista płynąć mocz żaba połączenie. Brzydki uniwersytet szybki wnętrze udział aktor. Obserwować też mięso strumień. Specjalny korzystać szukać pomóc książka. Kilka na zewnątrz przyszły użycie. Słownik most czerwony koniec pociąg włos toponim. Mocny zasada surowy blisko martwy budynek lubić. Postać przyjęcie rosyjski ciasto Rumunia. Kiedyś obrót sprawa. Kolega panna postawa dzielić samica klub.'),
(10, 'Traugutta', 'Staw.'),
(11, 'Szkolna', 'Ukraina ojciec cesarz pieśń strumień piątek. Internetowy bronić odpowiadać stolica. Październik święto zmiana umrzeć ziarno. Dziecięcy budowla woda wyrok ziemia cel. Naród dzisiaj motyl maj odbywać się wy. Sytuacja kościelny pisanie student gra wybrać. Znajdować Się energia numer pamiętać dziać się ramię. Pogląd byk wypadek charakterystyczny obwód. Zakład prezent drogi policzek dokonywać miecz. Jeżeli 5 cmentarz otworzyć. Słońce służba wodny Belgia znaczny zdjęcie. Właściciel wysoko szczyt trzy poruszać się pojawić się Anglia. Praca wyścig dziedzina ksiądz. Wiersz Izrael czwartek kupić tańczyć. Tańczyć płynąć opinia pamięć artysta zmarły na zewnątrz szczyt. Pełen marka obejmować pióro nauka zgromadzenie styczeń. Nauczyciel drewno treść mieszkać wysiłek. Niezwykły niebezpieczeństwo przy para rada opinia. Kula zgoda pogoda wnętrze. Austria - królewski bronić prąd grób dom. Urządzenie liczyć kontrola ludowy południowy wysoko.');

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `rodzina_wzeniona`
-- (See below for the actual view)
--
CREATE TABLE `rodzina_wzeniona` (
`rodzina_id` int(10) unsigned
,`uzytkownik_id` int(10) unsigned
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `sygnatura`
-- (See below for the actual view)
--
CREATE TABLE `sygnatura` (
`uzytkownik_id` int(10) unsigned
,`imie_pseudonim_nazwisko` varchar(196)
);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `tablica_ogloszeniowa`
--

CREATE TABLE `tablica_ogloszeniowa` (
  `id` smallint(255) UNSIGNED NOT NULL,
  `nazwa` varchar(256) NOT NULL,
  `opis` varchar(2048) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `tablica_ogloszeniowa`
--

INSERT INTO `tablica_ogloszeniowa` (`id`, `nazwa`, `opis`) VALUES
(1, 'Tablica główna', 'Witaj na naszym portalu!'),
(2, 'grupa Borówkowa', 'Działanie komórka następować liczyć smutny 6. W. piłka nożna egzamin wrażenie nadawać.'),
(3, 'miszkiel Sawickiej', 'Ja ramię matematyka smutny artystyczny studiować wtorek przeciwny. Przyszłość przygotowywać już fabryka nieść otrzymać. Projekt trzydziesty znajdować się pochodzenie gdy według. Ciepło europejski pół ten. Daleko gość otaczać przeciw ptak ten. Miłość głód przedsiębiorstwo środek. Badać mieszkanka dostęp budować. Zatrzymać miejscowość bogactwo stosować dziedzina Jezus mierzyć niedźwiedź. Śmierć artykuł krowa pojedynczy butelka. Podróż połączenie piątek blady w końcu. Występować czerwony radość wrócić nikt rozmiar norma. Naprawdę mur piątek zupełnie jedzenie pogoda. Ludowy nie- z również znajdować się. Palec pochodzić dokonać. Zmieniać pomoc myśleć tutaj powolny majuskuła. Gospodarka w celu nie- łódź czasownik wąski. Organizm substancja drapieżny panna bycie gwiazda. Organizm polityczny zbiór następny duży czasem. Patrzeć rzeka Ameryka dzieło. Podawać francuski grzech restauracja dziecko. Złożyć znaczyć dotyczyć wiadomość. Zobaczyć suchy republika jeździć. Silny głupi głęboki znosić próba uśmiech wiedza. Bieg lud czapka społeczny ślub kolejny myśl mecz. Krzew szczególny w małżeństwo wykonywać. Władza dzielnica wyrób padać. Leczenie uciekać słuchać pasmo - wygrać przepis. Przestępstwo budować kamień umieć okoliczność. Dolina częściowo okres rano. Warstwa bieda fałszywy szczególnie sześćdziesiąt ogon podnosić. Kawa wytwarzać smutny następny 3. Pierwiastek Chemiczny przepis wybrać Polak kolano prawdziwy długi. Trochę radiowy rak ozdobny cecha przeciw dać.'),
(4, 'spoldzielnia Długa', 'Już dzisiaj letni grać prawdziwy wzgórze. Wiedzieć przemysł tablica dziób Ukraina. Norma w ciągu mocny państwowy łaciński maj. Fala korona wzór właśnie 70. Pomoc Litwa dzień południe środkowy gaz bać się. Ogół górny święty władza z powodu. Wybitny ogólny pacjent pustynia deska igła owad osiemdziesiąt. Dyskusja plan napój niedźwiedź. Jesień wypowiedź nasienie armia. Szlachetny miejsce bohater aż sam. Kapelusz polegać pokój król finansowy flaga lista. Średni jeśli Polska opuścić księga. Przybyć mężczyzna rzeczownik stół. Kontakt późny pasmo osiem. Ty para płyn bogini stół pijany łatwo. Tkanina strach jeść ciężar. Dusza pięć zimny gdy drewno rzeczywistość. Średniowieczny kawa między błąd pomarańcza. Środowisko gołąb kurs zbiór żyć raz mocny związany. Miłość wobec bogactwo komputerowy handlowy dobro. Wódka nigdy prowincja widoczny prędkość. Ciotka 20 wschód 2 w kształcie źle firma. Doświadczenie jeśli potrawa rada 5 Holandia sądzić. Deszcz muzeum dany łączyć futro. Lekarz nieść środa przypominać. Wstyd poważny a kupić literatura talerz USA. Zbyt sprzęt szósty urząd skała. Stowarzyszenie wczesny reguła zgoda kij nieprzyjemny. Pewien pytanie symbol. Symbol brązowy postępowanie. Przeprowadzać rozmawiać ziemia otoczenie samochód. Fizyczny siedziba właśnie kawałek 40 poduszka. Pszczoła literacki oczekiwać ozdobny cień krótki organ niezwykły. Państwo wątpliwość przyjmować brat. M.In. letni spokój cienki lek dobrze cierpieć. Para dwanaście drogi ale przeciwny skłonność strata. Numer niedziela kolumna ósmy zawsze pragnąć zanim wobec.'),
(5, 'fpuh Konstytucji 3 Maja', 'Występować potrawa słownik pociąg zakładać silny koło przeszkoda. Określenie sądowy nagły kontrola. Głośny następować umieścić bogaty być choć itp.. Stowarzyszenie dlaczego akt. Pochodzić między święto dla jabłko wtedy. Muzyk w formie układ literatura. Kura istnieć słowacki majątek. Grupa związany pozycja Szwajcaria polować armia. Uprawiać plama równy chrześcijański. Czarny węgiel mur stawiać. Pisać sos jasny rozmawiać. Szacunek obowiązek dziki kto uznawać sztuczny. Przyszły toponim pragnąć. Uchodzić szyja wyspa klub zrozumieć wyraz. Ze zaraz śmiech narzędzie obcy poprzez. Rola pojawiać się blisko działać starożytny żydowski. Spór 10 artystyczny 100 założyć płakać papieros warstwa. On mnóstwo powiedzieć przyjemny mały dziewczynka. Wejście wcześnie rodzinny tytoń wolność po prostu Rumunia. Piłka jedyny go jeszcze. Wykorzystywać mieć telefon piętnaście. Pisarz dany wczoraj zapalenie nosić mąż. Uprawiać typ ? burza. Osioł gleba własny morze ucho. Szklanka mocny Afryka zamiast wisieć igła sprawiać. Np. instrument Chrystus słońce Niemcy podróżować w ciągu. Wreszcie kultura przepis obecny. 4 dla silny łóżko niebieski atak urządzenie. Gatunek wynik w organizm. Panna zmienić fotografia koncert figura. Złapać kontrola znaleźć.'),
(6, 'gabinety Leszczynowa', 'System rozpocząć nadzieja. Żelazo centrum atak zbudować. Większy ja barwa. Ze noga rodzina pójść cel narząd. Kwestia umowa pożar przyjaźń dokument muzyczny pojawiać się przyszłość. Prezent lista znowu system pierwiastek. Chłopak wspaniały pomysł komórka korona. Lato papież zgadzać się wejście poważny zmarły szanowny rzadki. Tradycyjny drzwi pytanie. Szczególnie kwestia kształt. Ozdobny kiedy jednocześnie szereg. Kostka majątek użyć słowacki Belgia wkrótce. Informacja zwierzę tłumaczyć wewnętrzny. Ciągnąć kwiat władza chronić wspomnienie. Nie Ma siedziba sposób poprzedni kawałek.'),
(7, 'ppuh Zdrojowa', 'Prawda budowla znajdować się czyjś. Rosyjski mysz zakład znajdować się diabeł dostęp. Wrzesień różny dzisiejszy. Główny karta łuk artykuł. Ich sąd warunek wspomnienie uczeń. Prawie szukać szwedzki rejon. Grudzień wieś ogół radość. Chłopak zamiast gdy bezpieczeństwo prowincja plecy jeżeli. Powoli wolno założyć przeciw uśmiech nawet wracać. Służba wstyd czasownik poprzez skłonność kierowca. Niebezpieczny domowy wspaniały chodzić ponownie.'),
(8, 'walaszek-meissner Lubelska', '3 sztuka mózg okres ciemny. Grecja amerykański grudzień chrześcijański. Krzesło wisieć wiosna istnieć robotnik. Zbiornik przygotowywać wyrażać. Przynosić obrona rzecz. Partia wieś zdrowie też. Swój dzięki lecz. Chodzić wysłać dziadek obecny. Wyrażenie koszt ogólny blady wysiłek archipelag. Możliwość brak sygnał dziwny. Moralny Egipt dany głowa rodzic róża dziki prywatny. Krok tytuł czterdzieści związek zatrzymać. Towarzystwo bliski żeński spadać podróż zgodnie wiek. Brzuch wieś słaby maszyna. Uciekać zapis Chiny. Termin nadawać bydło tu ponieważ wokół. Doprowadzić morski jeździć jednocześnie. Dzień wychodzić wyrok muzyk natura śmiech leżeć ogólny. Mało wychodzić waga plama lew osobisty. Przecież my wierny jeżeli doskonały. Godzina utwór gra narząd właściwość udać się. Wiersz włosy głos powód organ głos plama pojedynczy. Ciągnąć piątek zamek park odległość prawie jezioro. Służba bitwa wojenny obrona rozmawiać ryba założyć. Służyć jedenaście moment.'),
(9, 'grupa Sybiraków', 'Warstwa Chrystus przychodzić świecić łączyć plama. Tradycja przeciwny ukraiński mieszkaniec wiatr waluta deszcz. Wschodni mrówka sprzedaż dziecięcy nos. Mąka styczeń potrzeba połączyć wykonywanie. Obchodzić całkowicie odzież metr potrzeba rozwój dwudziesty. Specjalista gotowy zboże. 9 cienki sieć nikt żeński rower. Wywołać 1 kierunek. Dolina mięsień południe walka widok wstyd. Grzech postawić uczyć pełnić miejscowość jeść. Dziedzina czynność śnieg silnik bogini drewno. Młody kura udać się. Wielki pałac niech czerwiec odpowiadać skłonność sen. Kochać zaufanie rynek owoc minuskuła klub lód błąd. Wakacje instytucja brak przejście wioska. Spadać dziecięcy babka wysokość zobaczyć tytoń uczucie wycieczka. Następny prawda cukier poniedziałek pozostać wracać bogactwo. Oficjalny kupić próbować rzadki młody dawać ci. Służba klub niedziela wybory ocena wiek narząd.'),
(10, 'luczka Robotnicza', 'Usługa epoka roślina sól mur gaz urzędnik. Chcieć prowadzić artysta jednostka zostać 70. Żelazo ilość sen morze oni. Dziecięcy umieszczać miasto prawy. Powoli wyrażenie cztery 90. Dzisiaj uważać cukier wyrób. Zbudować wtedy uważać zimno.'),
(11, 'spoldzielnia Hallera', 'Zobaczyć mieć Grecja przyprawa pokazywać. Jedyny działać jesień podnosić. Elektryczny niski otrzymać nagle zwycięstwo bycie. Surowy wódka stopień dokonywać starożytny. Znów lina prostytutka tracić poziom ból. Dany oddział stać płakać. Przybyć zamek gotowy gniew umowa. Okropny flaga moralny zachodni w. odczuwać. Miejscowość ilość dzień towar fałszywy. Poprzez umiejętność właśnie ozdobny mózg. Modlitwa wewnętrzny dno karta całkowity ziemniak kaczka. Czysty metoda polityka okazja średni sylaba. Stracić nigdy podróż rzucić. Powiedzieć gość powstanie symbol nie ma cebula głupiec. Teraz samica wpaść dłoń wschód wynosić umysł szkoda. Oddział pozwalać potrzeba noc czekolada. Narzędzie podawać czynić wieś wieś badać biedny. Przygotowywać koniec mistrz. Zniszczyć czynność wyłącznie abugida łatwo zaraz. Samochód tradycja smutny w ciągu domowy. Przez sala prawie jej. Chory podobny sam ciekawy roślina strumień publiczny. Ciotka sukces chemiczny. Fotografia Kraków mieć klimat. Motyl dolina potrzebny skrzydło przed coś. Bądź pieniądze w postaci muzyka sobota. Dziecięcy słodki wodny władza. Hałas łąka jednak wielkość. Pięćdziesiąt kolumna zły gdyby wiosna. O środkowy święto seksualny w postaci. Karta rozwój ser gdy piasek odzież. Ochrona trzy wreszcie wrażenie. Poza wstyd zakończyć japoński mówić ciężar kupić. Rzymski ciekawy umowa nawet filmowy podstawowy. Zatoka ryzyko obywatelka dziewczynka zajmować się starać się 2. Przerwa ostatni stosunek mistrz odbywać się użyć prąd pierwiastek chemiczny. Pełen wyjście zgromadzenie Niemcy. Ciepło milion metal obecnie zakończenie armia. Skala pogoda strona sztuka bydło określać. Pisanie jeździć zwolennik idea odbywać się oglądać. Świat paliwo opieka wydawać. Piłka itp. średniowieczny pewny połączyć ten sam.'),
(12, 'spoldzielnia Makowa', 'Nadzieja złoto zamieszkiwać wojskowy ocean. Czoło wąski ciężki powoli. Bieg nigdy kawałek zawód łuk. Radio na zewnątrz potrzebny Niemcy listopad szacunek. Lub jezioro podnieść miesiąc skala zobaczyć. Mecz Egipt bar przeszkoda orzeł natychmiast osioł. Przyjmować grudzień bogaty słyszeć. Długo niszczyć umieścić –. Usa oddział ciało się płyn. Wybór reakcja wtorek polegać rejon daleko. Pierwiastek Chemiczny przychodzić restauracja w czasie czasownik literacki przyjaźń. Igła pragnienie jasny wiedzieć wtedy powoli święty. Żaden rzadko myśl różny narkotyk. Zupełnie hałas szczęśliwy dialekt złoto ponownie okres ślad. Nad pokój linia waluta właściwy. Stół wysiłek zeszły tablica. Płyn budować łaciński własny most sobą państwowy. Popularny uderzyć sąsiad godność. - jeść powiedzieć i ptak bardzo zwierzę. Przejście wszelki talerz zajmować nóż kto. 5 wieża samochód zysk strata mąka. Chrystus 40 bez według daleko telewizja zakładać. Funkcja aktywny zdrowie sposób tamten z krwi i kości świeży jedzenie. Głównie pozostawać produkować pisarz światło z krwi i kości pierwszy. Otaczać wschodni metoda pierś. Kolorowy system wymagać ciepły. Muzeum zniszczyć wierzyć chęć. Po Prostu numer zadanie fotografia zapach. Zimno panować malować trzydziesty. Dzieło pojedynczy nie ma m.in. pokarm zbudować. Dorosły koszt pierwszy zmiana jednostka pozwalać umrzeć. Zgromadzenie pora silny wrogość 30. Obrona zanim wyścig organizacja aktor. Te pomidor chłopiec chleb wydarzenie zbiornik prezydent. Umożliwiać gorący niech flaga. Dziewięćdziesiąt niewolnik połączenie świnia bogactwo Polak urodzenie. Ruch operacja ani zeszły kwiecień postępowanie. Pochodzenie Włochy tani zmarły. Zabić otrzymywać pierwiastek chemiczny wysłać. Chemiczny korzystać znany dać piosenka korzystać. Wróg kłaść np. wakacje akt rozmowa koło —. Bar chory czerwiec stan mocz.'),
(13, 'bodych Ptasia', 'Właściwość ponad sześćdziesiąt właśnie wszelki dodawać. Wykonywanie prawie czeski piasek zgoda mięsień muzyczny. Korona filmowy relacja stworzyć liczyć rodowity. Trudność noga pojawiać się badanie jadalny pałac cisza. Dopiero robić posiłek natura. Tkanina rada obcy sierpień futro też 50. Przygotowywać część związek sport. Istnienie górski śpiewać Egipt wiedza prawda skóra. Skończyć mięso wrogość. Umysł opuścić sobie wokół bitwa. Sprawiać otrzymać drobny jajko pora obowiązek alkohol. Działać specjalny 1 efekt artysta klasztor piosenka impreza. Element wiadomość plecy. Umrzeć zazwyczaj porządek stan radio żeński prawo czapka. Nowy całkiem granica. Uczyć Się księżyc studia wykonywać. Kurs dzisiaj nieść o niewielki prezent należy. Pani siedziba znajdować się pokarm kilka zwrot święto. Chęć Hiszpania ofiara znajdować się. Stać liczny oddać Jezus. Dwa — Kościół przejście budynek mąż cienki. Proces produkować wyrażać pisać trzymać dziecko przychodzić film. Poczta szkolny jasny następny słodki ciepły promień. Metal połączyć myśleć płynąć chodzić. Ciotka naturalny zaraz bitwa błąd ryż. Sobota Ukraina łuk sprzęt ozdobny Słowacja.'),
(14, 'pys Narcyzowa', 'Towar biec medycyna świątynia kraina lot wydarzenie. Chory ciężar czerwony między chiński praktyka. Niebezpieczny na zewnątrz niedźwiedź wiadomość bać się ziarno z. Kolacja kupić 80 przyjść film. Mężczyzna autor postępować w czasie niezwykły wciąż dzieło. Obchodzić wybory obiad w wobec. Stawiać podnosić Warszawa kolano wyglądać 4. Spowodować pojedynczy metalowy obiekt mały. Wysyłać trzydziesty rodzaj majątek ćwiczenie uważać tradycja mocz. Sposób plaża dobro rzadki. Naprawdę zgromadzenie niebezpieczny. Wieś liczba atomowa lato klient. Czuć sprzedaż zgodny znaczyć. Ukraiński tekst Boże Narodzenie ciotka. Ciepły atak opisać świnia. Pomoc składać podłoga korzystać. Muzyka dawno oni pozwalać Ameryka.'),
(15, 'oleksiuk Gołębia', 'Następny zawierać mąż przyjaciel. Dany bogaty ładny. Jeżeli uczyć się specjalny trudność wykorzystywać urodzić tarcza. Wysłać przypominać wyjście żona. Afganistan duński minister. Zimno Egipt świadczyć pierś zbudować poprzedni tani własny. Wzdłuż cichy kara przykład. Należeć szef transport Stany Zjednoczone uczeń. Zmienić dokument 900 obrót chrześcijański potrafić złożony. Gałąź żeby towarzystwo wysokość jajo zima cecha. Pani zbiornik artysta żeby niszczyć wieś dobro. Ustawa wyłącznie składać przygotowywać osiem ogromny. Książka królestwo konstrukcja układ okresowy kwestia rola miłość przyszłość. W Formie każdy model. Odzież odkryć 40 ziemia moment napisać zanim. Flaga dziki wprowadzać że. Stany Zjednoczone wieża mały dostęp tradycyjny pomiędzy wola. Pozostawać osiemdziesiąt otrzymywać. Przeciwko palec pić kolega. Wiedzieć prędkość urządzenie królowa 900 grecki. Zajmować Się lud podnosić mąż. Operacja gorączka ludzki oko przedsiębiorstwo. Polegać jedenaście zewnętrzny. Klimat państwo wielkość most. Miły bronić pierwiastek chemiczny fakt linia. Ochrona człowiek styl grzech moralny plac. Klub kawa oglądać głupiec serce chory kalendarz. Wierny dlaczego silnik prasa organizm mleko gdyby. Półwysep metr szwedzki serce dziewięć. Styczeń noc sąsiad stać się. Szeroki dziadek dlaczego srebro chyba. Większy dyrektor jego. Mapa żaba technika odcień. Zawodnik zainteresowanie wyjść trzeci południowy kolorowy raz. Panna słownik przeciwnik. Pióro miękki słowacki zapalenie. Zając od miód odcień Egipt obecny.'),
(16, 'fpuh Starowiejska', 'Samiec fakt jakby albo cień. Chmura rosnąć mama wpływ rachunek. Oś 100 powolny krzew doprowadzić morski. Dno nagły dokument gniew. Pamiętać przerwa stolica światło dziecięcy kosztować relacja. Jedyny zasada w wyniku zanim. Wracać wolny sylaba tradycyjny. Dostęp kontrola róg intensywny wzdłuż ozdobny. Usta duży grać stosunek słońce warzywo bić. Dziewiąty pisanie Boże Narodzenie wśród liczba syn badanie. Grecja utrzymywać święto rzucić kot dokument skała pojemnik. Użytkownik piwo francuski przyjechać 70. Chłopak powstać problem wspomnienie ta dyskusja jeśli. Zacząć słoneczny powoli dalej prezent. Oś pomagać pająk pojawić się mnóstwo polityka. Marka przemysł – nie. Pozostawać kobiecy piąty umożliwiać. Większość nieprzyjemny internetowy spaść szacunek osoba. Gruby kosz duch obrót obóz Holandia. Złożyć powstawać składać organizm sam znaleźć no książę. Sobie forma właściwy kościelny ogół czasownik. Duży dziura brat sukienka.'),
(17, 'prokopczyk-osipowicz Kielecka', 'Pomagać odcinek przyszłość składnik odkryć chłop. Widok publiczny biuro żywność dać martwy występować. Pijany wydać szereg otworzyć. Morze Śródziemne znać wracać próba. Zwolennik iść piec zachowywać się filozofia. Pić powstawać decyzja. Hiszpański rada miód. Nieść zgodnie mierzyć cichy głupi dzisiaj. Wiadomość potrzeba strumień.'),
(18, 'cieciora Lipca', 'Samochód przed służba czyjś owad powszechny odpowiadać. Operacja ziemski instrument znosić jednak seksualny. Kobieta użycie skład ! hotel cień. Tekst mrówka 1000 azjatycki opisać. Przestać wóz wschodni łatwo zakres. Tekst szybki ze syn kilka przyjąć mur. Budowa kierunek oś pieniądze wielkość numer. Pojęcie poziom staw żaba wybory żaden. 4 otoczenie dopływ bilet właściwość wiek. Gość bułgarski uderzać spotkanie za. 1000 odkryć odważny. Problem zimno postawić zwolennik. Dziura szkolny tajemnica przeciwny łuk w końcu. Związać mężczyzna piłka nożna padać analiza zero sprzęt ruch. Strefa siedziba jak świnia wierzyć mgła osobisty. Wydawać zwyczaj restauracja dobro związany cztery. Mgła karta statek ładny ziemski majątek Rosja. Majuskuła rzeczownik lot student głupi podział podstawa. Duży filmowy ta wilk. Przyszły sól jeden wysoki rada.'),
(19, 'bubel-latacz Wesoła', 'Prawie narkotyk tajemnica sukces świadczyć położony państwo. Sobą uśmiech wiek przybyć zewnętrzny silny. Różny zawód plecy ciecz mój przebywać pełen różowy. Zbierać bogactwo jednostka. Wiosna tajemnica służba nagły opinia nauczycielka. 1000 strefa planeta sprzedawać most pojawiać się przybyć. Charakterystyczny wyścig sądowy uciekać ponownie. Słuchać kolejowy pomiędzy. Pomarańczowy król ludzki prosić. Biały osiem substancja gmina. Papieros padać około chronić tor. Zakładać różnica składać akt pamiętać szkoda. Ta dzielić cierpienie święty Niemiec psychiczny kwiat. Obrona ubogi rodzaj tradycyjny biedny srebro szkło. Niż bliski chłopak przez tor określony. Wiadomość istota na przykład nocny. Egzamin spotkać udać się strumień ziemski czerwony. Śmiać Się warunek ulica liczba atomowa wąski uśmiech odnosić się. Dziewięć zmienić waga administracyjny zainteresowanie. Nóż większość pan. Większość związany żelazo dotyczyć dlatego późno kształt. Zachowanie zawód siódmy pięćdziesiąt Japonia wieża budynek. Ładny olej cienki klub. Miejsce rosnąć Jan wykonać niebo wąż. Kto widzieć właściwy wracać dziura istnienie cały poznać. Dokonywać przypadek wodny narzędzie bogactwo komórka minuta religia. Wyspa barwa piec kraj zdarzenie wśród 60. Biblioteka przyszły jazda piec Włochy przypominać dźwięk. Następny 6 dużo nastrój wiara władza Polska. Południowy przyjęcie pomoc żywność świeży. Istnieć ojciec niż Chiny mały. Budynek uprawiać odbywać się autor z. Pokryć wysłać szereg leczenie pełny alkohol park. Wódka szkodliwy przypominać temu. Jedzenie o Afryka Unia Europejska cisza pojechać. Panować - pomóc ogon. 3 spać dość ćwiczenie. Prawo wybierać francuski twardy. Liść lista norma Słońce. Literatura przemysł czyn umieć pieśń dym lipiec postawa. Natura sprawa podział północ. Czynność bóg przestępstwo brzeg twardy trzydzieści słownik wspólny. Szwecja dane policjant śpiewać Indie wzdłuż.'),
(20, 'przenioslo-krecichwost Ptasia', 'Ciemny 7 wojsko zbyt paliwo biuro. Dla środa głód wspaniały pracownik praktyka. Wejście gotowy zawartość świątynia pasek hałas żołnierz. Chleb nastrój jednocześnie norma ty masa silny. Zdolny służba wierny. Ciepły płyn opuścić jednak wiatr powiat spodnie. Jeść wrogi władca pacjent potem hotel treść. Nie sprzęt Belgia. Maj bok umieć katastrofa. Dziewięćdziesiąt stosunek - żona abugida granica. Bieda seksualny wewnątrz masło zawód ja materiał. Dzieło kierować kaczka czyli wzdłuż. Pomoc żona rzeczywistość uderzenie kobieta umiejętność bić smutek. Norma rysunek sos lekki kamień koń ojczyzna wola. Trzymać dzięki małpa robotnik głęboki przeciwny przyjęcie rozumieć.'),
(21, 'ppuh Stycznia', 'Przeciwko dusza oglądać dokładnie internetowy on kino. Staw wszystko podnieść domowy drobny szczególnie. Rejon ciepło relacja promień rano brązowy. Złapać ktoś budowa podstawowy długo kiedyś. Trwały nieść podłoga wywodzić się litera stopa. Dziecięcy decyzja koncert zakończyć więzienie bogaty pociąg. Drzwi razem gdzieś 7 klucz w. jasny w.. Kobiecy nie- napój bawić się daleki polityk cierpieć. Odważny dodawać sytuacja barwa sąd osiemdziesiąt miejscowość. Liść 40 stworzyć oddział. Wąski kultura przeciw reakcja pozycja zrozumieć. Miękki nagle butelka żydowski cześć niebieski koń. Kraj ciemność książka pasmo osiągnąć wykonanie zamknąć. Bóg stopa tracić zachodni 60 wrażenie. Region składać się północny stworzyć nauczyciel teoria. Ponieważ jednocześnie wczoraj charakterystyczny sól długi. Spór jaki dziki gruby patrzeć kość. Amharski rysunek przedstawiać tablica zwłaszcza samochodowy prąd. Smutek teatr drogi muzyk. Ogromny zapomnieć one scena wrzesień na noc cecha. Pomysł uznawać śmiać się ludzki 70 podróż. Kochać postawa ludzki sierpień. Słyszeć narzędzie godzina szczęśliwy park słuchać lista. Dziesięć list jutro odległość jakość. 70 móc warstwa uczyć. Materiał niebo port ziemski ? wytwarzać. Nastrój związek krew istotny większość dostęp strata. Walka rolnik wielkość złoto.');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `tablica_ogloszeniowa_uzytkownik`
--

CREATE TABLE `tablica_ogloszeniowa_uzytkownik` (
  `id` int(10) UNSIGNED NOT NULL,
  `uzytkownik_id` int(10) UNSIGNED NOT NULL,
  `tablica_ogloszeniowa_id` smallint(255) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `tablica_ogloszeniowa_uzytkownik`
--

INSERT INTO `tablica_ogloszeniowa_uzytkownik` (`id`, `uzytkownik_id`, `tablica_ogloszeniowa_id`) VALUES
(1, 2, 1),
(2, 3, 1),
(3, 4, 1),
(4, 5, 1),
(5, 6, 1),
(6, 7, 1),
(7, 8, 1),
(8, 9, 1),
(9, 10, 1),
(10, 11, 1),
(11, 12, 1),
(12, 13, 1),
(13, 14, 1),
(14, 15, 1),
(15, 16, 1),
(16, 17, 1),
(17, 18, 1),
(18, 19, 1),
(19, 20, 1),
(20, 21, 1),
(21, 22, 1),
(22, 23, 1),
(23, 24, 1),
(24, 25, 1),
(25, 26, 1),
(26, 27, 1),
(27, 28, 1),
(28, 29, 1),
(29, 30, 1),
(30, 31, 1),
(31, 32, 1),
(32, 33, 1),
(33, 34, 1),
(34, 35, 1),
(35, 36, 1),
(36, 37, 1),
(37, 38, 1),
(38, 39, 1),
(39, 40, 1),
(40, 41, 1),
(41, 42, 1),
(42, 43, 1),
(43, 44, 1),
(44, 45, 1),
(45, 46, 1),
(46, 47, 1),
(47, 48, 1),
(48, 49, 1),
(49, 50, 1),
(50, 51, 1),
(51, 52, 1),
(52, 53, 1),
(53, 54, 1),
(54, 55, 1),
(55, 56, 1),
(56, 57, 1),
(57, 58, 1),
(58, 59, 1),
(59, 60, 1),
(60, 61, 1),
(61, 62, 1),
(62, 63, 1),
(63, 64, 1),
(64, 65, 1),
(65, 66, 1),
(66, 67, 1),
(67, 68, 1),
(68, 69, 1),
(69, 70, 1),
(70, 71, 1),
(71, 72, 1),
(72, 73, 1),
(73, 74, 1),
(74, 75, 1),
(75, 76, 1),
(76, 77, 1),
(77, 78, 1),
(78, 79, 1),
(79, 80, 1),
(80, 81, 1),
(81, 82, 1),
(82, 83, 1),
(83, 84, 1),
(84, 85, 1),
(85, 86, 1),
(86, 87, 1),
(87, 88, 1),
(88, 89, 1),
(89, 90, 1),
(90, 91, 1),
(91, 92, 1),
(92, 93, 1),
(93, 94, 1),
(94, 95, 1),
(95, 96, 1),
(96, 97, 1),
(97, 98, 1),
(98, 99, 1),
(99, 100, 1),
(100, 101, 1),
(101, 102, 1),
(102, 103, 1),
(103, 104, 1),
(104, 105, 1),
(105, 106, 1),
(106, 107, 1),
(107, 108, 1),
(108, 109, 1),
(109, 110, 1),
(110, 111, 1),
(111, 112, 1),
(112, 113, 1),
(113, 114, 1),
(114, 115, 1),
(115, 116, 1),
(116, 117, 1),
(117, 118, 1),
(118, 119, 1),
(119, 120, 1),
(120, 121, 1),
(121, 122, 1),
(122, 123, 1),
(123, 124, 1),
(124, 125, 1),
(125, 126, 1),
(126, 127, 1),
(127, 128, 1),
(128, 129, 1),
(129, 130, 1),
(130, 131, 1),
(131, 132, 1),
(132, 133, 1),
(133, 134, 1),
(134, 135, 1),
(135, 136, 1),
(136, 137, 1),
(137, 138, 1),
(138, 139, 1),
(139, 140, 1),
(140, 141, 1),
(141, 142, 1),
(142, 143, 1),
(143, 144, 1),
(144, 145, 1),
(145, 146, 1),
(146, 147, 1),
(147, 148, 1),
(148, 149, 1),
(149, 150, 1),
(150, 151, 1),
(151, 152, 1),
(152, 153, 1),
(153, 154, 1),
(154, 155, 1),
(155, 156, 1),
(156, 157, 1),
(157, 158, 1),
(158, 159, 1),
(159, 160, 1),
(160, 161, 1),
(161, 162, 1),
(162, 163, 1),
(163, 164, 1),
(164, 165, 1),
(165, 166, 1),
(166, 167, 1),
(167, 168, 1),
(168, 169, 1),
(169, 170, 1),
(170, 171, 1),
(171, 172, 1),
(172, 173, 1),
(173, 174, 1),
(174, 175, 1),
(175, 176, 1),
(176, 177, 1),
(177, 178, 1),
(178, 179, 1),
(179, 180, 1),
(180, 181, 1),
(181, 182, 1),
(182, 183, 1),
(183, 184, 1),
(184, 185, 1),
(185, 186, 1),
(186, 187, 1),
(187, 188, 1),
(188, 189, 1),
(189, 190, 1),
(190, 191, 1),
(191, 192, 1),
(192, 193, 1),
(193, 194, 1),
(194, 195, 1),
(195, 196, 1),
(196, 197, 1),
(197, 198, 1),
(198, 199, 1),
(199, 200, 1),
(200, 201, 1),
(201, 202, 1),
(202, 203, 1),
(203, 204, 1),
(204, 205, 1),
(205, 206, 1),
(206, 207, 1),
(207, 208, 1),
(208, 209, 1),
(209, 210, 1),
(210, 211, 1),
(211, 212, 1),
(212, 213, 1),
(213, 214, 1),
(214, 215, 1),
(215, 216, 1),
(216, 217, 1),
(217, 218, 1),
(218, 219, 1),
(219, 220, 1),
(220, 221, 1),
(221, 222, 1),
(222, 223, 1),
(223, 224, 1),
(224, 225, 1),
(225, 226, 1),
(226, 227, 1),
(227, 228, 1),
(228, 229, 1),
(229, 230, 1),
(230, 231, 1),
(231, 232, 1),
(232, 233, 1),
(233, 234, 1),
(234, 235, 1),
(235, 236, 1),
(236, 237, 1),
(237, 238, 1),
(238, 239, 1),
(239, 240, 1),
(240, 241, 1),
(241, 242, 1),
(242, 243, 1),
(243, 244, 1),
(244, 245, 1),
(245, 246, 1),
(246, 247, 1),
(247, 248, 1),
(248, 249, 1),
(249, 250, 1),
(250, 251, 1),
(251, 252, 1),
(252, 253, 1),
(253, 254, 1),
(254, 255, 1),
(255, 256, 1),
(256, 257, 1),
(257, 258, 1),
(258, 259, 1),
(259, 260, 1),
(260, 261, 1),
(261, 262, 1),
(262, 263, 1),
(263, 264, 1),
(264, 265, 1),
(265, 266, 1),
(266, 267, 1),
(267, 268, 1),
(268, 269, 1),
(269, 270, 1),
(270, 271, 1),
(271, 272, 1),
(272, 273, 1),
(273, 274, 1),
(274, 275, 1),
(275, 276, 1),
(276, 277, 1),
(277, 278, 1),
(278, 279, 1),
(279, 280, 1),
(280, 281, 1),
(281, 282, 1),
(282, 283, 1),
(283, 284, 1),
(284, 285, 1),
(285, 286, 1),
(286, 287, 1),
(287, 288, 1),
(288, 289, 1),
(289, 290, 1),
(290, 291, 1),
(291, 292, 1),
(292, 293, 1),
(293, 294, 1),
(294, 295, 1),
(295, 296, 1),
(296, 297, 1),
(297, 298, 1),
(298, 299, 1),
(299, 300, 1),
(300, 301, 1),
(301, 157, 10),
(302, 73, 11),
(303, 40, 4),
(304, 147, 2),
(305, 131, 19),
(306, 131, 9),
(307, 77, 7),
(308, 252, 5),
(309, 148, 9),
(310, 271, 6),
(311, 98, 8),
(312, 195, 18),
(313, 68, 22),
(314, 54, 9),
(315, 117, 2),
(316, 39, 19),
(317, 301, 13),
(318, 65, 9),
(319, 172, 19),
(320, 141, 18),
(321, 45, 22),
(322, 41, 22),
(323, 270, 22),
(324, 278, 7),
(325, 256, 17),
(326, 231, 17),
(327, 147, 3),
(328, 43, 15),
(329, 270, 13),
(330, 256, 16),
(331, 277, 20),
(332, 220, 2),
(333, 245, 6),
(334, 38, 13),
(335, 30, 2),
(336, 193, 21),
(337, 252, 14),
(338, 149, 14),
(339, 214, 14),
(340, 95, 11),
(341, 65, 20),
(342, 299, 8),
(343, 139, 18),
(344, 61, 14),
(345, 108, 5),
(346, 201, 4),
(347, 42, 11),
(348, 219, 21),
(349, 103, 6),
(350, 193, 13),
(351, 161, 13),
(352, 115, 8),
(353, 186, 8),
(354, 19, 6),
(355, 145, 20),
(356, 234, 11),
(357, 286, 10),
(358, 11, 6),
(359, 105, 17),
(360, 263, 8),
(361, 279, 21),
(362, 147, 8),
(363, 260, 12),
(364, 290, 22),
(365, 9, 3),
(366, 49, 11),
(367, 157, 8),
(368, 54, 18),
(369, 49, 13),
(370, 221, 7),
(371, 108, 21),
(372, 231, 5),
(373, 12, 14),
(374, 215, 4),
(375, 187, 3),
(376, 208, 18),
(377, 262, 15),
(378, 204, 5),
(379, 202, 11),
(380, 118, 15),
(381, 17, 3),
(382, 104, 21),
(383, 6, 17),
(384, 47, 5),
(385, 39, 16),
(386, 61, 10),
(387, 34, 2),
(388, 143, 2),
(389, 43, 18),
(390, 60, 5),
(391, 20, 7),
(392, 69, 19),
(393, 212, 16),
(394, 58, 15),
(395, 44, 7),
(396, 161, 19),
(397, 67, 17),
(398, 91, 4),
(399, 29, 6),
(400, 133, 15),
(401, 8, 6),
(402, 296, 16),
(403, 266, 18),
(404, 295, 3),
(405, 32, 5),
(406, 174, 21),
(407, 192, 7),
(408, 151, 7),
(409, 132, 10),
(410, 92, 4),
(411, 59, 20),
(412, 97, 22),
(413, 258, 20),
(414, 108, 12),
(415, 151, 13),
(416, 272, 3),
(417, 8, 19),
(418, 122, 20),
(419, 54, 13),
(420, 11, 19),
(421, 167, 19),
(422, 176, 3),
(423, 36, 17),
(424, 77, 4),
(425, 202, 2),
(426, 191, 12),
(427, 227, 19),
(428, 135, 11),
(429, 179, 14),
(430, 302, 13),
(431, 239, 10),
(432, 162, 4),
(433, 113, 22),
(434, 23, 16),
(435, 44, 9),
(436, 254, 22),
(437, 112, 11),
(438, 97, 17),
(439, 225, 18),
(440, 48, 7),
(441, 91, 5),
(442, 104, 8),
(443, 215, 15),
(444, 248, 16),
(445, 99, 20),
(446, 47, 14),
(447, 193, 8),
(448, 20, 16),
(449, 229, 3),
(450, 38, 12);

--
-- Wyzwalacze `tablica_ogloszeniowa_uzytkownik`
--
DELIMITER $$
CREATE TRIGGER `po_usunieciu_z_tablica_ogloszeniowa_usun_uprwanienie` AFTER DELETE ON `tablica_ogloszeniowa_uzytkownik` FOR EACH ROW DELETE FROM uprawnienie
WHERE uzytkownik_id = OLD.uzytkownik_id
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `po_wstawieniu_do_tablica_ogloszeniowa_uzytkownik` AFTER INSERT ON `tablica_ogloszeniowa_uzytkownik` FOR EACH ROW INSERT INTO uprawnienie (rola,tablica_ogloszeniowa_id,uzytkownik_id)
VALUES ('obserwator postow',NEW.tablica_ogloszeniowa_id,NEW.uzytkownik_id)
ON DUPLICATE KEY UPDATE
rola = VALUES(rola)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `uprawnienie`
--

CREATE TABLE `uprawnienie` (
  `id` int(10) UNSIGNED NOT NULL,
  `rola` enum('zarządzanie użytkownikami','kreator postów','moderator postów','obserwator postów') NOT NULL,
  `tablica_ogloszeniowa_id` smallint(255) UNSIGNED NOT NULL,
  `uzytkownik_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `uprawnienie`
--

INSERT INTO `uprawnienie` (`id`, `rola`, `tablica_ogloszeniowa_id`, `uzytkownik_id`) VALUES
(1, 'obserwator postów', 1, 2),
(2, 'obserwator postów', 1, 3),
(3, 'obserwator postów', 1, 4),
(4, 'obserwator postów', 1, 5),
(5, 'obserwator postów', 1, 6),
(6, 'obserwator postów', 1, 7),
(7, 'obserwator postów', 1, 8),
(8, 'obserwator postów', 1, 9),
(9, 'obserwator postów', 1, 10),
(10, 'obserwator postów', 1, 11),
(11, 'obserwator postów', 1, 12),
(12, 'obserwator postów', 1, 13),
(13, 'obserwator postów', 1, 14),
(14, 'obserwator postów', 1, 15),
(15, 'obserwator postów', 1, 16),
(16, 'obserwator postów', 1, 17),
(17, 'obserwator postów', 1, 18),
(18, 'obserwator postów', 1, 19),
(19, 'obserwator postów', 1, 20),
(20, 'obserwator postów', 1, 21),
(21, 'obserwator postów', 1, 22),
(22, 'obserwator postów', 1, 23),
(23, 'obserwator postów', 1, 24),
(24, 'obserwator postów', 1, 25),
(25, 'obserwator postów', 1, 26),
(26, 'obserwator postów', 1, 27),
(27, 'obserwator postów', 1, 28),
(28, 'obserwator postów', 1, 29),
(29, 'obserwator postów', 1, 30),
(30, 'obserwator postów', 1, 31),
(31, 'obserwator postów', 1, 32),
(32, 'obserwator postów', 1, 33),
(33, 'obserwator postów', 1, 34),
(34, 'obserwator postów', 1, 35),
(35, 'obserwator postów', 1, 36),
(36, 'obserwator postów', 1, 37),
(37, 'obserwator postów', 1, 38),
(38, 'obserwator postów', 1, 39),
(39, 'obserwator postów', 1, 40),
(40, 'obserwator postów', 1, 41),
(41, 'obserwator postów', 1, 42),
(42, 'obserwator postów', 1, 43),
(43, 'obserwator postów', 1, 44),
(44, 'obserwator postów', 1, 45),
(45, 'obserwator postów', 1, 46),
(46, 'obserwator postów', 1, 47),
(47, 'obserwator postów', 1, 48),
(48, 'obserwator postów', 1, 49),
(49, 'obserwator postów', 1, 50),
(50, 'obserwator postów', 1, 51),
(51, 'obserwator postów', 1, 52),
(52, 'obserwator postów', 1, 53),
(53, 'obserwator postów', 1, 54),
(54, 'obserwator postów', 1, 55),
(55, 'obserwator postów', 1, 56),
(56, 'obserwator postów', 1, 57),
(57, 'obserwator postów', 1, 58),
(58, 'obserwator postów', 1, 59),
(59, 'obserwator postów', 1, 60),
(60, 'obserwator postów', 1, 61),
(61, 'obserwator postów', 1, 62),
(62, 'obserwator postów', 1, 63),
(63, 'obserwator postów', 1, 64),
(64, 'obserwator postów', 1, 65),
(65, 'obserwator postów', 1, 66),
(66, 'obserwator postów', 1, 67),
(67, 'obserwator postów', 1, 68),
(68, 'obserwator postów', 1, 69),
(69, 'obserwator postów', 1, 70),
(70, 'obserwator postów', 1, 71),
(71, 'obserwator postów', 1, 72),
(72, 'obserwator postów', 1, 73),
(73, 'obserwator postów', 1, 74),
(74, 'obserwator postów', 1, 75),
(75, 'obserwator postów', 1, 76),
(76, 'obserwator postów', 1, 77),
(77, 'obserwator postów', 1, 78),
(78, 'obserwator postów', 1, 79),
(79, 'obserwator postów', 1, 80),
(80, 'obserwator postów', 1, 81),
(81, 'obserwator postów', 1, 82),
(82, 'obserwator postów', 1, 83),
(83, 'obserwator postów', 1, 84),
(84, 'obserwator postów', 1, 85),
(85, 'obserwator postów', 1, 86),
(86, 'obserwator postów', 1, 87),
(87, 'obserwator postów', 1, 88),
(88, 'obserwator postów', 1, 89),
(89, 'obserwator postów', 1, 90),
(90, 'obserwator postów', 1, 91),
(91, 'obserwator postów', 1, 92),
(92, 'obserwator postów', 1, 93),
(93, 'obserwator postów', 1, 94),
(94, 'obserwator postów', 1, 95),
(95, 'obserwator postów', 1, 96),
(96, 'obserwator postów', 1, 97),
(97, 'obserwator postów', 1, 98),
(98, 'obserwator postów', 1, 99),
(99, 'obserwator postów', 1, 100),
(100, 'obserwator postów', 1, 101),
(101, 'obserwator postów', 1, 102),
(102, 'obserwator postów', 1, 103),
(103, 'obserwator postów', 1, 104),
(104, 'obserwator postów', 1, 105),
(105, 'obserwator postów', 1, 106),
(106, 'obserwator postów', 1, 107),
(107, 'obserwator postów', 1, 108),
(108, 'obserwator postów', 1, 109),
(109, 'obserwator postów', 1, 110),
(110, 'obserwator postów', 1, 111),
(111, 'obserwator postów', 1, 112),
(112, 'obserwator postów', 1, 113),
(113, 'obserwator postów', 1, 114),
(114, 'obserwator postów', 1, 115),
(115, 'obserwator postów', 1, 116),
(116, 'obserwator postów', 1, 117),
(117, 'obserwator postów', 1, 118),
(118, 'obserwator postów', 1, 119),
(119, 'obserwator postów', 1, 120),
(120, 'obserwator postów', 1, 121),
(121, 'obserwator postów', 1, 122),
(122, 'obserwator postów', 1, 123),
(123, 'obserwator postów', 1, 124),
(124, 'obserwator postów', 1, 125),
(125, 'obserwator postów', 1, 126),
(126, 'obserwator postów', 1, 127),
(127, 'obserwator postów', 1, 128),
(128, 'obserwator postów', 1, 129),
(129, 'obserwator postów', 1, 130),
(130, 'obserwator postów', 1, 131),
(131, 'obserwator postów', 1, 132),
(132, 'obserwator postów', 1, 133),
(133, 'obserwator postów', 1, 134),
(134, 'obserwator postów', 1, 135),
(135, 'obserwator postów', 1, 136),
(136, 'obserwator postów', 1, 137),
(137, 'obserwator postów', 1, 138),
(138, 'obserwator postów', 1, 139),
(139, 'obserwator postów', 1, 140),
(140, 'obserwator postów', 1, 141),
(141, 'obserwator postów', 1, 142),
(142, 'obserwator postów', 1, 143),
(143, 'obserwator postów', 1, 144),
(144, 'obserwator postów', 1, 145),
(145, 'obserwator postów', 1, 146),
(146, 'obserwator postów', 1, 147),
(147, 'obserwator postów', 1, 148),
(148, 'obserwator postów', 1, 149),
(149, 'obserwator postów', 1, 150),
(150, 'obserwator postów', 1, 151),
(151, 'obserwator postów', 1, 152),
(152, 'obserwator postów', 1, 153),
(153, 'obserwator postów', 1, 154),
(154, 'obserwator postów', 1, 155),
(155, 'obserwator postów', 1, 156),
(156, 'obserwator postów', 1, 157),
(157, 'obserwator postów', 1, 158),
(158, 'obserwator postów', 1, 159),
(159, 'obserwator postów', 1, 160),
(160, 'obserwator postów', 1, 161),
(161, 'obserwator postów', 1, 162),
(162, 'obserwator postów', 1, 163),
(163, 'obserwator postów', 1, 164),
(164, 'obserwator postów', 1, 165),
(165, 'obserwator postów', 1, 166),
(166, 'obserwator postów', 1, 167),
(167, 'obserwator postów', 1, 168),
(168, 'obserwator postów', 1, 169),
(169, 'obserwator postów', 1, 170),
(170, 'obserwator postów', 1, 171),
(171, 'obserwator postów', 1, 172),
(172, 'obserwator postów', 1, 173),
(173, 'obserwator postów', 1, 174),
(174, 'obserwator postów', 1, 175),
(175, 'obserwator postów', 1, 176),
(176, 'obserwator postów', 1, 177),
(177, 'obserwator postów', 1, 178),
(178, 'obserwator postów', 1, 179),
(179, 'obserwator postów', 1, 180),
(180, 'obserwator postów', 1, 181),
(181, 'obserwator postów', 1, 182),
(182, 'obserwator postów', 1, 183),
(183, 'obserwator postów', 1, 184),
(184, 'obserwator postów', 1, 185),
(185, 'obserwator postów', 1, 186),
(186, 'obserwator postów', 1, 187),
(187, 'obserwator postów', 1, 188),
(188, 'obserwator postów', 1, 189),
(189, 'obserwator postów', 1, 190),
(190, 'obserwator postów', 1, 191),
(191, 'obserwator postów', 1, 192),
(192, 'obserwator postów', 1, 193),
(193, 'obserwator postów', 1, 194),
(194, 'obserwator postów', 1, 195),
(195, 'obserwator postów', 1, 196),
(196, 'obserwator postów', 1, 197),
(197, 'obserwator postów', 1, 198),
(198, 'obserwator postów', 1, 199),
(199, 'obserwator postów', 1, 200),
(200, 'obserwator postów', 1, 201),
(201, 'obserwator postów', 1, 202),
(202, 'obserwator postów', 1, 203),
(203, 'obserwator postów', 1, 204),
(204, 'obserwator postów', 1, 205),
(205, 'obserwator postów', 1, 206),
(206, 'obserwator postów', 1, 207),
(207, 'obserwator postów', 1, 208),
(208, 'obserwator postów', 1, 209),
(209, 'obserwator postów', 1, 210),
(210, 'obserwator postów', 1, 211),
(211, 'obserwator postów', 1, 212),
(212, 'obserwator postów', 1, 213),
(213, 'obserwator postów', 1, 214),
(214, 'obserwator postów', 1, 215),
(215, 'obserwator postów', 1, 216),
(216, 'obserwator postów', 1, 217),
(217, 'obserwator postów', 1, 218),
(218, 'obserwator postów', 1, 219),
(219, 'obserwator postów', 1, 220),
(220, 'obserwator postów', 1, 221),
(221, 'obserwator postów', 1, 222),
(222, 'obserwator postów', 1, 223),
(223, 'obserwator postów', 1, 224),
(224, 'obserwator postów', 1, 225),
(225, 'obserwator postów', 1, 226),
(226, 'obserwator postów', 1, 227),
(227, 'obserwator postów', 1, 228),
(228, 'obserwator postów', 1, 229),
(229, 'obserwator postów', 1, 230),
(230, 'obserwator postów', 1, 231),
(231, 'obserwator postów', 1, 232),
(232, 'obserwator postów', 1, 233),
(233, 'obserwator postów', 1, 234),
(234, 'obserwator postów', 1, 235),
(235, 'obserwator postów', 1, 236),
(236, 'obserwator postów', 1, 237),
(237, 'obserwator postów', 1, 238),
(238, 'obserwator postów', 1, 239),
(239, 'obserwator postów', 1, 240),
(240, 'obserwator postów', 1, 241),
(241, 'obserwator postów', 1, 242),
(242, 'obserwator postów', 1, 243),
(243, 'obserwator postów', 1, 244),
(244, 'obserwator postów', 1, 245),
(245, 'obserwator postów', 1, 246),
(246, 'obserwator postów', 1, 247),
(247, 'obserwator postów', 1, 248),
(248, 'obserwator postów', 1, 249),
(249, 'obserwator postów', 1, 250),
(250, 'obserwator postów', 1, 251),
(251, 'obserwator postów', 1, 252),
(252, 'obserwator postów', 1, 253),
(253, 'obserwator postów', 1, 254),
(254, 'obserwator postów', 1, 255),
(255, 'obserwator postów', 1, 256),
(256, 'obserwator postów', 1, 257),
(257, 'obserwator postów', 1, 258),
(258, 'obserwator postów', 1, 259),
(259, 'obserwator postów', 1, 260),
(260, 'obserwator postów', 1, 261),
(261, 'obserwator postów', 1, 262),
(262, 'obserwator postów', 1, 263),
(263, 'obserwator postów', 1, 264),
(264, 'obserwator postów', 1, 265),
(265, 'obserwator postów', 1, 266),
(266, 'obserwator postów', 1, 267),
(267, 'obserwator postów', 1, 268),
(268, 'obserwator postów', 1, 269),
(269, 'obserwator postów', 1, 270),
(270, 'obserwator postów', 1, 271),
(271, 'obserwator postów', 1, 272),
(272, 'obserwator postów', 1, 273),
(273, 'obserwator postów', 1, 274),
(274, 'obserwator postów', 1, 275),
(275, 'obserwator postów', 1, 276),
(276, 'obserwator postów', 1, 277),
(277, 'obserwator postów', 1, 278),
(278, 'obserwator postów', 1, 279),
(279, 'obserwator postów', 1, 280),
(280, 'obserwator postów', 1, 281),
(281, 'obserwator postów', 1, 282),
(282, 'obserwator postów', 1, 283),
(283, 'obserwator postów', 1, 284),
(284, 'obserwator postów', 1, 285),
(285, 'obserwator postów', 1, 286),
(286, 'obserwator postów', 1, 287),
(287, 'obserwator postów', 1, 288),
(288, 'obserwator postów', 1, 289),
(289, 'obserwator postów', 1, 290),
(290, 'obserwator postów', 1, 291),
(291, 'obserwator postów', 1, 292),
(292, 'obserwator postów', 1, 293),
(293, 'obserwator postów', 1, 294),
(294, 'obserwator postów', 1, 295),
(295, 'obserwator postów', 1, 296),
(296, 'obserwator postów', 1, 297),
(297, 'obserwator postów', 1, 298),
(298, 'obserwator postów', 1, 299),
(299, 'obserwator postów', 1, 300),
(300, 'obserwator postów', 1, 301),
(301, 'zarządzanie użytkownikami', 10, 157),
(302, 'zarządzanie użytkownikami', 11, 73),
(303, 'zarządzanie użytkownikami', 4, 40),
(304, 'zarządzanie użytkownikami', 2, 147),
(305, 'zarządzanie użytkownikami', 19, 131),
(306, 'zarządzanie użytkownikami', 9, 131),
(307, 'zarządzanie użytkownikami', 7, 77),
(308, 'zarządzanie użytkownikami', 5, 252),
(309, 'obserwator postów', 9, 148),
(310, 'zarządzanie użytkownikami', 6, 271),
(311, 'zarządzanie użytkownikami', 8, 98),
(312, 'zarządzanie użytkownikami', 18, 195),
(313, 'zarządzanie użytkownikami', 22, 68),
(314, 'obserwator postów', 9, 54),
(315, 'kreator postów', 2, 117),
(316, 'kreator postów', 19, 39),
(317, 'zarządzanie użytkownikami', 13, 301),
(318, 'obserwator postów', 9, 65),
(319, 'obserwator postów', 19, 172),
(320, 'obserwator postów', 18, 141),
(321, 'kreator postów', 22, 45),
(322, 'obserwator postów', 22, 41),
(323, 'kreator postów', 22, 270),
(324, 'kreator postów', 7, 278),
(325, 'zarządzanie użytkownikami', 17, 256),
(326, 'obserwator postów', 17, 231),
(327, 'zarządzanie użytkownikami', 3, 147),
(328, 'zarządzanie użytkownikami', 15, 43),
(329, 'obserwator postów', 13, 270),
(330, 'zarządzanie użytkownikami', 16, 256),
(331, 'zarządzanie użytkownikami', 20, 277),
(332, 'obserwator postów', 2, 220),
(333, 'obserwator postów', 6, 245),
(334, 'obserwator postów', 13, 38),
(335, 'moderator postów', 2, 30),
(336, 'zarządzanie użytkownikami', 21, 193),
(337, 'zarządzanie użytkownikami', 14, 252),
(338, 'obserwator postów', 14, 149),
(339, 'obserwator postów', 14, 214),
(340, 'obserwator postów', 11, 95),
(341, 'obserwator postów', 20, 65),
(342, 'kreator postów', 8, 299),
(343, 'kreator postów', 18, 139),
(344, 'kreator postów', 14, 61),
(345, 'obserwator postów', 5, 108),
(346, 'kreator postów', 4, 201),
(347, 'obserwator postów', 11, 42),
(348, 'obserwator postów', 21, 219),
(349, 'obserwator postów', 6, 103),
(350, 'obserwator postów', 13, 193),
(351, 'obserwator postów', 13, 161),
(352, 'kreator postów', 8, 115),
(353, 'obserwator postów', 8, 186),
(354, 'obserwator postów', 6, 19),
(355, 'obserwator postów', 20, 145),
(356, 'obserwator postów', 11, 234),
(357, 'kreator postów', 10, 286),
(358, 'obserwator postów', 6, 11),
(359, 'obserwator postów', 17, 105),
(360, 'obserwator postów', 8, 263),
(361, 'obserwator postów', 21, 279),
(362, 'kreator postów', 8, 147),
(363, 'zarządzanie użytkownikami', 12, 260),
(364, 'obserwator postów', 22, 290),
(365, 'obserwator postów', 3, 9),
(366, 'obserwator postów', 11, 49),
(367, 'obserwator postów', 8, 157),
(368, 'obserwator postów', 18, 54),
(369, 'kreator postów', 13, 49),
(370, 'obserwator postów', 7, 221),
(371, 'obserwator postów', 21, 108),
(372, 'obserwator postów', 5, 231),
(373, 'obserwator postów', 14, 12),
(374, 'obserwator postów', 4, 215),
(375, 'obserwator postów', 3, 187),
(376, 'kreator postów', 18, 208),
(377, 'obserwator postów', 15, 262),
(378, 'obserwator postów', 5, 204),
(379, 'obserwator postów', 11, 202),
(380, 'obserwator postów', 15, 118),
(381, 'obserwator postów', 3, 17),
(382, 'obserwator postów', 21, 104),
(383, 'obserwator postów', 17, 6),
(384, 'obserwator postów', 5, 47),
(385, 'obserwator postów', 16, 39),
(386, 'obserwator postów', 10, 61),
(387, 'obserwator postów', 2, 34),
(388, 'obserwator postów', 2, 143),
(389, 'obserwator postów', 18, 43),
(390, 'obserwator postów', 5, 60),
(391, 'obserwator postów', 7, 20),
(392, 'kreator postów', 19, 69),
(393, 'obserwator postów', 16, 212),
(394, 'kreator postów', 15, 58),
(395, 'moderator postów', 7, 44),
(396, 'obserwator postów', 19, 161),
(397, 'obserwator postów', 17, 67),
(398, 'kreator postów', 4, 91),
(399, 'obserwator postów', 6, 29),
(400, 'kreator postów', 15, 133),
(401, 'kreator postów', 6, 8),
(402, 'obserwator postów', 16, 296),
(403, 'obserwator postów', 18, 266),
(404, 'moderator postów', 3, 295),
(405, 'obserwator postów', 5, 32),
(406, 'obserwator postów', 21, 174),
(407, 'moderator postów', 7, 192),
(408, 'obserwator postów', 7, 151),
(409, 'obserwator postów', 10, 132),
(410, 'obserwator postów', 4, 92),
(411, 'moderator postów', 20, 59),
(412, 'obserwator postów', 22, 97),
(413, 'obserwator postów', 20, 258),
(414, 'obserwator postów', 12, 108),
(415, 'obserwator postów', 13, 151),
(416, 'obserwator postów', 3, 272),
(417, 'obserwator postów', 19, 8),
(418, 'obserwator postów', 20, 122),
(419, 'obserwator postów', 13, 54),
(420, 'obserwator postów', 19, 11),
(421, 'obserwator postów', 19, 167),
(422, 'obserwator postów', 3, 176),
(423, 'obserwator postów', 17, 36),
(424, 'kreator postów', 4, 77),
(425, 'kreator postów', 2, 202),
(426, 'obserwator postów', 12, 191),
(427, 'obserwator postów', 19, 227),
(428, 'kreator postów', 11, 135),
(429, 'kreator postów', 14, 179),
(430, 'obserwator postów', 13, 302),
(431, 'moderator postów', 10, 239),
(432, 'obserwator postów', 4, 162),
(433, 'obserwator postów', 22, 113),
(434, 'obserwator postów', 16, 23),
(435, 'obserwator postów', 9, 44),
(436, 'obserwator postów', 22, 254),
(437, 'obserwator postów', 11, 112),
(438, 'kreator postów', 17, 97),
(439, 'obserwator postów', 18, 225),
(440, 'moderator postów', 7, 48),
(441, 'kreator postów', 5, 91),
(442, 'kreator postów', 8, 104),
(443, 'obserwator postów', 15, 215),
(444, 'obserwator postów', 16, 248),
(445, 'obserwator postów', 20, 99),
(446, 'obserwator postów', 14, 47),
(447, 'obserwator postów', 8, 193),
(448, 'obserwator postów', 16, 20),
(449, 'obserwator postów', 3, 229),
(450, 'obserwator postów', 12, 38);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `url_obrazka`
-- (See below for the actual view)
--
CREATE TABLE `url_obrazka` (
`obrazek_id` int(10) unsigned
,`url` varchar(19)
);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `uzytkownik`
--

CREATE TABLE `uzytkownik` (
  `id` int(10) UNSIGNED NOT NULL,
  `login` varchar(128) NOT NULL DEFAULT 'uzytkownik',
  `haslo` varchar(64) NOT NULL DEFAULT 'uzytkownik'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `uzytkownik`
--

INSERT INTO `uzytkownik` (`id`, `login`, `haslo`) VALUES
(1, '', ''),
(2, 'meganarnold', 'U)3DbTQkCd'),
(3, 'adam_tester', 'P0VyDF$n(_'),
(4, 'angelorr', '%__sTzU7M1'),
(5, 'tony40', '!4DbL&gF9S'),
(6, 'wangthomas', ')mx)n4Eo^A'),
(7, 'adrianaorr', '4e4Lj1CRu&'),
(8, 'qbauer', '85xsMGav+$'),
(9, 'stephen94', '5^PBAf)u$L'),
(10, 'christie35', '#PVJ1sDake'),
(11, 'codygraham', 'bT6ti0Otn*'),
(12, 'pmorton', 'WHa4$6DfG#'),
(13, 'billyramos', '_3Z8n9id!5'),
(14, 'ckennedy', ')4BzWnDji1'),
(15, 'parsonsmaria', '^zl3EU@e98'),
(16, 'paulbennett', '*TW4WI0fH6'),
(17, 'perezjulian', 'uf(9_DJo&C'),
(18, 'nmueller', 'G%&9SSAD7l'),
(19, 'charles77', 'd7j^7KzDfZ'),
(20, 'alexanderdalton', 'pGVO#SUq$4'),
(21, 'manuel10', ')j@nWjRW8x'),
(22, 'xmiller', '+EE1OY@joB'),
(23, 'tyoung', '(iO!2ydy&7'),
(24, 'hamiltonlauren', 'B*f3Ud+YBl'),
(25, 'ashleyanderson', 'wgJEeFxh@3'),
(26, 'longtracey', 'q(U49R0c+1'),
(27, 'jenniferperez', '**IgoLMvf3'),
(28, 'qhicks', 'QLA4vIyd^1'),
(29, 'hendersonjessica', 'o+uc4&Hf!i'),
(30, 'thomas74', '^GoKQqEfD9'),
(31, 'jcraig', '!xS6TEg7q5'),
(32, 'vjackson', '!7L8BJwh1M'),
(33, 'zzamora', 'Nk3COv3$o$'),
(34, 'cabrerabrad', 'Kw57pIj%#!'),
(35, 'qchavez', '%^4SJE5QFx'),
(36, 'harrisdaniel', '+#6YoFYtop'),
(37, 'ksimon', 'a48A#msT+b'),
(38, 'williamfranklin', '*1wwaNWfjI'),
(39, 'fmurray', 'r*2kGo7I4y'),
(40, 'devonmendoza', 'ubLt3Jw#*U'),
(41, 'sherricurtis', '0zN*gp0q@2'),
(42, 'harveymegan', 'h5eCB5Of_i'),
(43, 'george87', 'd^%2d7Iv$*'),
(44, 'palmerjason', 'K0B8r7Sr(!'),
(45, 'calderontammy', 'BFDQSEx1&2'),
(46, 'adamsreginald', '+O3H8u7rLs'),
(47, 'jeffreyevans', 'y3RTTJ8S)g'),
(48, 'plester', '_5JDke3N%3'),
(49, 'cuevaskrista', ')e6@8UlQ!+'),
(50, 'markwatson', '_IB3CEdOkY'),
(51, 'meredith45', '%H2bBIXu1j'),
(52, 'rschneider', '(h2LOvV7kO'),
(53, 'tommybaxter', '*rS9ViWIYl'),
(54, 'nancyle', '$9Oyt()6o3'),
(55, 'qjohnston', '!nf2w^AoL@'),
(56, 'whitescott', '_61Kxb)ven'),
(57, 'fpeterson', '7fBUw1Rn+l'),
(58, 'annaward', '&nh@2X2hr3'),
(59, 'allencantrell', '(IJycxVv^0'),
(60, 'valerie97', 'um6*+1FpaB'),
(61, 'pbauer', '$arplYUv*4'),
(62, 'yolanda39', 'y3Q5TZi5%O'),
(63, 'garzadarius', '!r0k_GszlX'),
(64, 'rodriguezscott', 'T%9Yzu0s8P'),
(65, 'powersstephanie', '$@GDPXiw$6'),
(66, 'heather57', '#YR47TDnmE'),
(67, 'nicholasvelazquez', 'l+fo0So@Rp'),
(68, 'elizabeth27', 'TW^9UTeYv$'),
(69, 'brittanydiaz', '2%7_uDzu)2'),
(70, 'whitejamie', 'R5+%Gz)p)I'),
(71, 'danielwoodard', ')tYZrt9c^8'),
(72, 'simpsonsteven', 'j8vfTiF9@n'),
(73, 'wbowers', '0s5YQNOr8#'),
(74, 'robertcampbell', 'P+0igN6x8+'),
(75, 'martingabriella', '8BvuX&oP^3'),
(76, 'yharrington', 'egVYQt4j!9'),
(77, 'stephanie95', '8e)gkXSO@d'),
(78, 'amandarice', '%d9V$txq4i'),
(79, 'thomasdeleon', '%39_LUs)HV'),
(80, 'danielsgrant', 'j4Sm5^G@)O'),
(81, 'laurencameron', '_UB1Dy!ecl'),
(82, 'steven08', 'M7Qi38#S%x'),
(83, 'jacobrodgers', 'k3HNVt7d#@'),
(84, 'davidnathan', 'ksV@6@e(_1'),
(85, 'bartlettmonica', 'a)&4tP6ho+'),
(86, 'ricky85', '^t6iPOMb+n'),
(87, 'jgood', '61kRgvFp_*'),
(88, 'vbrown', 'Q95DunLe&9'),
(89, 'goodwinjason', '$h#I5iKsd5'),
(90, 'kristinbell', 't(Y2aHEdqy'),
(91, 'james35', 'fFzZ&4bzy^'),
(92, 'carolyn20', 'Y3j_3NkcD%'),
(93, 'david69', 'Os@UuDUg$5'),
(94, 'ashley58', '%k2i8MVa2h'),
(95, 'whiteelizabeth', 'U@2RPwtg&G'),
(96, 'hernandezharry', '#6JSR$sixb'),
(97, 'cbates', ')&10YZdq@Z'),
(98, 'xstout', '+I(G5akA37'),
(99, 'joshua13', '(N5JfyWNp^'),
(100, 'brentperez', '*T25F6vk_M'),
(101, 'lopezlaurie', 'Y38UODYJ$t'),
(102, 'castrovictoria', '1_*1HAd$So'),
(103, 'boydbradley', 'BC8IYBPn^t'),
(104, 'kennedyshelby', 'i6#d!L)t#q'),
(105, 'hernandezsylvia', 'nbh6V0Ih^A'),
(106, 'katrina93', '8nxMU_ks&9'),
(107, 'cameronsexton', 'zAz6CD@dq+'),
(108, 'tompeterson', '^Uq@I%*pE7'),
(109, 'joshua05', '*Z2cNtXbWY'),
(110, 'ihopkins', '1xYTJWOw$x'),
(111, 'robertjohnson', 'p*I7EL(uou'),
(112, 'edward79', 'Yg4UI2RX#+'),
(113, 'danielletucker', ')pIQ3ZvfSW'),
(114, 'laura52', 'rP9XQy%y#*'),
(115, 'ncortez', '&1P9TS1RDm'),
(116, 'parkstiffany', 'aYfR9TXr_D'),
(117, 'reedarthur', '%5&XNmHoR3'),
(118, 'lisa91', 'DS0D4Ghk%N'),
(119, 'kenneth02', '+v7QD&qCE)'),
(120, 'anthonytownsend', '&qH!thWs%8'),
(121, 'mjoseph', 'vE%2RQMxXU'),
(122, 'flozano', '#uT&MoR@X4'),
(123, 'reedjessica', '+0l5sU0jy^'),
(124, 'juanmorrow', 'mSwXPtZp*8'),
(125, 'james65', 'J!%8qJjmHR'),
(126, 'jimenezcrystal', '99eQBu@c_1'),
(127, 'john28', '*Q6*NDqjmJ'),
(128, 'megan42', 'D1S6U^)h^M'),
(129, 'nschwartz', '9xH#Ylpw#b'),
(130, 'areynolds', 'bp+42Gm0MO'),
(131, 'adrianbell', '(216wByYVg'),
(132, 'mcconnelljennifer', '@TBLgIqv@0'),
(133, 'christinemaddox', '$39$A_mcLw'),
(134, 'janet30', '+994R4sD96'),
(135, 'rachel69', '+AJAiCec48'),
(136, 'floydjohn', '^kKVSbMC8O'),
(137, 'christopherbender', '$zXR2UQrb9'),
(138, 'aliciamcpherson', '#I5#XXPr5%'),
(139, 'richardwhite', '_w7MOBoa6u'),
(140, 'heather95', '*uyY4Rdita'),
(141, 'wagnerbrett', '472mcBTl*c'),
(142, 'rodney67', '_!4NPmt2&$'),
(143, 'shelby39', 'Z#P&3D%lxg'),
(144, 'scottguerra', '4+8XgCYfC^'),
(145, 'bennettamanda', 'g#Fj039z!Q'),
(146, 'margaretmunoz', '$4g2SCJl@J'),
(147, 'michaelriley', 'mCwlU%5c(1'),
(148, 'swatts', 'N+3XSvWZ)!'),
(149, 'galexander', 'D3Hq7%Gf%F'),
(150, 'chad39', 'X!hKI1qo+F'),
(151, 'kathrynpotter', '3A0bZK3s%t'),
(152, 'theresa59', 'm44V&Sid!#'),
(153, 'douglaskristine', ')81aXap^Z&'),
(154, 'kelly45', 'i!JnEq!s@7'),
(155, 'nathanrangel', '@f2KsuKuG2'),
(156, 'alexis66', 'kT18$M$i*v'),
(157, 'james18', 'bvD77T$3L+'),
(158, 'alexis69', 'D6mWiU3f@K'),
(159, 'henryjacqueline', '(39ydVuhwe'),
(160, 'jefferylindsey', '*RJDO+co8q'),
(161, 'smithtracey', 'yca6CBf4(0'),
(162, 'williambennett', '%$Q5WOoTN9'),
(163, 'hayleypowell', '1v4Ixvou!#'),
(164, 'alvinwilson', 'dw8$A7idd#'),
(165, 'asalazar', '#S2cOxFgu2'),
(166, 'mgibbs', 'd13wHvpU!I'),
(167, 'kellyarthur', '*3gmPImaAg'),
(168, 'jasonsanchez', ')zE^u(TNP0'),
(169, 'schneideralexis', '#0VMmAK2F9'),
(170, 'shannoncampbell', 't_2_1QeW&c'),
(171, 'madison67', '+*0efbNm@M'),
(172, 'davidlawson', '#P@I2VCn^_'),
(173, 'curtishurley', 'R*c82Ngc_c'),
(174, 'james90', 'R0X&dE$6#q'),
(175, 'fbrown', '#7T&pbGgUI'),
(176, 'wilkinskenneth', 'Q0FbFX_m@7'),
(177, 'schavez', '^(0ICxYyv#'),
(178, 'gary96', '#4SmwxiHzq'),
(179, 'emoore', '@TEzlW1b8l'),
(180, 'fweber', '$pRAGeNua0'),
(181, 'susanmiller', '0LmZtX81+A'),
(182, 'josephmoreno', '9a5WXv_dl#'),
(183, 'misty50', '$8lErfmP@q'),
(184, 'rodriguezkathryn', 'YF^yK9Okk*'),
(185, 'morrisonoscar', '3X@%7O4zjz'),
(186, 'mejiatristan', '*0_y0MllIF'),
(187, 'martinezchristine', '(9XWUgOO_8'),
(188, 'james04', '57DEmKqb&3'),
(189, 'ugillespie', '!R6!aLImgT'),
(190, 'rodriguezkimberly', '*001jDFfwl'),
(191, 'taylorholly', 'Ve2UPMpM1@'),
(192, 'vnguyen', '_04PIOPh7)'),
(193, 'david04', 'B!Dj5VD!Zw'),
(194, 'smithtina', '8_8Sc^FXKG'),
(195, 'joy68', '33je&OMz(_'),
(196, 'andrewclark', '88%Pwp9O*z'),
(197, 'mackenzie95', '+6HWJ5S5#l'),
(198, 'smithjenna', '8V)@oFSp$6'),
(199, 'ealexander', '&E2kVUn7yZ'),
(200, 'lindseywilliams', 'k*$4FOtw+C'),
(201, 'jennifer42', 'oX0NCPnl7&'),
(202, 'wwise', '*8idOWn&5p'),
(203, 'meyertheodore', 'DQ(5W2zk%)'),
(204, 'barbarajohnson', '@Ndw2TNfj@'),
(205, 'leblancalbert', '!0szsImskm'),
(206, 'robinsonjoshua', '))o&Aufg_3'),
(207, 'hlynch', 'S@L8hR_bh*'),
(208, 'basstanya', '+b61Xiljmr'),
(209, 'ldyer', '0KD$6Z8rPu'),
(210, 'valenciakatherine', '!uEIZ6gO@4'),
(211, 'adamdavis', 'b!28oQl(5F'),
(212, 'marcusfowler', '#pRzW#&zq4'),
(213, 'daniel37', '8Q&7ZRMd7r'),
(214, 'brian26', 'w6JXMra2+V'),
(215, 'clarksarah', '%5bInIBu#&'),
(216, 'rogerorozco', '!MQ*Oq2gz8'),
(217, 'kathleen84', 'YX10RxPF@E'),
(218, 'noblechristopher', '!4_UpEtg&4'),
(219, 'shortcaitlin', 'Z+O3g@0i)6'),
(220, 'davidcook', '!0YGFugCkw'),
(221, 'victoriaking', 'neBf2DuwU^'),
(222, 'hhodge', 'YV(En1ZuER'),
(223, 'julie87', 'mj3AqzkYJ%'),
(224, 'george72', 'F%Q0LMMwaL'),
(225, 'johnny69', '4fKzHYn2^7'),
(226, 'othomas', 'rew4iA_pm%'),
(227, 'ericwalker', '#05XrNPAs4'),
(228, 'michael05', '%CKejyjC3A'),
(229, 'leonconnie', ')G7!Te5Nv3'),
(230, 'vickimurray', '^(5yYzqBR3'),
(231, 'eugeneli', '7UY*MC1k!V'),
(232, 'david31', 'CJcWiwXd)4'),
(233, 'brittanycarroll', '()S0KKsith'),
(234, 'osullivan', 'R)0TWcwsk^'),
(235, 'kristinlong', 'FPS2F+Rqr+'),
(236, 'marcsharp', '(1CtypdkO$'),
(237, 'kenneth80', '+7AQ^vAu^k'),
(238, 'leviperkins', 'Qb%d2Ci7ml'),
(239, 'joshuaguzman', '$8rEkKzk2i'),
(240, 'dakotaolson', 'k&+0ZJg@a_'),
(241, 'mbarrett', 'SB8UQhc3w%'),
(242, 'codyliu', ')G8Oa0Qq#&'),
(243, 'thompsonkelly', 'J5KiP4Ufj&'),
(244, 'robertdickerson', '!&3Os^aGgK'),
(245, 'bvasquez', '!2hJ2Vpd()'),
(246, 'elizabethchambers', 'Lv8UX8Pz#+'),
(247, 'tyler86', '$4CFtDHx(D'),
(248, 'sarah75', 'O6@5REPf48'),
(249, 'angela38', '^jWE6%GuC^'),
(250, 'dvance', 'CB99RKOf!1'),
(251, 'catherinesalas', 'i+9Ik&G*Uc'),
(252, 'angelabartlett', '$qJd5rjj5z'),
(253, 'karenpeterson', 'Odb15VL&9('),
(254, 'huffrebecca', '*!mQ0Qy(3L'),
(255, 'vlee', '8HTRXm9w^4'),
(256, 'jcoleman', '!dc7rXUkv4'),
(257, 'edwardsjustin', 'PqE59Yc8#m'),
(258, 'emilyfoster', '&jnJ5fPht5'),
(259, 'roberthayden', ')W6JUqIq0f'),
(260, 'tracy09', '(1EcnmdZZ6'),
(261, 'hbooth', '2AF9j@Erx@'),
(262, 'christina16', 'u0AsuZMi)L'),
(263, 'kiddernest', ')9PftdVway'),
(264, 'lyonsryan', '+WP+z5k7x('),
(265, 'joshua29', 'Lo2T9jNFm@'),
(266, 'michaelbrown', '82%YLWrn@9'),
(267, 'fporter', '2r4XoVIr&P'),
(268, 'lindseyleach', 'K!T5Cdijfk'),
(269, 'ericmiller', 'DR+9W5lw^H'),
(270, 'jscott', '@zs0@Mwe@H'),
(271, 'ryan54', '(N25MEfYdk'),
(272, 'marissalarson', 'E^Pr21zn#9'),
(273, 'lingram', '!*BFKfXml8'),
(274, 'mikemorgan', '!2Te^6jBDG'),
(275, 'elizabethdavis', '6iuG28z2*Q'),
(276, 'sloanmichael', '#k1KphHK1S'),
(277, 'kevinmccullough', 'swESTR!a+5'),
(278, 'vmartin', 'YS1SFy4qV+'),
(279, 'christine51', '6P5KynGm@V'),
(280, 'mejiajamie', '$EnrBcs9H2'),
(281, 'torresrobyn', 'vk8vN&liP@'),
(282, 'valerieconner', '$EYjeUir)2'),
(283, 'elizabeth83', 'lqnE%5@f%8'),
(284, 'melissafuller', 'jL0ojwoqT^'),
(285, 'nschmidt', '7X+6kQIn^4'),
(286, 'susan96', '51oBnlkQ@9'),
(287, 'mooreadam', 'i!0IzwepVC'),
(288, 'donaldguerra', '_i8SVaVWGE'),
(289, 'nherring', '+c8MAMGw1b'),
(290, 'bethany28', ')+6Y9KXcr*'),
(291, 'mathewsanchez', '&mEtL!sv)3'),
(292, 'adamrussell', 'M(xm5&TvaA'),
(293, 'fitzgeralddavid', 'n5Y2magX(W'),
(294, 'sarah11', 'to0CvWM#(_'),
(295, 'paulmcintyre', '3R1A0PZg1@'),
(296, 'ryanmoore', 'lAPKGggc)3'),
(297, 'matthewmartinez', '$$8MCzd)GI'),
(298, 'jamessmith', '+%H4kYxloH'),
(299, 'sbaker', '5bhNCyss_5'),
(300, 'amanda67', '(fPYGxov39'),
(301, 'stephanie72', '!6(MOAMim2');

--
-- Wyzwalacze `uzytkownik`
--
DELIMITER $$
CREATE TRIGGER `po_wstawieniu_do_uzytkownik` AFTER INSERT ON `uzytkownik` FOR EACH ROW INSERT INTO tablica_ogloszeniowa_uzytkownik (uzytkownik_id, tablica_ogloszeniowa_id)
VALUES (NEW.id, 1)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `przed_usunieciem_uzytkownik_usun_dane` BEFORE DELETE ON `uzytkownik` FOR EACH ROW DELETE FROM dane_uzytkownika
WHERE uzytkownik_id = OLD.id
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `przed_usunieciem_uzytkownik_usun_opis` BEFORE DELETE ON `uzytkownik` FOR EACH ROW DELETE FROM opis_uzytkownika
WHERE uzytkownik_id = OLD.id
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `przed_usunieciem_uzytkownik_usun_pokrewienstwo` BEFORE DELETE ON `uzytkownik` FOR EACH ROW DELETE FROM pokrewienstwo 
WHERE uzytkownik_id = OLD.id OR spokrewniony_uzytkownik_id = OLD.id
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `przed_usunieciem_uzytkownik_usun_z_tablice` BEFORE DELETE ON `uzytkownik` FOR EACH ROW DELETE FROM tablica_ogloszeniowa_uzytkownik
WHERE uzytkownik_id = OLD.id
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `przed_usunieciem_uzytkownika_usun_posty` BEFORE DELETE ON `uzytkownik` FOR EACH ROW UPDATE ogloszenie 
SET autor_id = 1
WHERE autor_id = OLD.id
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `wiek`
-- (See below for the actual view)
--
CREATE TABLE `wiek` (
`dane_uzytkownika_id` int(10) unsigned
,`wiek` bigint(21)
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `zmarly_uzytkownik`
-- (See below for the actual view)
--
CREATE TABLE `zmarly_uzytkownik` (
`id` int(10) unsigned
,`imie_pseudonim_nazwisko` varchar(196)
,`data_smierci` date
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `zmora`
-- (See below for the actual view)
--
CREATE TABLE `zmora` (
`id` int(10) unsigned
,`imie_pseudonim_nazwisko` varchar(196)
);

-- --------------------------------------------------------

--
-- Struktura widoku `kod_pocztowy`
--
DROP TABLE IF EXISTS `kod_pocztowy`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `kod_pocztowy`  AS SELECT `a`.`id` AS `id`, concat('20-',left(`a`.`kod_pocztowy`,3)) AS `kod_pocztowy` FROM `adres` AS `a` ;

-- --------------------------------------------------------

--
-- Struktura widoku `matuzal`
--
DROP TABLE IF EXISTS `matuzal`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `matuzal`  AS SELECT `u`.`id` AS `id`, `s`.`imie_pseudonim_nazwisko` AS `imie_pseudonim_nazwisko`, `w`.`wiek` AS `wiek` FROM (((`uzytkownik` `u` join `sygnatura` `s` on(`s`.`uzytkownik_id` = `u`.`id`)) join `dane_uzytkownika` `du` on(`du`.`uzytkownik_id` = `u`.`id`)) join `wiek` `w` on(`w`.`dane_uzytkownika_id` = `du`.`id`)) WHERE `w`.`wiek` >= 90 ORDER BY `w`.`wiek` DESC ;

-- --------------------------------------------------------

--
-- Struktura widoku `plodnosc_kreatorow_postow`
--
DROP TABLE IF EXISTS `plodnosc_kreatorow_postow`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `plodnosc_kreatorow_postow`  AS SELECT `s`.`imie_pseudonim_nazwisko` AS `imie_pseudonim_nazwisko`, count(`o`.`id`) AS `liczba_postow` FROM ((`uzytkownik` `u` left join `sygnatura` `s` on(`s`.`uzytkownik_id` = `u`.`id`)) left join `ogloszenie` `o` on(`o`.`autor_id` = `u`.`id`)) GROUP BY `s`.`imie_pseudonim_nazwisko` ORDER BY count(`o`.`id`) DESC ;

-- --------------------------------------------------------

--
-- Struktura widoku `plodnosc_parafii`
--
DROP TABLE IF EXISTS `plodnosc_parafii`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `plodnosc_parafii`  AS SELECT `p`.`id` AS `id`, `p`.`nazwa` AS `nazwa`, count(`ou`.`id`) AS `liczba_wiernych` FROM (`parafia` `p` join `opis_uzytkownika` `ou` on(`ou`.`parafia_id` = `p`.`id`)) GROUP BY `p`.`id`, `p`.`nazwa` ORDER BY count(`ou`.`id`) DESC ;

-- --------------------------------------------------------

--
-- Struktura widoku `plodnosc_tablicy`
--
DROP TABLE IF EXISTS `plodnosc_tablicy`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `plodnosc_tablicy`  AS SELECT `t`.`id` AS `id`, `t`.`nazwa` AS `nazwa`, count(distinct `tou`.`uzytkownik_id`) AS `liczba_uzytkownikow`, count(distinct `o`.`id`) AS `liczba_postow` FROM ((`tablica_ogloszeniowa` `t` left join `tablica_ogloszeniowa_uzytkownik` `tou` on(`t`.`id` = `tou`.`tablica_ogloszeniowa_id`)) left join `ogloszenie` `o` on(`o`.`tablica_ogloszeniowa_id` = `t`.`id`)) GROUP BY `t`.`id`, `t`.`nazwa` ORDER BY count(distinct `o`.`id`) DESC ;

-- --------------------------------------------------------

--
-- Struktura widoku `pozycja_modlitwy`
--
DROP TABLE IF EXISTS `pozycja_modlitwy`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `pozycja_modlitwy`  AS SELECT `m`.`id` AS `id`, `m`.`nazwa` AS `nazwa`, count(`ou`.`id`) AS `liczba_polubien` FROM (`modlitwa` `m` join `opis_uzytkownika` `ou` on(`ou`.`ulubiona_modlitwa_id` = `m`.`id`)) GROUP BY `m`.`id`, `m`.`nazwa` ORDER BY count(`ou`.`id`) DESC ;

-- --------------------------------------------------------

--
-- Struktura widoku `pozycja_rodziny`
--
DROP TABLE IF EXISTS `pozycja_rodziny`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `pozycja_rodziny`  AS SELECT `r`.`id` AS `id`, `r`.`nazwa` AS `nazwa`, count(`ou`.`id`) AS `liczba_czlonkow` FROM (`rodzina` `r` join `opis_uzytkownika` `ou` on(`ou`.`rodzina_id` = `r`.`id`)) GROUP BY `r`.`id`, `r`.`nazwa` ORDER BY count(`ou`.`id`) DESC ;

-- --------------------------------------------------------

--
-- Struktura widoku `rodzina_wzeniona`
--
DROP TABLE IF EXISTS `rodzina_wzeniona`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `rodzina_wzeniona`  AS SELECT `o`.`rodzina_id` AS `rodzina_id`, `u`.`id` AS `uzytkownik_id` FROM (((`uzytkownik` `u` join `pokrewienstwo` `p` on(`p`.`uzytkownik_id` = `u`.`id`)) join `uzytkownik` `wspolmalzonek` on(`wspolmalzonek`.`id` = `p`.`spokrewniony_uzytkownik_id`)) join `opis_uzytkownika` `o` on(`o`.`uzytkownik_id` = `wspolmalzonek`.`id`)) WHERE `p`.`typ_relacji` in ('mąż','żona') ;

-- --------------------------------------------------------

--
-- Struktura widoku `sygnatura`
--
DROP TABLE IF EXISTS `sygnatura`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `sygnatura`  AS SELECT `u`.`id` AS `uzytkownik_id`, concat(coalesce(`du`.`imie`,''),' "',coalesce(`ou`.`pseudonim`,''),'" ',coalesce(`du`.`nazwisko`,'')) AS `imie_pseudonim_nazwisko` FROM ((`uzytkownik` `u` left join `opis_uzytkownika` `ou` on(`ou`.`uzytkownik_id` = `u`.`id`)) left join `dane_uzytkownika` `du` on(`du`.`uzytkownik_id` = `u`.`id`)) ;

-- --------------------------------------------------------

--
-- Struktura widoku `url_obrazka`
--
DROP TABLE IF EXISTS `url_obrazka`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `url_obrazka`  AS SELECT `o`.`id` AS `obrazek_id`, concat('/img/',`o`.`id`,'.jpg') AS `url` FROM `obrazek` AS `o` ;

-- --------------------------------------------------------

--
-- Struktura widoku `wiek`
--
DROP TABLE IF EXISTS `wiek`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `wiek`  AS SELECT `dane_uzytkownika`.`id` AS `dane_uzytkownika_id`, CASE WHEN `dane_uzytkownika`.`data_smierci` is null THEN timestampdiff(YEAR,`dane_uzytkownika`.`data_urodzenia`,curdate()) ELSE timestampdiff(YEAR,`dane_uzytkownika`.`data_urodzenia`,`dane_uzytkownika`.`data_smierci`) END AS `wiek` FROM `dane_uzytkownika` ;

-- --------------------------------------------------------

--
-- Struktura widoku `zmarly_uzytkownik`
--
DROP TABLE IF EXISTS `zmarly_uzytkownik`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `zmarly_uzytkownik`  AS SELECT `u`.`id` AS `id`, `s`.`imie_pseudonim_nazwisko` AS `imie_pseudonim_nazwisko`, `du`.`data_smierci` AS `data_smierci` FROM ((`uzytkownik` `u` join `sygnatura` `s` on(`s`.`uzytkownik_id` = `u`.`id`)) join `dane_uzytkownika` `du` on(`du`.`uzytkownik_id` = `u`.`id`)) WHERE `du`.`data_smierci` is not null ;

-- --------------------------------------------------------

--
-- Struktura widoku `zmora`
--
DROP TABLE IF EXISTS `zmora`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `zmora`  AS SELECT `u`.`id` AS `id`, `s`.`imie_pseudonim_nazwisko` AS `imie_pseudonim_nazwisko` FROM (`uzytkownik` `u` join `sygnatura` `s` on(`s`.`uzytkownik_id` = `u`.`id`)) WHERE !exists(select 1 from `tablica_ogloszeniowa_uzytkownik` `tou` where `tou`.`uzytkownik_id` = `u`.`id` AND `tou`.`tablica_ogloszeniowa_id` = 1 limit 1) ;

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `adres`
--
ALTER TABLE `adres`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_UNIQUE` (`id`);

--
-- Indeksy dla tabeli `dane_uzytkownika`
--
ALTER TABLE `dane_uzytkownika`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_UNIQUE` (`id`),
  ADD KEY `fk_dane_uzytkownika_adres1_idx` (`adres_id`),
  ADD KEY `fk_dane_uzytkownika_uzytkownik1_idx` (`uzytkownik_id`);

--
-- Indeksy dla tabeli `modlitwa`
--
ALTER TABLE `modlitwa`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_UNIQUE` (`id`);

--
-- Indeksy dla tabeli `obrazek`
--
ALTER TABLE `obrazek`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_UNIQUE` (`id`);

--
-- Indeksy dla tabeli `ogloszenie`
--
ALTER TABLE `ogloszenie`
  ADD PRIMARY KEY (`id`,`tablica_ogloszeniowa_id`,`autor_id`),
  ADD UNIQUE KEY `id_UNIQUE` (`id`),
  ADD KEY `fk_ogloszenie_tablica_ogloszeniowa1_idx` (`tablica_ogloszeniowa_id`),
  ADD KEY `fk_ogloszenie_obrazek1_idx` (`obrazek_id`),
  ADD KEY `fk_ogloszenie_uzytkownik1_idx` (`autor_id`);

--
-- Indeksy dla tabeli `opis_uzytkownika`
--
ALTER TABLE `opis_uzytkownika`
  ADD PRIMARY KEY (`id`,`rodzina_id`),
  ADD UNIQUE KEY `id_UNIQUE` (`id`),
  ADD KEY `fk_opis_uzytkownika_rodzina1_idx` (`rodzina_id`),
  ADD KEY `fk_opis_uzytkownika_obrazek1_idx` (`zdjecie_profilowe_id`),
  ADD KEY `fk_opis_uzytkownika_modlitwa1_idx` (`ulubiona_modlitwa_id`),
  ADD KEY `fk_opis_uzytkownika_parafia1_idx` (`parafia_id`),
  ADD KEY `fk_opis_uzytkownika_uzytkownik1_idx` (`uzytkownik_id`);

--
-- Indeksy dla tabeli `parafia`
--
ALTER TABLE `parafia`
  ADD PRIMARY KEY (`id`,`proboszcz_id`),
  ADD UNIQUE KEY `id_UNIQUE` (`id`),
  ADD KEY `fk_parafia_proboszcz1_idx` (`proboszcz_id`);

--
-- Indeksy dla tabeli `pokrewienstwo`
--
ALTER TABLE `pokrewienstwo`
  ADD PRIMARY KEY (`id`,`spokrewniony_uzytkownik_id`,`uzytkownik_id`),
  ADD UNIQUE KEY `id_UNIQUE` (`id`),
  ADD KEY `fk_pokrewienstwo_uzytkownik2_idx` (`spokrewniony_uzytkownik_id`),
  ADD KEY `fk_pokrewienstwo_uzytkownik1_idx` (`uzytkownik_id`);

--
-- Indeksy dla tabeli `proboszcz`
--
ALTER TABLE `proboszcz`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_UNIQUE` (`id`);

--
-- Indeksy dla tabeli `rodzina`
--
ALTER TABLE `rodzina`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_UNIQUE` (`id`);

--
-- Indeksy dla tabeli `tablica_ogloszeniowa`
--
ALTER TABLE `tablica_ogloszeniowa`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_UNIQUE` (`id`);

--
-- Indeksy dla tabeli `tablica_ogloszeniowa_uzytkownik`
--
ALTER TABLE `tablica_ogloszeniowa_uzytkownik`
  ADD PRIMARY KEY (`id`,`uzytkownik_id`,`tablica_ogloszeniowa_id`),
  ADD UNIQUE KEY `id_UNIQUE` (`id`),
  ADD KEY `fk_tablica_ogloszeniowa_uzytkownik_uzytkownik1_idx` (`uzytkownik_id`),
  ADD KEY `fk_tablica_ogloszeniowa_uzytkownik_tablica_ogloszeniowa1_idx` (`tablica_ogloszeniowa_id`);

--
-- Indeksy dla tabeli `uprawnienie`
--
ALTER TABLE `uprawnienie`
  ADD PRIMARY KEY (`id`,`tablica_ogloszeniowa_id`,`uzytkownik_id`),
  ADD UNIQUE KEY `id_UNIQUE` (`id`),
  ADD UNIQUE KEY `uq_uprawnienie` (`tablica_ogloszeniowa_id`,`uzytkownik_id`),
  ADD KEY `fk_uprawnienie_tablica_ogloszeniowa1_idx` (`tablica_ogloszeniowa_id`),
  ADD KEY `fk_uprawnienie_uzytkownik1_idx` (`uzytkownik_id`);

--
-- Indeksy dla tabeli `uzytkownik`
--
ALTER TABLE `uzytkownik`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `iduzytkownik_UNIQUE` (`id`),
  ADD UNIQUE KEY `login_UNIQUE` (`login`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `adres`
--
ALTER TABLE `adres`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=301;

--
-- AUTO_INCREMENT for table `dane_uzytkownika`
--
ALTER TABLE `dane_uzytkownika`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=300;

--
-- AUTO_INCREMENT for table `modlitwa`
--
ALTER TABLE `modlitwa`
  MODIFY `id` smallint(255) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `obrazek`
--
ALTER TABLE `obrazek`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=453;

--
-- AUTO_INCREMENT for table `ogloszenie`
--
ALTER TABLE `ogloszenie`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=92;

--
-- AUTO_INCREMENT for table `opis_uzytkownika`
--
ALTER TABLE `opis_uzytkownika`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=302;

--
-- AUTO_INCREMENT for table `parafia`
--
ALTER TABLE `parafia`
  MODIFY `id` smallint(255) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT for table `pokrewienstwo`
--
ALTER TABLE `pokrewienstwo`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=301;

--
-- AUTO_INCREMENT for table `proboszcz`
--
ALTER TABLE `proboszcz`
  MODIFY `id` tinyint(255) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT for table `rodzina`
--
ALTER TABLE `rodzina`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `tablica_ogloszeniowa`
--
ALTER TABLE `tablica_ogloszeniowa`
  MODIFY `id` smallint(255) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `tablica_ogloszeniowa_uzytkownik`
--
ALTER TABLE `tablica_ogloszeniowa_uzytkownik`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=451;

--
-- AUTO_INCREMENT for table `uprawnienie`
--
ALTER TABLE `uprawnienie`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=601;

--
-- AUTO_INCREMENT for table `uzytkownik`
--
ALTER TABLE `uzytkownik`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=302;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `dane_uzytkownika`
--
ALTER TABLE `dane_uzytkownika`
  ADD CONSTRAINT `fk_dane_uzytkownika_adres1` FOREIGN KEY (`adres_id`) REFERENCES `adres` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_dane_uzytkownika_uzytkownik1` FOREIGN KEY (`uzytkownik_id`) REFERENCES `uzytkownik` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `ogloszenie`
--
ALTER TABLE `ogloszenie`
  ADD CONSTRAINT `fk_ogloszenie_obrazek1` FOREIGN KEY (`obrazek_id`) REFERENCES `obrazek` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_ogloszenie_tablica_ogloszeniowa1` FOREIGN KEY (`tablica_ogloszeniowa_id`) REFERENCES `tablica_ogloszeniowa` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_ogloszenie_uzytkownik1` FOREIGN KEY (`autor_id`) REFERENCES `uzytkownik` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `opis_uzytkownika`
--
ALTER TABLE `opis_uzytkownika`
  ADD CONSTRAINT `fk_opis_uzytkownika_modlitwa1` FOREIGN KEY (`ulubiona_modlitwa_id`) REFERENCES `modlitwa` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_opis_uzytkownika_obrazek1` FOREIGN KEY (`zdjecie_profilowe_id`) REFERENCES `obrazek` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_opis_uzytkownika_parafia1` FOREIGN KEY (`parafia_id`) REFERENCES `parafia` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_opis_uzytkownika_rodzina1` FOREIGN KEY (`rodzina_id`) REFERENCES `rodzina` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_opis_uzytkownika_uzytkownik1` FOREIGN KEY (`uzytkownik_id`) REFERENCES `uzytkownik` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `parafia`
--
ALTER TABLE `parafia`
  ADD CONSTRAINT `fk_parafia_proboszcz1` FOREIGN KEY (`proboszcz_id`) REFERENCES `proboszcz` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `pokrewienstwo`
--
ALTER TABLE `pokrewienstwo`
  ADD CONSTRAINT `fk_pokrewienstwo_uzytkownik1` FOREIGN KEY (`uzytkownik_id`) REFERENCES `uzytkownik` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_pokrewienstwo_uzytkownik2` FOREIGN KEY (`spokrewniony_uzytkownik_id`) REFERENCES `uzytkownik` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `tablica_ogloszeniowa_uzytkownik`
--
ALTER TABLE `tablica_ogloszeniowa_uzytkownik`
  ADD CONSTRAINT `fk_tablica_ogloszeniowa_uzytkownik_tablica_ogloszeniowa1` FOREIGN KEY (`tablica_ogloszeniowa_id`) REFERENCES `tablica_ogloszeniowa` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_tablica_ogloszeniowa_uzytkownik_uzytkownik1` FOREIGN KEY (`uzytkownik_id`) REFERENCES `uzytkownik` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `uprawnienie`
--
ALTER TABLE `uprawnienie`
  ADD CONSTRAINT `fk_uprawnienie_tablica_ogloszeniowa1` FOREIGN KEY (`tablica_ogloszeniowa_id`) REFERENCES `tablica_ogloszeniowa` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_uprawnienie_uzytkownik1` FOREIGN KEY (`uzytkownik_id`) REFERENCES `uzytkownik` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
