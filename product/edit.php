<?php

error_reporting(E_ALL);
ini_set('display_errors', 1);
header('Content-Type: application/json');

require_once('../db_connnection.php');

$tenMonAn = filter_input(INPUT_POST,'tenMonAn', FILTER_SANITIZE_SPECIAL_CHARS);
$maMonAn = filter_input(INPUT_POST,'maMonAn', FILTER_SANITIZE_SPECIAL_CHARS);
// $maMonAn = htmlspecialchars($_POST['maMonAn'] ?? '');
$moTaMonAn = filter_input(INPUT_POST,'moTaMonAn', FILTER_SANITIZE_SPECIAL_CHARS);
$giaNiemYet = filter_input(INPUT_POST,'giaNiemYet', FILTER_SANITIZE_SPECIAL_CHARS);

if (empty($tenMonAn) || empty($maMonAn) || empty($giaNiemYet)) {
    echo json_encode(['missing' => true]);
    exit();
}

$conn = OpenCon();
$query = "CALL update_dish('$tenMonAn', '$maMonAn', '$moTaMonAn', '$giaNiemYet');";

try {
    if ($conn->query($query) === TRUE) {
        echo json_encode(['success' => 'Sửa đổi món ăn thành công']);
    } else {
        echo json_encode(['error' => "Lỗi kết nối cơ sở dữ liệu: {$conn->error}"]);
    }
} catch (Exception $e) {
    echo json_encode(['error' => "Lỗi cơ sở dữ liệu: {$e->getMessage()}"]);
}