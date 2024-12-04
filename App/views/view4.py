# view Nhân viên
import tkinter as tk
from tkinter import ttk
from controllers.view4_controller import get_staff
from views.vỉew1 import sort_table


def show_view4(parent):

    parent.clear_content()
    parent.label = tk.Label(parent.content_frame, text="Nhân viên")
    parent.label.pack()

    # Frame để thêm dữ liệu
    #insert_frame = create_insert_frame(parent)
    #insert_frame.pack(fill=tk.X)

    # Bảng dữ liệu nhân viên
    staff_table = create_staff_table(parent.content_frame)
    staff_table.pack(fill=tk.BOTH, expand=True)

    if parent.staff_buff is None:
        parent.staff_buff = get_staff()

    if parent.staff_buff:
        for staff in parent.staff_buff:
            data = (staff[0], staff[1], staff[2], staff[4], staff[5])
            staff_table.insert('', 'end', values=data)

def create_insert_frame(parent):
    pass

def create_staff_table(parent):
    staff_table = ttk.Treeview(parent, columns = ('ID', 'Tên', 'SĐT', 'Chức vụ', 'Hệ số lương'), show = 'headings', height=8)
    staff_table.heading('ID', text = 'ID')
    staff_table.heading('Tên', text = 'Tên')
    staff_table.heading('SĐT', text = 'SĐT')
    staff_table.heading('Chức vụ', text = 'Chức vụ')
    staff_table.heading('Hệ số lương', text = 'Hệ số lương', command=lambda: sort_table(staff_table, 'Hệ số lương', False))

    staff_table.column('ID', width=82) 
    staff_table.column('Tên', width=82) 
    staff_table.column('SĐT', width=82) 
    staff_table.column('Chức vụ', width=82)
    staff_table.column('Hệ số lương', width=82)

    return staff_table