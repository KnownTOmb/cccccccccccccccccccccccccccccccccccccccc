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
    $sql = "SELECT opis_uzytkownika.pseudonim, opis_uzytkownika.plec, opis_uzytkownika.opis FROM opis_uzytkownika JOIN uzytkownik ON uzytkownik.opis_uzytkownika_id = opis_uzytkownika.id WHERE uzytkownik.login = \"$login\"";
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
            <h1>Twoja Rodzina</h1>
            <?php
                if ($message == "") {
                    echo $row['pseudonim'];
                    echo "<form action=\"profile.php\" method=\"post\">";
                        echo "<input type=\"submit\" value=\"Wyloguj się\">";
                    echo "</form>";
                }
                else {
                    echo $message;
                }
            ?>
        </div>
    </body>
</html>