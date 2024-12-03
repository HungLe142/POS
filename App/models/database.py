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
