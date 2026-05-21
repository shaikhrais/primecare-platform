import sys
import os
import sqlite3
import json

# Add current folder to path to import governance_db
sys.path.append(os.path.dirname(os.path.abspath(__file__)))
import governance_db

def generate_summary():
    conn = governance_db.get_connection()
    cursor = conn.cursor()

    cursor.execute("SELECT page_id, role_allowed, labels FROM pages;")
    rows = cursor.fetchall()
    
    pages = [dict(row) for row in rows]
    
    # Exclude stubs like UNMAPPED_SYNC
    filtered_pages = [p for p in pages if p['page_id'] != 'UNMAPPED_SYNC']
    
    # Actual functional/dashboard screens (not localized label blocks)
    screens = [p for p in filtered_pages if not p['page_id'].endswith('_labels')]
    total_screens = len(screens)
    
    role_coverage = {}
    for page in screens:
        roles_str = page.get('role_allowed')
        roles = json.loads(roles_str) if roles_str else []
        for role in roles:
            role_coverage[role] = role_coverage.get(role, 0) + 1

    print("PrimeCare Platform Governance Summary")
    print("==========================================")
    print(f"Total Registered Screens: {total_screens}")
    print("\nRole-Based Access Coverage:")
    for role, count in sorted(role_coverage.items(), key=lambda x: x[1], reverse=True):
        print(f"  - {role:25}: {count} screens")
    
    # Check for localization labels
    labels_blocks = [p for p in filtered_pages if p['page_id'].endswith('_labels')]
    print(f"\nLocalized Component Blocks: {len(labels_blocks)}")
    for block in labels_blocks:
        labels_str = block.get('labels')
        labels_dict = json.loads(labels_str) if labels_str else {}
        label_count = len(labels_dict)
        print(f"  - {block['page_id']:25}: {label_count} keys")

    print("\n==========================================")
    print("All screens listed above are governed by the Registry-First architecture.")
    
    conn.close()

if __name__ == "__main__":
    generate_summary()
