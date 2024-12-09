import threading
from tkinter import messagebox
from widgets.view1_actions import insert_order_dish
def refresh_action(root): 

    # Check in first loading
    if root.in_view1 == False and root.in_view2 == False and root.in_view3 == False and root.in_view4 == False:
        messagebox.showwarning("Warning", "Please wait, the app is loading")
        return

    def target():
        #with root.view_lock: 
        print("Refreshing data...")

        root.dish_buff = None
        root.staff_buff = None
        root.order_buff = None

        if root.in_view1:
            root.show_view1()
        elif root.in_view2:
            root.show_view2()
        elif root.in_view2:
            root.show_view3()
        elif root.in_view2:
            root.show_view4()

    thread = threading.Thread(target=target)
    thread.start()
    thread.join(timeout=5)  # Thời gian chờ là 5 giây

    if thread.is_alive():
        print("Operation took too long and was cancelled.")
        messagebox.showwarning("Warning", "Please don't spawn to much!")

def search_action(table):
    print("Searching")

def on_item_select(table, main_view):
    selected_item = table.selection()[0] 
    item_data = table.item(selected_item)['values'] 
    print(f'Dòng được chọn: {item_data}')
    
    with main_view.view_lock:
        if main_view.in_view2:
            if main_view.right_frame_v2:
                main_view.right_frame_v2.ID_don_hang = item_data[0]
                main_view.right_frame_v2.Trang_thai = item_data[3]
                
                main_view.right_frame_v2.entry_sdt.config(state='normal')
                main_view.right_frame_v2.entry_sdt.delete(0, 'end') 
                main_view.right_frame_v2.entry_sdt.insert(0, item_data[1])
                main_view.right_frame_v2.entry_sdt.config(state='readonly')

                main_view.right_frame_v2.entry_note_status.config(state='normal')
                main_view.right_frame_v2.entry_note_status.delete(0, 'end') 
                main_view.right_frame_v2.entry_note_status.insert(0, item_data[4])
                main_view.right_frame_v2.entry_note_status.config(state='readonly')
                
                main_view.right_frame_v2.entry_init_time.config(state='normal')
                main_view.right_frame_v2.entry_init_time.delete(0, 'end') 
                main_view.right_frame_v2.entry_init_time.insert(0, item_data[5])
                main_view.right_frame_v2.entry_init_time.config(state='readonly')

                main_view.right_frame_v2.entry_fin_time.config(state='normal')
                main_view.right_frame_v2.entry_fin_time.delete(0, 'end') 
                main_view.right_frame_v2.entry_fin_time.insert(0, item_data[6])
                #if main_view.right_frame_v2.entry_fin_time.get() != 'None':
                main_view.right_frame_v2.entry_fin_time.config(state='readonly')

                main_view.right_frame_v2.entry_order_note.delete(0, 'end') 
                main_view.right_frame_v2.entry_order_note.insert(0, item_data[7])
            else:
                print("Some thing went from in view 2, the right frame contents were not initialized!!")
                return
        elif main_view.in_view1:
            if main_view.right_frame_v1:
                main_view.right_frame_v1.ID_mon_an = item_data[0]
                main_view.right_frame_v1.Ngay = item_data[1]
                main_view.right_frame_v1.So_luong_con = item_data[2]
                main_view.right_frame_v1.Giam_gia = item_data[3]
                main_view.right_frame_v1.Gia_ban_trong_ngay = item_data[4]
                if main_view.right_frame_v1.right_frame:
                    insert_order_dish(main_view.right_frame_v1.right_frame, main_view)
                else:
                    print("Some thing went wrong, the right frame of view 1 is not initialized correctly!")
            else:
                print("Some thing went from in view 1, the right frame contents were not initialized!!")
                return
