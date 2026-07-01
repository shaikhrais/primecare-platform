import os
import sqlite3
from pathlib import Path

PROJECT_ROOT = r"C:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")
DESCRIPTIONS_DIR = os.path.join(PROJECT_ROOT, "tools", "governance", "screen_descriptions")

def parse_description_file(file_path):
    with open(file_path, "r", encoding="utf-8", errors="ignore") as f:
        content = f.read()

    # Parse sections
    # Sections typically start with:
    # "User Tasks:"
    # "Red Flags of Operation:"
    # "Dashboard Requirements:" or "Requirements:"
    
    user_tasks = ""
    red_flags = ""
    requirements = ""

    current_section = None
    lines = content.split("\n")
    for line in lines:
        line_strip = line.strip()
        if not line_strip:
            continue
        
        if line_strip.lower().startswith("user tasks:"):
            current_section = "tasks"
            continue
        elif line_strip.lower().startswith("red flags of operation:") or line_strip.lower().startswith("red flags:"):
            current_section = "flags"
            continue
        elif line_strip.lower().startswith("dashboard requirements:") or line_strip.lower().startswith("requirements:"):
            current_section = "reqs"
            continue
        
        if current_section == "tasks":
            user_tasks += line_strip + "\n"
        elif current_section == "flags":
            red_flags += line_strip + "\n"
        elif current_section == "reqs":
            requirements += line_strip + "\n"

    return {
        "business_purpose": user_tasks.strip() or "N/A",
        "acceptance_criteria": red_flags.strip() or "N/A",
        "user_story": requirements.strip() or "N/A"
    }

def main():
    print("==============================================================")
    print("IMPORTING SCREEN REQUIREMENTS FROM TXT SPECS TO DATABASE")
    print("==============================================================")

    if not os.path.exists(DESCRIPTIONS_DIR):
        print(f"Error: Descriptions directory not found at {DESCRIPTIONS_DIR}")
        return

    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    c = conn.cursor()

    # Get all screens from database to build code -> id map
    c.execute("SELECT id, screen_code, screen_name FROM screens")
    screens = {r["screen_code"]: dict(r) for r in c.fetchall()}
    print(f"Loaded {len(screens)} screens from the database.")

    # Clear existing requirements to prevent duplicates
    c.execute("DELETE FROM screen_requirements")

    matched_count = 0
    skipped_count = 0

    desc_files = [f for f in os.listdir(DESCRIPTIONS_DIR) if f.endswith("_description.txt")]
    for filename in desc_files:
        screen_code = filename.replace("_description.txt", "")
        file_path = os.path.join(DESCRIPTIONS_DIR, filename)

        # Match with database screen
        db_screen = None
        # Try exact match first
        if screen_code in screens:
            db_screen = screens[screen_code]
        else:
            # Try matching by replacing underscores/dashes
            normalized_code = screen_code.replace("_", "-")
            for code, scr in screens.items():
                if code.replace("_", "-") == normalized_code:
                    db_screen = scr
                    break

        if db_screen:
            parsed = parse_description_file(file_path)
            screen_id = db_screen["id"]
            screen_name = db_screen["screen_name"]

            c.execute("""
                INSERT INTO screen_requirements (screen_id, business_purpose, user_story, sidebar_label, acceptance_criteria)
                VALUES (?, ?, ?, ?, ?)
            """, (
                screen_id,
                parsed["business_purpose"],
                parsed["user_story"],
                screen_name,
                parsed["acceptance_criteria"]
            ))
            matched_count += 1
        else:
            skipped_count += 1

    conn.commit()
    conn.close()

    print("==============================================================")
    print("IMPORT COMPLETED!")
    print(f"  - Successfully matched and imported: {matched_count} screens")
    print(f"  - Skipped/unmatched description files: {skipped_count}")
    print("==============================================================")

if __name__ == "__main__":
    main()
