from tkinter import ttk

def insert_order_dish(parent, root):  # right frame, main_view
    label_content = root.right_frame_v1.ID_mon_an + root.right_frame_v1.Ngay

    # Kiểm tra trùng tên label
    for frame, label, entry, button in root.right_frame_v1.order_dish:
        if label.cget("text") == label_content:
            print("Label trùng tên:", label_content)
            return

    frame = ttk.Frame(parent)
    frame.pack(padx=10, pady=4, fill='x', anchor='w')

    label = ttk.Label(frame, text=label_content)
    label.pack(side='left', padx=5)

    entry_val = root.right_frame_v1.So_luong_con
    entry = ttk.Entry(frame)
    entry.pack(side='left', fill='x', expand=True, padx=2)
    entry.delete(0, 'end')
    entry.insert(0, entry_val)

    # Hàm xử lý khi nút xóa được nhấn
    def delete_frame():
        frame.destroy()
        root.right_frame_v1.order_dish = [item for item in root.right_frame_v1.order_dish if item[0] != frame]
        print(f"Đã xóa {label_content}")

    delete_button = ttk.Button(frame, text="Xóa", command=delete_frame)
    delete_button.pack(side='right', padx=5)

    # Thêm frame, label, entry, delete_button vào danh sách order_dish
    root.right_frame_v1.order_dish.append((frame, label, entry, delete_button))
    print(f"Đã thêm {label_content}")

    
def get_entry_values(self): 
    for frame, label, entry in self.order_dish: 
        print(f"Label: {label.cget('text')}, Entry Value: {entry.get()}")