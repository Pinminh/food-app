CREATE DEFINER=`root`@`localhost` FUNCTION `count_dish` (`codeNMA` VARCHAR(256)) RETURNS INT(11) DETERMINISTIC proc_label:BEGIN
	IF (SELECT LENGTH(codeNMA) <> 4 || codeNMA NOT REGEXP "^[a-zA-Z0-9]{4}") THEN
 		signal sqlstate '45000' set message_text = 'Ma nhom mon an sai dinh dang (4 ky tu bao gom chu hoac so)';
    ELSEIF (NOT EXISTS (SELECT * FROM nhom_mon_an WHERE maNhomMonAn = codeNMA)) THEN
    	signal sqlstate '45000' set message_text = 'Ma nhom mon an khong ton tai';
    ELSE
        return(
            SELECT COUNT(*)
            FROM mon_an_thuoc_nhom
            WHERE maNhomMonAn = codeNMA
        );
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `phan_loai` (`codeMA` VARCHAR(15), `price` INT) RETURNS VARCHAR(12) CHARSET utf8mb4 DETERMINISTIC proc_label:BEGIN
	DECLARE Price_Level VARCHAR(12);
	IF (SELECT LENGTH(codeMA) <> 4 || codeMA NOT REGEXP "^[a-zA-Z0-9]{4}") THEN
 		signal sqlstate '45000' set message_text = 'Ma mon an sai dinh dang (4 ky tu bao gom chu hoac so)';
    ELSEIF price < 0 THEN 
    	signal sqlstate '45000' set message_text = 'Gia mon an toi thieu bang 0';
    ELSEIF (NOT EXISTS (SELECT * FROM mon_an WHERE mon_an.maMonAn = codeMA)) THEN
    	signal sqlstate '45000' set message_text = 'Ma mon an khong ton tai';
    ELSEIF (NOT EXISTS (SELECT * FROM mon_an WHERE mon_an.maMonAn = codeMA AND mon_an.giaNiemYet = price)) THEN
        signal sqlstate '45000' set message_text = 'Ma mon an va gia mon an khong trung khop';
    ELSE 
    	BEGIN
        	IF ((SELECT COUNT(*) FROM mon_an WHERE mon_an.maMonAn <> codeMA AND mon_an.giaNiemYet <= price) < (SELECT FLOOR(COUNT(*)/3) FROM mon_an)) THEN
                SET Price_Level = "Thap";                
            ELSEIF ((SELECT COUNT(*) FROM mon_an WHERE mon_an.maMonAn <> codeMA AND mon_an.giaNiemYet >= price) < (SELECT FLOOR(COUNT(*)/3) FROM mon_an)) THEN
                SET Price_Level = "Cao";
            ELSE
            	SET Price_Level = "Trung binh"; 
            END IF;
            Return (Price_Level);
    	END;
 	END IF;
END$$