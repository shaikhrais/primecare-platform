import sqlite3
import os

PROJECT_ROOT = r"c:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

conn = sqlite3.connect(DB_PATH)
c = conn.cursor()

# 1. Total routes
c.execute("SELECT count(*) FROM screens")
total_routes = c.fetchone()[0]

# 2. Total real UI routes (those that have progress > 20% or real UI enabled, wait, let's check what stages are available)
c.execute("PRAGMA table_info(screens)")
columns = [col[1] for col in c.fetchall()]

# Let's count based on stages:
# Stage 0: File exists
# Stage 1: Route connected
# Stage 2: HTML structure exists (sometimes placeholders are Stage 2 or under)
# Stage 3+: Real UI elements exist (Stage 3 and above)
# We can classify:
# Real UI routes: current_stage >= 3 (or stage > 2)
# Placeholder routes: current_stage == 2
# Empty/broken: current_stage <= 1
print("Columns in screens table:", columns)

# Let's query stage counts
c.execute("SELECT current_stage, count(*) FROM screens GROUP BY current_stage")
print("\nStage breakdown:")
for row in c.fetchall():
    print(f"  Stage {row[0]}: {row[1]} screens")

# Let's check progress percent ranges
c.execute("SELECT progress_percent, count(*) FROM screens GROUP BY progress_percent")
print("\nProgress percent breakdown:")
for row in c.fetchall():
    print(f"  {row[0]}%: {row[1]} screens")

# Let's query details on how stages are represented in the DB
c.execute("SELECT count(*) FROM screens WHERE is_placeholder = 1")
placeholders = c.fetchone()[0] if 'is_placeholder' in columns else 0

c.execute("SELECT count(*) FROM screens WHERE has_real_ui = 1")
real_ui = c.fetchone()[0] if 'has_real_ui' in columns else 0

print(f"\nStats computed directly:")
print(f"  Total routes: {total_routes}")
print(f"  Placeholders: {placeholders}")
print(f"  Real UI: {real_ui}")

conn.close()
