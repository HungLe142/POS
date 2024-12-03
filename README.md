- This is the repo of 241 - database's assignmet 2 
- DBMS: Sql Server
- Deploying data base: Azure

- REQUIREMENTS 1.1:
    + Data constraints:
        * NOT NULL: included in CREATE TABLE commands in add_all_table.sql
        * UNIQUE:see add_candidate_key.sql
        * PRIMARY KEY:included in CREATE TABLE commands in add_all_table.sql
        * FOREIGN KEY: see add_foreign_key.sql
        * CHECK: see restrict attribute.sql
        * DEFAULT:
    + 5 Semantic constraints: 
        * Use Check or Trigger, see in semantic constraints folder
        * Semantic constraints (ràng buộc ngữ nghĩa):
            + Số lượng món ăn trong ngày không quá 30 món,  (Trigger)
            + Mỗi món quán làm không quá 70 khẩu phần ăn (trong ngày). (Trigger)
            + Hệ số lương của quản lý, đầu bếp, thu ngân, bồi bàn lần lượt là: 150k/h, 100k/h, 30k/h, 25k/h, (trigger)
            + Mã đơn hàng có dạng là “OD” hoặc “ODS” được theo sau bởi 6 số ngẫu nhiên, với “OD” là đơn hàng tại chỗ, và “ODS” là đơn hàng trực tuyến (check)
            + Mỗi ca làm việc kéo dài 4 tiếng (check)

    + Some other constraints: check sdt khách, nv
