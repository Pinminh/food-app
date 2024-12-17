<?php
require_once '../db_connnection.php';
$price = $_POST['price'];

$conn = OpenCon();
$query = "CALL count_dish_per_group_by_price($price);";

if ($conn->query($query)) {
    echo "New record created successfully";
    header('Location: fun/index.php?price=' . $price);
} else {
    echo "Error: " . $query . "<br>" . $conn->error;
    header('Location: index.php?err=' . $conn->error);
}
