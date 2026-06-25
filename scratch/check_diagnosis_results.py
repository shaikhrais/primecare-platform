import sqlite3
import os

PROJECT_ROOT = r"c:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

conn = sqlite3.connect(DB_PATH)
c = conn.cursor()

# Get some counts
c.execute("SELECT count(*) FROM screens")
print("Total screens:", c.fetchone()[0])

c.execute("SELECT diagnosis_reply_status, count(*) FROM screens GROUP BY diagnosis_reply_status")
print("Status breakdown:")
for row in c.fetchall():
    print(f"  {row[0]}: {row[1]}")

c.execute("SELECT count(*) FROM screen_diagnosis_tests")
print("Total tests run:", c.fetchone()[0])

# Get 5 samples of tests
c.execute("SELECT route_path, reply_status, answer FROM screen_diagnosis_tests LIMIT 5")
print("\nSamples:")
for row in c.fetchall():
    print(f"  Route: {row[0]}")
    print(f"  Status: {row[1]}")
    print(f"  Answer:\n{row[2]}")
    print("-" * 50)

conn.close()
