<?php
include 'connect.php';

$message = "";
$logged = isset($_SESSION['login']);
if ($logged) {
    $login = $_SESSION['login'];
    $board_id = 1;
    if ($_SERVER["REQUEST_METHOD"] == "GET" && isset($_GET['board_id'])) {
        $board_id = $_GET['board_id'];
    }
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
            <?php
            if (!$logged){
                echo "<a href=\"../index.html\">Logowanie</a>";
            }
            ?>
            <a href="board.php">Tablice</a>
            <a href="profile.php">Profil</a>
            <a href="family.php">Rodzina</a>
            <?php
            if (!$logged){
                echo "<a href=\"login.php\">Logowanie</a>";
            }
            ?>
        </div>

        <div id="content">
            <h1>Tablice</h1>
            <form action="board.php" method="get">
                <select name="board_id">

                    <?php
                    $sql = "SELECT tablica_ogloszeniowa.id, tablica_ogloszeniowa.nazwa FROM tablica_ogloszeniowa JOIN tablica_ogloszeniowa_uzytkownik ON tablica_ogloszeniowa_uzytkownik.tablica_ogloszeniowa_id = tablica_ogloszeniowa.id JOIN uzytkownik ON uzytkownik.id = tablica_ogloszeniowa_uzytkownik.uzytkownik_id WHERE uzytkownik.login = \"$login\";";
                    $result = $conn->query($sql);

                    if ($result->num_rows > 0) {
                        while($row = $result->fetch_assoc()) {
                            echo "<option value=\"".$row["id"]."\">".$row["nazwa"]."</option>";
                        }
                    }
                    ?>

                </select>
                <input type="submit" value="Submit"><br>
            </form>
            
            <?php
            $sql = "SELECT tablica_ogloszeniowa.nazwa, tablica_ogloszeniowa.opis FROM tablica_ogloszeniowa JOIN tablica_ogloszeniowa_uzytkownik ON tablica_ogloszeniowa_uzytkownik.tablica_ogloszeniowa_id = tablica_ogloszeniowa.id JOIN uzytkownik ON uzytkownik.id = tablica_ogloszeniowa_uzytkownik.uzytkownik_id WHERE tablica_ogloszeniowa_id = \"$board_id\" and uzytkownik.login = \"$login\";";
            $result = $conn->query($sql);
            $row = $result->fetch_assoc();
            
            if ($result->num_rows > 0) {
                echo "<h2>".$row["nazwa"]."</h2>";
                echo "<p>".$row["opis"]."</p>";
            }
            ?>

            <div id="posts">
                
                <?php
                $sql = "SELECT ogloszenie.id, ogloszenie.tytul, opis_uzytkownika.pseudonim, ogloszenie.data_wstawienia FROM ogloszenie JOIN tablica_ogloszeniowa ON ogloszenie.tablica_ogloszeniowa_id = tablica_ogloszeniowa.id JOIN tablica_ogloszeniowa_uzytkownik ON tablica_ogloszeniowa_uzytkownik.tablica_ogloszeniowa_id = tablica_ogloszeniowa.id JOIN uzytkownik ON uzytkownik.id = tablica_ogloszeniowa_uzytkownik.uzytkownik_id JOIN opis_uzytkownika ON opis_uzytkownika.uzytkownik_id = ogloszenie.autor_id WHERE ogloszenie.tablica_ogloszeniowa_id = \"$board_id\" and uzytkownik.login = \"$login\" GROUP BY ogloszenie.id;";
                $result = $conn->query($sql);
                
                echo "<hr>";
                if ($result->num_rows > 0) {
                    while($row = $result->fetch_assoc()) {
                        echo "<div class=\"post\"><h3>".$row["tytul"]."</h3> Od ".$row["pseudonim"]." ".$row["data_wstawienia"]." "."</div><hr>";
                    }
                }
                ?>

            </div>
        </div>
    </body>
</html>