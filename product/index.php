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
        <a href="../user" class="btn btn-warning float-end m-1">Khách hàng</a>
        <a href="../restaurant" class="btn btn-warning float-end m-1">Nhà hàng</a>
        <h1 class="my-3">Quản lý món ăn</h1>
        <hr>

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
                <p id="successMessage"></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
            </div>
            </div>
        </div>
        </div>

        <!-- Modal for submitting food -->
        <button class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#add">Thêm món ăn mới</button>
        <div class="modal fade" id="add" tabindex="-1" role="dialog" aria-labelledby="add" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Thêm mới</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form enctype="multipart/form-data" class="needs-validation" id="addForm" novalidate>
                        <div class="modal-body">
                            <div class="form-group">
                                <label>Tên món ăn</label>
                                <input class="form-control my-2" type="text" placeholder="Tên món ăn" name="tenMonAn" required/>
                                <div class="invalid-feedback">Tên món ăn là bắt buộc</div>
                            </div>
                            <div class="form-group">
                                <label>Mã món ăn</label>
                                <input class="form-control my-2" type="text" placeholder="Mã món ăn" name="maMonAn" required/>
                                <div class="invalid-feedback">Mã món ăn là bắt buộc</div>
                            </div>
                            <div class="form-group">
                                <select class="form-select" name="maNhaHang">
                                    <option selected>Thuộc về nhà hàng</option>
                                    <?php
                                        $conn = OpenCon();
                                        $restaurant_query = 'CALL get_all_restaurants()';
                                        $restaurants = $conn->query($restaurant_query);

                                        if ( $restaurants->num_rows > 0) {
                                            while ($restaurant = $restaurants->fetch_assoc()) {
                                    ?>
                                                <option value="<?php echo $restaurant['username'] ?>">
                                                    <?php echo $restaurant['username'] . ' - ' . $restaurant['name'] ?>
                                                </option>
                                    <?php
                                            }
                                        }
                                    ?>
                                </select>
                                <div class="invalid-feedback">Nhà hàng là bắt buộc</div>
                            </div>
                            <div class="form-group">
                                <label>Mô tả món ăn</label>
                                <textarea class="form-control my-2" placeholder="Mô tả món ăn" name="moTaMonAn" style="height: 150px;"></textarea>
                            </div>
                            <div class="form-group">
                                <label>Giá niêm yết</label>
                                <input class="form-control my-2" type="number" placeholder="Giá niêm yết" name="giaNiemYet" required/>
                                <div class="invalid-feedback">Giá niêm yết là bắt buộc</div>
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

        <!-- Modal for categorize food by price -->
        <button class="btn btn-info mb-3" data-bs-toggle="modal" data-bs-target="#fun">Phân loại món ăn theo giá</button>
        <div class="modal fade" id="fun" tabindex="-1" role="dialog" aria-labelledby="fun" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Phân loại món ăn theo giá</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="fun.php" method="post" enctype="multipart/form-data">
                        <div class="modal-body">
                            <div class="form-group">
                                <label>Giá cần phân loại</label>
                                <input class="form-control my-2" type="number" placeholder="Giá cần phân loại" name="price" />
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button class="btn btn-secondary" type="button" data-bs-dismiss="modal">Đóng</button>
                            <button class="btn btn-primary" type="submit">Thực hiện</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Link for categorize food by price -->
        <a class="btn btn-success mb-3" href="fun1">Phân loại món ăn theo giá (tự động)</a>
        
        <table class="table table-striped mt-2" id="tab-product">
            <thead>
                <tr>
                    <th scope="col">Tên món ăn</th>
                    <th scope="col">Mã món ăn</th>
                    <th scope="col">Mô tả món ăn</th>
                    <th scope="col">Giá niêm yết</th>
                    <th scope="col"></th>
                </tr>
            </thead>
            <tbody>
                <?php

                $conn = OpenCon();
                $query = "CALL get_all_dishes()";
                $result = $conn->query($query);
                CloseCon($conn);

                if ($result->num_rows > 0) {
                    // OUTPUT DATA OF EACH ROW
                    while ($row = $result->fetch_assoc()) {
                ?>
                        <tr class="justify-content-center">
                            <th class='align-middle' scope="row"><?php echo $row['name'] ?></th>
                            <td class='align-middle'><?php echo $row['id'] ?></td>
                            <td class='align-middle'><?php echo $row['description'] ?></td>
                            <td class='align-middle'><?php echo $row['price'] ?></td>
                            <td class='align-middle'>
                                <div class="d-inline-flex">
                                    <a class="btn btn-secondary m-1" href="../view/view_detail/index.php?maMonAn=<?php echo $row['id'] ?>">Read</a>
                                    <button type='button' class='btn-edit btn btn-primary m-1' data-bs-tenMonAn='<?php echo $row['name'] ?>' data-bs-maMonAn='<?php echo $row['id'] ?>' data-bs-moTaMonan='<?php echo $row['description'] ?>' data-bs-giaNiemYet='<?php echo $row['price'] ?>' data-bs-target='#Edit' data-bs-toggle='modal'>Edit</button>
                                    <button type='button' class='btn-delete btn btn-danger m-1' data-bs-tenMonAn='<?php echo $row['name'] ?>' data-bs-maMonAn='<?php echo $row['id'] ?>' data-bs-target='#Delete' data-bs-toggle='modal'>Delete</button>
                                </div>
                            </td>
                        </tr>
                <?php
                    }
                }
                ?>

            </tbody>
        </table>
        
        <!-- Modal for editting food -->
        <div class="modal fade" id="Edit" tabindex="-1" role="dialog" aria-labelledby="Edit" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Chỉnh sửa</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form enctype="multipart/form-data" id="editForm" class="needs-validation" novalidate>
                        <div class="modal-body">
                            <div class="form-group">
                                <label>Tên món ăn</label>
                                <input class="form-control my-2" type="text" placeholder="Tên món ăn" name="tenMonAn" required/>
                                <div class="invalid-feedback">Tên món ăn là bắt buộc</div>
                            </div>
                            <div class="form-group">
                                <label>Mã món ăn</label>
                                <input class="form-control my-2" type="text" placeholder="Mã món ăn" name="maMonAn" readonly />
                            </div>
                            <div class="form-group">
                                <label>Mô tả món ăn</label>
                                <textarea class="form-control my-2" placeholder="Mô tả món ăn" name="moTaMonAn" style="height: 150px;"></textarea>
                            </div>
                            <div class="form-group">
                                <label>Giá niêm yết</label>
                                <input class="form-control my-2" type="number" placeholder="Giá niêm yết" name="giaNiemYet" required/>
                                <div class="invalid-feedback">Giá niêm yết là bắt buộc</div>
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
        
        <!-- Modal for deleting food -->
        <div class="modal fade" id="Delete" tabindex="-1" role="dialog" aria-labelledby="Delete" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Xóa</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form id="deleteForm">
                        <div class="modal-body">
                            <input type="text" name="tenMonAn" class="form-control my-2" readonly />
                            <input type="text" name="maMonAn" class="form-control my-2" readonly />
                            <p>Bạn chắc muốn xóa món ăn này?</p>
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