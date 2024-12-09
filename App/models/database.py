import pyodbc
from config.config import get_connection
import re
# Staff queries

def fetch_data():
    conn = get_connection()
    if conn:
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM NhanVien")
        result = cursor.fetchall()
        conn.close()
        return result
    return None

def fetch_data_daily_dishes():
    conn = get_connection()
    if conn:
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM MonAn_TrongNgay")
        result = cursor.fetchall()
        conn.close()
        return result
    return None

def get_list_of_staff():
    conn = get_connection()
    if conn:
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM NhanVien")
        result = cursor.fetchall()
        conn.close()
        return result
    return None

# Order queries
def create_new_order():
    print(111)
    pass

def fetch_orders():
    print("Fetching orders")
    conn = get_connection()
    if conn:
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM DonHang")
        result = cursor.fetchall()
        conn.close()
        print("Finish fetching orders")
        return result
    return None

def change_order_detail(main_view):
    print("Update order")
    if main_view.right_frame_v2 and main_view:
        
        if main_view.right_frame_v2.ID_don_hang is None:
            return False

        # When fetching get None, the data in entry will change to -> 'None'!!!
        ID_don_hang = main_view.right_frame_v2.ID_don_hang
        SDT_KhachHang = main_view.right_frame_v2.entry_sdt.get()
        Gio_hoan_thanh = main_view.right_frame_v2.entry_fin_time.get()
        Ghi_chu_don_hang = main_view.right_frame_v2.entry_order_note.get()
        print("Updating data: id đơn: ",ID_don_hang, SDT_KhachHang,Gio_hoan_thanh, Ghi_chu_don_hang )

        # Check input
        #if SDT_KhachHang == 'None' or  SDT_KhachHang == '':
            #print("Null phone number")
            #SDT_KhachHang = None
        #elif not re.match(r'^\d{10}$', SDT_KhachHang):
            #print("SĐT bị lỗi: ", SDT_KhachHang)
            #return 2 # Error code for invalid phone number

        if Gio_hoan_thanh == 'None':
            Gio_hoan_thanh = None
        elif not re.match(r'^([01]\d|2[0-3]):([0-5]\d):([0-5]\d)$', Gio_hoan_thanh):
            return 3

        if Ghi_chu_don_hang == 'None':
            Ghi_chu_don_hang = None
    
        # Dynamic SQL
        update_fields = [] 
        update_values = []

        #if SDT_KhachHang is not None: 
            #update_fields.append("SDT_KhachHang = ?") 
            #update_values.append(SDT_KhachHang) 
        if Gio_hoan_thanh is not None: 
            update_fields.append("Gio_hoan_thanh = ?") 
            update_values.append(Gio_hoan_thanh) 
        if Ghi_chu_don_hang is not None: 
            update_fields.append("Ghi_chu_don_hang = ?") 
            update_values.append(Ghi_chu_don_hang)

        if not update_fields: 
            print("No order's entry for updating.") 
            return 5

        update_values.append(ID_don_hang) 
        sql_update_query = f"UPDATE DonHang SET {', '.join(update_fields)} WHERE ID_don_hang = ?"

        # Mở kết nối và tạo con trỏ
        conn = get_connection()
        if conn:
            try:
                cursor = conn.cursor()

                # Thực thi câu lệnh SQL
                cursor.execute(sql_update_query, update_values)
                
                # Lưu thay đổi vào cơ sở dữ liệu
                conn.commit()

                print("Finish update order")
                return True
            except pyodbc.Error as e: 
                print(f"Some errors happend when updating the order: {e}") 
                
                error_message = str(e) 
                if "FOREIGN KEY constraint" in error_message:
                    return 4
                
                return False
            finally: 
                cursor.close()
        else:
            print("Can not connect to the Database.") 
            return False
    else:
        print("Some thing wrong, the right frame in view 2 or the current choosen order in view 2 is not initialized correctly!")
        return False

