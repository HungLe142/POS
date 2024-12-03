from models.database import create_new_order
from models.database import fetch_data_daily_dishes

def create_order():
    return create_new_order()

def get_daily_dishes():
    return fetch_data_daily_dishes()