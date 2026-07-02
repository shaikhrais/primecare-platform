import sqlite3
import os

DB_PATH = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"

def recreate_files():
    print("Recreating missing files from SQLite project_file_registry...")
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cur = conn.cursor()
    
    cur.execute("SELECT absolute_path, folder_path, code_content FROM project_file_registry;")
    files = cur.fetchall()
    
    recreated = 0
    for f in files:
        path = f["absolute_path"]
        folder = f["folder_path"]
        code = f["code_content"]
        
        if code and not os.path.exists(path):
            os.makedirs(folder, exist_ok=True)
            with open(path, "w", encoding="utf-8") as file_out:
                file_out.write(code)
            recreated += 1
            
    print(f"Recreation complete. Recreated {recreated} missing files.")
    conn.close()

if __name__ == "__main__":
    recreate_files()
