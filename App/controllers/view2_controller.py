from models.database import fetch_orders, change_order_detail, change_order_status, cancel_order


def get_orders():
    return fetch_orders()

def update_order(main_view):
    return change_order_detail(main_view)

# Use for close order
def update_order1(main_view):
    return change_order_status(main_view)

def cancel_the_order(main_view):
    return cancel_order(main_view)