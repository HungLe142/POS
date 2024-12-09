# view Khách hàng
import tkinter as tk
from tkinter import ttk
from views.view1 import sort_table
from controllers.view3_controller import get_cus


def show_view3(parent):

    parent.clear_content()
    parent.label = tk.Label(parent.content_frame, text="Khách hàng")
    parent.label.pack()

    # Frame để thêm dữ liệu
    #insert_frame = create_insert_frame(parent)
    #insert_frame.pack(fill=tk.X)

    # Bảng dữ liệu khách hàng
    cus_table = create_cus_table(parent.content_frame)
    cus_table.pack(fill=tk.BOTH, expand=True)

    if parent.cus_buff is None:
        parent.cus_buff = get_cus()

    if parent.cus_buff:
        for cus in parent.cus_buff:
            data = (cus[0], cus[1], cus[2], cus[3], cus[4])
            cus_table.insert('', 'end', values=data)

def create_cus_table(parent):
    cus_table = ttk.Treeview(parent, columns = ('ID_KhachHang', 'Ten', 'SDT_KhachHang', 'Loai_KH', 'Tong_HoaDon'), show = 'headings', height=8)
    cus_table.heading('ID_KhachHang', text = 'ID')
    cus_table.heading('Ten', text = 'Tên')
    cus_table.heading('SDT_KhachHang', text = 'SĐT')
    cus_table.heading('Loai_KH', text = 'Loại')
    cus_table.heading('Tong_HoaDon', text = 'Tổng hóa đơn', command=lambda: sort_table(staff_table, 'Hệ số lương', False))

    cus_table.column('ID_KhachHang', width=82) 
    cus_table.column('Ten', width=82) 
    cus_table.column('SDT_KhachHang', width=82) 
    cus_table.column('Loai_KH', width=82)
    cus_table.column('Tong_HoaDon', width=82)

    return cus_table
