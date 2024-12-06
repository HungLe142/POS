# view Đơn hàng
import tkinter as tk

def show_view2(parent):

    parent.clear_content()
    parent.label = tk.Label(parent.content_frame, text="Đơn hàng")
    parent.label.pack()

    parent.data_listbox = tk.Listbox(parent.content_frame)
    parent.data_listbox.pack(fill=tk.BOTH, expand=True)

    """
    Hiển thị View2 trong khung nội dung của lớp chính.
    """
    # Giả sử nội dung của view 2 là một danh sách các đơn hàng
    orders = ["Order 1", "Order 2", "Order 3"]
    for order in orders:
        parent.data_listbox.insert(tk.END, order)
