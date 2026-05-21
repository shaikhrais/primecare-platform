import sqlite3
import os

DB_PATH = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"

def get_connection():
    """Returns a connection to the SQLite database with Foreign Keys enabled."""
    conn = sqlite3.connect(DB_PATH)
    conn.execute("PRAGMA foreign_keys = ON;")
    conn.row_factory = sqlite3.Row
    return conn

def init_db(force_reset=False):
    """Initializes the SQLite database schemas. If force_reset is True, tables are dropped first."""
    conn = get_connection()
    cursor = conn.cursor()
    
    if force_reset:
        print("Force resetting SQLite tables...")
        cursor.execute("DROP TABLE IF EXISTS fields;")
        cursor.execute("DROP TABLE IF EXISTS pages;")
        cursor.execute("DROP TABLE IF EXISTS intents;")
        cursor.execute("DROP TABLE IF EXISTS sidebar_items;")
        cursor.execute("DROP TABLE IF EXISTS dashboards;")
        conn.commit()

    # 1. Dashboards Table
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS dashboards (
        screen_id TEXT PRIMARY KEY,
        screen_name TEXT NOT NULL,
        path TEXT NOT NULL,
        requires_sidebar INTEGER DEFAULT 0,
        category TEXT NOT NULL,
        layout_compliant INTEGER DEFAULT 1
    );
    """)

    # 2. Sidebar Items Table (relational)
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS sidebar_items (
        screen_id TEXT,
        item_id TEXT,
        label TEXT NOT NULL,
        type TEXT NOT NULL,
        expected_handler TEXT,
        status TEXT NOT NULL,
        PRIMARY KEY (screen_id, item_id),
        FOREIGN KEY (screen_id) REFERENCES dashboards(screen_id) ON DELETE CASCADE
    );
    """)

    # 3. Intents Table
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS intents (
        intent_id TEXT PRIMARY KEY,
        business_goal TEXT,
        status TEXT NOT NULL
    );
    """)

    # 4. Pages Table
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS pages (
        page_id TEXT PRIMARY KEY,
        route TEXT,
        name TEXT,
        label TEXT,
        route_var TEXT,
        icon_var TEXT,
        section TEXT,
        role_allowed TEXT, -- JSON array
        actions TEXT,      -- JSON array
        labels TEXT,       -- JSON dictionary of localizations
        linked_intent TEXT,
        implementation_status TEXT NOT NULL,
        FOREIGN KEY (linked_intent) REFERENCES intents(intent_id) ON DELETE SET NULL
    );
    """)

    # 5. Fields Table
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS fields (
        field_id TEXT PRIMARY KEY,
        page_id TEXT,
        linked_intent TEXT,
        validation TEXT,
        api_endpoint TEXT,
        service_method TEXT,
        database_table TEXT,
        database_column TEXT,
        status TEXT NOT NULL,
        FOREIGN KEY (page_id) REFERENCES pages(page_id) ON DELETE CASCADE,
        FOREIGN KEY (linked_intent) REFERENCES intents(intent_id) ON DELETE SET NULL
    );
    """)

    conn.commit()
    conn.close()
    print("SQLite database schemas initialized.")

if __name__ == "__main__":
    init_db()
