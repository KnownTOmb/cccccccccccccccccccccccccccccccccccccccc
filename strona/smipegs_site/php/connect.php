<?php
    if (session_status() == PHP_SESSION_NONE) {
        session_start();
    }

    $servername = "localhost";
    $username = "uzytkownik";
    $password = "Od}s\$CFP]6W_k5#Es2Z-`VQW";
    $dbname = "smipegs_lublin";

    // Create connection
    $conn = new mysqli($servername, $username, $password, $dbname);

    // Check connection
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    } 
?> 