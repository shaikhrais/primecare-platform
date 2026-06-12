import os
import sqlite3

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")
DESC_DIR = os.path.join(PROJECT_ROOT, "tools", "governance", "screen_descriptions")

def main():
    print(f"Project root: {PROJECT_ROOT}")
    print(f"Database path: {DB_PATH}")
    print(f"Description directory: {DESC_DIR}")

    if not os.path.exists(DB_PATH):
        print("Error: Database not found!")
        return

    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cur = conn.cursor()

    # Load screens
    screens = cur.execute("SELECT id, screen_code, component_behavior_text, actual_file_path FROM screens").fetchall()
    print(f"Total screens in SQLite: {len(screens)}")

    mismatches = 0
    db_updated = 0
    files_created = 0
    matching = 0

    os.makedirs(DESC_DIR, exist_ok=True)

    for s in screens:
        screen_id = s["id"]
        screen_code = s["screen_code"]
        db_text = s["component_behavior_text"] or ""
        
        # Expected file path
        txt_filename = f"-{screen_code}.txt"
        txt_path = os.path.join(DESC_DIR, txt_filename)

        file_text = ""
        if os.path.exists(txt_path):
            with open(txt_path, "r", encoding="utf-8", errors="ignore") as f:
                file_text = f.read()

        db_text_clean = db_text.strip().replace("\r\n", "\n")
        file_text_clean = file_text.strip().replace("\r\n", "\n")

        if not db_text_clean and not file_text_clean:
            # Both empty, let's note it
            mismatches += 1
            print(f"Screen '{screen_code}' (ID: {screen_id}) has no description in DB or file.")
        elif db_text_clean == file_text_clean:
            matching += 1
        elif file_text_clean and (not db_text_clean or db_text_clean != file_text_clean):
            # File has content, DB is empty or different -> Update DB from File
            cur.execute("""
                UPDATE screens
                SET component_behavior_text = ?
                WHERE id = ?;
            """, (file_text, screen_id))
            db_updated += 1
            print(f"Uploaded description for screen '{screen_code}' from file to DB.")
        elif db_text_clean and not file_text_clean:
            # DB has content, File is empty/missing -> Write File from DB
            with open(txt_path, "w", encoding="utf-8") as f:
                f.write(db_text)
            files_created += 1
            print(f"Saved description for screen '{screen_code}' from DB to file.")

    conn.commit()
    conn.close()

    print("\n==============================================================")
    print("Verification Summary:")
    print(f"Total Matching: {matching}")
    print(f"DB updated from files: {db_updated}")
    print(f"Files created from DB: {files_created}")
    print(f"Mismatches (both empty): {mismatches}")
    print("==============================================================")

if __name__ == "__main__":
    main()
