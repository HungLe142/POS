from models.database import fetch_orders
from models.database import change_order_detail

def get_orders():
    return fetch_orders()

def update_order(main_view):
    return change_order_detail(main_view)
