ALTER TABLE DonHang
ADD CONSTRAINT CHK_DH_ID_don_hang
CHECK (ID_don_hang LIKE 'OD[0-9][0-9][0-9][0-9][0-9][0-9]' OR ID_don_hang LIKE 'ODS[0-9][0-9][0-9][0-9][0-9][0-9]');
