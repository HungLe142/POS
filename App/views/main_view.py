import tkinter as tk
from controllers.main_controller import get_data_from_db
from views.vỉew1 import show_view1
from views.vỉew2 import show_view2
from views.view3 import show_view3
from views.view4 import show_view4

class MainView:
    def __init__(self, root):
        self.dish_buff = None
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
        self.button_view1 = tk.Button(self.sidebar_frame, text="Món ăn trong ngày", command=self.show_view1)
        self.button_view1.pack(pady=5, fill=tk.X)
        self.button_view2 = tk.Button(self.sidebar_frame, text="Đơn hàng", command=self.show_view2)
        self.button_view2.pack(pady=5, fill=tk.X)
        self.button_view3 = tk.Button(self.sidebar_frame, text="Khách hàng", command=self.show_view3)
        self.button_view3.pack(pady=5, fill=tk.X)
        self.button_view4 = tk.Button(self.sidebar_frame, text="Nhân viên", command=self.show_view4)
        self.button_view4.pack(pady=5, fill=tk.X)

        # Nội dung chính (mặc định hiển thị View 1)
        self.show_view1()

    def load_data(self): # Deprecated
        data = get_data_from_db()
        self.dish_buff = data
        if data:
            for row in data:
                self.data_listbox.insert(tk.END, row)

    def show_view1(self):
        show_view1(self)

    def show_view2(self):
        show_view2(self)

    def show_view3(self):
        show_view3(self)

    def show_view4(self):
        show_view2(self)

    def clear_content(self):
        for widget in self.content_frame.winfo_children():
            widget.destroy()

if __name__ == "__main__":
    root = tk.Tk()
    app = MainView(root)
    root.mainloop()
