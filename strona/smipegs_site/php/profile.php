<?php
include 'connect.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    unset($_SESSION['login']);
    header("Location:login.php");
    exit();
}

$message = "";
$logged = isset($_SESSION['login']);
if ($logged) {
    $login = $_SESSION['login'];
    $sql = "SELECT 
            opis_uzytkownika.pseudonim, 
            opis_uzytkownika.plec, 
            opis_uzytkownika.opis,
            dane_uzytkownika.imie,
            dane_uzytkownika.nazwisko,
            dane_uzytkownika.numer_telefonu,
            dane_uzytkownika.data_urodzenia,
            adres.rejon,
            adres.kod_pocztowy,
            adres.ulica,
            adres.numer_budynku,
            adres.numer_mieszkania
            FROM opis_uzytkownika 
            JOIN uzytkownik ON uzytkownik.id = opis_uzytkownika.uzytkownik_id
            LEFT JOIN dane_uzytkownika ON dane_uzytkownika.uzytkownik_id = uzytkownik.id
            LEFT JOIN adres ON adres.id = dane_uzytkownika.adres_id
            WHERE uzytkownik.login = \"$login\"";
    $result = $conn->query($sql);
    $row = $result->fetch_assoc();
}
else {
    header("Location:login.php");
}
?>
<!DOCTYPE html>
<html>
    <head lang="pl">
        <title>SMIPEGS Lublin</title>
        <meta charset="UTF-8">
    </head>
    <body>
        <div id="topbar">
            <img src="../img/logo.png"></img>
            <br>
            <?php if (!$logged){ echo "<a href=\"../index.html\">Główna</a>"; } ?>
            <?php if ($logged){ echo "<a href=\"board.php\">Tablice</a>"; } ?>
            <?php if ($logged){ echo "<a href=\"profile.php\">Profil</a>"; } ?>
            <?php if ($logged){ echo "<a href=\"family.php\">Rodzina</a>"; } ?>
            <?php if (!$logged){ echo "<a href=\"login.php\">Logowanie</a>"; } ?>
        </div>

        <div id="content">
            <h1>Twój Profil</h1>
            <h2><?php echo htmlspecialchars($row['pseudonim']); ?></h2>
            
            <div class="profile-section">
                <h3>Dane osobowe</h3>
                <p><strong>Imię:</strong> <?php echo htmlspecialchars($row['imie'] ?? 'Nie podano'); ?></p>
                <p><strong>Nazwisko:</strong> <?php echo htmlspecialchars($row['nazwisko'] ?? 'Nie podano'); ?></p>
                <p><strong>Płeć:</strong> <?php echo htmlspecialchars($row['plec'] ?? 'Nie podano'); ?></p>
                <p><strong>Data urodzenia:</strong> <?php echo htmlspecialchars($row['data_urodzenia'] ?? 'Nie podano'); ?></p>
                <p><strong>Telefon:</strong> <?php echo htmlspecialchars($row['numer_telefonu'] ?? 'Nie podano'); ?></p>
            </div>

            <div class="profile-section">
                <h3>Adres</h3>
                <p><strong>Rejon:</strong> <?php echo htmlspecialchars($row['rejon'] ?? 'Nie podano'); ?></p>
                <p><strong>Kod pocztowy:</strong> <?php echo htmlspecialchars($row['kod_pocztowy'] ?? 'Nie podano'); ?></p>
                <p><strong>Ulica:</strong> <?php echo htmlspecialchars($row['ulica'] ?? 'Nie podano'); ?></p>
                <p><strong>Numer budynku:</strong> <?php echo htmlspecialchars($row['numer_budynku'] ?? 'Nie podano'); ?></p>
                <p><strong>Numer mieszkania:</strong> <?php echo htmlspecialchars($row['numer_mieszkania'] ?? 'Nie podano'); ?></p>
            </div>

            <div class="profile-section">
                <h3>O mnie</h3>
                <p><?php echo htmlspecialchars($row['opis'] ?? 'Brak opisu'); ?></p>
            </div>

            <form action="profile.php" method="post">
                <input type="submit" value="Wyloguj się">
            </form>
        </div>
    </body>
</html>