from config.config import get_connection

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
