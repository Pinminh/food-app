-- Delivery Companies
INSERT INTO `delivery_company` (`id`, `name`) VALUES
    ('DC001', 'Giao hàng nhanh'),
    ('DC002', 'Giao hàng tiết kiệm'),
    ('DC003', 'Grab'),
    ('DC004', 'Viettel Post'),
    ('DC005', 'GoViet');

-- Customers
INSERT INTO `customer` (`username`, `password`, `name`, `address`, `phone`, `avatar`, `points`) VALUES
    ('customer1', '12345678', 'Nguyen Van A', '123 Le Loi, District 1, HCM', '0901234567', 'img/2022_12_07_06_59_24am.png', 500),
    ('customer2', '12345678', 'Tran Thi B', '456 Nguyen Hue, District 1, HCM', '0902345678', 'img/2022_12_07_06_44_02am.png', 300),
    ('customer3', '12345678', 'Le Hoang C', '789 Ly Tu Trong, District 1, HCM', '0903456789', 'img/2022_12_07_06_45_03am.png', 100),
    ('customer4', '12345678', 'Pham Van D', '321 Nam Ky Khoi Nghia, District 3, HCM', '0904567890', 'img/2022_12_08_06_33_13pm.png', 250),
    ('customer5', '12345678', 'Nguyen Thi E', '654 Vo Van Tan, District 3, HCM', '0905678901', 'img/2022_12_08_06_32_22pm.png', 150);

-- Recipients
INSERT INTO `recipient` (`phone`, `name`, `customer`) VALUES
    ('0901234567', 'Nguyen Van A', 'customer1'),
    ('0902345678', 'Tran Thi B', 'customer2'),
    ('0903456789', 'Le Hoang C', 'customer3'),
    ('0904567890', 'Pham Van D', 'customer4'),
    ('0905678901', 'Nguyen Thi E', 'customer5');

-- Insert Dish Groups
INSERT INTO `dish_group` (`id`, `name`, `description`) VALUES
    ('DG001', 'Gỏi', 'Món ăn bằng cá, tôm, thịt trộn với rau thơm sống và giấm. Tuy nhiên cũng có thể có các biến thế khác'),
    ('DG002', 'Mì', 'Món ăn dạng sợi dài, được dùng kèm với nước sốt hoặc nước dùng. Thường có nguồn gốc nước ngoài.'),
    ('DG003', 'Cơm', 'Món ăn làm từ gạo, được phục vụ kèm với các món khác. Là món truyền thống của các nước châu Á'),
    ('DG004', 'Súp', 'Món ăn dạng lỏng, gồm nước súp nền (có thể đặc hoặc loãng) và các thành phần đi kèm.'),
    ('DG005', 'Bún', 'Món ăn dạng sợi dài làm từ gạo, phục vụ kèm nước dùng. Là món truyền thống của Việt Nam.'),
    ('DG006', 'Bánh', 'Món ăn gồm bột bánh được làm chín và các thành phần khác. Có nhiều dạng bánh khác nhau với cách chế ');

-- Insert additional restaurants with Vietnamese descriptions
INSERT INTO `restaurant` (`username`, `password`, `name`, `address`, `phone`, `avatar`, `description`) VALUES
    ('restaurant1', 'password1', 'Quán cháo lòng bà Út', '193 Cô Giang, Quận 1, HCM', '0901111111', 'https://wallpapercave.com/wp/wp1874173.jpg', 'Hơn 80 năm nay, gánh cháo lòng Cô Út trên đường Cô Giang – quận 1, là địa chỉ quen thuộc của thực khách ở Sài Gòn. Với hương vị đậm đà, vừa vặn mà ai ăn cũng khen nức nở món cháo của bà. Đây là một trong các quán ăn ngon Sài Gòn mà bạn nên thưởng thức ít nhất một lần khi du lịch đến đây.'),
    ('restaurant2', 'password2', 'Bánh xèo', '46A Đinh Công Tráng, Phường Tân Định, Quận 1', '0902222222', 'https://th.bing.com/th/id/OIF.MtFAdAkBEFwLgjgoxmrguw?rs=1&pid=ImgDetMain', 'Nếu bạn muốn thưởng thức được món bánh xèo đúng hương vị thì quán bánh xèo này là một trong những các quán ăn ngon Sài Gòn ngon nức tiếng từ lâu. Bánh xèo theo kiểu miền Nam có vỏ rất giòn, bên trong phần nhân khá nhiều tôm thịt, tôm mềm nên khi cuốn rất tiện lợi.'),
    ('restaurant3', 'password3', 'Quán bánh mì Hòa Mã', '53 Cao Thắng, Quận 3', '0903333333', 'https://th.bing.com/th/id/OIP.A1UsHsfTFh4th4fMpoxllQHaFc?rs=1&pid=ImgDetMain', 'Bạn sẽ không khó để tìm đến tiệm bánh mì nhỏ mang tên Hòa Mã nằm trên đường Cao Thắng, quận 3. Theo lời kể lại của nhiều người thì đây là một trong những nơi bán bánh mì thịt đầu tiên ở Sài Gòn. Chủ nhân của nó là hai vợ chồng người Bắc di cư vào Nam từ trước những năm 50. Một ổ bánh mì thơm ngon phải kể đến là phần thập cẩm được chiên trong chiếc chảo nhỏ. Bên trong chảo là đủ thứ nguyên liệu hấp dẫn như trứng gà ốp la, thịt nguội, xúc xích, chả cá, chả lụa… Tất cả đều được chiên nóng cháy cạnh, tỉ mỉ cùng với ít hành tây và dùng nóng với bánh mì. Đây là một trong các quán ăn ngon Sài Gòn mà du khách nào cũng yêu thích khi tới Sài Gòn.'),
    ('restaurant4', 'password4', 'Phở Lệ', '413 – 415 Nguyễn Trãi, Phường 7, Quận 5', '0904444444', 'https://th.bing.com/th/id/OIP.b3hm6VohCSRL24qCkfGZLgHaE8?rs=1&pid=ImgDetMain', 'Có từ năm 1970 quán phở Lệ là một quán ăn ngon Sài Gòn mà du khách nên tới thưởng thức. Nước lèo của quán có vị ngọt từ xương cùng bò viên vừa vặn giúp cho món ăn này thu hút được nhiều du khách. Bạn sẽ cảm nhận được từng miếng bò viên cỡ lớn được cắt nhỏ vừa ăn, hơi giòn và có mỡ nên mềm mại chứ không khô. Tô phở được trang trí rất đẹp nhờ vài lát hành tây, hành lá tươi, nhìn giống phở Hà Nội một thời.'),
    ('restaurant5', 'password5', 'Dimsum Tiến Phát', '18 Ký Hòa, Phường 11, Quận 5', '0905555555', 'https://th.bing.com/th/id/OIP.3F-ngBnVE6kPUIepcnTgjwAAAA?rs=1&pid=ImgDetMain','Tiến Phát là thương hiệu dimsum danh tiếng của người Hoa khu Chợ Lớn. Không gian tuy không gọi là quá sang trọng như những nhà hàng dimsum khác nhưng lại tạo cho thực khách cảm giác quen thuộc, cứ như mỗi lần xem phim Hồng Kông vậy.'),
    ('restaurant6', 'password6', 'Bánh đúc Phan Đăng Lưu', '116/11 Phan Đăng Lưu, Quận Phú Nhuận', 'https://wallpapercave.com/wp/wp1874173.jpg', '0906666666', 'Nổi tiếng về độ lâu đời và hương vị món ăn này ở Sài Gòn thì phải kể đến hàng bánh đúc Phan Đăng Lưu. Bánh ở đây hấp dẫn ở độ dẻo dai của bột, thịt nấm đủ đầy và nêm nếm vừa miệng. Hòa quyện thêm chút bùi bùi, thơm thơm cho bánh còn có đậu xanh nấu nhuyễn. Đảm bảo bạn sẽ "ghiền" món ăn này đó.'),
    ('restaurant7', 'password7', 'Lẩu cá Dân Ích', '99 Châu Văn Liêm, Phường 14, Quận 5', '0907777777', 'https://th.bing.com/th/id/OIF.MtFAdAkBEFwLgjgoxmrguw?rs=1&pid=ImgDetMain', 'Nằm ở 1 góc đường Châu Văn Liêm, quán lẩu cá Dân Ích đã tồn tại và phát triển đến nay cũng đã hơn 40 năm tại Sài Gòn. Nơi đây lấy lòng được thực khách nhờ những món ăn đậm vị Trung Hoa như lẩu cá cù lao. Nước lẩu ở đây ngọt thanh từ xương hầm chứ không phải từ bọt ngọt đâu nhé. Nồi lẩu gồm có cá, tôm, chả cá, da heo, nấm… Rau và bún gạo, mì ăn kèm, đặc biệt ở đây có thêm bánh quẩy ăn với lẩu, khá lạ miệng nhưng siêu ngon.'),
    ('restaurant8', 'password8', 'Bún măng vịt', 'Hẻm 281 Lê Văn Sỹ, Phường 1, Quận Tân Bình', '0908888888', 'https://th.bing.com/th?id=OIF.%2b6HrHGnkmraFdpThtde90Q&rs=1&pid=ImgDetMain', 'Giữa Sài Gòn bao la quán xá thế này để tìm được một quán bún măng gỏi vịt ngon là cả một vấn đề. Quán nằm sâu trong con hẻm đường Lê Văn Sỹ, quận Tân Bình. Vậy mà quán bún vịt này bán gần 50 năm nổi tiếng chỉ bán trong vòng 1 tiếng là hết sạch. Đĩa gỏi đấy ắp toàn thịt là thịt, vịt ít mỡ da mỏng, chắc thịt và mềm. Tô bún măng rất thơm và đậm đà, măng ngon sần sật thêm chén nước chấm chỉ cần pha chút sa tế thì quá là tuyệt vời rồi. Note liền quán ăn ngon Sài Gòn này nhé.');

-- Insert restaurant images to match the new restaurants
INSERT INTO `restaurant_image` (`restaurant`, `image`) VALUES
    ('restaurant1', 'https://cdn3.ivivu.com/2019/06/an-sap-top-20-quan-an-ngon-sai-gon-b%E1%BA%A1n-nhat-dinh-phai-thu-ivi'),
    ('restaurant2', 'https://cdn3.ivivu.com/2019/06/an-sap-top-20-quan-an-ngon-sai-gon-b%E1%BA%A1n-nhat-dinh-phai-thu-ivi'),
    ('restaurant3', 'https://cdn3.ivivu.com/2019/06/an-sap-top-20-quan-an-ngon-sai-gon-b%E1%BA%A1n-nhat-dinh-phai-thu-ivi'),
    ('restaurant4', 'https://cdn3.ivivu.com/2019/06/an-sap-top-20-quan-an-ngon-sai-gon-b%E1%BA%A1n-nhat-dinh-phai-thu-ivi'),
    ('restaurant5', 'https://cdn3.ivivu.com/2019/06/an-sap-top-20-quan-an-ngon-sai-gon-b%E1%BA%A1n-nhat-dinh-phai-thu-ivi'),
    ('restaurant6', 'https://cdn3.ivivu.com/2019/06/an-sap-top-20-quan-an-ngon-sai-gon-b%E1%BA%A1n-nhat-dinh-phai-thu-ivi'),
    ('restaurant7', 'https://cdn3.ivivu.com/2019/06/an-sap-top-20-quan-an-ngon-sai-gon-b%E1%BA%A1n-nhat-dinh-phai-thu-ivi'),
    ('restaurant8', 'https://cdn3.ivivu.com/2019/06/an-sap-top-20-quan-an-ngon-sai-gon-b%E1%BA%A1n-nhat-dinh-phai-thu-ivi');

-- Add some dishes for these new restaurants
INSERT INTO `dish` (`id`, `name`, `price`, `restaurant`, `description`) VALUES
    ('DH001', 'Gỏi củ hủ dừa', 200000, 'restaurant1', 'Món gỏi củ hủ dừa tôm thịt là món ăn đặc sản của người miền Tây, thường được dùng làm món khai vị.'),
    ('DH002', 'Gỏi ngó sen tôm thịt', 100000, 'restaurant2', 'Gỏi ngó sen tôm thịt là món gỏi phổ biến trong các bữa tiệc, với hương vị thanh ngọt của tôm, thịt.'),
    ('DH003', 'Gỏi bò mè bóp thầu', 76000, 'restaurant1', 'Gỏi bò mè bóp thầu'),
    ('DH004', 'Gỏi bưởi tôm mực', 54000, 'restaurant2', 'Gỏi bưởi tôm mực với hương vị chua ngọt giúp bữa ăn thêm hương vị'),
    ('DH005', 'Mì ý sốt kem paris', 106000, 'restaurant3', 'Mì Ý sốt kem là một món ăn mang đậm phong vị Châu Âu. Sợi mì dai dai, chín tới, không bị nhũn, nát.'),
    ('DH006', 'Mì vịt tiềm', 83000, 'restaurant4', 'Mì vịt tiềm là món ăn ngon nổi tiếng của người Hoa và có giá trị dinh dưỡng cao, vì thịt vịt có vị n'),
    ('DH007', 'Mì cay', 76000, 'restaurant5', 'Với vị cay nồng kết hợp với hải sản tươi ngon, mì cay 7 cấp độ siêu ngon, kích thích vị giác.'),
    ('DH008', 'Ramen', 89000, 'restaurant6', 'Món ăn này là sự hòa quyện hoàn hảo giữa hương vị sợi vì độc đáo, nước súp thơm ngon đi kèm với các.'),
    ('DH009', 'Mì lạnh', 81000, 'restaurant7', 'Mì lạnh Hàn Quốc là món nổi tiếng và được sử dụng phổ biến của xứ sở kim chi đặc biệt vào dịp hè.'),
    ('DH010', 'Cơm gà Hong Kong', 70000, 'restaurant1', 'Món ăn nguồn gốc từ Hong Kong, Trung Quốc, với hương vị đậm đà đặc trưng của món Hoa'),
    ('DH011', 'Cơm gà Hải Nam', 70000, 'restaurant2', 'Món ăn nguồn gốc từ Hải Nam, Trung Quốc, với hương vị đậm đà đặc trưng của món Hoa'),
    ('DH012', 'Cơm sườn bì chả', 54000, 'restaurant3', 'Món cơm tấm bình dân quen thuộc của người Việt Nam'),
    ('DH013', 'Cơm rang kim chi', 58000, 'restaurant4', 'Món ăn kết hợp giữa cơm rang quen thuộc và kim chi, tạo nên sự kết hợp lạ mà quen.'),
    ('DH014', 'Cơm bò xào nấm', 100000, 'restaurant5', 'Sự kết hợp cân bằng và hoàn hảo cho một bữa ăn đầy đủ dinh dưỡng'),
    ('DH015', 'Súp hạt tiêu', 116000, 'restaurant6', 'Món súp được rất nhiều người yêu thích, với hương vị đặc trưng của hạt tiêu, kết hợp hoàn hảo với bá'),
    ('DH016', 'Súp phô mai', 95000, 'restaurant7', 'Món súp khoai tây phô mai là món súp rất được ưa chuộng là sự kết hợp giữa các nguyên liệu: khoai tâ'),
    ('DH017', 'Súp lơ', 60000, 'restaurant8', 'Món ăn đơn giản, nhưng vẫn thơm ngon và giàu dinh dưỡng'),
    ('DH018', 'Súp Lasagna', 50000, 'restaurant1', 'Tất cả mọi thứ đều được nấu trong một chảo – thêm các nguyên liệu vào khi bạn chế biến cho đến khi b'),
    ('DH019', 'Bào ngư vi cá', 1234, 'restaurant2', 'Món ăn đặc biệt bổ dưỡng với những nguyên liệu cao cấp, thích hợp để bồi bổ cho người ốm, phũ nữ đan'),
    ('DH020', 'Bún chả Hà Nội', 69000, 'restaurant3', 'Món ăn truyền thống của Hà Nội, được thực khách cả trong và ngoài nước ưa thích với chả nướng thơm p'),
    ('DH021', 'Bún thang', 75000, 'restaurant4', 'Bún thang là một món nước mang đậm hương vị của người Hà Nội. Món ăn nổi tiếng bởi sự cầu kỳ nhưng t'),
    ('DH022', 'Bún mọc', 74000, 'restaurant5', 'Với hương vị hấp dẫn từ những viên mọc hòa quyện cùng nước dùng đậm đà từ xương, bún mọc là món ăn đ'),
    ('DH023', 'Bún riêu cua', 120000, 'restaurant6', 'Món ăn bình dân nhưng không kém phần hấp dẫn với nước dùng ngọt vị, riêu cua thơm ngon'),
    ('DH024', 'Bún tôm Hải Phòng', 91000, 'restaurant7', 'Bún tôm là một món ăn đặc sản Hải Phòng thơm ngon, hấp dẫn nổi tiếng của người dân nơi đây với hương'),
    ('DH025', 'Bún đậu mắm tôm', 79000, 'restaurant8', 'Một mẹt bún đậu mắm tôm với đầy đủ các nguyên liệu hấp dẫn, sạch sẽ chắc hẳn là món ngon mà bất cứ a'),
    ('DH026', 'Bún bò Huế', 83000, 'restaurant1', 'Bún bò là một trong những đặc sản của xứ Huế, mặc dù món bún này phổ biến trên cả ba miền ở Việt Nam'),
    ('DH027', 'Bánh xèo', 51000, 'restaurant2', 'Bánh xèo gồm bột bên ngoài, bên trong có nhân là tôm, thịt, giá đỗ, kim chi, khoai tây, hẹ, tôm, thị'),
    ('DH028', 'Bánh đúc Hà Nội', 89000, 'restaurant3', 'Chỉ với những nguyên liệu cơ bản như mộc nhĩ, rau thơm, thịt xào hành tây, bánh đúc đã mang một hư'),
    ('DH029', 'Bánh mì chảo', 65000, 'restaurant4', 'Một phần bánh mì chảo gồm thịt bò bít tết, trứng ốp la, vài lát hành tây, được rưới nước sốt trên ch'),
    ('DH030', 'Bánh mì gà', 107000, 'restaurant5', 'Bánh mì gà không quá dài theo kiểu bánh mì Pháp thường thấy, cũng không dài như bánh mì truyền thống'),
    ('DH031', 'Pizza', 120000, 'restaurant6', 'Món ăn phổ biến và được ưa thính trên toàn thế giới, nguồn gốc từ Ý'),
    ('DH032', 'Bánh cuốn nóng', 52000, 'restaurant7', 'Món ăn đơn giản nhưng vẫn có dấu ấn riêng với thịt xay lẫn trong bánh, nước chấm đậm đà'),
    ('DH033', 'Bánh ướt', 70000, 'restaurant8', 'Món ăn đơn giản đổi vị cho ngày chán cơm');

INSERT INTO `dish_image` (`dish`, `image`) VALUES
    ('DH001', 'https://cdn.tgdd.vn/Files/2022/04/04/1423782/goi-y-8-mon-nguoi-khai-vi-cho-nhung-buoi-tiec-hoi-hop-voi-gia-dinh-202204040912057499.jpg'),
    ('DH002', 'https://cdn.tgdd.vn/Files/2022/04/04/1423782/goi-y-8-mon-nguoi-khai-vi-cho-nhung-buoi-tiec-hoi-hop-voi-gia-dinh-202204040914134517.jpg'),
    ('DH003', 'https://cdn.tgdd.vn/Files/2022/04/04/1423782/goi-y-8-mon-nguoi-khai-vi-cho-nhung-buoi-tiec-hoi-hop-voi-gia-dinh-202204040914556821.jpg'),
    ('DH004', 'https://cdn.tgdd.vn/Files/2022/04/04/1423782/goi-y-8-mon-nguoi-khai-vi-cho-nhung-buoi-tiec-hoi-hop-voi-gia-dinh-202204040921553201.jpg'),
    ('DH005', 'https://vn-live-05.slatic.net/p/90ceda8d45ffefa0cb930c64e18cfbe4.jpg_525x525q80.jpg'),
    ('DH006', 'https://cdn.tgdd.vn/Files/2018/06/13/1095115/cach-nau-mi-vit-tiem-ngon-ngat-ngay-khong-khac-gi-ngoai-hang-11-760x367.jpg'),
    ('DH007', 'https://cdn.daotaobeptruong.vn/wp-content/uploads/2021/01/mi-cay.jpg'),
    ('DH008', 'https://cdn.baogiaothong.vn/upload/1-2022/images/2022-03-31/ramen-696x502-1648704627-794-width640height461.jpg'),
    ('DH009', 'https://vnn-imgs-f.vgcloud.vn/2019/02/26/16/thuong-thuc-mi-lanh-banh-phu-rau-xanh-trieu-tien-giua-long-ha-noi.jpg'),
    ('DH010', 'https://bazantravel.com/cdn/medias/uploads/74/74113-com-ga-da-nang-700x700.jpg'),
    ('DH011', 'https://img-global.cpcdn.com/recipes/0656ee1233846265/680x482cq70/c%C6%A1m-ga-lu%E1%BB%99c-recipe-main-photo.jpg'),
    ('DH012', 'https://cdn.daynauan.info.vn/wp-content/uploads/2015/06/com-tam-suon-bi-cha.jpg'),
    ('DH015', 'https://danviet.mediacdn.vn/upload/3-2018/images/2018-07-09/Nhung-mon-sup-vua-dep-vua-ngon-lai-lam-cuc-nhanh-1-1531106719-width1024height1024.jpg'),
    ('DH016', 'https://danviet.mediacdn.vn/upload/3-2018/images/2018-07-09/Nhung-mon-sup-vua-dep-vua-ngon-lai-lam-cuc-nhanh-2-1531106738-width1024height1024.jpg'),
    ('DH017', 'https://danviet.mediacdn.vn/upload/3-2018/images/2018-07-09/Nhung-mon-sup-vua-dep-vua-ngon-lai-lam-cuc-nhanh-4-1531106770-width1024height1024.jpg'),
    ('DH018', 'https://danviet.mediacdn.vn/upload/3-2018/images/2018-07-09/Nhung-mon-sup-vua-dep-vua-ngon-lai-lam-cuc-nhanh-8-1531106839-width1024height1024.jpg'),
    ('DH019', 'https://thuongdinhyen.com/uploads/images/anh-san-pham/soup-bao-ngu1.jpg'),
    ('DH020', 'https://img-global.cpcdn.com/recipes/dcc8bd30ae5bc440/680x482cq70/bun-ch%E1%BA%A3-ha-n%E1%BB%99i-recipe-main-photo.jpg'),
    ('DH021', 'https://cdn.daynauan.info.vn/wp-content/uploads/2018/08/bun-thang.jpg'),
    ('DH022', 'https://luhanhvietnam.com.vn/du-lich/vnt_upload/news/11_2020/bun-moc-thanh-dam-de-an.jpg'),
    ('DH023', 'https://cdn.tgdd.vn/2020/08/CookProduct/Untitled-1-1200x676-10.jpg'),
    ('DH024', 'https://luhanhvietnam.com.vn/du-lich/vnt_upload/news/11_2020/hai-phong-co-mon-bun-tom.jpg'),
    ('DH025', 'https://luhanhvietnam.com.vn/du-lich/vnt_upload/news/11_2020/bun-dau-mam-tom-la-mon-dan-da.jpg'),
    ('DH026', 'https://cdn.tgdd.vn/Files/2018/04/01/1078873/nau-bun-bo-hue-cuc-de-tai-nha-tu-vien-gia-vi-co-san-202109161718049940.jpg'),
    ('DH027', 'https://cdn.daotaobeptruong.vn/wp-content/uploads/2020/01/banh-xeo-mien-tay.jpg'),
    ('DH028', 'https://cdn.tgdd.vn/Files/2021/08/03/1372652/cach-lam-banh-duc-nong-ngon-khong-dung-voi-va-han-the-202206021309198116.jpeg'),
    ('DH029', 'https://cdn.tgdd.vn/2021/12/CookRecipe/Avatar/banh-mi-chao-thap-cam-thumbnail.jpg'),
    ('DH030', 'https://saigonangi.com/wp-content/uploads/2020/10/77-1.png'),
    ('DH031', 'https://cdn.huongnghiepaau.com/wp-content/uploads/2017/07/cach-lam-banh-pizza-bang-chao.jpg'),
    ('DH032', 'https://cdn.tgdd.vn/2021/08/CookRecipe/Avatar/banh-cuon-nong-thit-bam-thumbnail.jpg'),
    ('DH033', 'https://bizweb.dktcdn.net/100/442/328/products/banh-uot-cha.jpg?v=1644836447513'),
    ('DH013', 'https://cdn.huongnghiepaau.com/wp-content/uploads/2019/01/com-rang-kim-chi.jpg'),
    ('DH014', 'https://yt.cdnxbvn.com/medias/uploads/209/209926-nam-xao-thit-bo.jpg');

-- Update dish groups to match dish categories
INSERT INTO `dish_dish_group` (`dish`, `dish_group`) VALUES
    ('DH001', 'DG001'), -- Gỏi
    ('DH002', 'DG001'),
    ('DH003', 'DG001'),
    ('DH004', 'DG001'),
    ('DH005', 'DG002'), -- Mì
    ('DH006', 'DG002'),
    ('DH007', 'DG002'),
    ('DH008', 'DG002'),
    ('DH009', 'DG002'),
    ('DH010', 'DG003'), -- Cơm
    ('DH011', 'DG003'),
    ('DH012', 'DG003'),
    ('DH013', 'DG003'),
    ('DH014', 'DG003'),
    ('DH015', 'DG004'), -- Súp
    ('DH016', 'DG004'),
    ('DH017', 'DG004'),
    ('DH018', 'DG004'),
    ('DH020', 'DG005'), -- Bún
    ('DH021', 'DG005'),
    ('DH022', 'DG005'),
    ('DH023', 'DG005'),
    ('DH024', 'DG005'),
    ('DH025', 'DG005'),
    ('DH026', 'DG005'),
    ('DH027', 'DG006'), -- Bánh
    ('DH028', 'DG006'),
    ('DH029', 'DG006'),
    ('DH030', 'DG006'),
    ('DH031', 'DG006'),
    ('DH032', 'DG006'),
    ('DH033', 'DG006');


-- Discounts
INSERT INTO `discount` (`id`, `name`, `type`, `discount_amount`, `discount_percentage`, `restaurant`, `start_date`, `end_date`) VALUES
    ('DC001', 'New Year Promo', 'fixed', 20000, NULL, 'restaurant1', '2024-12-25', '2025-01-05'),
    ('DC002', 'Weekend Special', 'percentage', NULL, 0.15, 'restaurant2', '2024-12-01', '2024-12-31'),
    ('DC003', 'Loyalty Discount', 'fixed', 30000, NULL, 'restaurant3', '2024-12-01', '2025-01-31');

-- Orders
INSERT INTO `order` (`id`, `order_date`, `status`, `delivery_address`, `customer`, `total_price`, `recipient_phone`, `delivery_company`) VALUES
    ('OD001', '2024-12-01', 'Delivered', '123 Le Loi, District 1, HCM', 'customer1', 95000, '0901234567', 'DC001'),
    ('OD002', '2024-12-02', 'Pending', '456 Nguyen Hue, District 1, HCM', 'customer2', 60000, '0902345678', 'DC002'),
    ('OD003', '2024-12-03', 'Processing', '789 Ly Tu Trong, District 1, HCM', 'customer3', 110000, '0903456789', 'DC003'),
    ('OD004', '2024-12-04', 'Delivered', '321 Nam Ky Khoi Nghia, District 3, HCM', 'customer4', 75000, '0904567890', 'DC004'),
    ('OD005', '2024-12-05', 'Pending', '654 Vo Van Tan, District 3, HCM', 'customer5', 90000, '0905678901', 'DC005');

-- Order Dishes
INSERT INTO `order_dish` (`order`, `dish`, `amount`, `current_price`) VALUES
    ('OD001', 'DH001', 1, 50000),
    ('OD001', 'DH002', 1, 45000),
    ('OD002', 'DH003', 1, 60000),
    ('OD003', 'DH004', 2, 40000),
    ('OD003', 'DH005', 1, 35000),
    ('OD004', 'DH006', 2, 25000),
    ('OD004', 'DH007', 1, 30000),
    ('OD005', 'DH008', 1, 80000),
    ('OD005', 'DH009', 1, 120000);

-- Order Delivery
INSERT INTO `order_delivery` (`order`, `delivery_company`, `shipper_name`, `shipper_phone`, `arrival`, `cost`) VALUES
    ('OD001', 'DC001', 'Nguyen Van X', '0981234567', '2024-12-01', 20000),
    ('OD002', 'DC002', 'Tran Van Y', '0982345678', '2024-12-02', 15000),
    ('OD003', 'DC003', 'Le Thi Z', '0983456789', '2024-12-03', 25000),
    ('OD004', 'DC004', 'Pham Van W', '0984567890', '2024-12-04', 18000),
    ('OD005', 'DC005', 'Nguyen Thi V', '0985678901', '2024-12-05', 22000);

-- Bills
INSERT INTO `bill` (`id`, `date`, `status`, `customer`) VALUES
    ('B001', '2024-12-01', 'Paid', 'customer1'),
    ('B002', '2024-12-02', 'Unpaid', 'customer2'),
    ('B003', '2024-12-03', 'Pending', 'customer3'),
    ('B004', '2024-12-04', 'Paid', 'customer4'),
    ('B005', '2024-12-05', 'Unpaid', 'customer5');

-- Order Bill Discounts
INSERT INTO `order_bill_discount` (`order`, `bill`, `discount`, `paid_price`) VALUES
    ('OD001', 'B001', 'DC001', 75000),
    ('OD002', 'B002', 'DC002', 51000),
    ('OD003', 'B003', 'DC003', 80000),
    ('OD004', 'B004', 'DC001', 55000),
    ('OD005', 'B005', 'DC002', 76500);

-- Customer Discounts
INSERT INTO `customer_discount` (`customer`, `discount`) VALUES
    ('customer1', 'DC001'),
    ('customer2', 'DC002'),
    ('customer3', 'DC003'),
    ('customer4', 'DC001'),
    ('customer5', 'DC002');

-- Point Discounts
INSERT INTO `point_discount` (`customer`, `discount`, `points`, `discount_type`, `start_date`, `end_date`) VALUES
    ('customer1', 'DC001', 20, 'fixed', '2024-12-01', '2025-01-31'),
    ('customer2', 'DC002', 50, 'percentage', '2024-12-01', '2025-01-31'),
    ('customer3', 'DC003', 100, 'fixed', '2024-12-01', '2025-01-31');

-- Feedback
INSERT INTO `feedback` (`customer`, `dish`, `ordinal`, `rating`, `comment`, `date`) VALUES
    ('customer1', 'DH001', 1, 5, 'Delicious!', '2024-12-01'),
    ('customer2', 'DH003', 1, 4, 'Tasty, but a bit too spicy.', '2024-12-02'),
    ('customer3', 'DH004', 1, 5, 'Perfect broken rice!', '2024-12-03'),
    ('customer4', 'DH006', 1, 4, 'Good banh mi, could use more filling.', '2024-12-04'),
    ('customer5', 'DH008', 1, 5, 'Fresh and delicious seafood!', '2024-12-05');