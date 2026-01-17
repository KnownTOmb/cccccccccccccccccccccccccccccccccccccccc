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
    
    // Pobranie pseudonimu użytkownika
    $sql_user = "SELECT opis_uzytkownika.pseudonim 
                 FROM opis_uzytkownika 
                 JOIN uzytkownik ON uzytkownik.id = opis_uzytkownika.uzytkownik_id 
                 WHERE uzytkownik.login = \"$login\"";
    $result_user = $conn->query($sql_user);
    $row_user = $result_user->fetch_assoc();
    
    // Pobranie krewnych używając widoków
    $sql = "SELECT 
            pokrewienstwo.typ_relacji,
            sygnatura.imie_pseudonim_nazwisko,
            wiek.wiek
        FROM pokrewienstwo
        JOIN uzytkownik ON uzytkownik.id = pokrewienstwo.uzytkownik_id
        JOIN sygnatura ON sygnatura.uzytkownik_id = pokrewienstwo.spokrewniony_uzytkownik_id
        JOIN dane_uzytkownika ON dane_uzytkownika.uzytkownik_id = pokrewienstwo.spokrewniony_uzytkownik_id
        JOIN wiek ON wiek.dane_uzytkownika_id = dane_uzytkownika.id
        WHERE uzytkownik.login = \"$login\"";
    
    $result = $conn->query($sql);
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
            <h1>Twoja Rodzina</h1>
            <h2><?php echo htmlspecialchars($row_user['pseudonim']); ?></h2>
            
            <?php
                if ($result->num_rows > 0) {
                    echo "<table border='1' cellpadding='10'>";
                    echo "<tr><th>Pseudonim</th><th>Typ relacji</th><th>Wiek</th></tr>";
                    
                    while($row = $result->fetch_assoc()) {
                        echo "<tr>";
                        echo "<td>" . htmlspecialchars($row['imie_pseudonim_nazwisko']) . "</td>";
                        echo "<td>" . htmlspecialchars($row['typ_relacji']) . "</td>";
                        echo "<td>" . ($row['wiek'] !== null ? $row['wiek'] : 'Nie podano') . "</td>";
                        echo "</tr>";
                    }
                    
                    echo "</table>";
                } else {
                    echo "<p>Brak dodanych krewnych</p>";
                }
            ?>
        </div>
    </body>
</html>