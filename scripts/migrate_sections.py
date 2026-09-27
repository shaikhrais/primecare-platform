import sqlite3
import os

DB_PATH = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"

def migrate():
    conn = sqlite3.connect(DB_PATH)
    cur = conn.cursor()

    # Enable foreign keys
    cur.execute("PRAGMA foreign_keys = ON;")

    # 1. Create tables
    cur.execute("""
    CREATE TABLE IF NOT EXISTS screen_sections (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        screen_id INTEGER,
        section_code TEXT NOT NULL,
        section_name TEXT NOT NULL,
        section_type TEXT NOT NULL,
        section_order INTEGER NOT NULL,
        purpose TEXT,
        required INTEGER DEFAULT 1,
        file_path TEXT,
        test_id TEXT NOT NULL,
        status TEXT DEFAULT 'PENDING',
        FOREIGN KEY (screen_id) REFERENCES screens(id) ON DELETE CASCADE
    );
    """)

    cur.execute("""
    CREATE TABLE IF NOT EXISTS screen_section_elements (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        section_id INTEGER,
        screen_id INTEGER,
        element_key TEXT NOT NULL,
        element_type TEXT NOT NULL,
        label TEXT NOT NULL,
        test_id TEXT NOT NULL,
        required INTEGER DEFAULT 1,
        action_required INTEGER DEFAULT 0,
        api_usage TEXT,
        element_order INTEGER NOT NULL,
        FOREIGN KEY (section_id) REFERENCES screen_sections(id) ON DELETE CASCADE,
        FOREIGN KEY (screen_id) REFERENCES screens(id) ON DELETE CASCADE
    );
    """)

    # Clear tables to allow idempotent runs
    cur.execute("DELETE FROM screen_section_elements;")
    cur.execute("DELETE FROM screen_sections;")

    # Fetch all screens
    cur.execute("SELECT id, screen_code, screen_name FROM screens;")
    screens = cur.fetchall()
    print(f"Total screens fetched: {len(screens)}")

    for s_id, s_code, s_name in screens:
        # Fetch required elements for this screen
        cur.execute("""
            SELECT element_key, element_type, label, test_id, required 
            FROM screen_required_elements 
            WHERE screen_id = ?;
        """, (s_id,))
        elements = cur.fetchall()

        if not elements:
            continue

        # We will create sections dynamically for this screen
        sections_map = {} # section_type -> (section_id, section_code, section_name, order)
        
        # Helper to get/create section
        def get_or_create_section(sec_type, sec_name, sec_code):
            if sec_type in sections_map:
                return sections_map[sec_type][0]
            
            order = len(sections_map) + 1
            test_id = f"section-{sec_code}"
            
            cur.execute("""
                INSERT INTO screen_sections (screen_id, section_code, section_name, section_type, section_order, purpose, required, test_id)
                VALUES (?, ?, ?, ?, ?, ?, 1, ?);
            """, (s_id, sec_code, sec_name, sec_type, order, f"Section for {sec_name}", test_id))
            
            sec_id = cur.lastrowid
            sections_map[sec_type] = (sec_id, sec_code, sec_name, order)
            return sec_id

        # Loop through elements and insert them
        for idx, (el_key, el_type, label, test_id, required) in enumerate(elements, 1):
            el_key_lower = el_key.lower() if el_key else ""
            
            # Map element to section based on its key/type
            if el_key_lower in ["screen_root", "page_title", "title", "header"]:
                sec_type = "header"
                sec_name = "Header Section"
                sec_code = f"{s_code}_header"
            elif any(x in el_key_lower for x in ["card", "metric", "stat", "badge", "total", "summary", "progress"]):
                sec_type = "summary_cards"
                sec_name = "Summary Cards Section"
                sec_code = f"{s_code}_summary"
            elif any(x in el_key_lower for x in ["list", "table", "grid", "records", "rows"]):
                sec_type = "table" if "table" in el_key_lower else "list"
                sec_name = "Data List Section"
                sec_code = f"{s_code}_data_list"
            elif any(x in el_key_lower for x in ["btn", "button", "action", "submit", "save", "delete", "trigger", "emergency"]):
                sec_type = "action_bar"
                sec_name = "Actions Section"
                sec_code = f"{s_code}_actions"
            elif any(x in el_key_lower for x in ["input", "field", "form", "text", "box", "search"]):
                sec_type = "form"
                sec_name = "Form Section"
                sec_code = f"{s_code}_form"
            else:
                sec_type = "details_panel"
                sec_name = "Details Section"
                sec_code = f"{s_code}_details"
                
            sec_id = get_or_create_section(sec_type, sec_name, sec_code)
            
            # Determine if action is required
            action_required = 0
            if el_type == "button" or "btn" in el_key_lower:
                action_required = 1

            cur.execute("""
                INSERT INTO screen_section_elements (section_id, screen_id, element_key, element_type, label, test_id, required, action_required, element_order)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);
            """, (sec_id, s_id, el_key, el_type, label, test_id, required, action_required, idx))

    conn.commit()
    conn.close()
    print("Database migration and section data entry completed successfully!")

if __name__ == "__main__":
    migrate()
