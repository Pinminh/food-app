-- Constraints for table `anh_mon_an`
--
ALTER TABLE `anh_mon_an`
  ADD CONSTRAINT `pk_anhmonan`
  PRIMARY KEY (`maMonAn`, `anhMonAn`);

ALTER TABLE `anh_mon_an`
  ADD CONSTRAINT `fk_anhmonan_mamonan`
  FOREIGN KEY (`maMonAn`)
  REFERENCES `mon_an` (`maMonAn`)
  ON DELETE CASCADE;

--
-- Constraints for table `anh_nha_hang`
--
ALTER TABLE `anh_nha_hang`
  ADD CONSTRAINT `pk_anhnh`
  PRIMARY KEY (`tenDangNhap`, `anhNhaHang`);

ALTER TABLE `anh_nha_hang`
  ADD CONSTRAINT `fk_anhnh_tendn`
  FOREIGN KEY (`tenDangNhap`)
  REFERENCES `nha_hang` (`tenDangNhap`)
  ON DELETE CASCADE;

--
-- Constraints for table `cong_ty_giao_hang`
--
ALTER TABLE `cong_ty_giao_hang`
  ADD CONSTRAINT `pk_congtygh` PRIMARY KEY (`maCongty`);


--
-- Constraints for table `danh_gia_mon_an`
--
ALTER TABLE `danh_gia_mon_an`
  ADD CONSTRAINT `danh_gia_mon_an_ibfk_1` FOREIGN KEY (`maMonAn`) REFERENCES `mon_an` (`maMonAn`),
  ADD CONSTRAINT `danh_gia_mon_an_ibfk_2` FOREIGN KEY (`khachHang`) REFERENCES `khach_hang` (`tenDangNhap`);

--
-- Constraints for table `doi_diem`
--
ALTER TABLE `doi_diem`
  ADD CONSTRAINT `doi_diem_ibfk_1` FOREIGN KEY (`khachHang`) REFERENCES `khach_hang` (`tenDangNhap`),
  ADD CONSTRAINT `doi_diem_ibfk_2` FOREIGN KEY (`maPhieu`) REFERENCES `phieu_giam_gia` (`maPhieu`);

--
-- Constraints for table `don_hang`
--
ALTER TABLE `don_hang`
  ADD CONSTRAINT `don_hang_ibfk_1` FOREIGN KEY (`khachHang`) REFERENCES `khach_hang` (`tenDangNhap`);

--
-- Constraints for table `khach_hang`
--
ALTER TABLE `khach_hang`
  ADD CONSTRAINT `khach_hang_ibfk_1` FOREIGN KEY (`tenDangNhap`) REFERENCES `tai_khoan` (`tenDangNhap`);

--
-- Constraints for table `mon_an_thuoc_nhom`
--
ALTER TABLE `mon_an_thuoc_nhom`
  ADD CONSTRAINT `mon_an_thuoc_nhom_ibfk_1` FOREIGN KEY (`maMonAn`) REFERENCES `mon_an` (`maMonAn`),
  ADD CONSTRAINT `mon_an_thuoc_nhom_ibfk_2` FOREIGN KEY (`maMonAn`) REFERENCES `mon_an` (`maMonAn`),
  ADD CONSTRAINT `mon_an_thuoc_nhom_ibfk_3` FOREIGN KEY (`maNhomMonAn`) REFERENCES `nhom_mon_an` (`maNhomMonAn`);

--
-- Constraints for table `nguoi_giao_hang`
--
ALTER TABLE `nguoi_giao_hang`
  ADD CONSTRAINT `fk_maCT_nguoigiao` FOREIGN KEY (`maCongTy`) REFERENCES `cong_ty_giao_hang` (`maCongTy`),
  ADD CONSTRAINT `fk_madon_nguoigiao` FOREIGN KEY (`maDonHang`) REFERENCES `don_hang` (`maDon`);

--
-- Constraints for table `nguoi_nhan`
--
ALTER TABLE `nguoi_nhan`
  ADD CONSTRAINT `fk_nguoinhan_madon` FOREIGN KEY (`maDonHang`) REFERENCES `don_hang` (`maDon`);

--
-- Constraints for table `nha_hang`
--
ALTER TABLE `nha_hang`
  ADD CONSTRAINT `fk_nh_tendn` FOREIGN KEY (`tenDangNhap`) REFERENCES `tai_khoan` (`tenDangNhap`);

--
-- Constraints for table `phieu_giam_gia`
--
ALTER TABLE `phieu_giam_gia`
  ADD CONSTRAINT `phieu_giam_gia_ibfk_1` FOREIGN KEY (`nhaHang`) REFERENCES `nha_hang` (`tenDangNhap`);

--
-- Constraints for table `quan_li_mon_an`
--
ALTER TABLE `quan_li_mon_an`
  ADD CONSTRAINT `quan_li_mon_an_ibfk_1` FOREIGN KEY (`maMonAn`) REFERENCES `mon_an` (`maMonAn`),
  ADD CONSTRAINT `quan_li_mon_an_ibfk_2` FOREIGN KEY (`nhaHang`) REFERENCES `nha_hang` (`tenDangNhap`);

--
-- Constraints for table `tao_don_hang`
--
ALTER TABLE `tao_don_hang`
  ADD CONSTRAINT `tao_don_hang_ibfk_1` FOREIGN KEY (`maDonHang`) REFERENCES `don_hang` (`maDon`),
  ADD CONSTRAINT `tao_don_hang_ibfk_2` FOREIGN KEY (`maGiamGia`) REFERENCES `phieu_giam_gia` (`maPhieu`),
  ADD CONSTRAINT `tao_don_hang_ibfk_3` FOREIGN KEY (`maPhieuThanhToan`) REFERENCES `phieu_thanh_toan` (`maPhieu`),
  ADD CONSTRAINT `tao_don_hang_ibfk_4` FOREIGN KEY (`maMonAn`) REFERENCES `mon_an` (`maMonAn`);