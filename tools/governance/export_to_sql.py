import sqlite3
import os

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")
SQL_OUTPUT_PATH = os.path.join(PROJECT_ROOT, "tools", "governance", "d1_schema.sql")

# Exact columns needed by the dashboard API for screens table (pruned to fit Cloudflare 100 column limit)
SCREEN_COLUMNS = [
    "id", "app_id", "role_id", "screen_code", "screen_name", "route_path",
    "cypress_ready", "cypress_ready_status", "screenshot_path", "video_recording_path",
    "when_tested", "is_valid", "complexity_score", "estimated_loc", "maintainability_score",
    "user_remarks", "user_remark_status", "required_components_json", "actual_components_json",
    "actual_file_path", "allowed_roles_text", "supports_mobile", "supports_tablet"
]

def escape_sql_val(val):
    if val is None:
        return "NULL"
    if isinstance(val, (int, float)):
        return str(val)
    # Text values: escape single quotes
    escaped = str(val).replace("'", "''")
    return f"'{escaped}'"

def main():
    print(f"Exporting database schemas and records from '{DB_PATH}' to '{SQL_OUTPUT_PATH}'...")
    if not os.path.exists(DB_PATH):
        print(f"Error: Local database '{DB_PATH}' not found!")
        return

    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()

    tables = ["orgs", "apps", "roles", "screens"]
    sql_statements = []

    # Drop existing tables if they exist to allow clean re-runs
    for t in tables:
        sql_statements.append(f"DROP TABLE IF EXISTS {t};")

    # 1. Export standard tables (orgs, apps, roles)
    for t in ["orgs", "apps", "roles"]:
        cursor.execute("SELECT sql FROM sqlite_master WHERE type='table' AND name=?;", (t,))
        create_sql = cursor.fetchone()
        if not create_sql:
            print(f"Warning: Table '{t}' not found in SQLite database!")
            continue
        
        sql_statements.append(create_sql[0] + ";")

        cursor.execute(f"PRAGMA table_info({t});")
        columns = [col[1] for col in cursor.fetchall()]
        col_list = ", ".join([f'"{c}"' for c in columns])

        cursor.execute(f"SELECT * FROM {t};")
        rows = cursor.fetchall()
        print(f"  Table '{t}': exporting {len(rows)} rows...")

        for row in rows:
            vals = [escape_sql_val(v) for v in row]
            val_list = ", ".join(vals)
            sql_statements.append(f"INSERT INTO {t} ({col_list}) VALUES ({val_list});")

    # 2. Export pruned screens table (exactly 23 required columns to respect Cloudflare D1's 100 column limit)
    t = "screens"
    screens_create_sql = """
CREATE TABLE screens (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    app_id INTEGER,
    role_id INTEGER,
    screen_code TEXT,
    screen_name TEXT,
    route_path TEXT,
    cypress_ready INTEGER,
    cypress_ready_status TEXT,
    screenshot_path TEXT,
    video_recording_path TEXT,
    when_tested TEXT,
    is_valid INTEGER,
    complexity_score INTEGER,
    estimated_loc INTEGER,
    maintainability_score INTEGER,
    user_remarks TEXT,
    user_remark_status TEXT,
    required_components_json TEXT,
    actual_components_json TEXT,
    actual_file_path TEXT,
    allowed_roles_text TEXT,
    supports_mobile INTEGER,
    supports_tablet INTEGER
);
"""
    sql_statements.append(screens_create_sql.strip())

    col_list = ", ".join([f'"{c}"' for c in SCREEN_COLUMNS])
    query_cols = ", ".join(SCREEN_COLUMNS)

    cursor.execute(f"SELECT {query_cols} FROM {t};")
    rows = cursor.fetchall()
    print(f"  Table '{t}' (PRUNED): exporting {len(rows)} rows...")

    for row in rows:
        vals = [escape_sql_val(v) for v in row]
        val_list = ", ".join(vals)
        sql_statements.append(f"INSERT INTO {t} ({col_list}) VALUES ({val_list});")

    conn.close()

    # Save to file
    with open(SQL_OUTPUT_PATH, "w", encoding="utf-8") as f:
        f.write("\n".join(sql_statements))

    print(f"Successfully exported SQL schema and seed data to '{SQL_OUTPUT_PATH}' ({os.path.getsize(SQL_OUTPUT_PATH)} bytes).")

if __name__ == "__main__":
    main()
