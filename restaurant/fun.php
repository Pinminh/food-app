<?php
require_once '../db_connnection.php';
$soDiem = $_POST['soDiem'];

$conn = OpenCon();
$query = "CALL get_customers_by_point($soDiem);";

if ($conn->query($query)) {
    echo "New record created successfully";
    header('Location: fun/index.php?soDiem=' . $soDiem);
} else {
    echo "Error: " . $query . "<br>" . $conn->error;
    header('Location: index.php?err=' . $conn->error);
}
