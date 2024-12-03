# view Món ăn trong ngày
import tkinter as tk

def show_view1(parent):

    parent.clear_content()
    parent.label = tk.Label(parent.content_frame, text="Món ăn trong ngày")
    parent.label.pack()

    parent.data_listbox = tk.Listbox(parent.content_frame)
    parent.data_listbox.pack(fill=tk.BOTH, expand=True)

    # Giả sử nội dung của view 2 là một danh sách các đơn hàng
    orders = ["Dish 1", "Dish 2", "Dish 3"]
    for order in orders:
        parent.data_listbox.insert(tk.END, order)

    parent.load_button = tk.Button(parent.content_frame, text="Load Data", command=parent.load_data)
    parent.load_button.pack()
