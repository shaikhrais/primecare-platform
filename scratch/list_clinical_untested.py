import os
import sqlite3

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

CLINICAL_ROLES = [
    'rn', 'rpn', 'lpn', 'np', 'physician', 'pediatric', 
    'physio', 'chiropractor', 'rmt', 'therapist', 
    'clinical_director', 'caregiver', 'hsw', 'hca', 'cns', 'clinical'
]

def main():
    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()
    
    # Get all untested screens
    cursor.execute("""
        SELECT screen_code, menu_label 
        FROM screens 
        WHERE when_tested IS NULL
    """)
    rows = cursor.fetchall()
    
    clinical_untested = {}
    other_untested = []
    
    for code, label in rows:
        prefix = code.split('_')[0] if '_' in code else code
        if prefix in CLINICAL_ROLES:
            if prefix not in clinical_untested:
                clinical_untested[prefix] = []
            clinical_untested[prefix].append((code, label or 'N/A'))
        else:
            other_untested.append((code, label or 'N/A'))
            
    print("==================================================")
    print("📋 UNTESTED CLINICAL SCREENS BY ROLE PREFIX")
    print("==================================================")
    
    total_clinical_untested = 0
    for role in sorted(clinical_untested.keys()):
        screens = clinical_untested[role]
        total_clinical_untested += len(screens)
        print(f"\n🩺 Role: {role.upper()} ({len(screens)} untested screens)")
        for code, label in screens[:8]:
            print(f"  - Code: {code:<35} | Label: {label}")
        if len(screens) > 8:
            print(f"    ... and {len(screens) - 8} more screens")
            
    print("\n==================================================")
    print(f"📊 CLINICAL SUMMARY")
    print(f"  Total Untested Clinical Screens: {total_clinical_untested}")
    print(f"  Total Untested Non-Clinical Screens: {len(other_untested)}")
    print(f"  Total Untested Screens in Database: {len(rows)}")
    print("==================================================")
    
    conn.close()

if __name__ == '__main__':
    main()
