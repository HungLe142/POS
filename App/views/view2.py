# view Đơn hàng
import tkinter as tk
from widgets.frame import create_sb_rf
from widgets.table import on_item_select

from tkinter import ttk, messagebox
from controllers.view2_controller import get_orders
from controllers.view2_controller import update_order



def show_view2(parent):

    parent.clear_content()
    parent.label = tk.Label(parent.content_frame, text="Đơn hàng")
    parent.label.pack(fill=tk.X)

    # Tạo PanedWindow để chia thành hai phần 
    paned_window = tk.PanedWindow(parent.content_frame, orient=tk.HORIZONTAL) 
    paned_window.pack(fill=tk.BOTH, expand=True)

    # Left frame:
    left_frame = tk.Frame(paned_window)
    paned_window.add(left_frame, minsize=600)

    # Search bar và refresh
    searchbar_and_refresh = create_sb_rf(left_frame, parent)
    searchbar_and_refresh.pack(fill=tk.X)

    # Order table:
    order_table = create_order_table(left_frame, parent)
    order_table.pack(fill=tk.BOTH, expand=True)

    # Right frame:
    parent.right_frame_v2 = Right_frame_V2_elements()
    right_frame = tk.Frame(paned_window)
    paned_window.add(right_frame, minsize=100)
    create_view2_right_frame_content(right_frame, parent)

    if parent.order_buff is None:
        parent.order_buff = get_orders() 

    if parent.order_buff:
        for order in parent.order_buff:
            data = (order[0], order[1], order[2], order[3], order[4], order[5], order[6], order[7], order[8])
            order_table.insert('', 'end', values=data)

def create_order_table(parent, root):
    order_table = ttk.Treeview(parent, columns = ('ID_don_hang', 'SDT_KhachHang', 'ID_NhanVien', 'Trang_thai', 'Ghi_chu_trang_thai', 'Gio_tao_don', 'Gio_hoan_thanh', 'Ghi_chu_don_hang', 'Tong_tien'), show = 'headings', height=8)
    order_table.heading('ID_don_hang', text = 'Mã đơn')
    order_table.heading('SDT_KhachHang')
    order_table.heading('ID_NhanVien', text = 'ID nhân viên tạo đơn')
    order_table.heading('Trang_thai', text = 'Trạng thái')
    order_table.heading('Ghi_chu_trang_thai')
    order_table.heading('Gio_tao_don')
    order_table.heading('Gio_hoan_thanh')
    order_table.heading('Ghi_chu_don_hang')
    order_table.heading('Tong_tien', text = 'Tổng tiền')

    order_table.column('ID_don_hang', width=82) 
    order_table.column('SDT_KhachHang', width=0, stretch=tk.NO)
    order_table.column('ID_NhanVien', width=82)
    order_table.column('Trang_thai', width=82)
    order_table.column('Ghi_chu_trang_thai', width=0, stretch=tk.NO)
    order_table.column('Gio_tao_don', width=0, stretch=tk.NO)
    order_table.column('Gio_hoan_thanh', width=0, stretch=tk.NO)
    order_table.column('Ghi_chu_don_hang', width=0, stretch=tk.NO)
    order_table.column('Tong_tien', width=82)

    order_table.bind('<<TreeviewSelect>>', lambda event: on_item_select(order_table, root))

    return order_table

def create_view2_right_frame_content(parent, root):
    label_title = ttk.Label(parent, text="Nội dung đơn hàng")
    label_title.pack(padx=10, pady=4, anchor='center')
    
    if root.right_frame_v2:
        # Dòng 1: Số điện thoại khách hàng
        frame1 = ttk.Frame(parent)
        frame1.pack(padx=10, pady=4, fill='x', anchor='w')
        
        label1 = ttk.Label(frame1, text="SĐT khách")
        label1.pack(side='left', padx=5)

        root.right_frame_v2.entry_sdt = ttk.Entry(frame1)
        root.right_frame_v2.entry_sdt.pack(side='right', fill='x', expand=True, padx=5)

        # Dòng 2: Ghi chú trạng thái đơn hàng
        frame2 = ttk.Frame(parent)
        frame2.pack(padx=10, pady=4, fill='x', anchor='w')
        
        label2 = ttk.Label(frame2, text="Tình trạng")
        label2.pack(side='left', padx=5)

        root.right_frame_v2.entry_note_status = ttk.Entry(frame2, state='readonly')
        root.right_frame_v2.entry_note_status.pack(side='right', fill='x', expand=True, padx=5)   

        # Dòng 3: Thời gian khởi tạo
        frame3 = ttk.Frame(parent)
        frame3.pack(padx=10, pady=4, fill='x', anchor='w')
        
        label3 = ttk.Label(frame3, text="Thời gian tạo", state='readonly')
        label3.pack(side='left', padx=5)

        root.right_frame_v2.entry_init_time = ttk.Entry(frame3)
        root.right_frame_v2.entry_init_time.pack(side='right', fill='x', expand=True, padx=5) 

        # Dòng 4: Thời gian đóng đơn
        frame4 = ttk.Frame(parent)
        frame4.pack(padx=10, pady=4, fill='x', anchor='w')
        
        label4 = ttk.Label(frame4, text="Thời gian đóng")
        label4.pack(side='left', padx=5)

        root.right_frame_v2.entry_fin_time = ttk.Entry(frame4)
        root.right_frame_v2.entry_fin_time.pack(side='right', fill='x', expand=True, padx=5) 

        # Dòng 5: Ghi chú của khách
        frame5 = ttk.Frame(parent)
        frame5.pack(padx=10, pady=4, fill='x', anchor='w')
        
        label5 = ttk.Label(frame5, text="Ghi chú khách")
        label5.pack(side='left', padx=5)

        root.right_frame_v2.entry_order_note = ttk.Entry(frame5)
        root.right_frame_v2.entry_order_note.pack(side='right', fill='x', expand=True, padx=5) 

        # Dòng 6: Nút xác nhận thay đổi:
        frame6 = ttk.Frame(parent)
        frame6.pack(padx=10, pady=4, fill='x', anchor='w')
        submit_button = ttk.Button(frame6, text="Xác nhận thay đổi", command=lambda: change_order_data(root)) 
        submit_button.pack(side='right', fill='x', expand=True, padx=5)
        confirm_order_button = ttk.Button(frame6, text="Đóng đơn hàng", command=lambda: confirm_order(root)) 
        confirm_order_button.pack(side='left', fill='x', expand=True, padx=5)  

def change_order_data(root):
    try:
        with root.view_lock:
            status = update_order(root)
            # Error code:
            # 2: invalid phone number
            # 3: invalid finish time
            # 4 : Foreign key constranit with sdt, not existed...
            # 5: No query for updating
            if status == 2:
                messagebox.showwarning("Warning", "Invalid phone number!")
                return
            elif status == 3:
                messagebox.showwarning("Warning", "Invalid finish time!")
                return
            elif status == 4:
                messagebox.showwarning("Warning", "No customer with selected exist, please subcribe a membership!")
                return
            elif status == 5:
                messagebox.showwarning("Warning", "Nothing new to update!")
                return
    except TimeoutError:
        messagebox.showwarning("Warning", "Please wait, the the app is executing the query")

def confirm_order(root):
    pass

class Right_frame_V2_elements():
    def __init__(self):
        # Storing the entry
        self.entry_sdt = None
        self.entry_note_status = None
        self.entry_init_time = None
        self.entry_fin_time = None
        self.entry_order_note = None
        
        # Storing other data of the choosen order
        self.ID_don_hang = None

        
