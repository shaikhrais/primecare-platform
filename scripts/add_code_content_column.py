import sqlite3

DB_PATH = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"

def main():
    conn = sqlite3.connect(DB_PATH)
    cur = conn.cursor()
    
    print("Checking if code_content column exists in project_file_registry...")
    try:
        cur.execute("SELECT code_content FROM project_file_registry LIMIT 1;")
        print("Column code_content already exists!")
    except sqlite3.OperationalError:
        print("Adding code_content column...")
        cur.execute("ALTER TABLE project_file_registry ADD COLUMN code_content TEXT;")
        conn.commit()
        print("Column code_content added successfully!")
        
    conn.close()

if __name__ == "__main__":
    main()
