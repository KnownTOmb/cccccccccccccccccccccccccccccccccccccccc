-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sty 12, 2026 at 06:03 PM
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
-- Database: `smipegs-lublin`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `adres`
--

CREATE TABLE `adres` (
  `id` int(10) UNSIGNED NOT NULL,
  `rejon` varchar(64) NOT NULL,
  `kod_pocztowy` tinyint(3) UNSIGNED NOT NULL,
  `ulica` varchar(64) NOT NULL,
  `numer_budynku` smallint(5) UNSIGNED NOT NULL,
  `numer_mieszkania` smallint(5) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `adres`
--

INSERT INTO `adres` (`id`, `rejon`, `kod_pocztowy`, `ulica`, `numer_budynku`, `numer_mieszkania`) VALUES
(1, 'Lublin', 101, 'Lipowa', 12, 3),
(2, 'Lublin', 102, 'Narutowicza', 5, NULL),
(3, 'Lublin', 103, 'Zana', 44, 7),
(4, 'Lublin', 104, 'Głęboka', 9, 2),
(5, 'Lublin', 105, 'Nadbystrzycka', 88, NULL),
(6, 'Lublin', 106, 'Krakowskie Przedmieście', 21, 1),
(7, 'Lublin', 107, 'Kunickiego', 13, NULL),
(8, 'Lublin', 108, 'Lubartowska', 77, 4),
(9, 'Lublin', 109, 'Chodźki', 6, 8),
(10, 'Lublin', 110, 'Turystyczna', 55, NULL),
(11, 'Lublin', 111, 'Unicka', 18, 2),
(12, 'Lublin', 112, 'Mełgiewska', 100, NULL),
(13, 'Lublin', 113, 'Sławinkowska', 3, NULL),
(14, 'Lublin', 114, 'Wieniawska', 9, 5),
(15, 'Lublin', 115, 'Północna', 27, NULL),
(16, 'Lublin', 116, 'Dożynkowa', 41, 6),
(17, 'Lublin', 117, 'Radości', 2, NULL),
(18, 'Lublin', 118, 'Spokojna', 19, 1),
(19, 'Lublin', 119, 'Uśmiechu', 7, NULL);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `dane_uzytkownika`
--

CREATE TABLE `dane_uzytkownika` (
  `id` int(10) UNSIGNED NOT NULL,
  `imie` varchar(64) NOT NULL,
  `nazwisko` varchar(64) NOT NULL,
  `numer_telefonu` varchar(16) NOT NULL,
  `data_urodzenia` date NOT NULL,
  `data_smierci` date DEFAULT NULL,
  `adres_id` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dane_uzytkownika`
--

INSERT INTO `dane_uzytkownika` (`id`, `imie`, `nazwisko`, `numer_telefonu`, `data_urodzenia`, `data_smierci`, `adres_id`) VALUES
(1, 'Jan', 'Kowalski', '500100101', '1948-02-12', NULL, 1),
(2, 'Anna', 'Kowalska', '500100102', '1950-06-03', NULL, 2),
(3, 'Stanisław', 'Nowak', '500100103', '1945-11-22', NULL, 3),
(4, 'Maria', 'Nowak', '500100104', '1947-09-01', NULL, 4),
(5, 'Jerzy', 'Wiśniewski', '500100105', '1949-01-15', NULL, 5),
(6, 'Halina', 'Wiśniewska', '500100106', '1952-04-18', NULL, 6),
(7, 'Tadeusz', 'Mazur', '500100107', '1943-07-30', NULL, 7),
(8, 'Zofia', 'Mazur', '500100108', '1946-12-09', NULL, 8),
(9, 'Ryszard', 'Zieliński', '500100109', '1944-03-25', NULL, 9),
(10, 'Barbara', 'Zielińska', '500100110', '1948-08-14', NULL, 10),
(11, 'Kazimierz', 'Kamiński', '500100111', '1942-10-02', NULL, 11),
(12, 'Danuta', 'Kamińska', '500100112', '1945-05-20', NULL, 12),
(13, 'Henryk', 'Lewandowski', '500100113', '1921-01-06', NULL, 13),
(14, 'Krystyna', 'Lewandowska', '500100114', '1946-02-17', '2026-01-01', 14),
(15, 'Marek', 'Dąbrowski', '500100115', '1950-09-09', NULL, 15),
(16, 'Ewa', 'Dąbrowska', '500100116', '1953-11-11', NULL, 16),
(17, 'Bogdan', 'Kaczmarek', '500100117', '1947-06-06', NULL, 17),
(18, 'Elżbieta', 'Kaczmarek', '500100118', '1951-03-03', NULL, 18),
(19, 'A', 'B', '5', '2024-01-10', NULL, NULL);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `ilosc_postow_i_ludzi`
-- (See below for the actual view)
--
CREATE TABLE `ilosc_postow_i_ludzi` (
`id` smallint(5) unsigned
,`nazwa` varchar(256)
,`liczba_uzytkownikow` bigint(21)
,`liczba_postow` bigint(21)
);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `modlitwa`
--

CREATE TABLE `modlitwa` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `nazwa` varchar(128) DEFAULT NULL,
  `tresc` varchar(2048) NOT NULL,
  `efekt` varchar(128) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `modlitwa`
--

INSERT INTO `modlitwa` (`id`, `nazwa`, `tresc`, `efekt`) VALUES
(1, 'O zdrowie', 'Modlitwa o zdrowie', 'Pocieszenie'),
(2, 'O rodzinę', 'Modlitwa za rodzinę', 'Spokój'),
(3, 'O pokój', 'Modlitwa o pokój', 'Ukojenie'),
(4, 'Różaniec', 'Modlitwa różańcowa', 'Skupienie'),
(5, 'Koronka', 'Koronka do Miłosierdzia', 'Nadzieja'),
(6, 'O siłę', 'Modlitwa o siłę', 'Wytrwałość'),
(7, 'O cierpliwość', 'Modlitwa o cierpliwość', 'Spokój'),
(8, 'Poranna', 'Modlitwa poranna', 'Motywacja'),
(9, 'Wieczorna', 'Modlitwa wieczorna', 'Wyciszenie'),
(10, 'Dziękczynna', 'Modlitwa dziękczynna', 'Wdzięczność'),
(11, 'O przebaczenie', 'Modlitwa o przebaczenie', 'Ulga'),
(12, 'O mądrość', 'Modlitwa o mądrość', 'Jasność'),
(13, 'O wiarę', 'Modlitwa o wiarę', 'Nadzieja'),
(14, 'O nadzieję', 'Modlitwa o nadzieję', 'Optymizm'),
(15, 'Za zmarłych', 'Modlitwa za zmarłych', 'Pamięć'),
(16, 'Za chorych', 'Modlitwa za chorych', 'Wsparcie'),
(17, 'Za dzieci', 'Modlitwa za dzieci', 'Spokój'),
(18, 'Za wnuki', 'Modlitwa za wnuki', 'Radość');

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `najplodniejsi_kreatorzy_postow`
-- (See below for the actual view)
--
CREATE TABLE `najplodniejsi_kreatorzy_postow` (
`pseudonim` varchar(64)
,`liczba_postow` bigint(21)
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `najplodniejsze_modlitwy`
-- (See below for the actual view)
--
CREATE TABLE `najplodniejsze_modlitwy` (
`id` smallint(5) unsigned
,`nazwa` varchar(128)
,`liczba_polubien` bigint(21)
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `najplodniejsze_parafie`
-- (See below for the actual view)
--
CREATE TABLE `najplodniejsze_parafie` (
`id` smallint(5) unsigned
,`nazwa` varchar(256)
,`liczba_wiernych` bigint(21)
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `najplodniejsze_rodziny`
-- (See below for the actual view)
--
CREATE TABLE `najplodniejsze_rodziny` (
`id` int(10) unsigned
,`nazwa` varchar(128)
,`liczba_czlonkow` bigint(21)
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `najstarsi_uzytkownicy`
-- (See below for the actual view)
--
CREATE TABLE `najstarsi_uzytkownicy` (
`id` int(10) unsigned
,`pseudonim` varchar(64)
,`wiek` bigint(21)
);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `obrazek`
--

CREATE TABLE `obrazek` (
  `id` int(10) UNSIGNED NOT NULL,
  `tekst_alternatywny` varchar(128) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `ogloszenie`
--

CREATE TABLE `ogloszenie` (
  `id` int(10) UNSIGNED NOT NULL,
  `tytul` varchar(128) NOT NULL,
  `data_wstawienia` date NOT NULL,
  `tresc` varchar(512) NOT NULL,
  `autor_id` int(10) UNSIGNED NOT NULL,
  `tablica_ogloszeniowa_id` smallint(5) UNSIGNED NOT NULL,
  `obrazek_id` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ogloszenie`
--

INSERT INTO `ogloszenie` (`id`, `tytul`, `data_wstawienia`, `tresc`, `autor_id`, `tablica_ogloszeniowa_id`, `obrazek_id`) VALUES
(1, 'Spotkanie szachowe', '2024-01-10', 'Zapraszam w środę', 1, 2, NULL),
(2, 'Sadzonki pomidorów', '2024-01-11', 'Oddam sadzonki', 2, 3, NULL),
(3, 'Różaniec', '2024-01-12', 'Modlitwa wspólna', 3, 5, NULL),
(4, 'Spacer', '2024-01-13', 'Park Saski', 4, 7, NULL),
(5, 'Nowa książka', '2024-01-14', 'Polecam lekturę', 5, 8, NULL),
(6, 'Działka', '2024-01-15', 'Wymiana nasion', 6, 6, NULL),
(7, 'Ciasto', '2024-01-16', 'Przepis na sernik', 8, 10, NULL),
(8, 'Wędkarstwo', '2024-01-17', 'Wyjazd nad jezioro', 11, 9, NULL),
(9, 'Zdrowie', '2024-01-18', 'Ćwiczenia na kręgosłup', 14, 16, NULL),
(10, 'Chór', '2024-01-19', 'Próba w piątek', 6, 14, NULL),
(11, 'Historia', '2024-01-20', 'Prelekcja', 5, 12, NULL),
(12, 'Majsterkowanie', '2024-01-21', 'Naprawa kranu', 7, 13, NULL),
(13, 'Rodzina', '2024-01-22', 'Zjazd rodzinny', 1, 15, NULL),
(14, 'Gotowanie', '2024-01-23', 'Zupa jarzynowa', 18, 10, NULL),
(15, 'Spacer', '2024-01-24', 'Las Dąbrowa', 10, 7, NULL),
(16, 'Książki', '2024-01-25', 'Klub czytelniczy', 16, 8, NULL),
(17, 'Zdrowie', '2024-01-26', 'Badania profilaktyczne', 12, 16, NULL),
(18, 'Wolontariat', '2024-01-27', 'Zbiórka darów', 9, 18, NULL);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `opis_uzytkownika`
--

CREATE TABLE `opis_uzytkownika` (
  `id` int(10) UNSIGNED NOT NULL,
  `plec` char(1) DEFAULT NULL,
  `pseudonim` varchar(64) DEFAULT NULL,
  `opis` varchar(1024) DEFAULT NULL,
  `parafia_id` smallint(5) UNSIGNED DEFAULT NULL,
  `rodzina_id` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `zdjecie_profilowe` int(10) UNSIGNED DEFAULT 1,
  `ulubiona_modlitwa_id` smallint(5) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `opis_uzytkownika`
--

INSERT INTO `opis_uzytkownika` (`id`, `plec`, `pseudonim`, `opis`, `parafia_id`, `rodzina_id`, `zdjecie_profilowe`, `ulubiona_modlitwa_id`) VALUES
(1, 'M', 'janek48', 'Lubi spacery i szachy', 1, 2, NULL, 1),
(2, 'K', 'anka50', 'Uwielbia ogród', 1, 2, NULL, 2),
(3, 'M', 'stan45', 'Były kolejarz', 2, 3, NULL, 3),
(4, 'K', 'marysia', 'Szydełkowanie to pasja', 2, 3, NULL, 4),
(5, 'M', 'jerzy49', 'Czyta historię', 3, 4, NULL, 5),
(6, 'K', 'halina', 'Chór parafialny', 3, 4, NULL, 6),
(7, 'M', 'tadek', 'Majsterkowicz', 4, 5, NULL, 7),
(8, 'K', 'zofia', 'Piecze ciasta', 4, 5, NULL, 8),
(9, 'M', 'rysiek', 'Działkowiec', 5, 6, NULL, 9),
(10, 'K', 'basia', 'Nordic walking', 5, 6, NULL, 10),
(11, 'M', 'kazik', 'Wędkarz', 6, 7, NULL, 11),
(12, 'K', 'danuta', 'Robótki ręczne', 6, 7, NULL, 12),
(13, 'M', 'henryk', 'Szachista', 7, 8, NULL, 13),
(14, 'K', 'krysia', 'Opieka nad wnukami', 7, 8, NULL, 14),
(15, 'M', 'marek', 'Były nauczyciel', 8, 9, NULL, 15),
(16, 'K', 'ewa', 'Czytelniczka', 8, 9, NULL, 16),
(17, 'M', 'bogdan', 'Handlarz', 9, 10, NULL, 17),
(18, 'K', 'ela', 'Gotowanie', 9, 10, NULL, 18);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `parafia`
--

CREATE TABLE `parafia` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `nazwa` varchar(256) NOT NULL,
  `id_proboszcz` tinyint(3) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `parafia`
--

INSERT INTO `parafia` (`id`, `nazwa`, `id_proboszcz`) VALUES
(1, 'Św. Jana', 1),
(2, 'Św. Pawła', 2),
(3, 'Św. Piotra', 3),
(4, 'Św. Łukasza', 4),
(5, 'Św. Marka', 5),
(6, 'Św. Mateusza', 6),
(7, 'Św. Jakuba', 7),
(8, 'Św. Anny', 8),
(9, 'Św. Józefa', 9),
(10, 'Św. Barbary', 10),
(11, 'Św. Teresy', 11),
(12, 'Św. Franciszka', 12),
(13, 'Św. Wojciecha', 13),
(14, 'Św. Michała', 14),
(15, 'Św. Krzysztofa', 15),
(16, 'Św. Katarzyny', 16),
(17, 'Św. Elżbiety', 17),
(18, 'Św. Moniki', 18);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `pokrewienstwo`
--

CREATE TABLE `pokrewienstwo` (
  `id` int(10) UNSIGNED NOT NULL,
  `typ_relacji` enum('mama','ojciec','córka','syn','siostra','brat','ciotka','wujek','siostrzenica','bratanica','siostrzeniec','bratanek','kuzyn','kuzynka','babcia','dziadek','wnuczka','wnuk','rodzeństwo','rodzic','ojczym','macocha','pasierb','pasierbica','szwagier','szwagierka','teść','tesciowa','ziec','synowa') DEFAULT NULL,
  `widzi_dane_osobowe` tinyint(1) NOT NULL,
  `uzytkownik_id` int(10) UNSIGNED NOT NULL,
  `spokrewiony_uzytkownik_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pokrewienstwo`
--

INSERT INTO `pokrewienstwo` (`id`, `typ_relacji`, `widzi_dane_osobowe`, `uzytkownik_id`, `spokrewiony_uzytkownik_id`) VALUES
(1, 'syn', 1, 1, 2),
(2, 'wujek', 1, 2, 1),
(3, 'wnuk', 1, 3, 4),
(4, 'siostra', 1, 4, 3),
(5, 'tesciowa', 1, 5, 6),
(6, 'szwagierka', 1, 6, 5),
(7, 'tesciowa', 1, 7, 8),
(8, 'tesciowa', 1, 8, 7),
(9, 'ciotka', 1, 9, 10),
(10, 'ziec', 1, 10, 9),
(11, 'tesciowa', 1, 11, 12),
(12, 'ziec', 1, 12, 11),
(13, 'szwagier', 1, 13, 14),
(14, 'kuzynka', 1, 14, 13),
(15, 'szwagierka', 1, 15, 16),
(16, 'szwagierka', 1, 16, 15),
(17, 'macocha', 1, 17, 18),
(18, 'brat', 1, 18, 17);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `proboszcz`
--

CREATE TABLE `proboszcz` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `imie` varchar(64) NOT NULL,
  `nazwisko` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `proboszcz`
--

INSERT INTO `proboszcz` (`id`, `imie`, `nazwisko`) VALUES
(1, 'Jan', 'Kowal'),
(2, 'Andrzej', 'Mazur'),
(3, 'Piotr', 'Nowicki'),
(4, 'Stanisław', 'Wójcik'),
(5, 'Tomasz', 'Lewandowski'),
(6, 'Marek', 'Kamiński'),
(7, 'Adam', 'Dąbrowski'),
(8, 'Paweł', 'Kaczmarek'),
(9, 'Grzegorz', 'Zieliński'),
(10, 'Ryszard', 'Król'),
(11, 'Józef', 'Pawlak'),
(12, 'Henryk', 'Piotrowski'),
(13, 'Bogdan', 'Grabowski'),
(14, 'Kazimierz', 'Sikora'),
(15, 'Roman', 'Michalski'),
(16, 'Edward', 'Adamczyk'),
(17, 'Waldemar', 'Lis'),
(18, 'Jerzy', 'Baran');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `rodzina`
--

CREATE TABLE `rodzina` (
  `id` int(10) UNSIGNED NOT NULL,
  `nazwa` varchar(128) NOT NULL,
  `opis` varchar(1024) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rodzina`
--

INSERT INTO `rodzina` (`id`, `nazwa`, `opis`) VALUES
(1, 'Nieznana', 'Brak danych o rodzinie'),
(2, 'Kowalscy', 'Rodzina z Czechowa'),
(3, 'Nowakowie', 'Wielopokoleniowa rodzina'),
(4, 'Wiśniewscy', 'Rodzina nauczycieli'),
(5, 'Mazurkowie', 'Rodzina rzemieślników'),
(6, 'Zielińscy', 'Rodzina ogrodników'),
(7, 'Kamińscy', 'Rodzina kolejarska'),
(8, 'Lewandowscy', 'Rodzina sportowa'),
(9, 'Dąbrowscy', 'Rodzina akademicka'),
(10, 'Kaczmarkowie', 'Rodzina handlowa'),
(11, 'Wójcikowie', 'Rodzina z tradycjami'),
(12, 'Piotrowscy', 'Rodzina miejska'),
(13, 'Grabowscy', 'Rodzina wiejska'),
(14, 'Pawlakowie', 'Rodzina rolnicza'),
(15, 'Michalscy', 'Rodzina urzędnicza'),
(16, 'Król', 'Mała rodzina'),
(17, 'Adamczykowie', 'Rodzina z Bronowic'),
(18, 'Sikorscy', 'Rodzina wojskowa');

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
-- Struktura tabeli dla tabeli `tablica_ogloszeniowa`
--

CREATE TABLE `tablica_ogloszeniowa` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `nazwa` varchar(256) NOT NULL,
  `opis` varchar(2048) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tablica_ogloszeniowa`
--

INSERT INTO `tablica_ogloszeniowa` (`id`, `nazwa`, `opis`) VALUES
(1, 'Tablica Główna', 'Ogłoszenia ogólne'),
(2, 'Szachy', 'Miłośnicy szachów'),
(3, 'Ogród', 'Ogrodnictwo'),
(4, 'Rękodzieło', 'Szydełko i druty'),
(5, 'Parafia Św. Jana', 'Sprawy parafialne'),
(6, 'Działkowcy', 'Uprawa działek'),
(7, 'Spacer', 'Grupy spacerowe'),
(8, 'Książki', 'Czytelnicy'),
(9, 'Wędkarstwo', 'Wędkarze'),
(10, 'Gotowanie', 'Przepisy'),
(11, 'Nordic Walking', 'Marsze'),
(12, 'Historia', 'Historia lokalna'),
(13, 'Majsterkowanie', 'Złota rączka'),
(14, 'Chór', 'Śpiew'),
(15, 'Rodzina', 'Sprawy rodzinne'),
(16, 'Zdrowie', 'Porady zdrowotne'),
(17, 'Podróże', 'Wycieczki'),
(18, 'Wolontariat', 'Pomoc innym');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `tablica_ogloszeniowa_uzytkownik`
--

CREATE TABLE `tablica_ogloszeniowa_uzytkownik` (
  `id` int(10) UNSIGNED NOT NULL,
  `uzytkownik_id` int(10) UNSIGNED NOT NULL,
  `tablica_ogloszeniowa_id` smallint(5) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tablica_ogloszeniowa_uzytkownik`
--

INSERT INTO `tablica_ogloszeniowa_uzytkownik` (`id`, `uzytkownik_id`, `tablica_ogloszeniowa_id`) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 1),
(4, 4, 1),
(5, 5, 1),
(6, 6, 1),
(7, 7, 1),
(8, 8, 1),
(9, 9, 1),
(10, 10, 1),
(11, 11, 1),
(12, 12, 1),
(13, 13, 1),
(14, 14, 1),
(15, 15, 1),
(16, 16, 1),
(17, 17, 1),
(18, 18, 1),
(19, 1, 8),
(20, 19, 1),
(21, 16, 12);

--
-- Wyzwalacze `tablica_ogloszeniowa_uzytkownik`
--
DELIMITER $$
CREATE TRIGGER `po_wstawieniu_tablica_ogloszeniowa_uzytkownik` AFTER INSERT ON `tablica_ogloszeniowa_uzytkownik` FOR EACH ROW INSERT INTO uprawnienia (rola,tablica_ogloszeniowa_id,uzytkownik_id)
VALUES ('obserwator postow',NEW.tablica_ogloszeniowa_id,NEW.uzytkownik_id)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `uprawnienia`
--

CREATE TABLE `uprawnienia` (
  `id` int(10) UNSIGNED NOT NULL,
  `rola` enum('zarządzanie postami i użytkownikami','kreator postów','moderator postów','obserwator postów') NOT NULL,
  `tablica_ogloszeniowa_id` smallint(5) UNSIGNED NOT NULL,
  `uzytkownik_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `uprawnienia`
--

INSERT INTO `uprawnienia` (`id`, `rola`, `tablica_ogloszeniowa_id`, `uzytkownik_id`) VALUES
(1, 'obserwator postów', 1, 1),
(2, 'kreator postów', 2, 1),
(3, 'kreator postów', 3, 2),
(4, 'moderator postów', 4, 4),
(5, 'obserwator postów', 5, 3),
(6, 'kreator postów', 6, 6),
(7, 'moderator postów', 7, 10),
(8, 'kreator postów', 8, 5),
(9, 'kreator postów', 9, 11),
(10, 'moderator postów', 10, 18),
(11, 'kreator postów', 11, 10),
(12, 'obserwator postów', 12, 5),
(13, 'kreator postów', 13, 7),
(14, 'moderator postów', 14, 6),
(15, 'kreator postów', 15, 1),
(16, 'obserwator postów', 16, 14),
(17, 'kreator postów', 17, 9),
(18, 'moderator postów', 18, 9),
(19, 'obserwator postów', 1, 19),
(20, 'obserwator postów', 12, 16);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `uzytkownik`
--

CREATE TABLE `uzytkownik` (
  `id` int(10) UNSIGNED NOT NULL,
  `login` varchar(128) NOT NULL,
  `haslo` binary(50) NOT NULL,
  `ip` varbinary(16) NOT NULL,
  `dane_uzytkownika_id` int(10) UNSIGNED DEFAULT NULL,
  `opis_uzytkownika_id` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `uzytkownik`
--

INSERT INTO `uzytkownik` (`id`, `login`, `haslo`, `ip`, `dane_uzytkownika_id`, `opis_uzytkownika_id`) VALUES
(1, 'jkowalski', 0x0100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000, 0x7f000001, 1, 1),
(2, 'akowalska', 0x0200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000, 0x7f000002, 2, 2),
(3, 'snowak', 0x0300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000, 0x7f000003, 3, 3),
(4, 'mnowak', 0x0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000, 0x7f000004, 4, 4),
(5, 'jwisniewski', 0x0500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000, 0x7f000005, 5, 5),
(6, 'hwisniewska', 0x0600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000, 0x7f000006, 6, 6),
(7, 'tmazur', 0x0700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000, 0x7f000007, 7, 7),
(8, 'zmazur', 0x0800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000, 0x7f000008, 8, 8),
(9, 'rzielinski', 0x0900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000, 0x7f000009, 9, 9),
(10, 'bzielinska', 0x0a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000, 0x7f00000a, 10, 10),
(11, 'kkaminski', 0x0b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000, 0x7f00000b, 11, 11),
(12, 'dkaminska', 0x0c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000, 0x7f00000c, 12, 12),
(13, 'hlewandowski', 0x0d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000, 0x7f00000d, 13, 13),
(14, 'klewandowska', 0x0e00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000, 0x7f00000e, 14, 14),
(15, 'mdabrowski', 0x0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000, 0x7f00000f, 15, 15),
(16, 'edabrowska', 0x1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000, 0x7f000010, 16, 16),
(17, 'bkaczmarek', 0x1100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000, 0x7f000011, 17, 17),
(18, 'ekaczmarek', 0x1200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000, 0x7f000012, 18, 18),
(19, 'ashfdjsf', 0x0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000, '', NULL, NULL);

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
-- Struktura widoku `ilosc_postow_i_ludzi`
--
DROP TABLE IF EXISTS `ilosc_postow_i_ludzi`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `ilosc_postow_i_ludzi`  AS SELECT `t`.`id` AS `id`, `t`.`nazwa` AS `nazwa`, count(distinct `tou`.`uzytkownik_id`) AS `liczba_uzytkownikow`, count(distinct `o`.`id`) AS `liczba_postow` FROM ((`tablica_ogloszeniowa` `t` left join `tablica_ogloszeniowa_uzytkownik` `tou` on(`t`.`id` = `tou`.`tablica_ogloszeniowa_id`)) left join `ogloszenie` `o` on(`o`.`tablica_ogloszeniowa_id` = `t`.`id`)) GROUP BY `t`.`id`, `t`.`nazwa` ORDER BY count(distinct `tou`.`uzytkownik_id`) DESC ;

-- --------------------------------------------------------

--
-- Struktura widoku `najplodniejsi_kreatorzy_postow`
--
DROP TABLE IF EXISTS `najplodniejsi_kreatorzy_postow`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `najplodniejsi_kreatorzy_postow`  AS SELECT `ou`.`pseudonim` AS `pseudonim`, count(`o`.`id`) AS `liczba_postow` FROM ((`uzytkownik` `u` join `opis_uzytkownika` `ou` on(`ou`.`id` = `u`.`id`)) join `ogloszenie` `o` on(`o`.`autor_id` = `u`.`id`)) GROUP BY `u`.`id` ORDER BY count(`o`.`id`) DESC LIMIT 0, 10 ;

-- --------------------------------------------------------

--
-- Struktura widoku `najplodniejsze_modlitwy`
--
DROP TABLE IF EXISTS `najplodniejsze_modlitwy`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `najplodniejsze_modlitwy`  AS SELECT `modlitwa`.`id` AS `id`, `modlitwa`.`nazwa` AS `nazwa`, count(`opis_uzytkownika`.`id`) AS `liczba_polubien` FROM (`modlitwa` join `opis_uzytkownika` on(`opis_uzytkownika`.`ulubiona_modlitwa_id` = `modlitwa`.`id`)) GROUP BY `modlitwa`.`id` ORDER BY `modlitwa`.`id` ASC ;

-- --------------------------------------------------------

--
-- Struktura widoku `najplodniejsze_parafie`
--
DROP TABLE IF EXISTS `najplodniejsze_parafie`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `najplodniejsze_parafie`  AS SELECT `parafia`.`id` AS `id`, `parafia`.`nazwa` AS `nazwa`, count(`opis_uzytkownika`.`id`) AS `liczba_wiernych` FROM (`parafia` join `opis_uzytkownika` on(`opis_uzytkownika`.`parafia_id` = `parafia`.`id`)) GROUP BY `parafia`.`id` ORDER BY `parafia`.`id` ASC ;

-- --------------------------------------------------------

--
-- Struktura widoku `najplodniejsze_rodziny`
--
DROP TABLE IF EXISTS `najplodniejsze_rodziny`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `najplodniejsze_rodziny`  AS SELECT `rodzina`.`id` AS `id`, `rodzina`.`nazwa` AS `nazwa`, count(`opis_uzytkownika`.`id`) AS `liczba_czlonkow` FROM (`rodzina` join `opis_uzytkownika` on(`opis_uzytkownika`.`rodzina_id` = `rodzina`.`id`)) GROUP BY `rodzina`.`id` ORDER BY `rodzina`.`id` ASC ;

-- --------------------------------------------------------

--
-- Struktura widoku `najstarsi_uzytkownicy`
--
DROP TABLE IF EXISTS `najstarsi_uzytkownicy`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `najstarsi_uzytkownicy`  AS SELECT `uzytkownik`.`id` AS `id`, `opis_uzytkownika`.`pseudonim` AS `pseudonim`, `wiek`.`wiek` AS `wiek` FROM (((`uzytkownik` join `opis_uzytkownika` on(`opis_uzytkownika`.`id` = `uzytkownik`.`opis_uzytkownika_id`)) join `dane_uzytkownika` on(`dane_uzytkownika`.`id` = `uzytkownik`.`dane_uzytkownika_id`)) join `wiek` on(`wiek`.`dane_uzytkownika_id` = `dane_uzytkownika`.`id`)) ORDER BY `wiek`.`wiek` DESC ;

-- --------------------------------------------------------

--
-- Struktura widoku `rodzina_wzeniona`
--
DROP TABLE IF EXISTS `rodzina_wzeniona`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `rodzina_wzeniona`  AS SELECT `o`.`rodzina_id` AS `rodzina_id`, `u`.`id` AS `uzytkownik_id` FROM (((`uzytkownik` `u` join `pokrewienstwo` `p` on(`p`.`uzytkownik_id` = `u`.`id`)) join `uzytkownik` `wspolmalzonek` on(`wspolmalzonek`.`id` = `p`.`spokrewiony_uzytkownik_id`)) join `opis_uzytkownika` `o` on(`o`.`id` = `wspolmalzonek`.`opis_uzytkownika_id`)) WHERE `p`.`typ_relacji` in ('mąż','żona') ;

-- --------------------------------------------------------

--
-- Struktura widoku `wiek`
--
DROP TABLE IF EXISTS `wiek`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `wiek`  AS SELECT `dane_uzytkownika`.`id` AS `dane_uzytkownika_id`, CASE WHEN `dane_uzytkownika`.`data_smierci` is null THEN timestampdiff(YEAR,`dane_uzytkownika`.`data_urodzenia`,curdate()) ELSE timestampdiff(YEAR,`dane_uzytkownika`.`data_urodzenia`,`dane_uzytkownika`.`data_smierci`) END AS `wiek` FROM `dane_uzytkownika` ;

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `adres`
--
ALTER TABLE `adres`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `dane_uzytkownika`
--
ALTER TABLE `dane_uzytkownika`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_dane_adres` (`adres_id`);

--
-- Indeksy dla tabeli `modlitwa`
--
ALTER TABLE `modlitwa`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `obrazek`
--
ALTER TABLE `obrazek`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `ogloszenie`
--
ALTER TABLE `ogloszenie`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_ogl_autor` (`autor_id`),
  ADD KEY `fk_ogl_tablica` (`tablica_ogloszeniowa_id`),
  ADD KEY `fk_ogl_obrazek` (`obrazek_id`);

--
-- Indeksy dla tabeli `opis_uzytkownika`
--
ALTER TABLE `opis_uzytkownika`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_opis_parafia` (`parafia_id`),
  ADD KEY `fk_opis_rodzina` (`rodzina_id`),
  ADD KEY `fk_opis_zdjecie` (`zdjecie_profilowe`),
  ADD KEY `fk_opis_modlitwa` (`ulubiona_modlitwa_id`);

--
-- Indeksy dla tabeli `parafia`
--
ALTER TABLE `parafia`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nazwa` (`nazwa`),
  ADD KEY `fk_parafia_proboszcz` (`id_proboszcz`);

--
-- Indeksy dla tabeli `pokrewienstwo`
--
ALTER TABLE `pokrewienstwo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_pokr_user` (`uzytkownik_id`),
  ADD KEY `fk_pokr_user2` (`spokrewiony_uzytkownik_id`);

--
-- Indeksy dla tabeli `proboszcz`
--
ALTER TABLE `proboszcz`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `rodzina`
--
ALTER TABLE `rodzina`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `tablica_ogloszeniowa`
--
ALTER TABLE `tablica_ogloszeniowa`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `tablica_ogloszeniowa_uzytkownik`
--
ALTER TABLE `tablica_ogloszeniowa_uzytkownik`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_tou_user` (`uzytkownik_id`),
  ADD KEY `fk_tou_tablica` (`tablica_ogloszeniowa_id`);

--
-- Indeksy dla tabeli `uprawnienia`
--
ALTER TABLE `uprawnienia`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_upr_tablica` (`tablica_ogloszeniowa_id`),
  ADD KEY `fk_upr_user` (`uzytkownik_id`);

--
-- Indeksy dla tabeli `uzytkownik`
--
ALTER TABLE `uzytkownik`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `login` (`login`),
  ADD UNIQUE KEY `ip` (`ip`),
  ADD KEY `fk_user_dane` (`dane_uzytkownika_id`),
  ADD KEY `fk_user_opis` (`opis_uzytkownika_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `adres`
--
ALTER TABLE `adres`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `dane_uzytkownika`
--
ALTER TABLE `dane_uzytkownika`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `modlitwa`
--
ALTER TABLE `modlitwa`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `obrazek`
--
ALTER TABLE `obrazek`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ogloszenie`
--
ALTER TABLE `ogloszenie`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `opis_uzytkownika`
--
ALTER TABLE `opis_uzytkownika`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `parafia`
--
ALTER TABLE `parafia`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `pokrewienstwo`
--
ALTER TABLE `pokrewienstwo`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `proboszcz`
--
ALTER TABLE `proboszcz`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `rodzina`
--
ALTER TABLE `rodzina`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `tablica_ogloszeniowa`
--
ALTER TABLE `tablica_ogloszeniowa`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `tablica_ogloszeniowa_uzytkownik`
--
ALTER TABLE `tablica_ogloszeniowa_uzytkownik`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `uprawnienia`
--
ALTER TABLE `uprawnienia`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `uzytkownik`
--
ALTER TABLE `uzytkownik`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `dane_uzytkownika`
--
ALTER TABLE `dane_uzytkownika`
  ADD CONSTRAINT `fk_dane_adres` FOREIGN KEY (`adres_id`) REFERENCES `adres` (`id`);

--
-- Constraints for table `ogloszenie`
--
ALTER TABLE `ogloszenie`
  ADD CONSTRAINT `fk_ogl_autor` FOREIGN KEY (`autor_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `fk_ogl_obrazek` FOREIGN KEY (`obrazek_id`) REFERENCES `obrazek` (`id`),
  ADD CONSTRAINT `fk_ogl_tablica` FOREIGN KEY (`tablica_ogloszeniowa_id`) REFERENCES `tablica_ogloszeniowa` (`id`);

--
-- Constraints for table `opis_uzytkownika`
--
ALTER TABLE `opis_uzytkownika`
  ADD CONSTRAINT `fk_opis_modlitwa` FOREIGN KEY (`ulubiona_modlitwa_id`) REFERENCES `modlitwa` (`id`),
  ADD CONSTRAINT `fk_opis_parafia` FOREIGN KEY (`parafia_id`) REFERENCES `parafia` (`id`),
  ADD CONSTRAINT `fk_opis_rodzina` FOREIGN KEY (`rodzina_id`) REFERENCES `rodzina` (`id`),
  ADD CONSTRAINT `fk_opis_zdjecie` FOREIGN KEY (`zdjecie_profilowe`) REFERENCES `obrazek` (`id`);

--
-- Constraints for table `parafia`
--
ALTER TABLE `parafia`
  ADD CONSTRAINT `fk_parafia_proboszcz` FOREIGN KEY (`id_proboszcz`) REFERENCES `proboszcz` (`id`);

--
-- Constraints for table `pokrewienstwo`
--
ALTER TABLE `pokrewienstwo`
  ADD CONSTRAINT `fk_pokr_user` FOREIGN KEY (`uzytkownik_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `fk_pokr_user2` FOREIGN KEY (`spokrewiony_uzytkownik_id`) REFERENCES `uzytkownik` (`id`);

--
-- Constraints for table `tablica_ogloszeniowa_uzytkownik`
--
ALTER TABLE `tablica_ogloszeniowa_uzytkownik`
  ADD CONSTRAINT `fk_tou_tablica` FOREIGN KEY (`tablica_ogloszeniowa_id`) REFERENCES `tablica_ogloszeniowa` (`id`),
  ADD CONSTRAINT `fk_tou_user` FOREIGN KEY (`uzytkownik_id`) REFERENCES `uzytkownik` (`id`);

--
-- Constraints for table `uprawnienia`
--
ALTER TABLE `uprawnienia`
  ADD CONSTRAINT `fk_upr_tablica` FOREIGN KEY (`tablica_ogloszeniowa_id`) REFERENCES `tablica_ogloszeniowa` (`id`),
  ADD CONSTRAINT `fk_upr_user` FOREIGN KEY (`uzytkownik_id`) REFERENCES `uzytkownik` (`id`);

--
-- Constraints for table `uzytkownik`
--
ALTER TABLE `uzytkownik`
  ADD CONSTRAINT `fk_user_dane` FOREIGN KEY (`dane_uzytkownika_id`) REFERENCES `dane_uzytkownika` (`id`),
  ADD CONSTRAINT `fk_user_opis` FOREIGN KEY (`opis_uzytkownika_id`) REFERENCES `opis_uzytkownika` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
