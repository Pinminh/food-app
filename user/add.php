<?php

error_reporting(E_ALL);
ini_set('display_errors', 1);
header('Content-Type: application/json');

require_once '../config/image.php';
require_once '../db_connnection.php';

$tenDangNhap = htmlspecialchars($_POST['tenDangNhap'] ?? '');
$matKhau = htmlspecialchars($_POST['matKhau'] ??'');
$tenKhachHang = htmlspecialchars($_POST['tenKhachHang'] ?? '');
$diaChi = htmlspecialchars($_POST['diaChi'] ?? '');
$sdt = htmlspecialchars($_POST['sdt'] ?? '');
$diemTichLuy = 0;

$path = $_FILES['fileToUpload']['name'] ?? null;

if (empty($tenDangNhap) || empty($matKhau) || empty($tenKhachHang) || empty($diaChi) || empty($sdt) || empty($path)) {
    echo json_encode(['missing' => true]);
    exit();
}

$ext = pathinfo($path ?? '', PATHINFO_EXTENSION);
$id = (string)date("Y_m_d_h_i_sa");
$fileuploadname = (string)$id;
$fileuploadname .= ".";
$fileuploadname .= $ext;
$target_file = TARGET_DIR . basename($fileuploadname);

if (file_exists($target_file)) {
    echo json_encode(['error' => 'Ảnh bị trùng tên']);
    exit();
}

// Allow certain file formats
$fileType = strtolower(pathinfo($target_file ?? '', PATHINFO_EXTENSION));
if (!in_array($fileType, ALLOWED_EXTS)) {
    echo json_encode(['error' => 'Chỉ chấp nhận ảnh định dạng jpg, png, jpeg, gif']);
    exit();
}

if ($_FILES['fileToUpload']['size'] > IMG_MAX_SIZE) {
    echo json_encode(['error' => 'Kích thước ảnh quá lớn']);
    exit();
}

move_uploaded_file($_FILES["fileToUpload"]["tmp_name"], $target_file);

$conn = OpenCon();
$query1 = "CALL Add_tai_khoan('$tenDangNhap', '$matKhau');";
$query2 = "CALL Add_khach_hang('$tenDangNhap', '$tenKhachHang', '$diaChi', '$sdt', '$target_file', '$diemTichLuy');";

try {
    if ($conn->query($query1) === TRUE && $conn->query($query2) === TRUE) {
        echo json_encode(['success' => 'Thêm khách hàng thành công']);
    } else {
        echo json_encode(['error' => "Lỗi kết nối cơ sở dữ liệu: {$conn->error}"]);
    }
} catch (Exception $e) {
    echo json_encode(['error' => "Lỗi cơ sở dữ liệu: {$e->getMessage()}"]);
}