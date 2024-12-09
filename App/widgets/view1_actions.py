from tkinter import ttk

def insert_order_dish(parent, root): # right frame, main_view
    label_content = root.right_frame_v1.ID_mon_an +  root.right_frame_v1.Ngay
    
    # Kiểm tra trùng tên label 
    for frame, label, entry in root.right_frame_v1.order_dish: 
        if label.cget("text") == label_content: 
            print("Label trùng tên:", label_content) 
            return

    frame = ttk.Frame(parent)
    frame.pack(padx=10, pady=4, fill='x', anchor='w')
    
    label = ttk.Label(frame, text=label_content)
    label.pack(side='left', padx=5)

    entry_val = root.right_frame_v1.So_luong_con
    entry = ttk.Entry(frame)
    entry.pack(side='right', fill='x', expand=True, padx=5)
    entry.delete(0, 'end') 
    entry.insert(0, entry_val)
    
    # Thêm frame, label, entry vào danh sách order_dish 
    root.right_frame_v1.order_dish.append((frame, label, entry)) 
    print(f"Đã thêm {label_content}") 
    
def get_entry_values(self): 
    for frame, label, entry in self.order_dish: 
        print(f"Label: {label.cget('text')}, Entry Value: {entry.get()}")