import sqlite3

DB_PATH = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"

def main():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cur = conn.cursor()
    
    cur.execute("SELECT id, screen_code FROM screens;")
    screens = cur.fetchall()
    
    for scr in screens:
        s_id = scr["id"]
        s_code = scr["screen_code"]
        
        # Get sections for this screen
        cur.execute("SELECT id, section_code FROM screen_sections WHERE screen_id = ?;", (s_id,))
        sections = cur.fetchall()
        
        for sec in sections:
            sec_id = sec["id"]
            sec_code = sec["section_code"]
            
            # The format is: screens/<screen_code>/sections/<screen_code>_<section_code>_section.dart
            # In our DB, section_code is stored as f"{s_code}_{sec_code_suffix}".
            # So section_code itself is already "<screen_code>_<section_code>"!
            planned_path = f"screens/{s_code}/sections/{sec_code}_section.dart"
            
            cur.execute("UPDATE screen_sections SET file_path = ? WHERE id = ?;", (planned_path, sec_id))
            
    conn.commit()
    conn.close()
    print("Planned section file paths updated successfully!")

if __name__ == "__main__":
    main()
