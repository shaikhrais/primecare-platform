import sqlite3

DB_PATH = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"

def main():
    conn = sqlite3.connect(DB_PATH)
    cur = conn.cursor()

    print("Creating project_file_registry table...")
    cur.execute("""
    CREATE TABLE IF NOT EXISTS project_file_registry (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        app_id INTEGER,
        role_id INTEGER,
        screen_id INTEGER,
        section_id INTEGER,
        file_code TEXT NOT NULL UNIQUE,
        file_name TEXT NOT NULL,
        file_type TEXT NOT NULL,
        absolute_path TEXT NOT NULL,
        folder_path TEXT NOT NULL,
        parent_file_id INTEGER,
        dependency_file_ids_json TEXT,
        purpose TEXT,
        generation_order INTEGER,
        implementation_status TEXT DEFAULT 'skeleton',
        created_at TEXT DEFAULT CURRENT_TIMESTAMP,
        updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (app_id) REFERENCES apps(id) ON DELETE SET NULL,
        FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE SET NULL,
        FOREIGN KEY (screen_id) REFERENCES screens(id) ON DELETE SET NULL,
        FOREIGN KEY (section_id) REFERENCES screen_sections(id) ON DELETE SET NULL
    );
    """)

    print("Creating project_file_dependencies table...")
    cur.execute("""
    CREATE TABLE IF NOT EXISTS project_file_dependencies (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        file_id INTEGER NOT NULL,
        depends_on_file_id INTEGER NOT NULL,
        dependency_type TEXT NOT NULL,
        FOREIGN KEY (file_id) REFERENCES project_file_registry(id) ON DELETE CASCADE,
        FOREIGN KEY (depends_on_file_id) REFERENCES project_file_registry(id) ON DELETE CASCADE
    );
    """)

    print("Creating implementation_execution_plan table...")
    cur.execute("""
    CREATE TABLE IF NOT EXISTS implementation_execution_plan (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        file_id INTEGER NOT NULL,
        build_step INTEGER NOT NULL,
        phase_name TEXT NOT NULL,
        FOREIGN KEY (file_id) REFERENCES project_file_registry(id) ON DELETE CASCADE
    );
    """)

    conn.commit()
    conn.close()
    print("Pre-implementation architecture tables migrated successfully!")

if __name__ == "__main__":
    main()
