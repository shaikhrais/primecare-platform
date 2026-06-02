import os
import sys
import sqlite3

# Reconfigure stdout to use UTF-8 on Windows
if sys.platform == 'win32':
    sys.stdout.reconfigure(encoding='utf-8')

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()
    
    # 1. Print schemas of translation tables
    for table in ['language_registry', 'translation_keys', 'translation_values']:
        print(f"\nSchema for '{table}':")
        cursor.execute(f"PRAGMA table_info({table})")
        columns = cursor.fetchall()
        for col in columns:
            print(f"  {col[1]} ({col[2]})")
            
    # 2. Sample data from language_registry
    print("\nSample from 'language_registry':")
    cursor.execute("SELECT * FROM language_registry LIMIT 10")
    for r in cursor.fetchall():
        print(f"  {r}")

    # 3. Sample data from translation_keys and values using correct column names
    print("\nSample from 'translation_keys' & 'translation_values':")
    query = """
    SELECT k.key_code, v.locale_code, v.translated_text 
    FROM translation_keys k
    JOIN translation_values v ON k.id = v.key_id
    LIMIT 30
    """
    cursor.execute(query)
    for r in cursor.fetchall():
        print(f"  Key: {r[0]} | Lang: {r[1]} | Val: {r[2]}")
        
    conn.close()

if __name__ == '__main__':
    main()
