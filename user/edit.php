<?php

error_reporting(E_ALL);
ini_set('display_errors', 1);
header('Content-Type: application/json');

require_once '../config/image.php';
require_once '../db_connnection.php';

$tenDangNhap = htmlspecialchars($_POST['tenDangNhap'] ?? '');
$tenKhachHang = htmlspecialchars($_POST['tenKhachHang'] ?? '');
$diaChi = htmlspecialchars($_POST['diaChi'] ?? '');
$sdt = htmlspecialchars($_POST['sdt'] ?? '');
$diemTichLuy = htmlspecialchars($_POST['diemTichLuy'] ?? '');
$anhDaiDien = htmlspecialchars($_POST['anhDaiDien'] ?? '');
$path = $_FILES['fileToUpload1']['name'] ?? '';

if (empty($tenDangNhap) || empty($tenKhachHang) || empty($diaChi) || empty($sdt)) {
    echo json_encode(['missing' => true]);
    exit();
}

$target_file = $anhDaiDien;

if ($path) {
    // if (file_exists($target_file)) {
    //     echo json_encode(['error' => 'Ảnh bị trùng tên']);
    //     exit();
    // }

    $ext = pathinfo($path, PATHINFO_EXTENSION);
    $id = (string)date("Y_m_d_h_i_sa");
    $fileuploadname = (string)$id;
    $fileuploadname .= ".";
    $fileuploadname .= $ext;
    $target_file = TARGET_DIR . basename($fileuploadname);

    $fileType = strtolower(pathinfo($target_file, PATHINFO_EXTENSION));
    // Allow certain file formats
    if (!in_array(strtolower($fileType), ALLOWED_EXTS)) {
        $upload_ok = 0;
        $target_file = $anhDaiDien;
        echo json_encode(['error' => 'Chỉ chấp nhận ảnh định dạng jpg, png, jpeg, gif']);
        exit();
    }

    if ($_FILES["fileToUpload1"]["size"] > IMG_MAX_SIZE) {
        echo json_encode(['error' => 'Kích thước ảnh quá lớn']);
        exit();
    }

    move_uploaded_file($_FILES["fileToUpload1"]["tmp_name"], $target_file);
}

$conn = OpenCon();
$query = "CALL Update_khach_hang('$tenDangNhap', '$tenKhachHang', '$diaChi', '$sdt', '$target_file', '$diemTichLuy');";

try {
    if ($conn->query($query) === TRUE) {
        echo json_encode(['success' => 'Sửa đổi khách hàng thành công']);
    } else {
        echo json_encode(['error' => "Lỗi kết nối cơ sở dữ liệu: {$conn->error}"]);
    }
} catch (Exception $e) {
    echo json_encode(['error' => "Lỗi cơ sở dữ liệu: {$e->getMessage()}"]);
}