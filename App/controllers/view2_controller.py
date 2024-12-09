from models.database import fetch_orders
from models.database import change_order_detail
from models.database import change_order_status


def get_orders():
    return fetch_orders()

def update_order(main_view):
    return change_order_detail(main_view)

# Use for close order
def update_order1(main_view):
    return change_order_status(main_view)