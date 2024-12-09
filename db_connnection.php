<?php

include "config/database.php";

function OpenCon() {
    $conn = new mysqli(DB_HOST, DB_USER, DB_PASS, DB_NAME);

    if ($conn->connect_error) {
        die("Connection Failed:" . $conn->connect_error);
    }

    return $conn;
}
 
function CloseCon($conn) {
    $conn -> close();
}