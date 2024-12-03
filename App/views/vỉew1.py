# view Món ăn trong ngày
import tkinter as tk
from controllers.view1_controller import create_order
from controllers.view1_controller import get_daily_dishes
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
    dish_table = create_dish_table(left_frame)
    dish_table.pack(fill=tk.BOTH, expand=True)

    if parent.dish_buff is None:
        parent.dish_buff = get_daily_dishes()

    if parent.dish_buff:
        for dish in parent.dish_buff:
            data = (dish[0], dish[2], dish[3], dish[4])
            dish_table.insert('', 'end', values=data)

    # Phần bên phải: Hiển thị những món ăn đã chọn để tạo đơn 
    right_frame = tk.Frame(paned_window)
    paned_window.add(right_frame, minsize=100) 

    selected_label = tk.Label(right_frame, text="Món ăn đã chọn") 
    selected_label.pack()

    selected_listbox = tk.Listbox(right_frame) 
    selected_listbox.pack(fill=tk.BOTH, expand=True) 

    order_button = tk.Button(right_frame, text="Tạo đơn", command=create_order)
    #order_button.pack(fill=tk.X)
    order_button.pack()
    
    # Dữ liệu món ăn 
    selected_orders = ["Selected Dish 1", "Selected Dish 2"] 
    for selected_order in selected_orders: 
        selected_listbox.insert(tk.END, selected_order)

def create_sb_rf(parent, root): 
    frame = tk.Frame(parent) 
    create_search_bar(frame) 
    create_refresh_button(frame, root) 
    return frame

def create_search_bar(parent):
    search_label = tk.Label(parent, text="Search:") 
    search_label.pack(side=tk.LEFT, padx=5) 

    search_entry = tk.Entry(parent) 
    search_entry.pack(side=tk.LEFT, fill=tk.X, expand=True, padx=5) 
    search_button = tk.Button(parent, text="Go", command=lambda: search_action(search_entry.get())) 
    search_button.pack(side=tk.LEFT, padx=5)

def create_refresh_button(parent, root):
    refresh_button = tk.Button(parent, text="Refresh", command=lambda:refresh_action(root)) 
    refresh_button.pack(side=tk.RIGHT, padx=5)

def search_action(query): 
    print(f"Searching for: {query}") 
    
def refresh_action(root): 
    print("Refreshing data...")
    root.dish_buff = None
    root.show_view1()

def create_dish_table(parent):
    dish_table = ttk.Treeview(parent, columns = ('ID', 'Số lượng', 'Giảm giá', 'Giá bán' ), show = 'headings', height=8)
    dish_table.heading('ID', text = 'ID')
    dish_table.heading('Số lượng', text = 'Số lượng', command=lambda: sort_table(dish_table, 'Số lượng', False))
    dish_table.heading('Giảm giá', text = 'Giảm giá', command=lambda: sort_table(dish_table, 'Giảm giá', False))
    dish_table.heading('Giá bán', text = 'Giá bán', command=lambda: sort_table(dish_table, 'Giá bán', False))

    dish_table.column('ID', width=82) 
    dish_table.column('Số lượng', width=82) 
    dish_table.column('Giảm giá', width=82) 
    dish_table.column('Giá bán', width=82)

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