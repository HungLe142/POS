ALTER TABLE CaLam
ADD CONSTRAINT CHK_CL_Duration
CHECK (DATEDIFF(HOUR, GioBatDau, GioKetThuc) = 4);
