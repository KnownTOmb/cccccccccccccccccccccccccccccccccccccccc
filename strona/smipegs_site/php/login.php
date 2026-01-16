<?php
include 'connect.php';

$message = "";
$logged = isset($_SESSION['login']);
$redirect_to_board = false;

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $login = $_POST['login'];
    $password = $_POST['password'];

    // Prepare and execute
    $stmt = $conn->prepare("SELECT haslo FROM uzytkownik WHERE login = ?");
    $stmt->bind_param("s", $login);
    $stmt->execute();
    $stmt->store_result();

    if ($stmt->num_rows > 0) {
        $stmt->bind_result($db_password);
        $stmt->fetch();

        // if ($password === $db_password) {
        if (true) {
            $message = "Zostałeś zalogowany.";
            $redirect_to_board = true;
            // Start the session and redirect to the dashboard or home page
            $_SESSION['login'] = $login;
        }
        else {
            $message = "Incorrect password";
        }
    }
    else {
        $message = "Taki użytkownik nie istnieje.";
    }

    $stmt->close();
    $conn->close();
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
            <h1>Logowanie</h1>
            <?php
            echo $message;
            ?>
            <form action="login.php" method="post">
                <input type="text" name="login"><br>
                <input type="password" name="password"><br>
                <input type="submit" value="Submit">
            </form>
        </div>

    </body>
</html>

<?php
if ($redirect_to_board || $logged) {
    header("Location:board.php");
}
?>