import os
import sqlite3
from collections import Counter

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()
    
    # Get all untested screens
    cursor.execute("""
        SELECT screen_code, menu_label, shell_layout_key 
        FROM screens 
        WHERE when_tested IS NULL
    """)
    rows = cursor.fetchall()
    
    print(f"Total Untested Screens: {len(rows)}")
    
    # Categorize by prefix of screen_code (e.g., 'rmt', 'np', 'physician', etc.)
    categories = {}
    for code, label, shell in rows:
        prefix = code.split('_')[0] if '_' in code else 'other'
        if prefix not in categories:
            categories[prefix] = []
        categories[prefix].append((code, label or 'N/A'))
        
    print("\n--- Breakdown of Untested Screens by Role/Prefix ---")
    sorted_categories = sorted(categories.items(), key=lambda x: len(x[1]), reverse=True)
    for prefix, screens in sorted_categories:
        print(f"  Prefix: {prefix:<20} | Untested Screens Count: {len(screens)}")
        
    print("\n--- Detailed Sample of Untested Screens (First 5 per category) ---")
    for prefix, screens in sorted_categories[:10]:
        print(f"\nCategory: '{prefix}' ({len(screens)} screens)")
        for code, label in screens[:5]:
            print(f"  - Code: {code:<30} (Label: {label})")
        if len(screens) > 5:
            print(f"    ... and {len(screens) - 5} more")
            
    conn.close()

if __name__ == '__main__':
    main()
