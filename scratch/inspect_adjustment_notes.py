import sqlite3
import json

DB_PATH = ".agents/governance/governance.db"
conn = sqlite3.connect(DB_PATH)
conn.row_factory = sqlite3.Row
cur = conn.cursor()

row = cur.execute("SELECT * FROM screens WHERE screen_code LIKE '%adjustment_notes%' OR screen_name LIKE '%Adjustment%'").fetchone()
if row:
    print("Screen Code:", row["screen_code"])
    print("Screen Name:", row["screen_name"])
    print("Route Path:", row["route_path"])
    print("data_cy_required_json:", row["data_cy_required_json"])
    print("data_cy_found_json:", row["data_cy_found_json"])
    print("data_cy_missing_json:", row["data_cy_missing_json"])
else:
    print("No matching screen found.")

conn.close()
