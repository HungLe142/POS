import tkinter as tk
from controllers.main_controller import get_data_from_db
from views.view1 import show_view1
from views.view2 import show_view2
from views.view3 import show_view3
from views.view4 import show_view4
import threading
#import gc

class MainView:
    def __init__(self, root):
        self.dish_buff = None
        self.staff_buff = None
        self.order_buff = None

        # Handle multithread in Main_View
        self.view_lock = threading.Lock()
        self.in_view1 = False
        self.in_view2 = False
        self.in_view3 = False
        self.in_view4 = False

        self.root = root
        self.root.title("POS App")
        self.root.geometry("900x600")

        # Frame bên trái (sidebar) cho điều hướng
        self.sidebar_frame = tk.Frame(root, width=200, bg='lightgray')
        self.sidebar_frame.pack(side=tk.LEFT, fill=tk.Y)

        # Frame bên phải cho nội dung chính
        self.content_frame = tk.Frame(root)
        self.content_frame.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)

        # Nội dung sidebar
        self.label_nav = tk.Label(self.sidebar_frame, text="POS", bg='lightgray')
        self.label_nav.pack(pady=10)
        self.button_view1 = tk.Button(self.sidebar_frame, text="Món ăn trong ngày", command=lambda:self.button_click(1))
        self.button_view1.pack(pady=5, fill=tk.X)
        self.button_view2 = tk.Button(self.sidebar_frame, text="Đơn hàng", command=lambda:self.button_click(2))
        self.button_view2.pack(pady=5, fill=tk.X)
        self.button_view3 = tk.Button(self.sidebar_frame, text="Khách hàng", command=lambda:self.button_click(3))
        self.button_view3.pack(pady=5, fill=tk.X)
        self.button_view4 = tk.Button(self.sidebar_frame, text="Nhân viên", command=lambda:self.button_click(4))
        self.button_view4.pack(pady=5, fill=tk.X)

        # Nội dung chính (mặc định hiển thị View 1)
        thread = threading.Thread(target = self.show_view1) 
        thread.start()

    def load_data(self): # Deprecated
        data = get_data_from_db()
        self.dish_buff = data
        if data:
            for row in data:
                self.data_listbox.insert(tk.END, row)
    
    def button_click(self, flag):
        if self.check_initial_load():
            return
            
        if flag == 1:
            self.show_view1()
        elif flag == 2:
            self.show_view2()
        elif flag == 3:
            self.show_view3()
        elif flag == 4:
            self.show_view4()

    def show_view1(self):
        with self.view_lock:
            show_view1(self)
            self.in_view1 = True
            self.in_view2 = False
            self.in_view3 = False
            self.in_view4 = False

    def show_view2(self):
        with self.view_lock:
            show_view2(self)
            self.in_view1 = False
            self.in_view2 = True
            self.in_view3 = False
            self.in_view4 = False

    def show_view3(self):
        with self.view_lock:
            show_view3(self)
            self.in_view1 = False
            self.in_view2 = False
            self.in_view3 = True
            self.in_view4 = False

    def show_view4(self):
        with self.view_lock:
            show_view4(self)
            self.in_view1 = False
            self.in_view2 = False
            self.in_view3 = False
            self.in_view4 = True

    def clear_content(self):
        self.dish_buff = None
        self.staff_buff = None
        self.order_buff = None
        self.right_frame_v2 = None
        #gc.collect() # Destruct the garbage
        for widget in self.content_frame.winfo_children():
            widget.destroy()
    
    def check_initial_load(self):
        if self.in_view1 == False and self.in_view2 == False and self.in_view3 == False and self.in_view4 == False:
            return True
        else:
            return False


if __name__ == "__main__":
    root = tk.Tk()
    app = MainView(root)
    root.mainloop()
