import pyodbc

DATABASE_CONFIG = {
    'server': 'server241cs.database.windows.net',
    'database': 'POS',
    'username': 'adminPOS',
    'password': '1231!#ASDF!a',
}

def get_connection():
    try:
        conn = pyodbc.connect(
            'DRIVER={ODBC Driver 17 for SQL Server};'
            'SERVER=' + DATABASE_CONFIG['server'] + ';'
            'DATABASE=' + DATABASE_CONFIG['database'] + ';'
            'UID=' + DATABASE_CONFIG['username'] + ';'
            'PWD=' + DATABASE_CONFIG['password']
        )
        return conn
    except Exception as e:
        print("Error: ", e)
        return None
