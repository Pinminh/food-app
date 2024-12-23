<?php
require_once '../db_connnection.php';
session_start();
?>

<!doctype html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <title>Food Ordering</title>
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.1/css/dataTables.bootstrap5.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
</head>

<body>
    <div class="container">
        <a href="../restaurant" class="btn btn-warning float-end m-1">Nhà hàng</a>
        <a href="../product" class="btn btn-warning float-end m-1">Món ăn</a>
        
        <h1 class="my-3">Quản lý khách hàng</h1>
        <hr>

        <!-- Modal for submitting users -->
        <button class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#add">Thêm khách hàng</button>
        <div class="modal fade" id="add" tabindex="-1" role="dialog" aria-labelledby="add" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Thêm mới</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>

                    <form enctype="multipart/form-data" class="needs-validation" id="addForm" novalidate>
                        <div class="modal-body">
                            <div class="form-group">
                                <label>Tên đăng nhập</label>
                                <input class="form-control my-2" type="text" placeholder="Tên đăng nhập" name="tenDangNhap" required/>
                                <div class="invalid-feedback">Tên đăng nhập là bắt buộc</div>
                            </div>
                            <div class="form-group">
                                <label>Mật khẩu</label>
                                <input class="form-control my-2" type="password" placeholder="Mật khẩu" name="matKhau" required/>
                                <div class="invalid-feedback">Mật khẩu là bắt buộc</div>
                            </div>
                            <div class="form-group">
                                <label>Tên khách hàng</label>
                                <input class="form-control my-2" type="text" placeholder="Tên khách hàng" name="tenKhachHang" required/>
                                <div class="invalid-feedback">Tên khách hàng là bắt buộc</div>
                            </div>
                            <div class="form-group">
                                <label>Địa chỉ</label>
                                <input class="form-control my-2" placeholder="Địa chỉ" name="diaChi" required/>
                                <div class="invalid-feedback">Địa chỉ là bắt buộc</div>
                            </div>
                            <div class="form-group">
                                <label>Số điện thoại</label>
                                <input class="form-control my-2" type="number" placeholder="Số điện thoại" name="sdt" required/>
                                <div class="invalid-feedback">Số điện thoại là bắt buộc</div>
                            </div>
                            <div class="mb-3">
                                <label>Ảnh đại diện</label>
                                <input type="file" class="form-control my-2" name="fileToUpload" id="fileToUpload" required>
                                <div class="invalid-feedback">Anhr đại diện là bắt buộc</div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button class="btn btn-secondary" type="button" data-bs-dismiss="modal">Đóng lại</button>
                            <button class="btn btn-primary" type="submit">Thêm mới</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Modal for error -->
        <div class="modal fade" id="errorModal" tabindex="-1" role="dialog" aria-labelledby="errorModalLabel" aria-hidden="true" style="z-index: 2050;">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="errorModalLabel">Xảy ra lỗi</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <p id="errorMessage"></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
            </div>
            </div>
        </div>
        </div>

        <!-- Modal for success -->
        <div class="modal fade" id="successModal" tabindex="-1" role="dialog" aria-labelledby="successModalLabel" aria-hidden="true" style="z-index: 2050;">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="successModalLabel">Thành công</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <p id="successMessage" color="red"> <?php echo $success_message ?> </p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
            </div>
            </div>
        </div>
        </div>
        
        <!-- Modal for searching users whose point is greater than some limit -->
        <button class="btn btn-info mb-3" data-bs-toggle="modal" data-bs-target="#fun">Khách hàng có điểm cao hơn ...</button>
        <div class="modal fade" id="fun" tabindex="-1" role="dialog" aria-labelledby="fun" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Khách hàng có điểm cao hơn một số nhất định</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="fun.php" method="post" enctype="multipart/form-data">
                        <div class="modal-body">
                            <div class="form-group">
                                <label>Số điểm</label>
                                <input class="form-control my-2" type="number" placeholder="Số điểm" name="soDiem" />
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button class="btn btn-secondary" type="button" data-dismiss="modal">Đóng lại</button>
                            <button class="btn btn-primary" type="submit">Tìm kiếm</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- User table -->
        <table class="table table-striped mt-2" id="tab-user">
            <thead>
                <tr>
                    <th scope="col">Tên đăng nhập</th>
                    <th scope="col">Tên khách hàng</th>
                    <th scope="col">Địa chỉ</th>
                    <th scope="col">Số điện thoại</th>
                    <th scope="col">Ảnh đại diện</th>
                    <th scope="col">Điểm tích lũy</th>
                    <th scope="col"></th>
                </tr>
            </thead>
            <tbody>
                <?php

                $conn = OpenCon();
                $query = "CALL get_all_customers()";
                $result = $conn->query($query);

                if ($result->num_rows > 0) {
                    // OUTPUT DATA OF EACH ROW
                    while ($row = $result->fetch_assoc()) {
                ?>
                        <tr class="justify-content-center">
                            <th class='align-middle' scope="row"><?php echo $row['username'] ?></th>
                            <td class='align-middle'><?php echo $row['name'] ?></td>
                            <td class='align-middle'><?php echo $row['address'] ?></td>
                            <td class='align-middle'><?php echo $row['phone'] ?></td>
                            <td><img src='<?php echo $row['avatar'] ?>' class='border rounded-circle p-1' width='72' height='72'></td>
                            <td class='align-middle'><?php echo $row['points'] ?></td>
                            <td class='align-middle'>
                                <div class="d-inline-flex">
                                    <button type='button' class='btn-edit btn btn-primary m-1' data-bs-tenDangNhap='<?php echo $row['username'] ?>' data-bs-tenKhachHang='<?php echo $row['name'] ?>' data-bs-diaChi='<?php echo $row['address'] ?>' data-bs-sdt='<?php echo $row['phone'] ?>' data-bs-anhDaiDien='<?php echo $row['avatar'] ?>' data-bs-diemTichLuy='<?php echo $row['points'] ?>' data-bs-target='#Edit' data-bs-toggle='modal'>Edit</button>
                                    <button type='button' class='btn-delete btn btn-danger m-1' data-bs-tenDangNhap='<?php echo $row['username'] ?>' data-bs-target='#Delete' data-bs-toggle='modal'>Delete</button>
                                </div>
                            </td>
                        </tr>
                <?php
                    }
                }
                ?>

            </tbody>
        </table>

        <!-- Modal for editting users -->
        <div class="modal fade" id="Edit" tabindex="-1" role="dialog" aria-labelledby="Edit" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Chỉnh sửa</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form enctype="multipart/form-data" class="needs-validation" id="editForm" novalidate>
                        <div class="modal-body">
                            <div class="form-group">
                                <label>Tên đăng nhập</label>
                                <input class="form-control my-2" type="text" placeholder="Tên đăng nhập" name="tenDangNhap" readonly />
                            </div>
                            <div class="form-group">
                                <label>Tên khách hàng</label>
                                <input class="form-control my-2" type="text" placeholder="Tên khách hàng" name="tenKhachHang" required/>
                                <div class="invalid-feedback">Tên khách hàng là bắt buộc</div>
                            </div>
                            <div class="form-group">
                                <label>Địa chỉ</label>
                                <input class="form-control my-2" placeholder="Địa chỉ" name="diaChi" required/>
                                <div class="invalid-feedback">Địa chỉ là bắt buộc</div>
                            </div>
                            <div class="form-group">
                                <label>Số điện thoại</label>
                                <input class="form-control my-2" type="number" placeholder="Số điện thoại" name="sdt" required/>
                                <div class="invalid-feedback">Số điện thoại là bắt buộc</div>
                            </div>
                            <div class="form-group">
                                <label>Hình ảnh hiện tại</label>
                                <input class="form-control my-2" type="text" name="anhDaiDien" readonly />
                            </div>
                            <div class="form-group">
                                <label>Hình ảnh mới</label>
                                <input type="file" name="fileToUpload1" id="fileToUpload1" class="form-control my-2"/>
                            </div>
                            <div class="form-group">
                                <label>Điểm tích lũy</label>
                                <input class="form-control my-2" type="number" placeholder="Điểm tích lũy" name="diemTichLuy" required/>
                                <div class="invalid-feedback">Điểm tích lũy là bắt buộc</div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button class="btn btn-secondary" type="button" data-bs-dismiss="modal">Đóng lại</button>
                            <button class="btn btn-primary" type="submit">Cập nhật</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Modal for deleting users -->
        <div class="modal fade" id="Delete" tabindex="-1" role="dialog" aria-labelledby="Delete" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Xóa</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form id="deleteForm">
                        <div class="modal-body">
                            <input type="text" name="tenDangNhap" class="form-control my-2" readonly />
                            <p>Bạn chắc chưa?</p>
                        </div>
                        <div class="modal-footer">
                            <button class="btn btn-primary btn-outline-light" type="button" data-bs-dismiss="modal">Đóng lại</button>
                            <button class="btn btn-danger btn-outline-light" type="submit">Xác nhận</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.1/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.1/js/dataTables.bootstrap5.min.js"></script>
    <script src="index.js"></script>
    <script src="form_validate.js"></script>
    <script src="add_form_redirect.js"></script>
    <script src="delete_form_redirect.js"></script>
    <script src="edit_form_redirect.js"></script>
</body>

</html>