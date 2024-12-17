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
        <a href="../../product/" class="btn btn-warning float-end m-1">Sản phẩm</a>
        <a href="../../user" class="btn btn-warning float-end m-1">Khách hàng</a>
        <h1 class="my-3">Quản lý món ăn</h1>
        <hr>
        <h4 class="text-primary my-4">Danh sách số lượng mỗi nhóm món ăn có giá lớn hơn <?php echo $_GET['price'] ?></h4>
        <table class="table table-striped mt-2" id="tab-product">
            <thead>
                <tr>
                    <th scope="col">Tên nhóm món ăn</th>
                    <th scope="col">Số lượng</th>
                </tr>
            </thead>
            <tbody>
                <?php
                require_once '../../db_connnection.php';

                $conn = OpenCon();
                $price = $_GET['price'];
                $query = "CALL count_dish_per_group_by_price($price);";

                $result = $conn->query($query);

                if ($result->num_rows > 0) {
                    // OUTPUT DATA OF EACH ROW
                    while ($row = $result->fetch_assoc()) {
                ?>
                        <tr class="justify-content-center">
                            <th class='align-middle' scope="row"><?php echo $row['name'] ?></th>
                            <td class='align-middle'><?php echo $row['amount'] ?></td>
                        </tr>
                <?php
                    }
                }
                ?>

            </tbody>
        </table>
    </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.1/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.1/js/dataTables.bootstrap5.min.js"></script>
    <script src="index.js"></script>
</body>

</html>