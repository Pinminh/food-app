<?php

header('Content-Type: application/json');

require_once '../db_connnection.php';

$tenDangNhap = htmlspecialchars($_POST['tenDangNhap'] ?? '');

$conn = OpenCon();
$query = "CALL Delete_khach_hang('$tenDangNhap')";

try {
    if ($conn->query($query) === TRUE) {
        echo json_encode(['success' => 'Xóa khách hàng thành công']);
    } else {
        echo json_encode(['error' => "Lỗi kết nối cơ sở dữ liệu: {$conn->error}"]);
    }
} catch (Exception $e) {
    echo json_encode(['error' => "Lỗi cơ sở dữ liệu: {$e->getMessage()}"]);
}