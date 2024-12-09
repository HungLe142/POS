from widgets.table import refresh_action, search_action
import tkinter as tk

# Search bar and refresh button:
def create_sb_rf(parent, root): 
    frame = tk.Frame(parent) 
    create_search_bar(frame) 
    create_refresh_button(frame, root) 
    return frame

def create_refresh_button(parent, root):
    refresh_button = tk.Button(parent, text="Refresh", command=lambda:refresh_action(root)) 
    refresh_button.pack(side=tk.RIGHT, padx=5)

def create_search_bar(parent):
    search_label = tk.Label(parent, text="Search:") 
    search_label.pack(side=tk.LEFT, padx=5) 

    search_entry = tk.Entry(parent) 
    search_entry.pack(side=tk.LEFT, fill=tk.X, expand=True, padx=5) 
    search_button = tk.Button(parent, text="Go", command=lambda: search_action(search_entry.get())) 
    search_button.pack(side=tk.LEFT, padx=5)
