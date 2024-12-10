<?php

error_reporting(E_ALL);
ini_set('display_errors', 1);
header('Content-Type: application/json');

require_once('../db_connnection.php');

$maMonAn = filter_input(INPUT_POST,'maMonAn', FILTER_SANITIZE_SPECIAL_CHARS);

$conn = OpenCon();
$query = "CALL Delete_mon_an('$maMonAn')";

try {
    if ($conn->query($query) === TRUE) {
        echo json_encode(['success' => 'Xóa món ăn thành công']);
    } else {
        echo json_encode(['error' => "Lỗi kết nối cơ sở dữ liệu: {$conn->error}"]);
    }
} catch (Exception $e) {
    echo json_encode(['error' => "Lỗi cơ sở dữ liệu: {$e->getMessage()} with maMonAn={$maMonAn}"]);
}
