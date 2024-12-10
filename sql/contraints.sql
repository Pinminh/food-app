ALTER TABLE `anh_mon_an`
  ADD CONSTRAINT `pk_anhmonan`
  PRIMARY KEY (`maMonAn`, `anhMonAn`);


ALTER TABLE `anh_nha_hang`
  ADD CONSTRAINT `pk_anhnh`
  PRIMARY KEY (`tenDangNhap`, `anhNhaHang`);


ALTER TABLE `cong_ty_giao_hang`
  ADD CONSTRAINT `pk_congtygh`
  PRIMARY KEY (`maCongty`);


ALTER TABLE `danh_gia_mon_an`
  ADD CONSTRAINT `pk_danhgiamonan`
  PRIMARY KEY (`khachHang`, `maMonAn`);


ALTER TABLE `doi_diem`
  ADD CONSTRAINT `pk_doidiem`
  PRIMARY KEY (`khachHang`, `maPhieu`);


ALTER TABLE `don_hang`
  ADD CONSTRAINT `pk_donhang`
  PRIMARY KEY (`maDon`);


ALTER TABLE `khach_hang`
  ADD CONSTRAINT `pk_khachhang`
  PRIMARY KEY (`tenDangNhap`);


ALTER TABLE `mon_an`
  ADD CONSTRAINT `pk_monan`
  PRIMARY KEY (`maMonAn`);


ALTER TABLE `mon_an_thuoc_nhom`
  ADD CONSTRAINT `pk_monannhom`
  PRIMARY KEY (`maMonAn`, `maNhomMonAn`);


ALTER TABLE `nguoi_giao_hang`
  ADD CONSTRAINT `pk_giaohang`
  PRIMARY KEY (`maCongTy`, `maDonHang`);


ALTER TABLE `nguoi_nhan`
  ADD CONSTRAINT `pk_nguoinhan`
  PRIMARY KEY (`maDonHang`, `tenNguoiNhan`);


ALTER TABLE `nha_hang`
  ADD CONSTRAINT `pk_nhahang`
  PRIMARY KEY (`tenDangNhap`);


ALTER TABLE `nhom_mon_an`
  ADD CONSTRAINT `pk_nhommonan`
  PRIMARY KEY (`maNhomMonAn`);


ALTER TABLE `phieu_giam_gia`
  ADD CONSTRAINT `pk_phieugiamgia`
  PRIMARY KEY (`maPhieu`);


ALTER TABLE `phieu_thanh_toan`
  ADD CONSTRAINT `pk_phieuthanhtoan`
  PRIMARY KEY (`maPhieu`);


ALTER TABLE `quan_li_mon_an`
  ADD CONSTRAINT `pk_quanlimonan`
  PRIMARY KEY (`maMonAn`, `nhaHang`);


ALTER TABLE `tai_khoan`
  ADD CONSTRAINT `pk_taikhoan`
  PRIMARY KEY (`tenDangNhap`);


ALTER TABLE `tao_don_hang`
  ADD CONSTRAINT `pk_taodonhang`
  PRIMARY KEY (`maDonHang`, `maGiamGia`, `maPhieuThanhToan`, `maMonAn`);


-- Constraints for table `anh_mon_an`
--
ALTER TABLE `anh_mon_an`
  ADD CONSTRAINT `fk_anhmonan_mamonan`
  FOREIGN KEY (`maMonAn`)
  REFERENCES `mon_an` (`maMonAn`)
  ON DELETE CASCADE;

--
-- Constraints for table `anh_nha_hang`
--
ALTER TABLE `anh_nha_hang`
  ADD CONSTRAINT `fk_anhnh_tendn`
  FOREIGN KEY (`tenDangNhap`)
  REFERENCES `nha_hang` (`tenDangNhap`)
  ON DELETE CASCADE;

--
-- Constraints for table `danh_gia_mon_an`
--
ALTER TABLE `danh_gia_mon_an`
  ADD CONSTRAINT `fk_danhgia_monan`
  FOREIGN KEY (`maMonAn`)
  REFERENCES `mon_an` (`maMonAn`)
  ON DELETE CASCADE,

  ADD CONSTRAINT `fk_danhgia_khachhang`
  FOREIGN KEY (`khachHang`)
  REFERENCES `khach_hang` (`tenDangNhap`)
  ON DELETE CASCADE;

--
-- Constraints for table `doi_diem`
--
ALTER TABLE `doi_diem`
  ADD CONSTRAINT `fk_doidiem_khachhang`
  FOREIGN KEY (`khachHang`)
  REFERENCES `khach_hang` (`tenDangNhap`)
  ON DELETE CASCADE,

  ADD CONSTRAINT `fk_doidiem_maphieu`
  FOREIGN KEY (`maPhieu`)
  REFERENCES `phieu_giam_gia` (`maPhieu`)
  ON DELETE CASCADE;

--
-- Constraints for table `don_hang`
--
ALTER TABLE `don_hang`
  ADD CONSTRAINT `fk_donhang_khachhang`
  FOREIGN KEY (`khachHang`)
  REFERENCES `khach_hang` (`tenDangNhap`)
  ON DELETE CASCADE;

--
-- Constraints for table `khach_hang`
--
ALTER TABLE `khach_hang`
  ADD CONSTRAINT `fk_khachhang_taikhoan`
  FOREIGN KEY (`tenDangNhap`)
  REFERENCES `tai_khoan` (`tenDangNhap`)
  ON DELETE CASCADE;

--
-- Constraints for table `mon_an_thuoc_nhom`
--
ALTER TABLE `mon_an_thuoc_nhom`
  ADD CONSTRAINT `fk_monannhom_monan`
  FOREIGN KEY (`maMonAn`)
  REFERENCES `mon_an` (`maMonAn`)
  ON DELETE CASCADE,

  ADD CONSTRAINT `fk_monannhom_nhom`
  FOREIGN KEY (`maNhomMonAn`)
  REFERENCES `nhom_mon_an` (`maNhomMonAn`)
  ON DELETE CASCADE;

--
-- Constraints for table `nguoi_giao_hang`
--
ALTER TABLE `nguoi_giao_hang`
  ADD CONSTRAINT `fk_maCT_nguoigiao`
  FOREIGN KEY (`maCongTy`)
  REFERENCES `cong_ty_giao_hang` (`maCongTy`)
  ON DELETE CASCADE,

  ADD CONSTRAINT `fk_madon_nguoigiao`
  FOREIGN KEY (`maDonHang`)
  REFERENCES `don_hang` (`maDon`)
  ON DELETE CASCADE;

--
-- Constraints for table `nguoi_nhan`
--
ALTER TABLE `nguoi_nhan`
  ADD CONSTRAINT `fk_nguoinhan_madon`
  FOREIGN KEY (`maDonHang`)
  REFERENCES `don_hang` (`maDon`)
  ON DELETE CASCADE;

--
-- Constraints for table `nha_hang`
--
ALTER TABLE `nha_hang`
  ADD CONSTRAINT `fk_nh_tendn`
  FOREIGN KEY (`tenDangNhap`)
  REFERENCES `tai_khoan` (`tenDangNhap`)
  ON DELETE CASCADE;

--
-- Constraints for table `phieu_giam_gia`
--
ALTER TABLE `phieu_giam_gia`
  ADD CONSTRAINT `fk_phieugiamgia_nhahang`
  FOREIGN KEY (`nhaHang`)
  REFERENCES `nha_hang` (`tenDangNhap`)
  ON DELETE CASCADE;

--
-- Constraints for table `quan_li_mon_an`
--
ALTER TABLE `quan_li_mon_an`
  ADD CONSTRAINT `fk_quanlimonan_monan`
  FOREIGN KEY (`maMonAn`)
  REFERENCES `mon_an` (`maMonAn`)
  ON DELETE CASCADE,

  ADD CONSTRAINT `fk_quanlimonan_nhahang`
  FOREIGN KEY (`nhaHang`)
  REFERENCES `nha_hang` (`tenDangNhap`)
  ON DELETE CASCADE;

--
-- Constraints for table `tao_don_hang`
--
ALTER TABLE `tao_don_hang`
  ADD CONSTRAINT `fk_taodonhang_donhang`
  FOREIGN KEY (`maDonHang`)
  REFERENCES `don_hang` (`maDon`)
  ON DELETE CASCADE,

  ADD CONSTRAINT `fk_taodonhang_giamgia`
  FOREIGN KEY (`maGiamGia`)
  REFERENCES `phieu_giam_gia` (`maPhieu`)
  ON DELETE CASCADE,

  ADD CONSTRAINT `fk_taodonhang_phieuthanhtoan`
  FOREIGN KEY (`maPhieuThanhToan`)
  REFERENCES `phieu_thanh_toan` (`maPhieu`)
  ON DELETE CASCADE,

  ADD CONSTRAINT `fk_taodonhang_monan`
  FOREIGN KEY (`maMonAn`)
  REFERENCES `mon_an` (`maMonAn`)
  ON DELETE CASCADE;