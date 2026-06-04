import os
import json
import sqlite3
from datetime import datetime

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

translations_to_add = {
    "es": "Pantalla en construcción",
    "fr": "Écran en construction",
    "en": "Screen Under Construction"
}

# Update JSON files (handling nested structure)
def update_json_file(file_path, group, key, value):
    if not os.path.exists(file_path):
        print(f"File not found: {file_path}")
        return
    with open(file_path, 'r', encoding='utf-8') as f:
        data = json.load(f)
    
    if group not in data:
        data[group] = {}
    
    data[group][key] = value
    
    with open(file_path, 'w', encoding='utf-8') as f:
        json.dump(data, f, indent=4, ensure_ascii=False)
    print(f"Updated {file_path}: added {group}.{key} = {value}")

def main():
    # Directories to update
    dirs = [
        os.path.join(PROJECT_ROOT, "packages", "flutter_core", "assets", "translations"),
        os.path.join(PROJECT_ROOT, "packages", "flutter_core", "lib", "src", "localization")
    ]
    
    for d in dirs:
        for locale, val in translations_to_add.items():
            file_path = os.path.join(d, f"{locale}.json")
            update_json_file(file_path, "governance", "screen_under_construction", val)
            
    # Sync with DB
    if os.path.exists(DB_PATH):
        conn = sqlite3.connect(DB_PATH)
        cursor = conn.cursor()
        now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        key_code = "governance.screen_under_construction"
        key_group = "governance"
        default_text = translations_to_add["en"]
        
        try:
            cursor.execute("SELECT id FROM translation_keys WHERE key_code = ?", (key_code,))
            row = cursor.fetchone()
            if row:
                key_id = row[0]
                print(f"DB: Key '{key_code}' already exists with ID {key_id}")
            else:
                cursor.execute(
                    "INSERT INTO translation_keys (key_code, key_group, default_text, description, created_at) VALUES (?, ?, ?, ?, ?)",
                    (key_code, key_group, default_text, "Added screen_under_construction", now)
                )
                key_id = cursor.lastrowid
                print(f"DB: Inserted key '{key_code}' with new ID {key_id}")
                
            all_locales = ['en', 'fr', 'es', 'hi', 'gu', 'ar', 'ur']
            for locale in all_locales:
                translated_text = translations_to_add.get(locale)
                if not translated_text:
                    translated_text = f"[{locale.upper()}] {default_text}"
                
                cursor.execute("SELECT id FROM translation_values WHERE key_id = ? AND locale_code = ?", (key_id, locale))
                val_row = cursor.fetchone()
                if val_row:
                    cursor.execute(
                        "UPDATE translation_values SET translated_text = ? WHERE id = ?",
                        (translated_text, val_row[0])
                    )
                else:
                    cursor.execute(
                        "INSERT INTO translation_values (key_id, locale_code, translated_text, verified, created_at) VALUES (?, ?, ?, 1, ?)",
                        (key_id, locale, translated_text, now)
                    )
            conn.commit()
            print("DB sync succeeded.")
        except Exception as e:
            conn.rollback()
            print(f"DB Error: {e}")
        finally:
            conn.close()

if __name__ == '__main__':
    main()
