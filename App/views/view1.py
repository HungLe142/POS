# view Món ăn trong ngày
import tkinter as tk
import threading
from controllers.view1_controller import create_order
from controllers.view1_controller import get_daily_dishes
from widgets.table import refresh_action, on_item_select
from widgets.frame import create_sb_rf
from tkinter import ttk


def show_view1(parent):

    parent.clear_content()
    parent.label = tk.Label(parent.content_frame, text="Món ăn trong ngày", bg='lightgray')
    parent.label.pack(fill=tk.X) # only vertiacal

    # Tạo PanedWindow để chia thành hai phần 
    paned_window = tk.PanedWindow(parent.content_frame, orient=tk.HORIZONTAL) 
    paned_window.pack(fill=tk.BOTH, expand=True)

    # Phần bên trái: Hiển thị các món ăn được bán trong ngày 
    left_frame = tk.Frame(paned_window)
    paned_window.add(left_frame, minsize=600)

    # Search bar và refresh
    searchbar_and_refresh = create_sb_rf(left_frame, parent)
    searchbar_and_refresh.pack(fill=tk.X)

    # Danh sách món bán trong ngày
    dish_table = create_dish_table(left_frame, parent)
    dish_table.pack(fill=tk.BOTH, expand=True)

    if parent.dish_buff is None:
        parent.dish_buff = get_daily_dishes()

    if parent.dish_buff:
        for dish in parent.dish_buff:
            data = (dish[0], dish[1], dish[2], dish[3], dish[4])
            dish_table.insert('', 'end', values=data)

    parent.right_frame_v1 = Right_frame_V1_elements()
    parent.right_frame_v1.right_frame = tk.Frame(paned_window)
    paned_window.add(parent.right_frame_v1.right_frame, minsize=100)

    # Gọi hàm để tạo nội dung của right_frame
    create_view1_right_frame_content(parent.right_frame_v1.right_frame, parent)

    # Tạo nút "Tạo đơn hàng" và đặt nó ở cuối khung
    submit_button = ttk.Button(parent.right_frame_v1.right_frame, text="Tạo đơn hàng", command=lambda: create_order(root))
    submit_button.pack(side='bottom', fill='x', expand=True, padx=5)




    
def create_order(root):
    pass

def create_dish_table(parent, root):
    dish_table = ttk.Treeview(parent, columns = ('ID', 'Ngay', 'Số lượng', 'Giảm giá', 'Giá bán'), show = 'headings', height=8)
    dish_table.heading('ID', text = 'ID')
    dish_table.heading('Ngay', text = 'Ngày')
    dish_table.heading('Số lượng', text = 'Số lượng', command=lambda: sort_table(dish_table, 'Số lượng', False))
    dish_table.heading('Giảm giá', text = 'Giảm giá', command=lambda: sort_table(dish_table, 'Giảm giá', False))
    dish_table.heading('Giá bán', text = 'Giá bán', command=lambda: sort_table(dish_table, 'Giá bán', False))

    dish_table.column('ID', width=82)
    dish_table.column('Ngay', width=82)  
    dish_table.column('Số lượng', width=82) 
    dish_table.column('Giảm giá', width=82) 
    dish_table.column('Giá bán', width=82)

    dish_table.bind('<<TreeviewSelect>>', lambda event: on_item_select(dish_table, root))

    return dish_table

def sort_table(tree, col, reverse): 
    l = [(tree.set(k, col), k) for k in tree.get_children('')] 
    l.sort(reverse=reverse, key=lambda t: float(t[0]) if t[0].isdigit() or is_float(t[0]) else t[0]) 
    for index, (val, k) in enumerate(l): 
        tree.move(k, '', index) 
        tree.heading(col, command=lambda: sort_table(tree, col, not reverse)) 
        
def is_float(value): 
    try: 
        float(value) 
        return True 
    except ValueError: return

def create_view1_right_frame_content(parent, root):
    label_title = ttk.Label(parent, text="Món ăn được chọn")
    label_title.pack(padx=10, pady=4, anchor='center')


class Right_frame_V1_elements(): # include frame, data, entry in frame
    def __init__(self):
        # Extract data from choosen row
       self.ID_mon_an = None
       self.Ngay = None
       self.So_luong_con = None
       self.Giam_gia = None
       self.Gia_ban_trong_ngay = None

       # Entry
       self.order_dish = []

       # Pointer to ther right frame of view 1
       self.right_frame = None
       

