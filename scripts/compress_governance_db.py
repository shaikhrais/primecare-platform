import sqlite3
import os

DB_PATH = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"

def main():
    if not os.path.exists(DB_PATH):
        print("Database file not found!")
        return

    size_before = os.path.getsize(DB_PATH)
    print(f"Size before vacuum: {size_before / (1024 * 1024):.2f} MB")

    print("Connecting and executing VACUUM...")
    conn = sqlite3.connect(DB_PATH)
    conn.execute("VACUUM;")
    conn.close()

    size_after = os.path.getsize(DB_PATH)
    print(f"Size after vacuum: {size_after / (1024 * 1024):.2f} MB")
    print(f"Compressed by {(size_before - size_after) / (1024 * 1024):.2f} MB")

if __name__ == "__main__":
    main()
